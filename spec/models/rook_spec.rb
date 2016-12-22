require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe ".valid_move?" do
    let(:game) { FactoryGirl.create(:game) }
    let(:rook) { FactoryGirl.create(:rook, x_position: 0, y_position: 0, game: game)}

    context "when not valid direction" do

    end

    context "when not valid destination" do

    end

    context "when obstructed" do

    end

    context "when valid" do

    end
  end
end
