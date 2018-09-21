class Dialog < ApplicationRecord
  has_many :phrases, -> { order(:start_in_sec) }, dependent: :destroy
  validates :name, presence: true
  
  def interruptions(dialog)
    count_interrupt = 0
    dialog.phrases.each do |phrase|
      id = phrase.id + 1
      if Phrase.find_by(id: id) do
        count_interrupt += 1 if Phrase.find_by(id: id).start_in_sec >= phrase.end_in_sec
        end
      end
    end
    return count_interrupt
  end

  def duration(dialog)
    time = dialog.phrases.last.end_in_sec
    Time.at(time).utc.strftime("%H:%M:%S")
  end

  private
end
