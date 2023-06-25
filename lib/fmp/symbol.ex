defmodule FMP.Symbol do
  defstruct [
    :symbol,
    :name,
    :price,
    :exchange,
    :exchange_short_name,
    :type
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.Symbol{
        symbol: data["symbol"],
        name: data["name"],
        price: data["price"],
        exchange: data["exchange"],
        exchange_short_name: data["exchangeShortName"],
        type: data["type"]
      }
    end)
  end
end
