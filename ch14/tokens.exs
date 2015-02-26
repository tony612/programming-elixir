defmodule Tokens do
  def run do
    receive do
      {sender, message} -> send sender, {:ok, "Token is #{message}"}
      run
    end
  end
end

# clients
pid1 = spawn(Tokens, :run, [])
pid2 = spawn(Tokens, :run, [])

send pid1, {self, "fred"}
send pid2, {self, "betty"}

receive do
  {:ok, message} -> IO.puts message
after 500 -> IO.puts "Timeout"
end

receive do
  {:ok, message} -> IO.puts message
after 500 -> IO.puts "Timeout"
end

# clients 2

pid3 = spawn(Tokens, :run, [])
pid4 = spawn(Tokens, :run, [])

send pid3, {self, "fred"}

receive do
  {:ok, message} ->
    IO.puts message
    send pid4, {self, "betty"}
after 500 -> IO.puts "Timeout"
end

receive do
  {:ok, message} -> IO.puts message
after 500 -> IO.puts "Timeout"
end
