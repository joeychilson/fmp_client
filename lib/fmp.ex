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
    do: get("#{@api_v4}/financial-reports-dates", %{symbol: symbol})

  @doc """
  Fetches a list of a company's earnings call transcripts from the FMP API.

  ## Examples

    iex> {:ok, transcript} = FMP.get_earnings_call_transcript("AAPL")
    iex> Enum.count(transcript) > 0
    true
  """
  def get_earnings_call_transcript(symbol),
    do: get("#{@api_v4}/earning_call_transcript", %{symbol: symbol})

  @doc """
  Fetches the earnings call transcripts for a company for a given year.

  ## Examples

    iex> {:ok, transcript} = FMP.get_earnings_call_transcript("AAPL", 2020)
    iex> Enum.count(transcript) > 0
    true
  """
  def get_earnings_call_transcript(symbol, year),
    do: get("#{@api_v4}/batch_earning_call_transcript/#{symbol}", %{year: year})

  @doc """
  Fetches the earnings call transcripts for a company for a given year and quarter.

  ## Examples

    iex> {:ok, transcript} = FMP.get_earnings_call_transcript("AAPL", 2020, 1)
    iex> transcript.year == 2020 && transcript.quarter == 1
    true
  """
  def get_earnings_call_transcript(symbol, year, quarter) do
    case get("#{@api_v3}/earning_call_transcript/#{symbol}", %{year: year, quarter: quarter}) do
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
  Fetches a company's income statement growth from the FMP API.

  ## Examples

    iex> {:ok, income_statement_growth} = FMP.get_income_statement_growth("AAPL")
    iex> Enum.count(income_statement_growth) > 0
    true

    iex> {:ok, income_statement_growth} = FMP.get_income_statement_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(income_statement_growth) == 1
    true
  """
  def get_income_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement-growth/#{symbol}", params)

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
  Fetches a company's balance sheet growth from the FMP API.

  ## Examples

    iex> {:ok, balance_sheet_growth} = FMP.get_balance_sheet_growth("AAPL")
    iex> Enum.count(balance_sheet_growth) > 0
    true

    iex> {:ok, balance_sheet_growth} = FMP.get_balance_sheet_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(balance_sheet_growth) == 1
    true
  """
  def get_balance_sheet_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement-growth/#{symbol}", params)

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
  Fetches a company's cash flow statement growth from the FMP API.

  ## Examples

    iex> {:ok, cash_flow_statement_growth} = FMP.get_cash_flow_statement_growth("AAPL")
    iex> Enum.count(cash_flow_statement_growth) > 0
    true

    iex> {:ok, cash_flow_statement_growth} = FMP.get_cash_flow_statement_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(cash_flow_statement_growth) == 1
    true
  """
  def get_cash_flow_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's financial growth from the FMP API.

  ## Examples

    iex> {:ok, financial_growth} = FMP.get_financial_growth("AAPL")
    iex> Enum.count(financial_growth) > 0
    true

    iex> {:ok, financial_growth} = FMP.get_financial_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(financial_growth) == 1
    true
  """
  def get_financial_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/financial-growth/#{symbol}", params)

  @doc """
  Fetches a company's revenue product segmentation from the FMP API.

  The response is not the same as the API documentation. We reshape the data to make it easier to work with.

  ## Examples

    iex> {:ok, product_segmentation} = FMP.get_product_segmentation("AAPL")
    iex> Enum.count(product_segmentation) > 0
    true
  """
  def get_product_segmentation(symbol) do
    resp = get("#{@api_v4}/revenue-product-segmentation", %{symbol: symbol, structure: "flat"})

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
    resp = get("#{@api_v4}/revenue-geographic-segmentation", %{symbol: symbol, structure: "flat"})

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
  Fetches a company's key metrics from the FMP API.

  ## Examples

    iex> {:ok, key_metrics} = FMP.get_key_metrics("AAPL")
    iex> Enum.count(key_metrics) > 0
    true

    iex> {:ok, key_metrics} = FMP.get_key_metrics("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(key_metrics) == 1
    true
  """
  def get_key_metrics(symbol, params \\ %{}), do: get("#{@api_v3}/key-metrics/#{symbol}", params)

  @doc """
  Fetches a company's key metrics TTM from the FMP API.

  ## Examples

    iex> {:ok, key_metrics_ttm} = FMP.get_key_metrics_ttm("AAPL")
    iex> Enum.count(key_metrics_ttm) > 0
    true

    iex> {:ok, key_metrics_ttm} = FMP.get_key_metrics_ttm("AAPL", %{limit: 1})
    iex> Enum.count(key_metrics_ttm) == 1
    true
  """
  def get_key_metrics_ttm(symbol, params \\ %{}),
    do: get("#{@api_v3}/key-metrics-ttm/#{symbol}", params)

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
    case get("#{@api_v4}/score", %{symbol: symbol}) do
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
  Fetches a company's discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, discounted_cash_flow} = FMP.get_discounted_cash_flow("AAPL")
    iex> discounted_cash_flow.symbol
    "AAPL"
  """
  def get_discounted_cash_flow(symbol) do
    case get("#{@api_v3}/discounted-cash-flow/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, historical_discounted_cash_flow} = FMP.get_historical_discounted_cash_flow("AAPL")
    iex> Enum.count(historical_discounted_cash_flow) > 0
    true
  """
  def get_historical_discounted_cash_flow(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-discounted-cash-flow-statement/#{symbol}", params)

  @doc """
  Fetches a company's historical daily discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, historical_daily_discounted_cash_flow} = FMP.get_historical_daily_discounted_cash_flow("AAPL")
    iex> Enum.count(historical_daily_discounted_cash_flow) > 0
    true
  """
  def get_historical_daily_discounted_cash_flow(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-daily-discounted-cash-flow/#{symbol}", params)

  @doc """
  Fetches a company's advanced discounted cash flow TTM from the FMP API.

  ## Examples

    iex> {:ok, advanced_discounted_cash_flow} = FMP.get_advanced_discounted_cash_flow("AAPL")
    iex> Enum.count(advanced_discounted_cash_flow) > 0
    true
  """
  def get_advanced_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's advanced levered discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, advanced_levered_discounted_cash_flow} = FMP.get_advanced_levered_discounted_cash_flow("AAPL")
    iex> Enum.count(advanced_levered_discounted_cash_flow) > 0
    true
  """
  def get_advanced_levered_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_levered_discounted_cash_flow", %{symbol: symbol})

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
    case get("#{@api_v4}/stock_peers", %{symbol: symbol}) do
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
  Fetches a company's price targets from the FMP API.

  ## Examples

    iex> {:ok, price_targets} = FMP.get_price_targets("AAPL")
    iex> Enum.count(price_targets) > 0
    true
  """
  def get_price_targets(symbol), do: get("#{@api_v4}/price-target", %{symbol: symbol})

  @doc """
  Fetches a company's price targets consensus from the FMP API.

  ## Examples

    iex> {:ok, price_targets_consenus} = FMP.get_price_targets_consenus("AAPL")
    iex> price_targets_consenus.symbol
    "AAPL"
  """
  def get_price_targets_consenus(symbol) do
    case get("#{@api_v4}/price-target-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's price target summary from the FMP API.

  ## Examples

    iex> {:ok, price_target_summary} = FMP.get_price_target_summary("AAPL")
    iex> price_target_summary.symbol
    "AAPL"
  """
  def get_price_target_summary(symbol) do
    case get("#{@api_v4}/price-target-summary", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of price targets by an analyst from the FMP API.

  ## Examples

    iex> {:ok, price_targets} = FMP.get_price_targets_by_analyst("AAPL")
    iex> Enum.count(price_targets) > 0
    true
  """
  def get_price_targets_by_analyst(analyst_name),
    do: get("#{@api_v4}/price-target-analyst-name", %{name: analyst_name})

  @doc """
  Fetches a list of price targets by an analyst company from the FMP API.

  ## Examples

    iex> {:ok, price_targets} = FMP.get_price_targets_by_analyst_company("AAPL")
    iex> Enum.count(price_targets) > 0
    true
  """
  def get_price_targets_by_analyst_company(company),
    do: get("#{@api_v4}/price-target-analyst-company", %{company: company})

  @doc """
  Fetches a company's shares float from the FMP API.

  ## Examples

    iex> {:ok, shares_float} = FMP.get_shares_float("AAPL")
    iex> shares_float.symbol
    "AAPL"
  """
  def get_shares_float(symbol) do
    case get("#{@api_v4}/shares_float", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's rating from the FMP API.

  ## Examples

    iex> {:ok, rating} = FMP.get_rating("AAPL")
    iex> rating.symbol
    "AAPL"
  """
  def get_rating(symbol) do
    case get("#{@api_v3}/rating/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical rating from the FMP API.

  ## Examples

    iex> {:ok, rating} = FMP.get_historical_rating("AAPL")
    iex> Enum.count(rating) > 0
    true

    iex> {:ok, rating} = FMP.get_historical_rating("AAPL", %{limit: 1})
    iex> Enum.count(rating) == 1
    true
  """
  def get_historical_rating(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-rating/#{symbol}", params)

  @doc """
  Fetches a list of company's notes from the FMP API.

  ## Examples

    iex> {:ok, notes} = FMP.get_company_notes("AAPL")
    iex> Enum.count(notes) > 0
    true
  """
  def get_company_notes(symbol), do: get("#{@api_v4}/company-notes", %{symbol: symbol})

  @doc """
  Fetches a company's ESG score from the FMP API.

  ## Examples

    iex> {:ok, esg_scores} = FMP.get_esg_scores("AAPL")
    iex> Enum.count(esg_scores) > 0
    true
  """
  def get_esg_scores(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data", %{symbol: symbol})

  @doc """
  Fetches a company's ESG risk rating from the FMP API.

  ## Examples

    iex> {:ok, esg_risk_ratings} = FMP.get_esg_risk_ratings("AAPL")
    iex> Enum.count(esg_risk_ratings) > 0
    true
  """
  def get_esg_risk_ratings(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data-ratings", %{symbol: symbol})

  @doc """
  Fetches a sector ESG score benchmarks from the FMP API.

  ## Examples

    iex> {:ok, esg_sector_benchmarks} = FMP.get_esg_sector_benchmarks(2020)
    iex> Enum.count(esg_sector_benchmarks) > 0
    true
  """
  def get_esg_sector_benchmarks(year),
    do: get("#{@api_v4}/esg-sector-benchmark", %{year: year})

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
    case get("#{@api_v4}/etf-info", %{symbol: symbol}) do
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
  Fetches the list of sec filings of a company from the FMP API.

  ## Examples

    iex> {:ok, sec_filings} = FMP.get_sec_filings("AAPL")
    iex> Enum.count(sec_filings) > 0
    true
  """
  def get_sec_filings(symbol, params \\ %{}), do: get("#{@api_v3}/sec_filings/#{symbol}", params)

  @doc """
  Fetches the SEC rss feed from the FMP API.

  ## Examples

    iex> {:ok, rss_feed} = FMP.get_rss_feed()
    iex> Enum.count(rss_feed) > 0
    true
  """
  def get_rss_feed(params \\ %{}), do: get("#{@api_v3}/rss_feed", params)

  @doc """
  Fetches the price targets rss feed from the FMP API.

  ## Examples

    iex> {:ok, price_targets_rss_feed} = FMP.get_price_targets_rss_feed()
    iex> Enum.count(price_targets_rss_feed) > 0
    true
  """
  def get_price_targets_rss_feed(params \\ %{}),
    do: get("#{@api_v4}/price-target-rss-feed", params)

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
