defmodule Factor.Worker do
  use GenServer

  # Callbacks
  def start_link(stack) do
    :gen_server.start_link({ :local, :factor }, __MODULE__, stack, [])
  end

  def init do
    { :ok, [:a, :b, :c] }
  end

  def handle_call(:pop, _from, [h|t]) do
    { :reply, h, t }
  end

  def handle_cast({:push, item}, state) do
    { :noreply, [item|state] }
  end
end
