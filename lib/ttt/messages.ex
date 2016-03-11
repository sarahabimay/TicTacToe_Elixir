defmodule TTT.Messages do
  def request_move_for_mark(mark), do: "Player #{mark}, Please enter a valid move: "
  def board_size_title(), do: "Board Size:\n"
  def game_type_title(), do:  "Game Type:\n"
  def draw_announcement(), do:  "Game Over! The game was a draw."
  def win_announcement(), do:  "Game Over! The winner is: "
end
