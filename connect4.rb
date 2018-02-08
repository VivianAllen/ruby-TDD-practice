# a game of connect 4
class Connect4
  # spec
  # game grid is 6 row x 7 col, zero-based indices
  # players alternate 'dropping' discs on any none-full col, player 1 first
  # play is handled by a 'play' method
  # successful move returns "Player n has a turn!"
  # cols fill up as discs dropped
  # attempt on full col returns "Column full!"
  # four discs in horizontal or diagonal row is win condition, returns
  # "Player n wins!"
  # moves attempted after game won return "Game has finished!"

  def initialize
    @grid = Array.new(7) { Array.new(6) } # game grid
    @player = 1 # player designation, starts with 1
    @game = true # game state (true = being played, false = over)
  end

  def report_grid
    @grid
  end

  def fill_grid(col)
    return false if @grid[col].count(&:nil?).zero?
    # if grid column not full, add player token to first nil position
    i = @grid[col].find_index(nil)
    @grid[col][i] = @player
    true
  end

  def switch_player
    @player == 1 ? @player = 2 : @player = 1
  end

  def win_vert?
    @grid.any? do |col|
      col.each.with_index.count { |x, i| !x.nil? && col[i + 1] == x } >= 3
    end
  end

  def win_horz?
    @grid.transpose.any? do |col|
      col.each.with_index.count { |x, i| !x.nil? && col[i + 1] == x } >= 3
    end
  end

  def check_win
    [win_vert?, win_horz?].any?
  end

  def play(col)
    return 'Game has finished!' unless @game
    if fill_grid(col) && !check_win
      play_msg = "Player #{@player} has a turn"
      switch_player
    elsif check_win
      play_msg = "Player #{@player} wins!"
      @game = false
    else
      play_msg = 'Column full!'
    end
    play_msg
  end
end
