defmodule FMP.Peers do
  defstruct [
    :symbol,
    :list
  ]

  def from_json([peers]) do
    %FMP.Peers{
      symbol: peers["symbol"],
      list: peers["peersList"]
    }
  end
end
