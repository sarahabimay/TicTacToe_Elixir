defmodule TTT.Player.PlayerFactory do
  alias TTT.Player.BeatablePlayer
  alias TTT.Player.HumanPlayer
  alias TTT.Player.UnbeatablePlayer
  @choice_to_players %{
                        "HVH" => [HumanPlayer, HumanPlayer],
                        "HVB" => [HumanPlayer, BeatablePlayer],
                        "BVH" => [BeatablePlayer, HumanPlayer],
                        "HVU" => [HumanPlayer, UnbeatablePlayer],
                        "UVH" => [UnbeatablePlayer, HumanPlayer]
                      }
  def select_players(choice) do
    @choice_to_players[choice]
  end
end
