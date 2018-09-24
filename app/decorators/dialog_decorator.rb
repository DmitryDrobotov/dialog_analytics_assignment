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
    phrases[0..-2].each.with_index.with_object([]) do |(_phrase, index), interruptions|
      interruptions << phrases[index + 1] if phrases[index + 1].start_in_sec < phrases[index].end_in_sec
    end
  end

  def long_breaks
    phrases.each.with_index.with_object([]) do |(phrase, index), long_breaks|
      long_breaks << phrase if phrases[index].start_in_sec - phrases[index - 1].end_in_sec > 5
    end
  end

  def interruptions_stat
    "#{interruptions.count} (#{100 / total_phrases * interruptions.count}%)"
  end

  def long_breaks_stat
    "#{long_breaks.count} (#{100 / total_phrases * long_breaks.count}%)"
  end
end
