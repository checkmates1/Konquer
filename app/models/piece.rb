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

    # initialize placeholder board
    @board = [
       [0,0,0,0,0],
       [0,0,0,0,0],
       [0,0,1,0,0],
       [0,0,0,0,0],
       [0,0,0,0,0]
     ]

    # set common variables
    @current_x = self.x_position
    @current_y = self.y_position

    @destination_x = destination_x
    @destination_y = destination_y

    @x_difference = @current_x - destination_x
    @y_difference = @current_y - destination_y

    # determine type of move and call relevant method
    if (@x_difference.abs == @y_difference.abs)
      return check_diagonal?(destination_x, destination_y)
    elsif (@x_difference == 0 && @y_difference != 0)
      return check_vertical?(destination_y)
    elsif (@y_difference == 0 && @x_difference != 0)
      return check_horizontal?(destination_x)
    else
      return nil
    end

  end

  def check_diagonal?(destination_x, destination_y)
    y_direction = -@y_difference <=> 0
    if @x_difference < 0
      (@current_x..destination_x).each_with_index do |x, i|
        # x is x value
        # i is distance from original space
        # y is starting y plus i times direction of y
        y = @current_y + (i * y_direction)
        return [x, y] if @board[y][x] != 0
      end
    else
      (destination_x..@current_x).each.with_index do |x, i|
        # x is x value
        # i is distance from original space
        # y is starting y plus i times direction of y
        y = @current_y + (i * y_direction)
        return [x, y] if @board[y][x] != 0
      end
    end

  end

  def check_vertical?(destination_y)
    if @y_difference < 0
      (@current_y..destination_y).each do |y|
        #check if space is zero, or nil, depending on how @board is built
        return [@current_x, y] if @board[y][@current_x] != 0
      end
    else
      (destination_y..@current_y).each do |y|
        #check if space is zero, or nil, depending on how @board is built
        return [@current_x, y] if @board[y][@current_x] != 0
      end
    end
  end

  def check_horizontal?(destination_x)
    if @x_difference < 0
      (@current_x..destination_x).each do |x|
        #check if space is zero, or nil, depending on how @board is built
        return [x, @current_y] if @board[@current_y][x] != 0
      end
    else
      (destination_x..@current_x).each do |x|
        #check if space is zero, or nil, depending on how @board is built
        return [x, @current_y] if @board[@current_y][x] != 0
      end
    end
  end

end
