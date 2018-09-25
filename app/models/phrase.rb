class Phrase < ApplicationRecord
  belongs_to :dialog

  validates :actor, presence: true
  validates :start_in_sec, presence: true, numericality: { only_integer: true }
  validates :end_in_sec, presence: true, numericality: { only_integer: true }
  validates :content, presence: true

  def previous 
    prev = Phrase.where('id < ?', id).last
# binding.pry
    return prev if prev.dialog_id == dialog_id
#   Phrase.joins(:dialog).find_by(phrases.id < ?self.id, phrases.dialog_id = ?dialog.dialog_id).last 
  end 

#  def previous
    # Phrase.where("id < ?", id).order("id DESC").first || Phrase.last
    # Phrase.offset(self.id).limit(2).order(id: :desc).last
#  end
end
