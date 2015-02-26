defmodule Keep do
  import :timer, only: [ sleep: 1 ]

  def run do
    Process.flag(:trap_exit, true)
    # ex5
    # MESSAGE RECEIVED: :hello
    # MESSAGE RECEIVED: {:DOWN, #Reference<0.0.0.103>, :process, #PID<0.54.0>, {%RuntimeError{message: "Boom"}, [{Keep, :child, 1, [file: 'ch14/keep.exs', line: 18]}]}}
    spawn_monitor Keep, :child, [self]
    sleep 500
    listen
  end

  def child(parent) do
    send parent, :hello
    # ex3
    # MESSAGE RECEIVED: :hello
    # MESSAGE RECEIVED: {:EXIT, #PID<0.54.0>, :boom}
    # exit(:boom)

    # ex4
    # MESSAGE RECEIVED: :hello
    # MESSAGE RECEIVED: {:EXIT, #PID<0.54.0>, {%RuntimeError{message: "Boom"}, [{Keep, :child, 1, [file: 'ch14/keep.exs', line: 14]}]}}
    raise "Boom"
  end

  def listen do
    receive do
      msg -> IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 -> IO.puts "Nothing"
    end
    listen
  end
end

Keep.run
