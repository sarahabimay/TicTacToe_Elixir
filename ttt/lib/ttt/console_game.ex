defmodule TTT.ConsoleGame do
  alias TTT.Console, as: Console
  alias TTT.Board, as: Board
  alias TTT.BoardPlay, as: BoardPlay
  alias TTT.BoardResult, as: BoardResult

  def start_game do
    [board_size, _] = Console.request_options
    play_game(board_size)
  end

  def play_game(board) when is_list(board) do
    mark = BoardPlay.next_mark_to_play(board)
    move = Console.request_next_move(board, mark)
    new_board = BoardPlay.play_move(board, move, mark)
    Console.display_board(new_board)
    _play_game(BoardResult.game_over?(new_board), new_board)
  end

  def play_game(dimension) do
    board = Board.empty_board(dimension)
    Console.display_board(board)
    play_game(board)
  end

  defp _play_game(false, board), do: play_game(board)
  defp _play_game(true, board), do: Console.announce_result(BoardResult.found_winner?(board), board)
end
