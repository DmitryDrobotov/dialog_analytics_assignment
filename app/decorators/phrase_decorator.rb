class PhraseDecorator < ApplicationDecorator
  delegate_all

  def colored_phrase
    klass = if object.interrupted?
      "alert-danger"
    elsif object.long_break?
      "alert-warning"
    elsif object.skipped?
      "alert-secondary"
    else 
      ""
    end
    helpers.content_tag :div, class: "alert #{klass}" do
      "#{object.actor}: #{object.content}"
    end
  end
end
