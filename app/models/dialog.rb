class Dialog < ApplicationRecord
  has_many :phrases, -> { order(:start_in_sec) }, dependent: :destroy

  validates :name, presence: true
end
