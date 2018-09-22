class Dialog < ApplicationRecord
  has_many :phrases, -> { order(:start_in_sec) }, dependent: :destroy
  validates :name, presence: true
  
  def interruptions(dialog)
    interrupt = 0
    dialog.phrases.each do |phrase|
      id = phrase.id + 1
      if Phrase.find_by(id: id)
        interrupt += 1 if Phrase.find_by(id: id).start_in_sec <= phrase.end_in_sec
      end
    end
    max_interrupt = dialog.phrases.length - 1
    percentage = interrupt*100/max_interrupt
    return "#{interrupt}(#{percentage}%)"
  end

  def duration(dialog)
    time = dialog.phrases.last.end_in_sec
    Time.at(time).utc.strftime("%H:%M:%S")
  end

  def long_breaks(dialog)
    breaks = 0
    dialog.phrases.each do |phrase|
      id = phrase.id + 1
      if Phrase.find_by(id: id)
        breaks += 1 if (Phrase.find_by(id: id).start_in_sec - 5) < phrase.end_in_sec
      end
    end
    max_breaks = dialog.phrases.length - 1
    percentage = breaks*100/max_breaks
    return "#{breaks}(#{percentage}%)"
  end
end
