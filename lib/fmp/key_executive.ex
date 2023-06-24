defmodule FMP.KeyExecutive do
  defstruct [
    :title,
    :name,
    :pay,
    :currency_pay,
    :gender,
    :year_born,
    :title_since
  ]

  def from_json(list) do
    Enum.map(list, fn executive ->
      %FMP.KeyExecutive{
        title: executive["title"],
        name: executive["name"],
        pay: executive["pay"],
        currency_pay: executive["currencyPay"],
        gender: executive["gender"],
        year_born: executive["yearBorn"],
        title_since: executive["titleSince"]
      }
    end)
  end
end
