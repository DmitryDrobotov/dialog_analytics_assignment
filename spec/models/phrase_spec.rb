require 'rails_helper'

RSpec.describe Phrase, type: :model do
  let(:dialog) { create(:dialog_with_phrases) }
  let(:phrase) { dialog.phrases.second }
  
  describe "#interrupted?" do
    it { expect(phrase.interrupted?).to be_truthy }
  end

  describe "#long_breaks" do
    it { expect(phrase.long_break?).to be_falsey }
  end

  describe "#did_not_have?" do
    it { expect(phrase.did_not_have?).to be_falsey }
  end

  describe ".all_actors" do
    it { expect(Phrase.all_actors).to eq(["A"]) }
  end
end
