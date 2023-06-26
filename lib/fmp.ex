defmodule FMP do
  @api_v3 "https://financialmodelingprep.com/api/v3"
  @api_v4 "https://financialmodelingprep.com/api/v4"

  @doc """
  Fetches a company's financial reports dates from the FMP API.

  ## Examples

    iex> {:ok, dates} = FMP.get_financial_reports_dates("AAPL")
    iex> Enum.count(dates) > 0
    true
  """
  def get_financial_reports_dates(symbol),
    do: get("#{@api_v4}/financial-reports-dates?symbol=#{symbol}")

  @doc """
  Fetches a list of a company's earnings call transcripts from the FMP API.

  ## Examples

    iex> {:ok, transcript} = FMP.get_earnings_call_transcript("AAPL")
    iex> Enum.count(transcript) > 0
    true
  """
  def get_earnings_call_transcript(symbol),
    do: get("#{@api_v4}/earning_call_transcript?symbol=#{symbol}")

  @doc """
  Fetches the earnings call transcripts for a company for a given year.

  ## Examples

    iex> {:ok, transcript} = FMP.get_earnings_call_transcript("AAPL", 2020)
    iex> Enum.count(transcript) > 0
    true
  """
  def get_earnings_call_transcript(symbol, year),
    do: get("#{@api_v4}/batch_earning_call_transcript/#{symbol}?year=#{year}")

  @doc """
  Fetches the earnings call transcripts for a company for a given year and quarter.

  ## Examples

    iex> {:ok, transcript} = FMP.get_earnings_call_transcript("AAPL", 2020, 1)
    iex> transcript.year == 2020 && transcript.quarter == 1
    true
  """
  def get_earnings_call_transcript(symbol, year, quarter) do
    case get("#{@api_v3}/earning_call_transcript/#{symbol}?year=#{year}&quarter=#{quarter}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

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
  Fetches a company's revenue product segmentation from the FMP API.

  The response is not the same as the API documentation. We reshape the data to make it easier to work with.

  ## Examples

    iex> {:ok, product_segmentation} = FMP.get_product_segmentation("AAPL")
    iex> Enum.count(product_segmentation) > 0
    true
  """
  def get_product_segmentation(symbol) do
    resp = get("#{@api_v4}/revenue-product-segmentation?symbol=#{symbol}&structure=flat")

    case resp do
      {:ok, data} ->
        reshaped_data =
          Enum.map(data, fn map ->
            [date_product_tuple] = Map.to_list(map)
            {date, product_data} = date_product_tuple

            %{
              date: to_string(date),
              products:
                Map.to_list(product_data)
                |> Enum.map(fn {product, revenue} ->
                  %{
                    name: to_string(product),
                    revenue: revenue
                  }
                end)
            }
          end)

        {:ok, reshaped_data}

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Fetches a company's revenue geographic segmentation from the FMP API.

  The response is not the same as the API documentation. We reshape the data to make it easier to work with.

  ## Examples

    iex> {:ok, geographic_segmentation} = FMP.get_geographic_segmentation("AAPL")
    iex> Enum.count(geographic_segmentation) > 0
    true
  """
  def get_geographic_segmentation(symbol) do
    resp = get("#{@api_v4}/revenue-geographic-segmentation?symbol=#{symbol}&structure=flat")

    case resp do
      {:ok, data} ->
        reshaped_data =
          Enum.map(data, fn map ->
            [date_country_tuple] = Map.to_list(map)
            {date, country_data} = date_country_tuple

            %{
              date: to_string(date),
              countries:
                Map.to_list(country_data)
                |> Enum.map(fn {country, revenue} ->
                  %{
                    name: to_string(country),
                    revenue: revenue
                  }
                end)
            }
          end)

        {:ok, reshaped_data}

      {:error, _} = error ->
        error
    end
  end

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
  def get_financial_scores(symbol) do
    case get("#{@api_v4}/score?symbol=#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

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
  def get_market_cap(symbol) do
    case get("#{@api_v3}/market-capitalization/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

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
  def get_peers(symbol) do
    case get("#{@api_v4}/stock_peers?symbol=#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company profile from the FMP API.

  ## Examples

    iex> {:ok, profile} = FMP.get_profile("AAPL")
    iex> profile.symbol
    "AAPL"
  """
  def get_profile(symbol) do
    case get("#{@api_v3}/profile/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's shares float from the FMP API.

  ## Examples

    iex> {:ok, shares_float} = FMP.get_shares_float("AAPL")
    iex> shares_float.symbol
    "AAPL"
  """
  def get_shares_float(symbol) do
    case get("#{@api_v4}/shares_float?symbol=#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

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
  def get_etf(symbol) do
    case get("#{@api_v4}/etf-info?symbol=#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

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

  @doc """
  Fetches the SEC rss feed from the FMP API.

  ## Examples

    iex> {:ok, rss_feed} = FMP.get_rss_feed()
    iex> Enum.count(rss_feed) > 0
    true
  """
  def get_rss_feed(params \\ %{}), do: get("#{@api_v3}/rss_feed", params)

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
