defmodule MyList do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def mapsum([], _func), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  def max([]), do: nil
  def max([head | tail]), do: _max(tail, head)
  defp _max([], max_val), do: max_val
  defp _max([head | tail], max_val) when head >= max_val, do: _max(tail, head)
  defp _max([head | tail], max_val) when head < max_val, do: _max(tail, max_val)

  # def max1([]), do: nil
  # def max1([ max1 ]), do: max1
  # def max1([ max1 | [head|tail] ]) when max1 >= head, do: max1([ max1 | tail ])
  # def max1([ max1 | [head|tail] ]) when max1 <  head, do: max1([ head | tail ])

  def caesar([], _n), do: []
  def caesar([head | tail], n) when head+n <= ?z, do: [head + n | caesar(tail, n)]
  def caesar([head | tail], n) when head+n > ?z, do: [head + n - 26 | caesar(tail, n)]

  def span(one, one), do: [one]
  def span(from, to) when from < to, do: [from | span(from + 1, to)]
  def span(from, to) when from > to, do: raise "From must be less than to"

end
