defmodule MyList do
  # MyList.all?([2, 4, 6], fn(x) -> rem(x, 2) == 0 end) => true
  # MyList.all?([2, 4, 5], fn(x) -> rem(x, 2) == 0 end) => false
  def all?([], _func), do: true
  def all?([head | tail], func), do: func.(head) && all?(tail, func)

  # MyList.each(["some", "example"], fn(x) -> IO.puts x end)
  # some
  # example
  # :ok
  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  # MyList.filter([1, 2, 3], fn(x) -> rem(x, 2) == 0 end)
  # => [2]
  def filter([], _func), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  # MyList.split([1, 2, 3], 2) => {[1, 2], [3]}
  # MyList.split([1, 2, 3], 10) => {[1, 2, 3], []}
  # MyList.split([1, 2, 3], 0) => {[], [1, 2, 3]}
  def split([], _count), do: {[], []}
  def split(list, count) when count >= 0, do: _split(list, count, [])

  defp _split([head | tail], count, acc) when count > 0, do: _split(tail, count - 1, acc ++ [head])
  defp _split(list, 0, acc), do: {acc, list}
  defp _split([], _, acc), do: {acc, []}

  def take([], _count), do: []
  def take(list, count), do: _take(list, count, [])

  # MyList.take([1, 2, 3], 2) => [1, 2]
  # MyList.take([1, 2, 3], 10) => [1, 2, 3]
  # MyList.take([1, 2, 3], 0) => []
  defp _take([head | tail], count, acc) when count > 0, do: _take(tail, count - 1, acc ++ [head])
  defp _take(_, 0, acc), do: acc
  defp _take([], _, acc), do: acc

  # MyList.flatten([1, [[2], 3]]) => [1, 2, 3]
  # MyList.flatten([1, [2, 3, [4]], 5, [[[6]]]]) => [1, 2, 3, 4, 5, 6]
  def flatten([]), do: []
  def flatten(not_list) when not is_list(not_list), do: [not_list]
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)

  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]

  def primes_up_to(n) do
    range = span(2, n)
    not_primes = for x <- range, y <- range, x < y, x*y <= n, do: x*y
    range -- not_primes
  end

  def orders_with_tax do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    orders = [
      [ id: 123, ship_to: :NC, net_amount: 100.00 ],
      [ id: 124, ship_to: :OK, net_amount:  35.50 ],
      [ id: 125, ship_to: :TX, net_amount:  24.00 ],
      [ id: 126, ship_to: :TX, net_amount:  44.80 ],
      [ id: 127, ship_to: :NC, net_amount:  25.00 ],
      [ id: 128, ship_to: :MA, net_amount:  10.00 ],
      [ id: 129, ship_to: :CA, net_amount: 102.00 ],
      [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]
    for order <- orders,
        order[:ship_to] == :NC || order[:ship_to] == :TX,
        do: Keyword.merge(order, [total_count: order[:net_amount] * (1 + tax_rates[order[:ship_to]])])
  end

end
