require_relative 'matrix_multiplication'
require 'test/unit'

# connect 4 test class
class TestMatMult < Test::Unit::TestCase

  def test_matmult_integers
    mat1 = [[1, 2, 3], [4, 5, 6]]
    mat2 = [[7, 8], [9, 10], [11, 12]]
    assert_equal([[58, 64], [139, 154]], matmult(mat1, mat2))
  end

  def test_matmult_floats
    mat1 = [[rand, rand, rand], [rand, rand, rand], [rand, rand, rand]]
    mat2 = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    assert_equal(mat1, matmult(mat1, mat2))
    assert_equal(mat1, matmult(mat2, mat1))
  end

  def test_matmult_errors
    mat1 = [[rand, rand], [rand, rand]]
    mat2 = [[rand, rand, rand], [rand, rand, rand], [rand, rand, rand]]
    assert_raise { matmult(mat1, mat2) }
    mat1 = [[rand, rand, rand], [rand, rand, rand]]
    mat2 = [[rand, rand, rand], [rand, rand, rand]]
    assert_raise { matmult(mat1, mat2) }
  end

end
