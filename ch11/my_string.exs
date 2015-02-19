defmodule MyString do
  # MyString.check_printable('cat!') # => true
  # MyString.check_printable('∂x/∂y') # => false
  def check_printable(list), do: Enum.all?(list, fn ch -> ch in ?\s..?~ end)

  # MyString.anagram?('cat', 'act') # => true
  # MyString.anagram?('cat', 'actor') # => false
  # MyString.anagram?('incorporates', 'procreations') # => true
  def anagram?(word1, word2), do: Enum.sort(word1) == Enum.sort(word2)
end
