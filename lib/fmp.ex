defmodule FMP do
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
    do: get("#{@api_v3}/income-statement/#{cik_or_symbol}", params)

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
    do: get("#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", params)

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
    do: get("#{@api_v3}/cash-flow-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's financial ratios from the FMP API.

  ## Examples

    iex> {:ok, ratios} = FMP.get_financial_ratios("AAPL")
    iex> Enum.count(ratios) > 0
    true

    iex> {:ok, ratios} = FMP.get_financial_ratios("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(ratios) == 1
    true
  """
  def get_financial_ratios(symbol, params \\ %{}), do: get("#{@api_v3}/ratios/#{symbol}", params)

  @doc """
  Fetches a company's financial scores from the FMP API.

  ## Examples

    iex> {:ok, scores} = FMP.get_financial_scores("AAPL")
    iex> scores.symbol
    "AAPL"
  """
  def get_financial_scores(symbol), do: get("#{@api_v4}/score?symbol=#{symbol}")

  @doc """
  Fetches a company's enterprise value from the FMP API.

  ## Examples

    iex> {:ok, enterprise_value} = FMP.get_enterprise_value("AAPL")
    iex> enterprise_value.symbol
    "AAPL"
  """
  def get_enterprise_value(symbol, params \\ %{}),
    do: get("#{@api_v3}/enterprise-values/#{symbol}", params)

  @doc """
  Fetches a company's key executives from the FMP API.

  ## Examples

    iex> {:ok, executives} = FMP.get_key_executives("AAPL")
    iex> Enum.count(executives) > 0
    true
  """
  def get_key_executives(symbol), do: get("#{@api_v3}/key-executives/#{symbol}")

  @doc """
  Fetches a company's market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.get_market_cap("AAPL")
    iex> market_cap.symbol
    "AAPL"
  """
  def get_market_cap(symbol), do: get("#{@api_v3}/market-capitalization/#{symbol}")

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
    do: get("#{@api_v3}/historical-market-capitalization/#{symbol}", params)

  @doc """
  Fetches a company's peers from the FMP API.

  ## Examples

    iex> {:ok, peers} = FMP.get_peers("AAPL")
    iex> peers.symbol
    "AAPL"
  """
  def get_peers(symbol), do: get("#{@api_v4}/stock_peers?symbol=#{symbol}")

  @doc """
  Fetches a company profile from the FMP API.

  ## Examples

    iex> {:ok, profile} = FMP.get_profile("AAPL")
    iex> profile.symbol
    "AAPL"
  """
  def get_profile(symbol), do: get("#{@api_v3}/profile/#{symbol}")

  @doc """
  Fetches the symbols of all companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_symbols(), do: get("#{@api_v3}/stock/list")

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_tradable_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_tradable_symbols(), do: get("#{@api_v3}/available-traded/list")

  @doc """
  Fetches the symbols of all ETFs from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_etfs()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_etfs(), do: get("#{@api_v3}/etf/list")

  @doc """
  Fetches information about an ETF from the FMP API.

  ## Examples

    iex> {:ok, etf} = FMP.get_etf("SPY")
    iex> etf.symbol
    "SPY"
  """
  def get_etf(symbol), do: get("#{@api_v4}/etf-info?symbol=#{symbol}")

  @doc """
  Fetches the holdings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, holdings} = FMP.get_etf_holdings("SPY")
    iex> Enum.count(holdings) > 0
    true
  """
  def get_etf_holdings(symbol), do: get("#{@api_v3}/etf-holder/#{symbol}")

  @doc """
  Fetches the stock exposure of an ETF from the FMP API.

  ## Examples

    iex> {:ok, stock_exposure} = FMP.get_etf_stock_exposure("SPY")
    iex> Enum.count(stock_exposure) > 0
    true
  """
  def get_etf_stock_exposure(symbol), do: get("#{@api_v3}/etf-stock-exposure/#{symbol}")

  @doc """
  Fetches the country weightings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, country_weightings} = FMP.get_etf_country_weightings("SPY")
    iex> Enum.count(country_weightings) > 0
    true
  """
  def get_etf_country_weightings(symbol), do: get("#{@api_v3}/etf-country-weightings/#{symbol}")

  @doc """
  Fetches the sector weightings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, sector_weightings} = FMP.get_etf_sector_weightings("SPY")
    iex> Enum.count(sector_weightings) > 0
    true
  """
  def get_etf_sector_weightings(symbol), do: get("#{@api_v3}/etf-sector-weightings/#{symbol}")

  @doc false
  defp get(url, params \\ %{}) do
    api_key = Application.get_env(:fmp_client, :api_key)
    if api_key == nil, do: {:error, :api_key_not_set}

    url = if params == %{}, do: url, else: "#{url}?#{URI.encode_query(params)}"

    url =
      if String.contains?(url, "?"),
        do: "#{url}&apikey=#{api_key}",
        else: "#{url}?apikey=#{api_key}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode!(body, keys: :atoms) do
          [] -> {:error, :not_found}
          data -> {:ok, data}
        end

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, {:unexpected_status_code, code}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
