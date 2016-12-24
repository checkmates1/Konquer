FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end

  factory :game do
    name 'Test_game'
    association :white_player_id, factory: :user
    association :black_player_id, factory: :user
  end

  factory :piece do
    association :game
  end

  factory :rook, parent: :piece, class: 'Rook' do
    type 'Rook'
  end

  factory :pawn, parent: :piece, class: 'Pawn' do
    type 'Pawn'
  end
end
