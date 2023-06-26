defmodule FMP.Profile do
  defstruct [
    :ceo,
    :zip,
    :exchange_short_name,
    :country,
    :full_time_employees,
    :dcf,
    :website,
    :is_adr,
    :city,
    :state,
    :isin,
    :is_actively_trading,
    :exchange,
    :range,
    :market_cap,
    :is_fund,
    :sector,
    :vol_avg,
    :changes,
    :company_name,
    :is_etf,
    :ipo_date,
    :address,
    :cusip,
    :phone,
    :dcf_diff,
    :price,
    :industry,
    :description,
    :default_image,
    :beta,
    :image,
    :symbol,
    :cik,
    :last_div,
    :currency
  ]

  def from_resp([profile]) do
    %FMP.Profile{
      ceo: profile["ceo"],
      zip: profile["zip"],
      exchange_short_name: profile["exchangeShortName"],
      country: profile["country"],
      full_time_employees: String.to_integer(profile["fullTimeEmployees"]),
      dcf: profile["dcf"],
      website: profile["website"],
      is_adr: profile["isAdr"],
      city: profile["city"],
      state: profile["state"],
      isin: profile["isin"],
      is_actively_trading: profile["isActivelyTrading"],
      exchange: profile["exchange"],
      range: profile["range"],
      market_cap: profile["mktCap"],
      is_fund: profile["isFund"],
      sector: profile["sector"],
      vol_avg: profile["volAvg"],
      changes: profile["changes"],
      company_name: profile["companyName"],
      is_etf: profile["isEtf"],
      ipo_date: Date.from_iso8601!(profile["ipoDate"]),
      address: profile["address"],
      cusip: profile["cusip"],
      phone: profile["phone"],
      dcf_diff: profile["dcfDiff"],
      price: profile["price"],
      industry: profile["industry"],
      description: profile["description"],
      default_image: profile["defaultImage"],
      beta: profile["beta"],
      image: profile["image"],
      symbol: profile["symbol"],
      cik: profile["cik"],
      last_div: profile["lastDiv"],
      currency: profile["currency"]
    }
  end
end

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

  def from_resp(list) do
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

defmodule FMP.MarketCap do
  defstruct [
    :symbol,
    :date,
    :market_cap
  ]

  def from_resp(list) do
    Enum.map(list, fn data ->
      %FMP.MarketCap{
        symbol: data["symbol"],
        date: Date.from_iso8601!(data["date"]),
        market_cap: data["marketCap"]
      }
    end)
  end
end

defmodule FMP.Peers do
  defstruct [
    :symbol,
    :list
  ]

  def from_resp([peers]) do
    %FMP.Peers{
      symbol: peers["symbol"],
      list: peers["peersList"]
    }
  end
end
