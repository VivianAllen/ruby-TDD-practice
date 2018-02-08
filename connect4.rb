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

  def view_grid
    @grid.each { |x| puts x.inspect }
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

  def diagonalise(in_grid)
    # get diagonals proc
    get_diagonals = proc do |grid|
      diagonals = []
      grid.each_index do |start_i|
        curr_diagonal = []
        col_i = start_i
        row_i = 0
        while col_i < grid.length && row_i < grid[col_i].length
          curr_diagonal.push(grid[col_i][row_i])
          col_i += 1
          row_i += 1
        end
        diagonals.push(curr_diagonal)
      end
      diagonals
    end
    # get all diagonals and concatenate
    diags1 = get_diagonals.call(in_grid)
    diags2 = get_diagonals.call(in_grid.transpose)
    diags3 = get_diagonals.call(in_grid.reverse)
    diags4 = get_diagonals.call(in_grid.reverse.transpose)
    diags1.concat(diags2[1..-1]).concat(diags3).concat(diags4[1..-1])
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

  def win_diag?
    diagonalise(@grid).any? do |col|
      col.each.with_index.count { |x, i| !x.nil? && col[i + 1] == x } >= 3
    end
  end

  def check_win
    [win_vert?, win_horz?, win_diag?].any?
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
