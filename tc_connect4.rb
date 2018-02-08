# File: tc_simple_number.rb
require_relative 'connect4'
require 'test/unit'

# connect 4 test class
class TestConnect4 < Test::Unit::TestCase

  def setup
    @game = Connect4.new
  end

  def teardown
    nil
  end

  def test_fill_grid_player1
    @game.fill_grid(0)
    @game.fill_grid(0)
    @game.fill_grid(0)
    @game.fill_grid(0)
    assert_equal([1, 1, 1, 1, nil, nil], @game.report_grid[0])
    @game.fill_grid(0)
    @game.fill_grid(0)
    assert_equal(false, @game.fill_grid(0))
  end

  def test_fill_grid_player2
    @game.switch_player
    @game.fill_grid(1)
    @game.fill_grid(1)
    @game.fill_grid(1)
    @game.fill_grid(1)
    assert_equal([2, 2, 2, 2, nil, nil], @game.report_grid[1])
    @game.fill_grid(1)
    @game.fill_grid(1)
    assert_equal(false, @game.fill_grid(1))
  end

  def test_play
    assert_equal('Player 1 has a turn', @game.play(0))
    assert_equal('Player 2 has a turn', @game.play(0))
    @game.play(0)
    @game.play(0)
    @game.play(0)
    @game.play(0)
    assert_equal('Column full!', @game.play(0))
  end

  def test_column_full
    @game.play(0)
    @game.play(0)
    @game.play(0)
    @game.play(0)
    @game.play(0)
    @game.play(0)
    @game.play(1)
    @game.play(1)
    @game.play(1)
    @game.play(1)
    @game.play(1)
    @game.play(1)
    assert_equal('Column full!', @game.play(0))
    assert_equal('Column full!', @game.play(1))
    assert_equal([1, 2, 1, 2, 1, 2], @game.report_grid[0])
    assert_equal([1, 2, 1, 2, 1, 2], @game.report_grid[1])
  end

  def test_win_vert_player1
    @game.play(0)
    @game.play(1)
    @game.play(0)
    @game.play(1)
    @game.play(0)
    @game.play(1)
    assert_equal("Player 1 wins!", @game.play(0))
    assert_equal("Game has finished!", @game.play(0))
  end

  def test_win_vert_player2
    @game.play(0)
    @game.play(1)
    @game.play(3)
    @game.play(1)
    @game.play(0)
    @game.play(1)
    @game.play(3)
    assert_equal("Player 2 wins!", @game.play(1))
    assert_equal("Game has finished!", @game.play(0))
  end

  def test_win_horz_player1
    @game.play(0)
    @game.play(0)
    @game.play(1)
    @game.play(1)
    @game.play(2)
    @game.play(2)
    assert_equal('Player 1 wins!', @game.play(3))
    assert_equal("Game has finished!", @game.play(0))
  end

  def test_win_horz_player2
    @game.play(0)
    @game.play(0)
    @game.play(1)
    @game.play(1)
    @game.play(2)
    @game.play(2)
    @game.play(2)
    @game.play(3)
    @game.play(2)
    assert_equal('Player 2 wins!', @game.play(3))
    assert_equal("Game has finished!", @game.play(0))
  end

end
