class PhraseDecorator < ApplicationDecorator
  delegate_all

  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def colored_phrase
    klass = if object.interrupted?
      "alert-danger"
    elsif object.long_break?
      "alert-warning"
    else 
      ""
    end
    helpers.content_tag :div, class: "alert #{klass}" do
      "#{object.actor}: #{object.content}"
    end
  end
end
