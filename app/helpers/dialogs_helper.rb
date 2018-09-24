module DialogsHelper

  def class_for(phrase)
    if @dialog.long_breaks.include?(phrase)
      'alert-warning'
    elsif @dialog.interruptions.include?(phrase)
      'alert-danger'
    end
  end
end
