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
    Time.at(object.phrases.maximum(:end_in_sec)).utc.strftime('%H:%M:%S')
  end

  def total_phrases
    object.phrases.length
  end

  def interruptions
    interruptions = object.phrases.where('is_interruption').count
    "#{interruptions} (#{interruptions * 100 / total_phrases}%)"
  end

  def long_breaks
    long_breaks = object.phrases.where('is_long_break').count
    "#{long_breaks} (#{long_breaks * 100 / total_phrases}%)"
  end
end
