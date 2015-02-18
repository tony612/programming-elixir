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


end
