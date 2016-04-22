defmodule TTT do
  def main(_) do
    TTT.ConsoleGame.start_game(TTT.Board.Board, TTT.Console.Console)
  end
end
