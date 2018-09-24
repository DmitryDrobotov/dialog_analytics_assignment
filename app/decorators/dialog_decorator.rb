class DialogDecorator < ApplicationDecorator
  delegate_all

  def duration
    time = object.phrases.last.end_in_sec
    Time.at(time).utc.strftime("%H:%M:%S")
  end

  def total_phrases
    object.phrases.length
  end

  def interruptions
    interruptions = object.interruptions
    max_interruptions = object.max_interruptions
    percentage = percentage(interruptions, max_interruptions)
    "#{interruptions}(#{percentage}%)"
  end

  def skipped
    skipped_phrases = object.skipped_phrases
    max_skipped_phrases = object.max_skipped_phrases
    percentage = percentage(skipped_phrases, max_skipped_phrases)
    "#{skipped_phrases}(#{percentage}%)"
  end

  def long_breaks
    long_breaks = object.long_breaks
    max_long_breaks = object.max_long_breaks
    percentage = percentage(long_breaks, max_long_breaks)
    "#{long_breaks}(#{percentage}%)"
  end

  def percentage(real_number,max_possible)
    real_number*100/max_possible
  end
end
