require 'rails_helper'

RSpec.describe Dialog, type: :model do
  let(:dialog) { create(:dialog_with_phrases) }

  describe "#long_breaks" do
    it { expect(dialog.long_breaks).to eq(0) }
  end

  describe "#interruptions" do
    it { expect(dialog.interruptions).to eq(2) }
  end

  describe "#max_long_breaks" do
    it { expect(dialog.max_long_breaks).to eq(2) }
  end
end

