module DialogsHelper
  def self.alert_role(phrase)
    breakout = DialogsHelper.break_time(phrase)
    return 'alert-danger' if breakout.negative?
    return 'alert-warning' if breakout > 5
    'alert'
  end

  def self.phrase_info(object_id)
    interruptions = 0
    long_breaks = 0
    phrase_sel = Phrase.where(dialog_id: object_id)
    phrase_sel.each do |phrase|
      next if phrase.id == 1
      breakout = break_time(phrase)
      interruptions += 1 if breakout < 0
      long_breaks += 1 if breakout > 5
    end
    return {interruptions: interruptions, long_breaks: long_breaks}
  end

  def self.actor_list
    Phrase.select(:actor).distinct
  end

  private

  def self.break_time(phrase)
      prev = phrase.previous
      return phrase.start_in_sec - (prev.nil? ? 0 : prev.end_in_sec)
  end
end
