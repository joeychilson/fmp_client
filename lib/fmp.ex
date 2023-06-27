defmodule FMP do
  @api_v3 "https://financialmodelingprep.com/api/v3"
  @api_v4 "https://financialmodelingprep.com/api/v4"

  @doc """
  Fetches the trading hours for the current year from the FMP API.

  ## Examples

    iex> {:ok, trading_hours} = FMP.trading_hours()
    iex> trading_hours.stockExchangeName == "New York Stock Exchange"
    true
  """
  def trading_hours(), do: get("#{@api_v3}/is-the-market-open")

  @doc """
  Fetches a list of all delisted companies from the FMP API.

  ## Examples

    iex> {:ok, delisted_companies} = FMP.delisted_companies()
    iex> Enum.count(delisted_companies) > 0
    true
  """
  def delisted_companies(params \\ %{}),
    do: get("#{@api_v3}/delisted-companies", params)

  @doc """
  Fetches a company's financial reports dates from the FMP API.

  ## Examples

    iex> {:ok, dates} = FMP.financial_reports_dates("AAPL")
    iex> Enum.count(dates) > 0
    true
  """
  def financial_reports_dates(symbol),
    do: get("#{@api_v4}/financial-reports-dates", %{symbol: symbol})

  @doc """
  Fetches a list of a company's earnings call transcripts from the FMP API.

  ## Examples

    iex> {:ok, transcript} = FMP.earnings_call_transcript("AAPL")
    iex> Enum.count(transcript) > 0
    true
  """
  def earnings_call_transcript(symbol),
    do: get("#{@api_v4}/earning_call_transcript", %{symbol: symbol})

  @doc """
  Fetches the earnings call transcripts for a company for a given year.

  ## Examples

    iex> {:ok, transcript} = FMP.earnings_call_transcript("AAPL", 2020)
    iex> Enum.count(transcript) > 0
    true
  """
  def earnings_call_transcript(symbol, year),
    do: get("#{@api_v4}/batch_earning_call_transcript/#{symbol}", %{year: year})

  @doc """
  Fetches the earnings call transcripts for a company for a given year and quarter.

  ## Examples

    iex> {:ok, transcript} = FMP.earnings_call_transcript("AAPL", 2020, 1)
    iex> transcript.year == 2020 && transcript.quarter == 1
    true
  """
  def earnings_call_transcript(symbol, year, quarter) do
    case get("#{@api_v3}/earning_call_transcript/#{symbol}", %{year: year, quarter: quarter}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's income statements from the FMP API.

  ## Examples

    iex> {:ok, income_statements} = FMP.income_statements("320193")
    iex> Enum.count(income_statements) > 0
    true

    iex> {:ok, income_statements} = FMP.income_statements("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(income_statements) == 1
    true
  """
  def income_statements(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's income statement growth from the FMP API.

  ## Examples

    iex> {:ok, income_statement_growth} = FMP.income_statement_growth("AAPL")
    iex> Enum.count(income_statement_growth) > 0
    true

    iex> {:ok, income_statement_growth} = FMP.income_statement_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(income_statement_growth) == 1
    true
  """
  def income_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's balance sheets from the FMP API.

  ## Examples

    iex> {:ok, balance_sheets} = FMP.balance_sheets("320193")
    iex> Enum.count(balance_sheets) > 0
    true

    iex> {:ok, balance_sheets} = FMP.balance_sheets("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(balance_sheets) == 1
    true
  """
  def balance_sheets(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's balance sheet growth from the FMP API.

  ## Examples

    iex> {:ok, balance_sheet_growth} = FMP.balance_sheet_growth("AAPL")
    iex> Enum.count(balance_sheet_growth) > 0
    true

    iex> {:ok, balance_sheet_growth} = FMP.balance_sheet_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(balance_sheet_growth) == 1
    true
  """
  def balance_sheet_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's cash flow statements from the FMP API.

  ## Examples

    iex> {:ok, cash_flow} = FMP.cash_flow_statements("320193")
    iex> Enum.count(cash_flow) > 0
    true

    iex> {:ok, cash_flow} = FMP.cash_flow_statements("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(cash_flow) == 1
    true
  """
  def cash_flow_statements(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's cash flow statement growth from the FMP API.

  ## Examples

    iex> {:ok, cash_flow_statement_growth} = FMP.cash_flow_statement_growth("AAPL")
    iex> Enum.count(cash_flow_statement_growth) > 0
    true

    iex> {:ok, cash_flow_statement_growth} = FMP.cash_flow_statement_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(cash_flow_statement_growth) == 1
    true
  """
  def cash_flow_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's financial growth from the FMP API.

  ## Examples

    iex> {:ok, financial_growth} = FMP.financial_growth("AAPL")
    iex> Enum.count(financial_growth) > 0
    true

    iex> {:ok, financial_growth} = FMP.financial_growth("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(financial_growth) == 1
    true
  """
  def financial_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/financial-growth/#{symbol}", params)

  @doc """
  Fetches a company's revenue product segmentation from the FMP API.

  The response is not the same as the API documentation. We reshape the data to make it easier to work with.

  ## Examples

    iex> {:ok, product_segmentation} = FMP.product_segmentation("AAPL")
    iex> Enum.count(product_segmentation) > 0
    true
  """
  def product_segmentation(symbol) do
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

    iex> {:ok, geographic_segmentation} = FMP.geographic_segmentation("AAPL")
    iex> Enum.count(geographic_segmentation) > 0
    true
  """
  def geographic_segmentation(symbol) do
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

    iex> {:ok, key_metrics} = FMP.key_metrics("AAPL")
    iex> Enum.count(key_metrics) > 0
    true

    iex> {:ok, key_metrics} = FMP.key_metrics("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(key_metrics) == 1
    true
  """
  def key_metrics(symbol, params \\ %{}), do: get("#{@api_v3}/key-metrics/#{symbol}", params)

  @doc """
  Fetches a company's key metrics TTM from the FMP API.

  ## Examples

    iex> {:ok, key_metrics_ttm} = FMP.key_metrics_ttm("AAPL")
    iex> Enum.count(key_metrics_ttm) > 0
    true

    iex> {:ok, key_metrics_ttm} = FMP.key_metrics_ttm("AAPL", %{limit: 1})
    iex> Enum.count(key_metrics_ttm) == 1
    true
  """
  def key_metrics_ttm(symbol, params \\ %{}),
    do: get("#{@api_v3}/key-metrics-ttm/#{symbol}", params)

  @doc """
  Fetches a company's financial ratios from the FMP API.

  ## Examples

    iex> {:ok, ratios} = FMP.financial_ratios("AAPL")
    iex> Enum.count(ratios) > 0
    true

    iex> {:ok, ratios} = FMP.financial_ratios("AAPL", %{period: "quarter", limit: 1})
    iex> Enum.count(ratios) == 1
    true
  """
  def financial_ratios(symbol, params \\ %{}), do: get("#{@api_v3}/ratios/#{symbol}", params)

  @doc """
  Fetches a company's financial scores from the FMP API.

  ## Examples

    iex> {:ok, scores} = FMP.financial_scores("AAPL")
    iex> scores.symbol
    "AAPL"
  """
  def financial_scores(symbol) do
    case get("#{@api_v4}/score", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's enterprise value from the FMP API.

  ## Examples

    iex> {:ok, enterprise_value} = FMP.enterprise_value("AAPL")
    iex> enterprise_value.symbol
    "AAPL"
  """
  def enterprise_value(symbol, params \\ %{}),
    do: get("#{@api_v3}/enterprise-values/#{symbol}", params)

  @doc """
  Fetches a company's discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, discounted_cash_flow} = FMP.discounted_cash_flow("AAPL")
    iex> discounted_cash_flow.symbol
    "AAPL"
  """
  def discounted_cash_flow(symbol) do
    case get("#{@api_v3}/discounted-cash-flow/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, historical_discounted_cash_flow} = FMP.historical_discounted_cash_flow("AAPL")
    iex> Enum.count(historical_discounted_cash_flow) > 0
    true
  """
  def historical_discounted_cash_flow(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-discounted-cash-flow-statement/#{symbol}", params)

  @doc """
  Fetches a company's historical daily discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, historical_daily_discounted_cash_flow} = FMP.historical_daily_discounted_cash_flow("AAPL")
    iex> Enum.count(historical_daily_discounted_cash_flow) > 0
    true
  """
  def historical_daily_discounted_cash_flow(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-daily-discounted-cash-flow/#{symbol}", params)

  @doc """
  Fetches a company's advanced discounted cash flow TTM from the FMP API.

  ## Examples

    iex> {:ok, advanced_discounted_cash_flow} = FMP.advanced_discounted_cash_flow("AAPL")
    iex> Enum.count(advanced_discounted_cash_flow) > 0
    true
  """
  def advanced_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's advanced levered discounted cash flow from the FMP API.

  ## Examples

    iex> {:ok, advanced_levered_discounted_cash_flow} = FMP.advanced_levered_discounted_cash_flow("AAPL")
    iex> Enum.count(advanced_levered_discounted_cash_flow) > 0
    true
  """
  def advanced_levered_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_levered_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's key executives from the FMP API.

  ## Examples

    iex> {:ok, executives} = FMP.key_executives("AAPL")
    iex> Enum.count(executives) > 0
    true
  """
  def key_executives(symbol), do: get("#{@api_v3}/key-executives/#{symbol}")

  @doc """
  Fetches a company's executive compensation from the FMP API.

  ## Examples

    iex> {:ok, executive_compensation} = FMP.executive_compensation("AAPL")
    iex> Enum.count(executive_compensation) > 0
    true
  """
  def executive_compensation(symbol),
    do: get("#{@api_v4}/governance/executive_compensation", %{symbol: symbol})

  @doc """
  Fetches the executive compensation benchmark for a year from the FMP API.

  ## Examples

    iex> {:ok, executive_compensation_benchmark} = FMP.executive_compensation_benchmark(2020)
    iex> Enum.count(executive_compensation_benchmark) > 0
    true
  """
  def executive_compensation_benchmark(year),
    do: get("#{@api_v4}/executive-compensation-benchmark", %{year: year})

  @doc """
  Fetches a company's market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.market_cap("AAPL")
    iex> market_cap.symbol
    "AAPL"
  """
  def market_cap(symbol) do
    case get("#{@api_v3}/market-capitalization/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.historical_market_cap("AAPL")
    iex> Enum.count(market_cap) > 0
    true

    iex> {:ok, market_cap} = FMP.historical_market_cap("AAPL", %{limit: 1})
    iex> Enum.count(market_cap) == 1
    true
  """
  def historical_market_cap(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-market-capitalization/#{symbol}", params)

  @doc """
  Fetches a company's peers from the FMP API.

  ## Examples

    iex> {:ok, peers} = FMP.peers("AAPL")
    iex> peers.symbol
    "AAPL"
  """
  def peers(symbol) do
    case get("#{@api_v4}/stock_peers", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company profile from the FMP API.

  ## Examples

    iex> {:ok, profile} = FMP.profile("AAPL")
    iex> profile.symbol
    "AAPL"
  """
  def profile(symbol) do
    case get("#{@api_v3}/profile/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's outlook from the FMP API.

  ## Examples

    iex> {:ok, outlook} = FMP.company_outlook("AAPL")
    iex> outlook.symbol
    "AAPL"
  """
  def company_outlook(symbol), do: get("#{@api_v4}/company-outlook", %{symbol: symbol})

  @doc """
  Fetches a company's historical employee count from the FMP API.

  ## Examples

    iex> {:ok, employee_count} = FMP.historical_employee_count("AAPL")
    iex> Enum.count(employee_count) > 0
    true
  """
  def historical_employee_count(symbol),
    do: get("#{@api_v4}/historical/employee_count", %{symbol: symbol})

  @doc """
  Fetches a company's shares float from the FMP API.

  ## Examples

    iex> {:ok, shares_float} = FMP.shares_float("AAPL")
    iex> shares_float.symbol
    "AAPL"
  """
  def shares_float(symbol) do
    case get("#{@api_v4}/shares_float", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's price targets from the FMP API.

  ## Examples

    iex> {:ok, price_targets} = FMP.price_targets("AAPL")
    iex> Enum.count(price_targets) > 0
    true
  """
  def price_targets(symbol), do: get("#{@api_v4}/price-target", %{symbol: symbol})

  @doc """
  Fetches a company's price targets consensus from the FMP API.

  ## Examples

    iex> {:ok, price_targets_consenus} = FMP.price_targets_consenus("AAPL")
    iex> price_targets_consenus.symbol
    "AAPL"
  """
  def price_targets_consenus(symbol) do
    case get("#{@api_v4}/price-target-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's price target summary from the FMP API.

  ## Examples

    iex> {:ok, price_tarsummary} = FMP.price_tarsummary("AAPL")
    iex> price_tarsummary.symbol
    "AAPL"
  """
  def price_tarsummary(symbol) do
    case get("#{@api_v4}/price-target-summary", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of price targets by an analyst from the FMP API.

  ## Examples

    iex> {:ok, price_targets} = FMP.price_targets_by_analyst("AAPL")
    iex> Enum.count(price_targets) > 0
    true
  """
  def price_targets_by_analyst(analyst_name),
    do: get("#{@api_v4}/price-target-analyst-name", %{name: analyst_name})

  @doc """
  Fetches a list of price targets by an analyst company from the FMP API.

  ## Examples

    iex> {:ok, price_targets} = FMP.price_targets_by_analyst_company("Barclays")
    iex> Enum.count(price_targets) > 0
    true
  """
  def price_targets_by_analyst_company(company),
    do: get("#{@api_v4}/price-target-analyst-company", %{company: company})

  @doc """
  Fetches a company's upgrades and downgrades from the FMP API.

  ## Examples

    iex> {:ok, upgrades_and_downgrades} = FMP.upgrades_and_downgrades("AAPL")
    iex> Enum.count(upgrades_and_downgrades) > 0
    true
  """
  def upgrades_and_downgrades(symbol),
    do: get("#{@api_v4}/upgrade-downgrade", %{symbol: symbol})

  @doc """
  Fetches a company's upgrades and downgrades consensus from the FMP API.

  ## Examples

    iex> {:ok, upgrades_and_downgrades_consenus} = FMP.upgrades_and_downgrades_consenus("AAPL")
    iex> upgrades_and_downgrades_consenus.symbol
    "AAPL"
  """
  def upgrades_and_downgrades_consenus(symbol) do
    case get("#{@api_v4}/upgrade-downgrade-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of upgrades and downgrades by an analyst company from the FMP API.

  ## Examples

    iex> {:ok, upgrades_and_downgrades} = FMP.upgrades_and_downgrades_by_company("Barclays")
    iex> Enum.count(upgrades_and_downgrades) > 0
    true
  """
  def upgrades_and_downgrades_by_company(company),
    do: get("#{@api_v4}/upgrade-downgrade-analyst-company", %{company: company})

  @doc """
  Fetches a company's rating from the FMP API.

  ## Examples

    iex> {:ok, rating} = FMP.rating("AAPL")
    iex> rating.symbol
    "AAPL"
  """
  def rating(symbol) do
    case get("#{@api_v3}/rating/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical rating from the FMP API.

  ## Examples

    iex> {:ok, rating} = FMP.historical_rating("AAPL")
    iex> Enum.count(rating) > 0
    true

    iex> {:ok, rating} = FMP.historical_rating("AAPL", %{limit: 1})
    iex> Enum.count(rating) == 1
    true
  """
  def historical_rating(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-rating/#{symbol}", params)

  @doc """
  Fetches a list of company's notes from the FMP API.

  ## Examples

    iex> {:ok, notes} = FMP.company_notes("AAPL")
    iex> Enum.count(notes) > 0
    true
  """
  def company_notes(symbol), do: get("#{@api_v4}/company-notes", %{symbol: symbol})

  @doc """
  Fetches a company's ESG score from the FMP API.

  ## Examples

    iex> {:ok, esg_scores} = FMP.esg_scores("AAPL")
    iex> Enum.count(esg_scores) > 0
    true
  """
  def esg_scores(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data", %{symbol: symbol})

  @doc """
  Fetches a company's ESG risk rating from the FMP API.

  ## Examples

    iex> {:ok, esg_risk_ratings} = FMP.esg_risk_ratings("AAPL")
    iex> Enum.count(esg_risk_ratings) > 0
    true
  """
  def esg_risk_ratings(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data-ratings", %{symbol: symbol})

  @doc """
  Fetches a sector ESG score benchmarks from the FMP API.

  ## Examples

    iex> {:ok, esg_sector_benchmarks} = FMP.esg_sector_benchmarks(2020)
    iex> Enum.count(esg_sector_benchmarks) > 0
    true
  """
  def esg_sector_benchmarks(year),
    do: get("#{@api_v4}/esg-sector-benchmark", %{year: year})

  @doc """
  Fetches a company's institutional ownership from the FMP API.

  ## Examples

    iex> {:ok, institutional_ownership} = FMP.institutional_stock_ownership("AAPL")
    iex> Enum.count(institutional_ownership) > 0
    true
  """
  def institutional_stock_ownership(symbol),
    do: get("#{@api_v4}/institutional-ownership/symbol-ownership", %{symbol: symbol})

  @doc """
  Fetches a company's institutional ownership by holders from the FMP API.

  ## Examples

    iex> {:ok, institutional_ownership} = FMP.stock_ownership_by_holders("AAPL")
    iex> Enum.count(institutional_ownership) > 0
    true
  """
  def stock_ownership_by_holders(symbol, params \\ %{}),
    do:
      get(
        "#{@api_v4}/institutional-ownership/institutional-holders/symbol-ownership-percent",
        Map.merge(%{symbol: symbol}, params)
      )

  @doc """
  Fetches the symbols of all companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def symbols(), do: get("#{@api_v3}/stock/list")

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.tradable_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def tradable_symbols(), do: get("#{@api_v3}/available-traded/list")

  @doc """
  Fetches the symbol changes from the FMP API.

  ## Examples

    iex> {:ok, symbol_changes} = FMP.symbol_changes()
    iex> Enum.count(symbol_changes) > 0
    true
  """
  def symbol_changes(), do: get("#{@api_v4}/symbol_change")

  @doc """
  Fetches the symbols of all ETFs from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.etfs()
    iex> Enum.count(symbols) > 0
    true
  """
  def etfs(), do: get("#{@api_v3}/etf/list")

  @doc """
  Fetches information about an ETF from the FMP API.

  ## Examples

    iex> {:ok, etf} = FMP.etf("SPY")
    iex> etf.symbol
    "SPY"
  """
  def etf(symbol) do
    case get("#{@api_v4}/etf-info", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the holdings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, holdings} = FMP.etf_holdings("SPY")
    iex> Enum.count(holdings) > 0
    true
  """
  def etf_holdings(symbol), do: get("#{@api_v3}/etf-holder/#{symbol}")

  @doc """
  Fetches the stock exposure of an ETF from the FMP API.

  ## Examples

    iex> {:ok, stock_exposure} = FMP.etf_stock_exposure("SPY")
    iex> Enum.count(stock_exposure) > 0
    true
  """
  def etf_stock_exposure(symbol), do: get("#{@api_v3}/etf-stock-exposure/#{symbol}")

  @doc """
  Fetches the country weightings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, country_weightings} = FMP.etf_country_weightings("SPY")
    iex> Enum.count(country_weightings) > 0
    true
  """
  def etf_country_weightings(symbol), do: get("#{@api_v3}/etf-country-weightings/#{symbol}")

  @doc """
  Fetches the sector weightings of an ETF from the FMP API.

  ## Examples

    iex> {:ok, sector_weightings} = FMP.etf_sector_weightings("SPY")
    iex> Enum.count(sector_weightings) > 0
    true
  """
  def etf_sector_weightings(symbol), do: get("#{@api_v3}/etf-sector-weightings/#{symbol}")

  @doc """
  Fetches the list of sec filings of a company from the FMP API.

  ## Examples

    iex> {:ok, sec_filings} = FMP.sec_filings("AAPL")
    iex> Enum.count(sec_filings) > 0
    true
  """
  def sec_filings(symbol, params \\ %{}), do: get("#{@api_v3}/sec_filings/#{symbol}", params)

  @doc """
  Fetches the SEC rss feed from the FMP API.

  ## Examples

    iex> {:ok, rss_feed} = FMP.rss_feed()
    iex> Enum.count(rss_feed) > 0
    true
  """
  def rss_feed(params \\ %{}), do: get("#{@api_v3}/rss_feed", params)

  @doc """
  Fetches the price targets rss feed from the FMP API.

  ## Examples

    iex> {:ok, price_targets_rss_feed} = FMP.price_targets_rss_feed()
    iex> Enum.count(price_targets_rss_feed) > 0
    true
  """
  def price_targets_rss_feed(params \\ %{}),
    do: get("#{@api_v4}/price-target-rss-feed", params)

  @doc """
  Fetches the upgrades and downgrades rss feed from the FMP API.

  ## Examples

    iex> {:ok, upgrades_and_downgrades_rss_feed} = FMP.upgrades_and_downgrades_rss_feed()
    iex> Enum.count(upgrades_and_downgrades_rss_feed) > 0
    true
  """
  def upgrades_and_downgrades_rss_feed(params \\ %{}),
    do: get("#{@api_v4}/upgrades-downgrades-rss-feed", params)

  @doc """
  Search via ticker and company name from the FMP API.

  ## Examples

    iex> {:ok, search} = FMP.search("AAPL")
    iex> Enum.count(search) > 0
    true
  """
  def search(query, params \\ %{}),
    do: get("#{@api_v3}/search", Map.merge(%{query: query}, params))

  @doc """
  Search via ticker from the FMP API.

  ## Examples

    iex> {:ok, search_ticker} = FMP.search_ticker("AAPL")
    iex> Enum.count(search_tickers) > 0
    true
  """
  def search_ticker(query, params \\ %{}),
    do: get("#{@api_v3}/search-ticker", Map.merge(%{query: query}, params))

  @doc """
  Search via company name from the FMP API.

  ## Examples

    iex> {:ok, search_name} = FMP.search_name("Apple")
    iex> Enum.count(search_name) > 0
    true
  """
  def search_name(query, params \\ %{}),
    do: get("#{@api_v3}/search-name", Map.merge(%{query: query}, params))

  @doc """
  Screen stocks from the FMP API.

  ## Examples

    iex> {:ok, screener} = FMP.screener(%{marketCapMoreThan: 100000000000})
    iex> Enum.count(screener) > 0
    true
  """
  def screener(params \\ %{}), do: get("#{@api_v3}/screener", params)

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

      {:ok, %HTTPoison.Response{status_code: 403}} ->
        {:error, :invalid_subscription}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, {:unexpected_status_code, code}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
