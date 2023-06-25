defmodule FMP.ETF do
  defstruct [
    :symbol,
    :asset_class,
    :aum,
    :avg_volume,
    :cusip,
    :description,
    :domicile,
    :etf_company,
    :expense_ratio,
    :inception_date,
    :isin,
    :name,
    :nav,
    :nav_currency,
    :sectors_list,
    :website,
    :holdings_count
  ]

  def from_json([data]) do
    %FMP.ETF{
      symbol: data["symbol"],
      asset_class: data["assetClass"],
      aum: data["aum"],
      avg_volume: data["avgVolume"],
      cusip: data["cusip"],
      description: data["description"],
      domicile: data["domicile"],
      etf_company: data["etfCompany"],
      expense_ratio: data["expenseRatio"],
      inception_date: Date.from_iso8601!(data["inceptionDate"]),
      isin: data["isin"],
      name: data["name"],
      nav: data["nav"],
      nav_currency: data["navCurrency"],
      sectors_list: FMP.ETFSector.from_json(data["sectorsList"]),
      website: data["website"],
      holdings_count: data["holdingsCount"]
    }
  end
end

defmodule FMP.ETFHolding do
  defstruct [
    :asset,
    :name,
    :isin,
    :cusip,
    :shares_number,
    :weight_percentage,
    :market_value,
    :updated
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.ETFHolding{
        asset: data["asset"],
        name: data["name"],
        isin: data["isin"],
        cusip: data["cusip"],
        shares_number: data["sharesNumber"],
        weight_percentage: data["weightPercentage"],
        market_value: data["marketValue"],
        updated: Date.from_iso8601!(data["updated"])
      }
    end)
  end
end

defmodule FMP.ETFExposure do
  defstruct [
    :etf_symbol,
    :asset_exposure,
    :shares_number,
    :weight_percentage,
    :market_value
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.ETFExposure{
        etf_symbol: data["etfSymbol"],
        asset_exposure: data["assetExposure"],
        shares_number: data["sharesNumber"],
        weight_percentage: data["weightPercentage"],
        market_value: data["marketValue"]
      }
    end)
  end
end

defmodule FMP.ETFCountryWeight do
  defstruct [
    :country,
    :weight_percentage
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.ETFCountryWeight{
        country: data["country"],
        weight_percentage: data["weightPercentage"]
      }
    end)
  end
end

defmodule FMP.ETFSector do
  defstruct [
    :industry,
    :exposure
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.ETFSector{
        industry: data["industry"],
        exposure: data["exposure"]
      }
    end)
  end
end

defmodule FMP.ETFSectorWeight do
  defstruct [
    :sector,
    :weight_percentage
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.ETFSectorWeight{
        sector: data["sector"],
        weight_percentage: data["weightPercentage"]
      }
    end)
  end
end
