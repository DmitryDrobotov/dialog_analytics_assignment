class Phrase < ApplicationRecord
  belongs_to :dialog

  validates :actor, presence: true
  validates :start_in_sec, presence: true, numericality: { only_integer: true }
  validates :end_in_sec, presence: true, numericality: { only_integer: true }
  validates :content, presence: true

  # this return previous record or nil
  def previous 
    prev = Phrase.where('id < ?', id).last
    return prev if prev.dialog_id == dialog_id
  end 
end
