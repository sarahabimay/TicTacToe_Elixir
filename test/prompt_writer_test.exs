defmodule PromptWriterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  alias TTT.PromptWriter
  alias TTT.Board
  alias TTT.BoardDisplay

  test "it displays HVH game with 3x3 board" do
    dimension = 3
    empty_board = Board.empty_board(dimension)
    expected_display_board = BoardDisplay.formatted_board(empty_board)
    result = capture_io(fn -> PromptWriter.display_board(empty_board) end)
    assert String.contains?(result, expected_display_board)
  end

  test "game is a draw announcement" do
    result = capture_io(fn -> PromptWriter.announce_draw() end)
    assert result == "Game Over! The game was a draw.\n"
  end

  test "announce the game was won by X" do
    result = capture_io(fn -> PromptWriter.announce_win("X") end)
    assert result == "Game Over! The winner is: X\n"
  end

  test "display closing down message" do
    result = capture_io(fn -> PromptWriter.closing_down_message() end)
    assert result == "Goodbye and Thanks for playing!\n"
  end

  test "clear the screen" do
    result = capture_io(fn -> PromptWriter.clear_screen() end)
    assert result == "\e[2J\e[H"
  end
end
