class Phrase < ApplicationRecord
  belongs_to :dialog

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

  def self.all_actors
    Phrase.pluck(:actor).uniq
  end

  private

  def following
    @following ||= dialog.phrases.where("start_in_sec > ?", start_in_sec).first
  end

  def previous
    @previous ||= dialog.phrases.where("start_in_sec < ?", start_in_sec).last
  end
end
