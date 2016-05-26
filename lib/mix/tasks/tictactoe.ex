defmodule Mix.Tasks.Tictactoe do
  use Mix.Task

  def run(_args) do
    TTT.ConsoleGame.start_game(TTT.Board.Board, TTT.Console.Console)
  end
end

