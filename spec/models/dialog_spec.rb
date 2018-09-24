require 'rails_helper'

RSpec.describe Dialog, type: :model do
  before do
    @dialog = create(:dialog_with_phrases)
  end

  it "#long_breaks" do
    @dialog.long_breaks.should eq(0)
  end

  it "#interruptions" do
    @dialog.interruptions.should eq(2)
  end

  it "#max_long_breaks" do
    @dialog.max_long_breaks.should eq(2)
  end
end

