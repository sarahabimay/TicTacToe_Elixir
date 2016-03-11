defmodule ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  alias TTT.Console

  defmodule IOAssert do
    def assert_with_input(input, action_fn) do
     capture_io([input: input], fn -> action_fn.() end)
    end

    def stdout_assert(action_fn, assert_fn) do
     capture_io(fn -> action_fn.() end)
     |> assert_fn.()
    end
  end

  test "board size options request" do
    board_sizes = ["3X3", "4X4"]
    expected = "[1] 3X3\n[2] 4X4\n"
    result = Console.create_options_for_display(board_sizes)
    assert result == expected
  end

  test "it receives valid board size choice" do
    user_input = "1"
    expected_size = 3
    action_fn = fn -> assert Console.request_board_size == expected_size end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives invalid board size choice" do
    invalid_choice = "a"
    valid_choice = "1"
    user_input = "#{invalid_choice}\n#{valid_choice}"
    expected_size = 3
    action_fn = fn -> assert Console.request_board_size == expected_size end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives valid game_type choice" do
    user_input = "1"
    expected = "HVH"
    action_fn = fn -> assert Console.request_game_type == expected end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives invalid game_type choice" do
    invalid_choice = "a"
    valid_choice = "1"
    user_input = "#{invalid_choice}\n#{valid_choice}"
    expected_type = "HVH"
    action_fn = fn -> assert Console.request_game_type == expected_type end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it displays HVH game with 3x3 board" do
    row1_display = "1 | 2 | 3\n"
    row2_display = "4 | 5 | 6\n"
    row3_display = "7 | 8 | 9\n"
    row_divider = "____________\n"
    expected = row1_display <> row_divider <> row2_display <> row_divider <> row3_display
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    empty_board = row1 ++ row2 ++ row3
    action_fn = fn -> Console.display_board(empty_board) end
    assert_fn = fn(result) -> assert String.contains?(result, expected) end
    IOAssert.stdout_assert(action_fn, assert_fn)
  end

  test "receives valid next move" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    next_move = "5"
    action_fn = fn -> assert Console.request_next_move(board) == 5 end
    IOAssert.assert_with_input(next_move, action_fn)
  end

  test "receives invalid move then valid move" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    moves = "0\n1"
    action_fn = fn -> assert Console.request_next_move(board) == 1 end
    IOAssert.assert_with_input(moves, action_fn)
  end

  test "game is a draw announcement" do
    result = capture_io(fn ->
       Console.announce_draw
    end)
    assert result == "Game Over! The game was a draw.\n"
  end

  test "announce the game was won by X" do
    result = capture_io(fn ->
       Console.announce_win("X")
    end)
    assert result == "Game Over! The winner is: X\n"
  end

  test "clear the screen" do
    result = capture_io(fn ->
      Console.clear_screen
    end)
    assert result == "\e[2J\e[H"
  end
end