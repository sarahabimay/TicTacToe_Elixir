defmodule TTT.HumanPlayer do
  def next_move(board, display) do
    display.request_next_move(board)
  end
end
