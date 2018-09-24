class Phrase < ApplicationRecord
  belongs_to :dialog, optional: true

  validates :actor, presence: true
  validates :start_in_sec, presence: true, numericality: { only_integer: true }
  validates :end_in_sec, presence: true, numericality: { only_integer: true }
  validates :content, presence: true

  def interrupted?
    previous.end_in_sec > start_in_sec if previous
  end

  def long_break?
    previous.end_in_sec < start_in_sec - 5 if previous
  end

  def skipped?
    start_in_sec > end_in_sec
  end

  def self.all_actors
    Phrase.pluck(:actor).uniq
  end

  private

  def previous
    @previous ||= dialog.phrases.where("start_in_sec < ?", start_in_sec).last
  end
end
