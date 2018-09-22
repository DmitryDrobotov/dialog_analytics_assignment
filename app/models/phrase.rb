class Phrase < ApplicationRecord
  belongs_to :dialog

  validates :actor, presence: true
  validates :start_in_sec, presence: true, numericality: { only_integer: true }
  validates :end_in_sec, presence: true, numericality: { only_integer: true }
  validates :content, presence: true

  def interrupt(phrase)
    if phrase.befor_phrase(phrase)
      phrase.befor_phrase(phrase).end_in_sec > phrase.start_in_sec
    end
  end

  def breaks(phrase)
    if phrase.befor_phrase(phrase)
      phrase.befor_phrase(phrase).end_in_sec < phrase.start_in_sec - 5
    end
  end
  
  def following_phrase(phrase)
    id = phrase.id + 1
    Phrase.find(id)
  end

  def befor_phrase(phrase)
    id = phrase.id - 1
    Phrase.find(id)
  end
end
