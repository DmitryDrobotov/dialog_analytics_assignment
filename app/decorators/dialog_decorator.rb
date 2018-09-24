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

  def hitching
    hitching = object.hitching
    max_hitching = object.max_hitching
    percentage = percentage(hitching, max_hitching)
    "#{hitching}(#{percentage}%)"
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
