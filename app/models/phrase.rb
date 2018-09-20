class Phrase < ApplicationRecord
  belongs_to :dialog

  validates :actor, presence: true
  validates :start_in_sec, presence: true, numericality: { only_integer: true }
  validates :end_in_sec, presence: true, numericality: { only_integer: true }
  validates :content, presence: true
end
