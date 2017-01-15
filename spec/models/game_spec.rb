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

  describe '.set_default_active_player' do
    let(:white_player) { FactoryGirl.create(:user) }
    let(:game) { FactoryGirl.create(:game, white_player: white_player) }
    it 'should set white_player to active_player at game start' do
      expect(game.active_player).to eq white_player
    end
  end

  # describe 'swap_active_player' do
  #   let(:black_player) { FactoryGirl.create(:user) }
  #   let(:game) { FactoryGirl.create(:game, black_player: black_player) }
  #   it 'should change active_player from white_player to black_player' do
  #     game.active_player = game.white_player
  #     game.swap_active_player(game.white_player)
  #     expect(game.active_player).to eq black_player
  #   end
  # end
end
