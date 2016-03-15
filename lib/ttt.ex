defmodule TTT do
  def run do
    TTT.ConsoleGame.start_game(TTT.Board.empty_board(), TTT.Console)
  end
end
