require 'rails_helper'

RSpec.describe Phrase, type: :model do
  before do
    @dialog = create(:dialog_with_phrases)
    @phrase = @dialog.phrases.second
  end
  
  it "#interrupted?" do
    @phrase.interrupted?.should be_truthy
  end

  it "#long_breaks" do
    @phrase.long_break?.should be_falsey
  end

  it ".all_actors" do
    Phrase.all_actors == ["A"]
  end
end
