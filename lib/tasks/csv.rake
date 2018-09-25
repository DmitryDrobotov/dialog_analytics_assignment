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
  task :import => [:environment] do |t, args|
    args.with_defaults(csv_file_path: 'extra/dialogs.csv')

    csv_file_path = Rails.root.join(args[:csv_file_path])
    CSV.foreach(csv_file_path, headers: :first_row, header_converters: :symbol) do |row|

      # place import to database code here
      Dialog.find_or_create_by(name: row[:dialog_name]).phrases.create(actor: row[:phrase_actor],
                                                                       start_in_sec: row[:phrase_start_in_sec],
                                                                       end_in_sec: row[:phrase_end_in_sec],
                                                                       content: row[:phrase_content])

      putc '.'
    end

    puts
  end
end
