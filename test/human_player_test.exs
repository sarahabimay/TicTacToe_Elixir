defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  alias TTT.HumanPlayer
  alias TTT.Console

  test "get next move from display" do
    next_move = "1"
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    result = capture_io([input: next_move, capture_prompt: false], fn ->
      IO.write HumanPlayer.next_move(board, Console)
    end)
    assert result == next_move
  end
end
