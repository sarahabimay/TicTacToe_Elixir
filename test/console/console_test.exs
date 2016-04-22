defmodule ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias TTT.Console.Console
  alias TTT.Board.Board
  alias TTT.Console.BoardDisplay

  defmodule IOAssert do
    def assert_with_input(input, action_fn) do
     capture_io([input: input], fn -> action_fn.() end)
    end

    def stdout_assert(action_fn, assert_fn) do
     capture_io(fn -> action_fn.() end)
     |> assert_fn.()
    end
  end

  test "it receives a board size choice" do
    user_input = "0\n1"
    expected_size = 3
    action_fn = fn -> assert Console.request_board_size() == expected_size end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives a game_type choice" do
    user_input = "0\n1\n"
    expected = "HVH"
    action_fn = fn -> assert Console.request_game_type() == expected end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "receives next move" do
    dimension = 3
    board = Board.empty_board(dimension)
    next_move = "5"
    action_fn = fn -> assert Console.request_next_move(board) == 5 end
    IOAssert.assert_with_input(next_move, action_fn)
  end

  test "receives replay game choice" do
    yes_input = "0\n1\n"
    expected = 1
    action_fn = fn -> assert Console.play_again_option() == expected end
    IOAssert.assert_with_input(yes_input, action_fn)
  end

  test "it displays a board" do
    dimension = 3
    empty_board = Board.empty_board(dimension)
    expected_display_board = BoardDisplay.formatted_board(empty_board)
    result = capture_io(fn -> Console.display_board(empty_board) end)
    assert String.contains?(result, expected_display_board)
  end

  test "game is a draw announcement" do
    result = capture_io(fn -> Console.announce_result(false, []) end)
    assert result == "Game Over! The game was a draw.\n"
  end

  test "game is a win announcement" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = ["X", 8, 9]
    board = row1 ++ row2 ++ row3
    result = capture_io(fn -> Console.announce_result(true, board) end)
    assert result == "Game Over! The winner is: X\n"
  end

  test "closing down message" do
    result = capture_io(fn -> Console.closing_down_message() end)
    assert result == "Goodbye and Thanks for playing!\n"
  end

  test "clear the screen" do
    result = capture_io(fn -> Console.clear_screen() end)
    assert result == "\e[2J\e[H"
  end
end
