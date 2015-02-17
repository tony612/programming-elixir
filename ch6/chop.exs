defmodule Chop do
  def guess(to_guess, a..b) do
    guess_num = div(a + b, 2)
    IO.puts "Is it #{guess_num}"
    guess(to_guess, a..b, guess_num)
  end

  def guess(to_guess, _range, guess_num) when to_guess == guess_num do
    IO.inspect guess_num
  end

  def guess(to_guess, a.._b, guess_num) when to_guess < guess_num do
    guess(to_guess, a..guess_num-1)
  end

  def guess(to_guess, _a..b, guess_num) when to_guess > guess_num do
    guess(to_guess, (guess_num + 1)..b)
  end
end
