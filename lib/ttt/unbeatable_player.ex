defmodule TTT.UnbeatablePlayer do
  alias TTT.Board
  alias TTT.BoardPlay
  alias TTT.BoardResult

  def next_move(board, _) do
    ai_mark = TTT.BoardPlay.next_mark_to_play(board)
    [_, move] = minimax(length(Board.available_positions(board)), board, ai_mark, ai_mark, -10000000, 10000000)
    move
  end

  def minimax(depth, current_board, ai_mark, current_mark, alpha, beta) do
    best_score = reset_score(current_mark, ai_mark)
    best_move = -1
    case BoardResult.game_over?(current_board) || depth == 0 do
      true ->
        [board_score(current_board, depth, ai_mark), -1]
      false ->
        score_next_move(depth, current_board, ai_mark, current_mark, best_score, best_move, Board.available_positions(current_board), alpha, beta)
    end
  end

  def score_next_move(_, _, _, _, current_best_score, current_best_move, [], _, _), do: [current_best_score, current_best_move]

  def score_next_move(depth, current_board, ai_mark, current_mark, current_best_score, current_best_move, [next_move | rest ], alpha, beta) do
    state_of_board = BoardPlay.play_move(next_move, current_board)
    [score, _] = minimax(depth - 1, state_of_board, ai_mark, opponent_mark(current_mark), alpha, beta)

    [best_score, best_move] =
    case new_best_score?(ai_mark, current_mark, current_best_score, score) do
      true ->
        [score, next_move]
      false ->
        [current_best_score, current_best_move]
    end
    new_alpha = new_alpha(alpha, score, ai_mark, current_mark)
    new_beta = new_beta(beta, score, ai_mark, current_mark)
    [bs, bm] =
    case new_beta <= new_alpha do
      true ->
        [best_score, best_move]
      false ->
        score_next_move(depth, current_board, ai_mark, current_mark, best_score, best_move, rest, new_alpha, new_beta)
    end
    [bs, bm]
  end

  def new_alpha(alpha, score, ai_mark, mark) when mark == ai_mark do
    Enum.max([alpha, score])
  end

  def new_alpha(alpha, _, ai_mark, mark) when mark != ai_mark do
    alpha
  end

  def new_beta(beta, score, ai_mark, mark) when mark != ai_mark do
    Enum.min([beta, score])
  end

  def new_beta(beta, _, ai_mark, mark) when mark == ai_mark do
    beta
  end

  def better_score(ai_mark, current_mark, current_best_score, score, move) do
    if (new_best_score?(ai_mark, current_mark, current_best_score, score)) do
      [score, move]
    else
      [current_best_score, -1]
    end
  end

  def new_best_score?(ai_mark, mark, best_score, new_score) when mark == ai_mark do
    new_score > best_score
  end

  def new_best_score?(ai_mark, mark, best_score, new_score) when mark != ai_mark do
    new_score < best_score
  end

  def reset_score(current_mark, ai_mark) when current_mark == ai_mark, do: -10000000
  def reset_score(current_mark, ai_mark) when current_mark != ai_mark, do: 10000000

  def free_space?(depth, board) do
    BoardResult.remaining_spaces?(board) || depth == 0
  end

  def board_score(board, depth, ai_mark) do
    get_score(BoardResult.winning_mark(board), ai_mark, depth)
  end

  def get_score(winning_mark, ai_mark, depth) when winning_mark == ai_mark do
    depth
  end

  def get_score(winning_mark, _, _) when is_list(winning_mark) do
    0
  end
  def get_score(_, _, depth) do
    depth * -1
  end

  def opponent_mark("X"), do: "O"
  def opponent_mark("O"), do: "X"
end
