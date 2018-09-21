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
  def actors
    "#{object.phrases.first.actor} and #{object.phrases.second.actor}"
  end

  def duration
    object.duration(object)
  end

  def total_phrases
    object.phrases.length
  end

  def interruptions
    object.interruptions(object)
  end

  def long_breaks
    "4 (16%)" # replace with interruptions count and percentage relatively to the total count of phrases in the dialog
  end
end
