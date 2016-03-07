defmodule ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT

  defmodule IOAssert do
    def assert_with_input(input, action_fn) do
     capture_io([input: input], fn -> action_fn.() end)
    end

    def stdout_assert(action_fn, assert_fn) do
     capture_io(fn -> action_fn.() end)
     |> assert_fn.()
    end
  end

  test "it receives valid board size choice" do
    user_input = "1"
    action_fn = fn -> assert TTT.Console.request_board_size == user_input end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives invalid board size choice" do
    user_input = "a"
    action_fn = fn -> assert TTT.Console.request_board_size == :invalid end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives valid game_type choice" do
    user_input = "1"
    action_fn = fn -> assert TTT.Console.request_game_type == user_input end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives invalid game_type choice" do
    user_input = "a"
    action_fn = fn -> assert TTT.Console.request_game_type == :invalid end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it displays HVH game with 3x3 board" do
    board_dimension = 3
    row1 = "1 | 2 | 3\n"
    row2 = "4 | 5 | 6\n"
    row3 = "7 | 8 | 9\n"
    row_divider = "____________\n"
    expected = row1 <> row_divider <>row2 <> row_divider <> row3
    empty_board = TTT.Board.empty_board(board_dimension)
    action_fn = fn -> TTT.Console.display_board(empty_board) end
    assert_fn = fn(result) -> assert String.contains?(result, expected) end
    IOAssert.stdout_assert(action_fn, assert_fn)
  end
end
