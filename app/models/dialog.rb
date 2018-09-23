class Dialog < ApplicationRecord
  has_many :phrases, -> { order(:start_in_sec) }, dependent: :destroy
  validates :name, presence: true

  def interruptions
    interrupt = 0
    phrases.each do |phrase|
      interrupt += 1 if phrase.interrupted?
    end
    interrupt
  end

  def long_breaks
    breaks = 0
    phrases.each do |phrase|
      breaks += 1 if phrase.long_break?
    end
    breaks
  end

  def max_long_breaks
    phrases.length - 1
  end

  def max_interruptions
    max_long_breaks
  end
end
