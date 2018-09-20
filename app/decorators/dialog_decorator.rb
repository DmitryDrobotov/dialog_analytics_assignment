class DialogDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def duration
    '00:00:00' # replace with a duration of the dialog
  end

  def total_phrases
    object.phrases.length
  end

  def interruptions
    "2 (10%)" # replace with interruptions count and percentage relatively to the total count of phrases in the dialog
  end

  def long_breaks
    "4 (16%)" # replace with interruptions count and percentage relatively to the total count of phrases in the dialog
  end
end
