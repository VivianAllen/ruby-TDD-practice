
def matmult(mat1, mat2)
  if mat1.count != mat2[1].count
    raise ArgumentError.new('matrix 2 must have a row for every column in matrix 1!')
  end
  result = []
  mat1.each do |row|
    outrow = []
    mat2.transpose.each do |col|
      outval = 0
      row.each_with_index { |x, i| outval += x * col[i] }
      outrow.push(outval)
    end
    result.push(outrow)
  end
  result
end
