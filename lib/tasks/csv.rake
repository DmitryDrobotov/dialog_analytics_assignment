require 'csv'

namespace :csv do
  desc "Generates CSV from extra/dialogs/*.txt files and stores it at extra/dialogs.csv"
  task :generate, :csv_file_path do |t, args|
    args.with_defaults(csv_file_path: 'extra/dialogs.csv')

    csv_file_path = Rails.root.join(args[:csv_file_path])
    txt_file_pattern = Rails.root.join('extra', 'dialogs', '*.txt')

    CSV.open(csv_file_path, "wb") do |csv|
      csv << ['dialog_name', 'phrase_actor', 'phrase_start_in_sec', 'phrase_end_in_sec', 'phrase_content']

      Dir.glob(txt_file_pattern) do |txt_file_path|
        File.open(txt_file_path).read.each_line.with_index do |line, line_number|
          dialog_name = File.basename(txt_file_path, ".txt").humanize
          phrase_actor, phrase_content = line.match(/^([A-Z]):\s\"(.+?)\"$/).captures

          phrase_start_in_sec = line_number * 8 + rand(4)
          phrase_end_in_sec   = (line_number + 1) * 8 + rand(12) - 8

          csv << [dialog_name, phrase_actor, phrase_start_in_sec, phrase_end_in_sec, phrase_content]

          putc '.'
        end
      end
    end

    puts
  end

  desc "Imports CSV to database"
  task :import, [:csv_file_path] => [:environment] do |t, args|
    args.with_defaults(csv_file_path: 'extra/dialogs.csv')
    prev_end_in_sec = 0

    csv_file_path = Rails.root.join(args[:csv_file_path])
    CSV.foreach(csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      csv_hash = row.to_hash
      dialog = Dialog.find_by(name: csv_hash[:dialog_name])
      unless dialog
        dialog = Dialog.create!(name: csv_hash[:dialog_name])
        prev_end_in_sec = 0
      end
      Phrase.create!(dialog_id: dialog.id, actor: csv_hash[:phrase_actor], 
                     start_in_sec: csv_hash[:phrase_start_in_sec], 
                     end_in_sec: csv_hash[:phrase_end_in_sec], 
                     content: csv_hash[:phrase_content],
                     is_interruption: interruption(csv_hash[:phrase_start_in_sec].to_i, prev_end_in_sec.to_i),
                     is_long_break: long_break(csv_hash[:phrase_start_in_sec].to_i, prev_end_in_sec.to_i))
      prev_end_in_sec = csv_hash[:phrase_end_in_sec]
      putc '.'
    end

    puts
  end

  def interruption(start_in_sec, prev_end_in_sec)
    return true if start_in_sec < prev_end_in_sec
    false
  end

  def long_break(start_in_sec, prev_end_in_sec)
    return true if start_in_sec - prev_end_in_sec > 5
    false
  end
end
