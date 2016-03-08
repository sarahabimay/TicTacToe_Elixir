defmodule TTT.ConsoleGame do
  alias TTT.Console, as: Console
  alias TTT.Board, as: Board

  def start_game do
    [board_size, _] = Console.request_options
    play_game(board_size)
  end

  def play_game(board) when is_list(board) do
    mark = Board.next_mark_to_play(board)
    move = Console.request_next_move(board, mark)
    new_board = Board.play_move(board, move, mark)
    Console.display_board(new_board)
    _play_game(Board.game_over?(new_board), new_board)
  end

  def play_game(dimension) do
    board = Board.empty_board(dimension)
    Console.display_board(board)
    play_game(board)
  end

  def _play_game(false, board), do: play_game(board)
  def _play_game(true, board), do: Console.announce_result(Board.found_winner?(board), board)
end
