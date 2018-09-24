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
    Time.at(phrases.last.end_in_sec).utc.strftime('%H:%M:%S')
  end

  def total_phrases
    object.phrases.length
  end

  def interruptions
    interruptions = []
    phrases.each_with_index do |_phrase, index|
      interruptions << phrases[index + 1] if phrases[index + 1].start_in_sec < phrases[index].end_in_sec
      break if index == phrases.size - 2
    end
    interruptions
  end

  def long_breaks
    breaks = []
    phrases.each_with_index do |phrase, index|
      breaks << phrase if phrases[index].start_in_sec - phrases[index - 1].end_in_sec > 5
    end
    breaks
  end
end
