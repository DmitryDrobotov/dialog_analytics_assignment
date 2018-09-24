class DialogDecorator < ApplicationDecorator
  delegate_all

  def duration
    Time.at(phrases.last.end_in_sec).utc.strftime("%H:%M:%S")
  end

  def total_phrases
    phrases.length
  end

  def interruptions
    counter = 0
    array = phrases.map { |x| [x.start_in_sec, x.end_in_sec] }
    array.each_with_index { |val, i| counter += 1 if array[i + 1] && array[i + 1][0] < val[-1] }
    counter
  end

  def long_breaks
    counter = 0
    array = phrases.map { |x| [x.start_in_sec, x.end_in_sec] }
    array.each_with_index { |val, i| counter += 1 if array[i + 1] && array[i + 1][0] - val[-1] >= 5 }
    counter
  end
end
