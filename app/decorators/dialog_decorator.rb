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
    interruptions = DialogsHelper.phrase_info(object.id)[:interruptions]
    "#{interruptions} (#{interruptions * 100 / total_phrases}%)"
  end

  def long_breaks
    # "4 (16%)" # replace with interruptions count and percentage relatively to the total count of phrases in the dialog
    long_breaks = DialogsHelper.phrase_info(object.id)[:long_breaks]
    "#{long_breaks} (#{long_breaks * 100 / total_phrases}%)"
  end
end
