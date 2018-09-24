module DialogsHelper
  def check_for_alert(phrase, index)
    if index > 0 && phrase.start_in_sec < @dialog.phrases[index - 1].end_in_sec
      'alert-danger'
    elsif index > 0 && phrase.start_in_sec - @dialog.phrases[index - 1].end_in_sec >= 5
      'alert-warning'
    else
      ''
    end
  end
end
