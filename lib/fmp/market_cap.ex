defmodule FMP.MarketCap do
  defstruct [
    :symbol,
    :date,
    :market_cap
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.MarketCap{
        symbol: data["symbol"],
        date: Date.from_iso8601!(data["date"]),
        market_cap: data["marketCap"]
      }
    end)
  end
end
