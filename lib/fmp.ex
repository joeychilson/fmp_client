defmodule FMP do
  alias FMP.ETFHolding
  alias FMP.BalanceSheet
  alias FMP.CashFlowStatement
  alias FMP.ETF
  alias FMP.ETFHolding
  alias FMP.ETFExposure
  alias FMP.ETFCountryWeight
  alias FMP.ETFSectorWeight
  alias FMP.IncomeStatement
  alias FMP.KeyExecutive
  alias FMP.MarketCap
  alias FMP.Peers
  alias FMP.Profile
  alias FMP.Symbol

  @api_v3 "https://financialmodelingprep.com/api/v3"
  @api_v4 "https://financialmodelingprep.com/api/v4"

  @doc """
  Fetches a company's income statements from the FMP API.

  ## Examples

    iex> {:ok, income_statements} = FMP.get_income_statements("320193")
    iex> Enum.count(income_statements) > 0
    true

    iex> {:ok, income_statements} = FMP.get_income_statements("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(income_statements) == 1
    true
  """
  def get_income_statements(cik_or_symbol, params \\ %{}),
    do: get_data(IncomeStatement, "#{@api_v3}/income-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's balance sheets from the FMP API.

  ## Examples

    iex> {:ok, balance_sheets} = FMP.get_balance_sheets("320193")
    iex> Enum.count(balance_sheets) > 0
    true

    iex> {:ok, balance_sheets} = FMP.get_balance_sheets("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(balance_sheets) == 1
    true
  """
  def get_balance_sheets(cik_or_symbol, params \\ %{}),
    do: get_data(BalanceSheet, "#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's cash flow statements from the FMP API.

  ## Examples

    iex> {:ok, cash_flow} = FMP.get_cash_flow_statements("320193")
    iex> Enum.count(cash_flow) > 0
    true

    iex> {:ok, cash_flow} = FMP.get_cash_flow_statements("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(cash_flow) == 1
    true
  """
  def get_cash_flow_statements(cik_or_symbol, params \\ %{}),
    do:
      get_data(
        CashFlowStatement,
        "#{@api_v3}/cash-flow-statement/#{cik_or_symbol}",
        params
      )

  @doc """
  Fetches a company's key executives from the FMP API.

  ## Examples

    iex> {:ok, executives} = FMP.get_key_executives("AAPL")
    iex> Enum.count(executives) > 0
    true
  """
  def get_key_executives(symbol),
    do: get_data(KeyExecutive, "#{@api_v3}/key-executives/#{symbol}")

  @doc """
  Fetches a company's market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.get_market_cap("AAPL")
    iex> market_cap.symbol
    "AAPL"
  """
  def get_market_cap(symbol),
    do: get_data(MarketCap, "#{@api_v3}/market-capitalization/#{symbol}")

  @doc """
  Fetches a company's historical market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.get_historical_market_cap("AAPL")
    iex> Enum.count(market_cap) > 0
    true

    iex> {:ok, market_cap} = FMP.get_historical_market_cap("AAPL", %{limit: 1})
    iex> Enum.count(market_cap) == 1
    true
  """
  def get_historical_market_cap(symbol, params \\ %{}),
    do: get_data(MarketCap, "#{@api_v3}/historical-market-capitalization/#{symbol}", params)

  @doc """
  Fetches a company's peers from the FMP API.

  ## Examples

    iex> {:ok, peers} = FMP.get_peers("AAPL")
    iex> peers.symbol
    "AAPL"
  """
  def get_peers(symbol),
    do: get_data(Peers, "#{@api_v4}/stock_peers?symbol=#{symbol}")

  @doc """
  Fetches a company profile from the FMP API.

  ## Examples

    iex> {:ok, profile} = FMP.get_profile("AAPL")
    iex> profile.symbol
    "AAPL"
  """
  def get_profile(symbol),
    do: get_data(Profile, "#{@api_v3}/profile/#{symbol}")

  @doc """
  Fetches the symbols of all companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_symbols(),
    do: get_data(Symbol, "#{@api_v3}/stock/list")

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_tradable_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_tradable_symbols(),
    do: get_data(Symbol, "#{@api_v3}/available-traded/list")

  @doc """
  Fetches the symbols of all ETFs from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_etfs()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_etfs(),
    do: get_data(Symbol, "#{@api_v3}/etf/list")

  @doc """
  Fetches information about an ETF from the FMP API.

  ## Examples

    iex> {:ok, etf} = FMP.get_etf("SPY")
    iex> etf.symbol
    "SPY"
  """
  def get_etf(symbol),
    do: get_data(ETF, "#{@api_v4}/etf-info?symbol=#{symbol}")

  @doc """
  Fetches the holdings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, holdings} = FMP.get_etf_holdings("SPY")
    iex> Enum.count(holdings) > 0
    true
  """
  def get_etf_holdings(symbol),
    do: get_data(ETFHolding, "#{@api_v3}/etf-holder/#{symbol}")

  @doc """
  Fetches the stock exposure of an ETF from the FMP API.

  ## Examples

    iex> {:ok, stock_exposure} = FMP.get_etf_stock_exposure("SPY")
    iex> Enum.count(stock_exposure) > 0
    true
  """
  def get_etf_stock_exposure(symbol),
    do: get_data(ETFExposure, "#{@api_v3}/etf-stock-exposure/#{symbol}")

  @doc """
  Fetches the country weightings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, country_weightings} = FMP.get_etf_country_weightings("SPY")
    iex> Enum.count(country_weightings) > 0
    true
  """
  def get_etf_country_weightings(symbol),
    do: get_data(ETFCountryWeight, "#{@api_v3}/etf-country-weightings/#{symbol}")

  @doc """
  Fetches the sector weightings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, sector_weightings} = FMP.get_etf_sector_weightings("SPY")
    iex> Enum.count(sector_weightings) > 0
    true
  """
  def get_etf_sector_weightings(symbol),
    do: get_data(ETFSectorWeight, "#{@api_v3}/etf-sector-weightings/#{symbol}")

  @doc false
  defp get(url) do
    api_key = Application.get_env(:fmp_client, :api_key)
    if api_key == nil, do: {:error, :api_key_not_set}

    url =
      if String.contains?(url, "?"),
        do: "#{url}&apikey=#{api_key}",
        else: "#{url}?apikey=#{api_key}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, {:unexpected_status_code, code}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @doc false
  defp get_data(struct, url, params \\ %{}) do
    url = "#{url}?#{URI.encode_query(params)}"

    case get(url) do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, struct.from_resp(resp)}

      error ->
        error
    end
  end
end
