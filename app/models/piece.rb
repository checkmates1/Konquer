class Piece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  enum status: [:dead, :alive]
  enum color: [:white, :black]

  validates :type, presence: true

  scope :pawns, -> { where(type: 'Pawn') }
  scope :rooks, -> { where(type: 'Rook') }
  scope :knights, -> { where(type: 'Knight') }
  scope :bishops, -> { where(type: 'Bishop') }
  scope :queens, -> { where(type: 'Queen') }
  scope :kings, -> { where(type: 'King') }

  def types
    %w(Pawn Rook Knight Bishop Queen King)
  end

  def obstructed?(destination_x, destination_y)

    # set common variables
    @current_x = x_position
    @current_y = y_position

    @destination_x = destination_x
    @destination_y = destination_y

    @x_difference = @current_x - destination_x
    @y_difference = @current_y - destination_y

    # determine type of move and call relevant method
    return true if check_diagonal?(destination_x)
    return true if check_vertical?(destination_y)
    return true if check_horizontal?(destination_x)
    nil
  end

  def check_diagonal?(destination_x)
    return false unless @x_difference.abs == @y_difference.abs && @x_difference != 0
    y_direction = -@y_difference <=> 0
    if @x_difference < 0
      (@current_x..destination_x).each_with_index do |x, i|
        # x is x value
        # i is distance from original space
        # y is starting y plus i times direction of y
        y = @current_y + (i * y_direction)
        return true if @board[y][x] != 0
      end
    else
      (destination_x..@current_x).each.with_index do |x, i|
        # x is x value
        # i is distance from original space
        # y is starting y plus i times direction of y
        y = @current_y + (i * y_direction)
        return true if @board[y][x] != 0
      end
    end
  end

  def check_vertical?(destination_y)
    return false unless @x_difference.zero? && @y_difference != 0
    if @y_difference < 0
      (@current_y..destination_y).each do |y|
        # check if space is zero, or nil, depending on how @board is built
        return true if @board[y][@current_x] != 0
      end
    else
      (destination_y..@current_y).each do |y|
        # check if space is zero, or nil, depending on how @board is built
        return true if @board[y][@current_x] != 0
      end
    end
  end

  def check_horizontal?(destination_x)
    return false unless @y_difference.zero? && @x_difference != 0
    if @x_difference < 0
      (@current_x..destination_x).each do |x|
        # check if space is zero, or nil, depending on how @board is built
        return true if @board[@current_y][x] != 0
      end
    else
      (destination_x..@current_x).each do |x|
        # check if space is zero, or nil, depending on how @board is built
        return true if @board[@current_y][x] != 0
      end
    end
  end
end
