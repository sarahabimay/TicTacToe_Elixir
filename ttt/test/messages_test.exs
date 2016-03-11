defmodule MessagesTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Messages

  test "mark X is embedded in the get new move message" do
    mark = "X"
    message = "Player X, Please enter a valid move: "
    assert Messages.request_move_for_mark(mark) == message
  end

  test "board size title" do
    message = "Board Size:\n"
    assert Messages.board_size_title == message
  end

  test "game type title" do
    message = "Game Type:\n"
    assert Messages.game_type_title == message
  end

  test "draw announcement" do
    message = "Game Over! The game was a draw."
    assert Messages.draw_announcement == message
  end

  test "win announcement" do
    message = "Game Over! The winner is: "
    assert Messages.win_announcement == message
  end
end
