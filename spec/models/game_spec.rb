require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '.check?' do
    let(:game) { FactoryGirl.create(:game) }

    it 'should return true' do
      FactoryGirl.create(:pawn, x_position: 4, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 3, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 2, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 3, y_position: 1, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game)
      expect(game.check?).to eq true
    end

    it 'should return false' do
      FactoryGirl.create(:pawn, x_position: 4, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 3, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:pawn, x_position: 2, y_position: 2, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 0, color: 'white', game: game)
      expect(game.check?).to eq false
    end
  end

  describe '.stalemate?' do
    let(:user_white) { FactoryGirl.create(:user) }
    let(:user_black) { FactoryGirl.create(:user) }
    let(:game) { FactoryGirl.create(:game, white_player: user_white, black_player: user_black, active_player: user_black) }

    it 'should return true' do
      FactoryGirl.create(:king, x_position: 0, y_position: 0, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 2, y_position: 1, color: 'white', game: game)
      FactoryGirl.create(:queen, x_position: 1, y_position: 2, color: 'white', game: game)
      expect(game.stalemate?).to eq true
    end

    it 'should return false' do
      FactoryGirl.create(:king, x_position: 0, y_position: 0, color: 'black', game: game)
      FactoryGirl.create(:king, x_position: 3, y_position: 2, color: 'white', game: game)
      FactoryGirl.create(:queen, x_position: 2, y_position: 3, color: 'white', game: game)
      expect(game.stalemate?).to eq false
    end
  end

  describe '.forfeit' do
    let(:white_player) { FactoryGirl.create(:user, wins: 0, losses: 0) }
    let(:black_player) { FactoryGirl.create(:user, wins: 0, losses: 0) }
    let(:game) { FactoryGirl.create(:game, white_player: white_player, black_player: black_player) }

    it 'increments white_player losses and black_player wins by 1 if white_player forfeits' do
      game.forfeit(white_player)
      expect(white_player.losses).to eq 1
      expect(black_player.wins).to eq 1
      expect(game.reload.winning_player).to eq black_player
    end
    it 'increments black_player losses and white_player wins by 1 if black_player forfeits' do
      game.forfeit(black_player)
      expect(black_player.losses).to eq 1
      expect(white_player.wins).to eq 1
      expect(game.reload.winning_player).to eq white_player
    end
  end

  describe 'active_player_valid?' do
    it "allows active_player to be white player" do
      g=FactoryGirl.create(:game)
      g.active_player = g.white_player
      expect(g).to be_valid
      expect(g.active_player).to eq g.white_player
    end

    it "allows active_player to be black player" do
      g=FactoryGirl.create(:game)
      g.active_player = g.black_player
      expect(g).to be_valid
      expect(g.active_player).to eq g.black_player
    end

    it "does not allow active_player to be some third player" do
      g=FactoryGirl.create(:game)
      u= FactoryGirl.create(:user)
      g.active_player = u
      expect(g.active_player_valid?).to eq false
    end
  end

  describe 'assign_active_player' do
    let(:white_player) { FactoryGirl.create(:user) }
    let(:black_player) { FactoryGirl.create(:user) }
    let(:game) { FactoryGirl.create(:game, white_player: white_player, black_player: black_player) }
    it 'should set active_player to white_player' do
      game.assign_active_player(white_player)
      expect(game.active_player).to eq white_player
    end
    it 'should set active_player to black_player' do
      game.assign_active_player(black_player)
      expect(game.active_player).to eq black_player
    end
  end
end
