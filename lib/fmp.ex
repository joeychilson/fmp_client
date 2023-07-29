defmodule FMP do
  @api_v3 "https://financialmodelingprep.com/api/v3"
  @api_v4 "https://financialmodelingprep.com/api/v4"

  @doc """
  Fetches the trading hours for the current year from the FMP API.
  """
  def trading_hours, do: get("#{@api_v3}/is-the-market-open")

  @doc """
  Fetches a list of all delisted companies from the FMP API.

  ## Optional

  * `:page` - The page number to fetch.
  """
  def companies_delisted(opts \\ []),
    do: get("#{@api_v3}/delisted-companies", opts)

  @doc """
  Fetches a list of companies in the S&P 500 from the FMP API.
  """
  def companies_sp500, do: get("#{@api_v3}/sp500_constituent")

  @doc """
  Fetches the history of companies in the S&P 500 from the FMP API.
  """
  def companies_sp500_historical, do: get("#{@api_v3}/historical/sp500_constituent")

  @doc """
  Fetches a list of companies in the NASDAQ from the FMP API.
  """
  def companies_nasdaq, do: get("#{@api_v3}/nasdaq_constituent")

  @doc """
  Fetches a list of companies in the Dow Jones from the FMP API.
  """
  def companies_dow_jones, do: get("#{@api_v3}/dowjones_constituent")

  @doc """
  Fetches the history of companies in the Dow Jones from the FMP API.
  """
  def companies_dow_jones_historical, do: get("#{@api_v3}/historical/dowjones_constituent")

  @doc """
  Fetches a company by cik from the FMP API.

  ## Required

  * `cik` - The CIK of the company.
  """
  def company_by_cik(cik) do
    cik = String.pad_leading(cik, 10, "0")

    case get("#{@api_v3}/cik/#{cik}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company by cusip from the FMP API.

  ## Required

  * `cusip` - The CUSIP of the company.
  """
  def company_by_cusip(cusip) do
    case get("#{@api_v3}/cusip/#{cusip}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company profile from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def company_profile(symbol) do
    case get("#{@api_v3}/profile/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's outlook from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def company_outlook(symbol),
    do: get("#{@api_v4}/company-outlook", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's core information from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def company_core_information(symbol) do
    case get("#{@api_v4}/company-core-information", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical employee count from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def employee_count_historical(symbol),
    do: get("#{@api_v4}/historical/employee_count", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's shares float from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def shares_float(symbol) do
    case get("#{@api_v4}/shares_float", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the list of cik from the FMP API.
  """
  def cik_list, do: get("#{@api_v3}/cik_list")

  @doc """
  Searches for a cik by name from the FMP API.

  ## Required

  * `name` - The name of the company.
  """
  def cik_search(name), do: get("#{@api_v3}/cik-search/#{name}")

  @doc """
  Fetches the earnings calendar from the FMP API.

  ## Optional

  * `from` - The start date of the earnings calendar.
  * `to` - The end date of the earnings calendar.
  """
  def earnings_calendar(opts \\ []), do: get("#{@api_v3}/earning_calendar", opts)

  @doc """
  Fetches the confirmed earnings calendar from the FMP API.

  ## Optional

  * `from` - The start date of the earnings calendar.
  * `to` - The end date of the earnings calendar.
  """
  def earnings_calendar_confirmed(opts \\ []),
    do: get("#{@api_v4}/earning-calendar-confirmed", opts)

  @doc """
  Fetches the historical earnings calendar for a given symbol from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `from` - The start date of the earnings calendar.
  * `to` - The end date of the earnings calendar.
  """
  def earnings_calendar_historical(symbol, opts \\ []),
    do: get("#{@api_v3}/historical/earning_calendar/#{symbol}", opts)

  @doc """
  Fetches the IPO calendar from the FMP API.

  ## Optional

  * `from` - The start date of the IPO calendar.
  * `to` - The end date of the IPO calendar.
  """
  def ipo_calendar(opts \\ []), do: get("#{@api_v3}/ipo_calendar", opts)

  @doc """
  Fetches the IPO calendar prospectus from the FMP API.

  ## Optional

  * `from` - The start date of the IPO calendar.
  * `to` - The end date of the IPO calendar.
  """
  def ipo_calendar_prospectus(opts \\ []),
    do: get("#{@api_v4}/ipo-calendar-prospectus", opts)

  @doc """
  Fetches the confirmed IPO calendar from the FMP API.

  ## Optional

  * `from` - The start date of the IPO calendar.
  * `to` - The end date of the IPO calendar.
  """
  def ipo_calendar_confirmed(opts \\ []),
    do: get("#{@api_v4}/ipo-calendar-confirmed", opts)

  @doc """
  Fetches the stock split calendar from the FMP API.

  ## Optional

  * `from` - The start date of the stock split calendar.
  * `to` - The end date of the stock split calendar.
  """
  def stock_split_calendar(opts \\ []),
    do: get("#{@api_v3}/stock_split_calendar", opts)

  @doc """
  Fetches the dividend calendar from the FMP API.

  ## Optional

  * `from` - The start date of the dividend calendar.
  * `to` - The end date of the dividend calendar.
  """
  def dividends_calendar(opts \\ []),
    do: get("#{@api_v3}/stock_dividend_calendar", opts)

  @doc """
  Fetches the historical dividend calendar for a given symbol from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def dividends_historical(symbol),
    do: get("#{@api_v3}/historical-price-full/stock_dividend/#{symbol}")

  @doc """
  Fetches the economoic calendar from the FMP API.

  ## Optional

  * `from` - The start date of the economic calendar.
  * `to` - The end date of the economic calendar.
  """
  def economic_calendar(opts \\ []),
    do: get("#{@api_v3}/economic_calendar", opts)

  @doc """
  Fetches a company's financial reports dates from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def financial_reports_dates(symbol),
    do: get("#{@api_v4}/financial-reports-dates", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's income statements from the FMP API.

  ## Required

  * `cik_or_symbol` - The CIK or symbol of the company.

  ## Optional

  * `period` - The period of the income statements. Can be `quarter` or `annual`.
  * `limit` - The number of income statements to return.
  """
  def income_statements(cik_or_symbol, opts \\ []),
    do: get("#{@api_v3}/income-statement/#{cik_or_symbol}", opts)

  @doc """
  Fetches a company's income statement growth from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the income statement growth. Can be `quarter` or `annual`.
  * `limit` - The number of income statement growths to return.
  """
  def income_statement_growth(symbol, opts \\ []),
    do: get("#{@api_v3}/income-statement-growth/#{symbol}", opts)

  @doc """
  Fetches a company's balance sheets from the FMP API.

  ## Required

  * `cik_or_symbol` - The CIK or symbol of the company.

  ## Optional

  * `period` - The period of the balance sheets. Can be `quarter` or `annual`.
  * `limit` - The number of balance sheets to return.
  """
  def balance_sheets(cik_or_symbol, opts \\ []),
    do: get("#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", opts)

  @doc """
  Fetches a company's balance sheet growth from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the balance sheet growths. Can be `quarter` or `annual`.
  * `limit` - The number of balance sheet growths to return.
  """
  def balance_sheet_growth(symbol, opts \\ []),
    do: get("#{@api_v3}/balance-sheet-statement-growth/#{symbol}", opts)

  @doc """
  Fetches a company's cash flow statements from the FMP API.

  ## Required

  * `cik_or_symbol` - The CIK or symbol of the company.

  ## Optional

  * `period` - The period of the cash flow statements. Can be `quarter` or `annual`.
  * `limit` - The number of cash flow statements to return.
  """
  def cash_flow_statements(cik_or_symbol, opts \\ []),
    do: get("#{@api_v3}/cash-flow-statement/#{cik_or_symbol}", opts)

  @doc """
  Fetches a company's cash flow statement growth from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the cash flow statement growth. Can be `quarter` or `annual`.
  * `limit` - The number of cash flow statement growths to return.
  """
  def cash_flow_statement_growth(symbol, opts \\ []),
    do: get("#{@api_v3}/cash-flow-statement-growth/#{symbol}", opts)

  @doc """
  Fetches a company's financial growth from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the financial growth. Can be `quarter` or `annual`.
  * `limit` - The number of financial growths to return.
  """
  def financial_growth(symbol, opts \\ []),
    do: get("#{@api_v3}/financial-growth/#{symbol}", opts)

  @doc """
  Fetches a company's revenue product segmentation from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def product_segmentation(symbol) do
    params = Keyword.new([{:symbol, symbol}, {:structure, "flat"}])
    resp = get("#{@api_v4}/revenue-product-segmentation", params)

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

  ## Required

  * `symbol` - The symbol of the company.
  """
  def geographic_segmentation(symbol) do
    params = Keyword.new([{:symbol, symbol}, {:structure, "flat"}])
    resp = get("#{@api_v4}/revenue-geographic-segmentation", params)

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

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the key metrics. Can be `quarter` or `annual`.
  * `limit` - The number of key metrics to return.
  """
  def key_metrics(symbol, opts \\ []), do: get("#{@api_v3}/key-metrics/#{symbol}", opts)

  @doc """
  Fetches a company's key metrics TTM from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the key metrics. Can be `quarter` or `annual`.
  * `limit` - The number of key metrics to return.
  """
  def key_metrics_ttm(symbol, opts \\ []),
    do: get("#{@api_v3}/key-metrics-ttm/#{symbol}", opts)

  @doc """
  Fetches a company's financial ratios from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the financial ratios. Can be `quarter` or `annual`.
  * `limit` - The number of financial ratios to return.
  """
  def financial_ratios(symbol, opts \\ []), do: get("#{@api_v3}/ratios/#{symbol}", opts)

  @doc """
  Fetches a company's financial scores from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def financial_scores(symbol) do
    case get("#{@api_v4}/score", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's enterprise value from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the enterprise value. Can be `quarter` or `annual`.
  * `limit` - The number of enterprise values to return.
  """
  def enterprise_value(symbol, opts \\ []),
    do: get("#{@api_v3}/enterprise-values/#{symbol}", opts)

  @doc """
  Fetches a company's discounted cash flow from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def discounted_cash_flow(symbol) do
    case get("#{@api_v3}/discounted-cash-flow/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical discounted cash flow from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `period` - The period of the discounted cash flow. Can be `quarter` or `annual`.
  * `limit` - The number of discounted cash flows to return.
  """
  def discounted_cash_flow_historical(symbol, opts \\ []),
    do: get("#{@api_v3}/historical-discounted-cash-flow-statement/#{symbol}", opts)

  @doc """
  Fetches a company's historical daily discounted cash flow from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `limit` - The number of discounted cash flows to return.
  """
  def discounted_cash_flow_historical_daily(symbol, opts \\ []),
    do: get("#{@api_v3}/historical-daily-discounted-cash-flow/#{symbol}", opts)

  @doc """
  Fetches a company's advanced discounted cash flow TTM from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def advanced_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_discounted_cash_flow", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's advanced levered discounted cash flow from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def advanced_levered_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_levered_discounted_cash_flow", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's insider roster from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def insider_roster(symbol),
    do: get("#{@api_v4}/insider-roaster", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's insider roster statistics from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def insider_roster_statistics(symbol),
    do: get("#{@api_v4}/insider-roaster-statistic", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's key executives from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def key_executives(symbol), do: get("#{@api_v3}/key-executives/#{symbol}")

  @doc """
  Fetches a company's executive compensation from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def executive_compensation(symbol),
    do: get("#{@api_v4}/governance/executive_compensation", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches the executive compensation benchmark for a year from the FMP API.

  ## Required

  * `year` - The year to fetch the benchmark for.
  """
  def executive_compensation_benchmark(year),
    do: get("#{@api_v4}/executive-compensation-benchmark", Keyword.put([], :year, year))

  @doc """
  Fetches a company's market capitalization from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def market_cap(symbol) do
    case get("#{@api_v3}/market-capitalization/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical market capitalization from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `limit` - The number of results to return.
  """
  def market_cap_historical(symbol, opts \\ []),
    do: get("#{@api_v3}/historical-market-capitalization/#{symbol}", opts)

  @doc """
  Fetches a company's peers from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def peers(symbol) do
    case get("#{@api_v4}/stock_peers", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's SIC information using CIK from the FMP API.

  ## Required

  * `cik` - The CIK of the company.
  """
  def sic_by_cik(cik) do
    cik = String.pad_leading(cik, 10, "0")

    case get("#{@api_v4}/standard_industrial_classification", Keyword.put([], :cik, cik)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's SIC information using symbol from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def sic_by_symbol(symbol) do
    case get("#{@api_v4}/standard_industrial_classification", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches SIC information for SIC code from the FMP API.

  ## Required

  * `sic_code` - The SIC code to fetch information for.
  """
  def sic_by_code(sic_code),
    do: get("#{@api_v4}/standard_industrial_classification", Keyword.put([], :sicCode, sic_code))

  @doc """
  Fetches all SIC information from the FMP API.
  """
  def sic_all, do: get("#{@api_v4}/standard_industrial_classification/all")

  @doc """
  Fetches a list of SIC codes from the FMP API.

  ## Optional

  * `industry` - The industry to fetch SIC codes for.
  * `sicCode` - The SIC code to fetch information for.
  """
  def sic_list(opts \\ []),
    do: get("#{@api_v4}/standard_industrial_classification_list", opts)

  @doc """
  Fetches a company's historical chart from the FMP API.

  ## Required

  * `interval` - The interval to fetch historical data for.
  * `symbol` - The symbol of the company.
  """
  def chart_historical(interval, symbol),
    do: get("#{@api_v3}/historical-chart/#{interval}/#{symbol}")

  @doc """
  Fetches historical chart with full data for the symbols from the FMP API.

  ## Required

  * `symbols` - The symbols of the companies.

  ## Optional

  * `from` - The start date of the historical data.
  * `to` - The end date of the historical data.
  * `serietype` - The type of series to fetch.
  """
  def chart_historical_full(symbols, opts \\ []),
    do: get("#{@api_v3}/historical-price-full/#{symbols}", opts)

  @doc """
  Fetches quotes for an exchange from the FMP API.

  ## Required

  * `exchange` - The exchange to fetch quotes for.
  """
  def quotes(exchange), do: get("#{@api_v3}/quotes/#{exchange}")

  @doc """
  Fetches quotes from the FMP API.

  ## Required

  * `symbols` - The symbols of the companies.
  """
  def quote(symbols), do: get("#{@api_v3}/quote/#{symbols}")

  @doc """
  Fetches short quotes from the FMP API.

  ## Required

  * `symbols` - The symbols of the companies.
  """
  def quote_short(symbols), do: get("#{@api_v3}/quote-short/#{symbols}")

  @doc """
  Fetches price changes from the FMP API.

  ## Required

  * `symbols` - The symbols of the companies.
  """
  def price_change(symbols), do: get("#{@api_v3}/stock-price-change/#{symbols}")

  @doc """
  Fetches a OTC prices from the FMP API.

  ## Required

  * `symbols` - The symbols of the companies.
  """
  def otc_prices(symbols), do: get("#{@api_v3}/otc/real-time-price/#{symbols}")

  @doc """
  Fetches a FOREX prices from the FMP API.
  """
  def forex, do: get("#{@api_v3}/fx")

  @doc """
  Fetches all of the FOREX quotes from the FMP API.
  """
  def forex_quotes, do: get("#{@api_v3}/quotes/forex")

  @doc """
  Fetches a FOREX exchange rates for a pair from the FMP API.

  ## Required

  * `pair` - The pair of currencies.
  """
  def exchange_rates(pair) do
    case get("#{@api_v3}/fx/#{pair}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's technical indicator from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  * `interval` - The interval of the technical indicator.

  ## Optional

  * `period` - The period of the technical indicator.
  * `type` - The series type of the technical indicator.
  """
  def technical_indicator(symbol, interval, opts \\ []),
    do: get("#{@api_v3}/technical_indicator/#{interval}/#{symbol}", opts)

  @doc """
  Fetches a company's historical stock splits from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def stock_splits(symbol), do: get("#{@api_v3}/historical-price-full/stock_split/#{symbol}")

  @doc """
  Fetches a company's price targets from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def price_targets(symbol), do: get("#{@api_v4}/price-target", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's price targets consensus from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def price_targets_consenus(symbol) do
    case get("#{@api_v4}/price-target-consensus", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's price target summary from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def price_target_summary(symbol) do
    case get("#{@api_v4}/price-target-summary", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of price targets by an analyst from the FMP API.

  ## Required

  * `analyst_name` - The name of the analyst.
  """
  def price_targets_by_analyst(analyst_name),
    do: get("#{@api_v4}/price-target-analyst-name", Keyword.put([], :name, analyst_name))

  @doc """
  Fetches a list of price targets by an analyst company from the FMP API.

  ## Required

  * `company` - The name of the analyst company.
  """
  def price_targets_by_analyst_company(company),
    do: get("#{@api_v4}/price-target-analyst-company", Keyword.put([], :company, company))

  @doc """
  Fetches a company's upgrades and downgrades from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def upgrades_and_downgrades(symbol),
    do: get("#{@api_v4}/upgrades-downgrades", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's upgrades and downgrades consensus from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def upgrades_and_downgrades_consenus(symbol) do
    case get("#{@api_v4}/upgrades-downgrades-consensus", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of upgrades and downgrades by an analyst company from the FMP API.

  ## Required

  * `company` - The name of the analyst company.
  """
  def upgrades_and_downgrades_by_company(company),
    do: get("#{@api_v4}/upgrades-downgrades-grading-company", Keyword.put([], :company, company))

  @doc """
  Fetches a company's rating from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def rating(symbol) do
    case get("#{@api_v3}/rating/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical rating from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `limit` - The number of results to return.
  """
  def rating_historical(symbol, opts \\ []),
    do: get("#{@api_v3}/historical-rating/#{symbol}", opts)

  @doc """
  Fetches a company's social sentiment from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  * `page` - The page of the results to fetch.
  """
  def social_sentiment(symbol, page \\ 0) do
    params = Keyword.new([{:symbol, symbol}, {:page, page}])
    get("#{@api_v4}/historical/social-sentiment", params)
  end

  @doc """
  Fetches a company's stock grade from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Paramaters

  * `limit` - The number of results to return.
  """
  def stock_grade(symbol, opts \\ []),
    do: get("#{@api_v4}/grade", Keyword.put(opts, :symbol, symbol))

  @doc """
  Fetches a company's earnings surprises from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def earnings_surprises(symbol),
    do: get("#{@api_v3}/earnings-surprises/#{symbol}")

  @doc """
  Fetches a company's analyst estimates from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `limit` - The number of results to return.
  * `period` - The period of the analyst estimates.
  """
  def analyst_estimates(symbol, opts \\ []),
    do: get("#{@api_v3}/analyst-estimates/#{symbol}", opts)

  @doc """
  Fetches a list of a company's earnings call transcripts from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def earnings_call_transcript(symbol),
    do: get("#{@api_v4}/earning_call_transcript", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches the earnings call transcripts for a company for a given year.

  ## Required

  * `symbol` - The symbol of the company.
  * `year` - The year of the earnings call transcript.
  """
  def earnings_call_transcript(symbol, year),
    do: get("#{@api_v4}/batch_earning_call_transcript/#{symbol}", Keyword.put([], :year, year))

  @doc """
  Fetches the earnings call transcripts for a company for a given year and quarter.

  ## Required

  * `symbol` - The symbol of the company.
  * `year` - The year of the earnings call transcript.
  * `quarter` - The quarter of the earnings call transcript.
  """
  def earnings_call_transcript(symbol, year, quarter) do
    params = Keyword.new([{:year, year}, {:quarter, quarter}])

    case get("#{@api_v3}/earning_call_transcript/#{symbol}", params) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of company's notes from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def company_notes(symbol), do: get("#{@api_v4}/company-notes", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's ESG score from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def esg_scores(symbol),
    do:
      get("#{@api_v4}/esg-environmental-social-governance-data", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's ESG risk rating from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def esg_risk_ratings(symbol),
    do:
      get(
        "#{@api_v4}/esg-environmental-social-governance-data-ratings",
        Keyword.put([], :symbol, symbol)
      )

  @doc """
  Fetches a sector ESG score benchmarks from the FMP API.

  ## Required

  * `year` - The year of the ESG score benchmarks.
  """
  def esg_sector_benchmarks(year),
    do:
      get(
        "#{@api_v4}/esg-environmental-social-governance-sector-benchmark",
        Keyword.put([], :year, year)
      )

  @doc """
  Fetches a company's mutual fund holders from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def mutual_fund_holders(symbol), do: get("#{@api_v3}/mutual-fund-holder/#{symbol}")

  @doc """
  Fetches a company's institutional holders from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def institutional_holders(symbol), do: get("#{@api_v3}/institutional-holder/#{symbol}")

  @doc """
  Fetches form 13F for a given CIK from the FMP API.

  ## Required

  * `cik` - The CIK of the company.
  * `date` - The date of the form 13F.
  """
  def form_13f(cik, date) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v3}/form-thirteen/#{cik}", Keyword.put([], :date, date))
  end

  @doc """
  Fetches form 13F filing dates for a given CIK from the FMP API.

  ## Required

  * `cik` - The CIK of the company.
  """
  def form_13f_filing_dates(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v3}/form-thirteen-date/#{cik}")
  end

  @doc """
  Fetches form 13F allocation dates from the FMP API.
  """
  def form_13f_asset_allocation_dates, do: get("#{@api_v4}/13f-asset-allocation-date")

  @doc """
  Fetches form 13F asset allocations for a given date from the FMP API.

  ## Required

  * `date` - The date of the form 13F asset allocation.
  """
  def form_13f_asset_allocations(date),
    do: get("#{@api_v4}/13f-asset-allocation-date", Keyword.put([], :date, date))

  @doc """
  Fetches a company's institutional ownership from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def insider_ownership_acquisition(symbol),
    do:
      get(
        "#{@api_v4}/insider/ownership/acquisition_of_beneficial_ownership",
        Keyword.put([], :symbol, symbol)
      )

  @doc """
  Fetches a company's institutional ownership from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def institutional_ownership(symbol),
    do:
      get("#{@api_v4}/institutional-ownership/symbol-ownership", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a company's institutional ownership percentage from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `date` - The date of the institutional ownership percentage.
  * `page` - The page number of the results.
  """
  def institutional_ownership_percentage(symbol, opts \\ []),
    do:
      get(
        "#{@api_v4}/institutional-ownership/institutional-holders/symbol-ownership-percent",
        Keyword.put(opts, :symbol, symbol)
      )

  @doc """
  Fetches a company's institutional ownership by shares held from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `date` - The date of the institutional ownership percentage.
  * `page` - The page number of the results.
  """
  def institutional_ownership_by_shares_held(symbol, opts \\ []),
    do:
      get(
        "#{@api_v4}/institutional-ownership/institutional-holders/symbol-ownership",
        Keyword.put(opts, :symbol, symbol)
      )

  @doc """
  Fetches a institution's portfolio holdings from the FMP API.

  ## Required

  * `cik` - The CIK of the institution.

  ## Optional

  * `date` - The date of the portfolio holdings.
  * `page` - The page number of the results.
  """
  def institution_portfolio_holdings(cik, opts \\ []),
    do: get("#{@api_v4}/institutional-ownership/portfolio-holdings", Keyword.put(opts, :cik, cik))

  @doc """
  Fetches a institution's portfolio summary from the FMP API.

  ## Required

  * `cik` - The CIK of the institution.
  """
  def institution_portfolio_summary(cik) do
    cik = String.pad_leading(cik, 10, "0")

    get(
      "#{@api_v4}/institutional-ownership/portfolio-holdings-summary",
      Keyword.put([], :cik, cik)
    )
  end

  @doc """
  Fetches a institution's portfolio dates from the FMP API.

  ## Required

  * `cik` - The CIK of the institution.
  """
  def institution_portfolio_dates(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/institutional-ownership/portfolio-date", Keyword.put([], :cik, cik))
  end

  @doc """
  Fetches a institution's portfolio industry summary from the FMP API.

  ## Required

  * `cik` - The CIK of the institution.
  * `date` - The date of the portfolio holdings.

  ## Optional

  * `page` - The page number of the results.
  """
  def institution_industry_summary(cik, date, opts \\ []) do
    cik = String.pad_leading(cik, 10, "0")

    params =
      Keyword.new([
        {:cik, cik},
        {:date, date}
      ])
      |> Keyword.merge(opts)

    get("#{@api_v4}/institutional-ownership/industry/portfolio-holdings-summary", params)
  end

  @doc """
  Fetches insider trading transactions from the FMP API.

  ## Optional

  * `symbol` - The symbol of the stock.
  * `companyCik` - The CIK of the company.
  * `reportingCik` - The CIK of the reporting institution.
  * `transactionType` - The type of transaction.
  * `page` - The page number of the results.
  """
  def insider_trading(opts \\ []),
    do: get("#{@api_v4}/insider-trading", opts)

  @doc """
  Fetches insider trading transactions types from the FMP API.
  """
  def insider_trading_transactions_type, do: get("#{@api_v4}/insider-trading-transaction-type")

  @doc """
  Fetches a list of commitment of traders report from the FMP API.
  """
  def commitment_of_traders_report_list, do: get("#{@api_v4}/commitment_of_traders_report/list")

  @doc """
  Fetches a commitment of traders report from and to a date from the FMP API.

  ## Required

  * `from` - The from date.
  * `to` - The to date.
  """
  def commitment_of_traders_report(from, to) do
    params = Keyword.new([{:from, from}, {:to, to}])
    get("#{@api_v4}/commitment_of_traders_report", params)
  end

  @doc """
  Fetches a commitment of traders report from a symbol from the FMP API.

  ## Required

  * `symbol` - The symbol.
  """
  def commitment_of_traders_report(symbol),
    do: get("#{@api_v4}/commitment_of_traders_report/#{symbol}")

  @doc """
  Fetches a commitment of traders report analysis from and to a date from the FMP API.

  ## Required

  * `from` - The from date.
  * `to` - The to date.
  """
  def commitment_of_traders_report_analysis(from, to) do
    params = Keyword.new([{:from, from}, {:to, to}])
    get("#{@api_v4}/commitment_of_traders_report_analysis", params)
  end

  @doc """
  Fetches a commitment of traders report analysis from a symbol from the FMP API.

  ## Required

  * `symbol` - The symbol.
  """
  def commitment_of_traders_report_analysis(symbol),
    do: get("#{@api_v4}/commitment_of_traders_report_analysis/#{symbol}")

  @doc """
  Fetches a list of senate trading for a symbol from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def senate_trading(symbol),
    do: get("#{@api_v4}/senate-trading", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches a list of senate disclosures for a symbol from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def senate_disclosures(symbol),
    do: get("#{@api_v4}/senate-disclosure", Keyword.put([], :symbol, symbol))

  @doc """
  Fetches ciks by name from the FMP API.

  ## Optional

  * `name` - The name of the company.
  * `page` - The page number.
  """
  def cik_mapper_name(opts \\ []),
    do: get("#{@api_v4}/mapper-cik-name", opts)

  @doc """
  Fetches ciks by symbol from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  """
  def cik_mapper_company(symbol) do
    case get("#{@api_v4}/mapper-cik-company/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the symbols of all companies from the FMP API.
  """
  def symbols, do: get("#{@api_v3}/stock/list")

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.
  """
  def symbols_exchanges, do: get("#{@api_v3}/available-traded/list")

  @doc """
  Fetches the symbols of all indexes from the FMP API.
  """
  def symbols_indexes, do: get("#{@api_v3}/symbol/available-indexes")

  @doc """
  Fetches the symbols of all euro next companies from the FMP API.
  """
  def symbols_euronext, do: get("#{@api_v3}/symbol/available-euronext")

  @doc """
  Fetches the symbols of all TSX companies from the FMP API.
  """
  def symbols_tsx, do: get("#{@api_v3}/symbol/available-tsx")

  @doc """
  Fetches the symbols of all crypto currencies from the FMP API.
  """
  def symbols_crypto, do: get("#{@api_v3}/symbol/available-cryptocurrencies")

  @doc """
  Fetches the symbols of all forex currencies from the FMP API.
  """
  def symbols_forex, do: get("#{@api_v3}/symbol/available-forex-currency-pairs")

  @doc """
  Fetches the symbols of all commodities from the FMP API.
  """
  def symbols_commodities, do: get("#{@api_v3}/symbol/available-commodities")

  @doc """
  Fetches the symbol changes from the FMP API.
  """
  def symbol_changes, do: get("#{@api_v4}/symbol_change")

  @doc """
  Fetches mutual funds by name from the FMP API.

  ## Required

  * `name` - The name of the mutual fund.
  """
  def mutual_fund(name),
    do: get("#{@api_v4}/mutual-fund-holdings/name", Keyword.put([], :name, name))

  @doc """
  Fetches mutual funds holdings from the FMP API.

  ## Optional

  * `symbol` - The symbol of the mutual fund.
  * `cik` - The CIK of the mutual fund.
  * `date` - The date of the mutual fund.
  """
  def mutual_fund_portfolio_holdings(opts \\ []),
    do: get("#{@api_v4}/mutual-fund-holdings", opts)

  @doc """
  Fetches mutual funds portfolio dates from the FMP API.

  ## Optional

  * `symbol` - The symbol of the mutual fund.
  * `cik` - The CIK of the mutual fund.
  """
  def mutual_fund_portfolio_dates(opts \\ []),
    do: get("#{@api_v4}/mutual-fund-holdings/portfolio-date", opts)

  @doc """
  Fetches the symbols of all ETFs from the FMP API.
  """
  def etfs, do: get("#{@api_v3}/etf/list")

  @doc """
  Fetches information about an ETF from the FMP API.

  ## Required

  * `symbol` - The symbol of the ETF.
  """
  def etf(symbol) do
    case get("#{@api_v4}/etf-info", Keyword.put([], :symbol, symbol)) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the portfolio dates of an ETF from the FMP API.

  ## Optional

  * `symbol` - The symbol of the ETF.
  * `cik` - The CIK of the ETF.
  """
  def etf_portfolio_dates(opts \\ []),
    do: get("#{@api_v4}/etf-holdings/portfolio-date", opts)

  @doc """
  Fetches the holdings of an ETF from the FMP API.

  ## Required

  * `symbol` - The symbol of the ETF.
  """
  def etf_holdings(symbol), do: get("#{@api_v3}/etf-holder/#{symbol}")

  @doc """
  Fetches the historical holdings of an ETF from the FMP API.

  ## Optional

  * `symbol` - The symbol of the ETF.
  * `ciK` - The CIK of the ETF.
  * `date` - The date of the holdings.
  """
  def etf_holdings_historical(opts \\ []), do: get("#{@api_v4}/etf-holdings", opts)

  @doc """
  Fetches the stock exposure of an ETF from the FMP API.

  ## Required

  * `symbol` - The symbol of the ETF.
  """
  def etf_stock_exposure(symbol), do: get("#{@api_v3}/etf-stock-exposure/#{symbol}")

  @doc """
  Fetches the country weightings of an ETF from the FMP API.

  ## Required

  * `symbol` - The symbol of the ETF.
  """
  def etf_country_weightings(symbol), do: get("#{@api_v3}/etf-country-weightings/#{symbol}")

  @doc """
  Fetches the sector weightings of an ETF from the FMP API.

  ## Required

  * `symbol` - The symbol of the ETF.
  """
  def etf_sector_weightings(symbol), do: get("#{@api_v3}/etf-sector-weightings/#{symbol}")

  @doc """
  Fetches sectors PE ratios for a given date from the FMP API.

  ## Required

  * `date` - The date of the PE ratios.

  ## Optional

  * `exchange` - The exchange of the PE ratios.
  """
  def pe_ratios_sectors(date, opts \\ []),
    do: get("#{@api_v4}/sector_price_earning_ratio", Keyword.put(opts, :date, date))

  @doc """
  Fetches industries PE ratios for a given date from the FMP API.

  ## Required

  * `date` - The date of the PE ratios.

  ## Optional

  * `exchange` - The exchange of the PE ratios.
  """
  def pe_ratios_industries(date, opts \\ []),
    do: get("#{@api_v4}/industry_price_earning_ratio", Keyword.put(opts, :date, date))

  @doc """
  Fetches sectors performance from the FMP API.
  """
  def sectors_performance, do: get("#{@api_v3}/sector-performance")

  @doc """
  Fetches historical sectors performance from the FMP API.

  ## Optional

  * `limit` - The limit of the historical sectors performance.
  """
  def sectors_performance_historical(opts \\ []),
    do: get("#{@api_v3}/historical-sectors-performance", opts)

  @doc """
  Fetches top gainers from the FMP API.
  """
  def top_gainers, do: get("#{@api_v3}/stock_market/gainers")

  @doc """
  Fetches top losers from the FMP API.
  """
  def top_losers, do: get("#{@api_v3}/stock_market/losers")

  @doc """
  Fetches most active stocks from the FMP API.
  """
  def top_active, do: get("#{@api_v3}/stock_market/actives")

  @doc """
  Fetches market risk premiums for each country from the FMP API.
  """
  def market_risk_preminum, do: get("#{@api_v4}/market_risk_premium")

  @doc """
  Fetches treasury rates from the FMP API.

  ## Optional

  * `from` - The start date of the treasury rates.
  * `to` - The end date of the treasury rates.
  """
  def treasury_rates(opts \\ []), do: get("#{@api_v4}/treasury", opts)

  @doc """
  Fetches economic indicators from the FMP API.

  ## Required

  * `name` - The name of the economic indicator.

  ## Optional

  * `from` - The start date of the economic indicator.
  * `to` - The end date of the economic indicator.
  """
  def ecomonic_indicators(name, opts \\ []),
    do: get("#{@api_v4}/economic", Keyword.put(opts, :name, name))

  @doc """
  Fetches crowdfunding offerings from the FMP API.

  ## Required

  * `cik` - The CIK of the company.
  """
  def crowdfunding_offerings(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/crowdfunding-offerings", Keyword.put([], :cik, cik))
  end

  @doc """
  Fetches fundraising from the FMP API.

  ## Required

  * `cik` - The CIK of the company.
  """
  def fundraising(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/fundraising", Keyword.put([], :cik, cik))
  end

  @doc """
  Fetches the list of FMP articles from the FMP API.

  ## Optional

  * `page` - The page number.
  * `size` - The size of the pages.
  """
  def fmp_articles(opts \\ []), do: get("#{@api_v3}/fmp/articles", opts)

  @doc """
  Fetches the list of stock news from the FMP API.

  ## Optional

  * `tickers` - The list of tickers.
  * `limit` - The number of news to return.
  * `page` - The page number.
  """
  def news_stock(opts \\ []), do: get("#{@api_v3}/stock_news", opts)

  @doc """
  Fetches the list of crypto news from the FMP API.

  ## Optional

  * `symbol` - The symbol of the crypto.
  * `page` - The page number.
  """
  def news_crypto(opts \\ []), do: get("#{@api_v4}/crypto_news", opts)

  @doc """
  Fetches the list of forex news from the FMP API.

  ## Optional

  * `symbol` - The symbol of the crypto.
  * `page` - The page number.
  """
  def news_forex(opts \\ []), do: get("#{@api_v4}/forex_news", opts)

  @doc """
  Fetches the list of general news from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def news_general(page \\ 0), do: get("#{@api_v4}/general_news", Keyword.put([], :page, page))

  @doc """
  Fetches the list of press releases from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.
  * `page` - The page number.
  """
  def press_releases(symbol, page \\ 0),
    do: get("#{@api_v3}/press-releases/#{symbol}", Keyword.put([], :page, page))

  @doc """
  Fetches the list of sec filings of a company from the FMP API.

  ## Required

  * `symbol` - The symbol of the company.

  ## Optional

  * `type` - The type of the filing.
  * `page` - The page number.
  """
  def sec_filings(symbol, opts \\ []), do: get("#{@api_v3}/sec_filings/#{symbol}", opts)

  @doc """
  Fetches the SEC rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed(page \\ 0), do: get("#{@api_v3}/rss_feed", Keyword.put([], :page, page))

  @doc """
  Fetches the insider trading rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_insider_trading(page \\ 0),
    do: get("#{@api_v4}/insider-trading-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the price targets rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_price_targets(page \\ 0),
    do: get("#{@api_v4}/price-target-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the upgrades and downgrades rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_upgrades_and_downgrades(page \\ 0),
    do: get("#{@api_v4}/upgrades-downgrades-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the stock news sentiment rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_stock_news_sentiment(page \\ 0),
    do: get("#{@api_v4}/stock-news-sentiments-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the institutional ownership rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_institutional_ownership(page \\ 0),
    do: get("#{@api_v4}/institutional-ownership/rss_feed", Keyword.put([], :page, page))

  @doc """
  Fetches the senate trading rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_senate_trading(page \\ 0),
    do: get("#{@api_v4}/senate-trading-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the senate disclosures rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_senate_disclosures(page \\ 0),
    do: get("#{@api_v4}/senate-disclosure-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the mergers and acquisitions rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_mergers_and_acquisitions(page \\ 0),
    do: get("#{@api_v4}/mergers-acquisitions-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the crowdfunding offerings rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_crowdfunding_offerings(page \\ 0),
    do: get("#{@api_v4}/crowdfunding-offerings-rss-feed", Keyword.put([], :page, page))

  @doc """
  Fetches the fundraising rss feed from the FMP API.

  ## Required

  * `page` - The page number.
  """
  def rss_feed_fundraising(page \\ 0),
    do: get("#{@api_v4}/fundraising-rss-feed", Keyword.put([], :page, page))

  @doc """
  Search via ticker and company name from the FMP API.

  ## Required

  * `query` - The query to search for.

  ## Optional

  * `limit` - The number of results to return.
  * `exchange` - The exchange to search in.
  """
  def search(query, opts \\ []),
    do: get("#{@api_v3}/search", Keyword.put(opts, :query, query))

  @doc """
  Search via ticker from the FMP API.

  ## Required

  * `query` - The query to search for.

  ## Optional

  * `limit` - The number of results to return.
  * `exchange` - The exchange to search in.
  """
  def search_ticker(query, opts \\ []),
    do: get("#{@api_v3}/search-ticker", Keyword.put(opts, :query, query))

  @doc """
  Search via company name from the FMP API.

  ## Required

  * `query` - The query to search for.

  ## Optional

  * `limit` - The number of results to return.
  * `exchange` - The exchange to search in.
  """
  def search_name(query, opts \\ []),
    do: get("#{@api_v3}/search-name", Keyword.put(opts, :query, query))

  @doc """
  Search for institutions from the FMP API.

  ## Required

  * `name` - The name of the institution to search for.
  """
  def search_institutions(name),
    do: get("#{@api_v4}/institutional-ownership/name", Keyword.put([], :name, name))

  @doc """
  Search for mergers and acquisitions from the FMP API.

  ## Required

  * `name` - The name of the merger or acquisition to search for.
  """
  def search_mergers_and_acquisitions(name),
    do: get("#{@api_v4}/mergers-acquisitions/search", Keyword.put([], :name, name))

  @doc """
  Search for crowdfunding offerings from the FMP API.

  ## Required

  * `name` - The name of the crowdfunding offering to search for.
  """
  def search_crowdfunding_offerings(name),
    do: get("#{@api_v4}/crowdfunding-offerings/search", Keyword.put([], :name, name))

  @doc """
  Search for fundraising from the FMP API.

  ## Required

  * `name` - The name of the fundraising to search for.
  """
  def search_fundraising(name),
    do: get("#{@api_v4}/fundraising/search", Keyword.put([], :name, name))

  @doc """
  Screen stocks from the FMP API.

  ## Optional

  * `marketCapMoreThan` - The market cap to screen for.
  * `marketCapLowerThan` - The market cap to screen for.
  * `priceMoreThan` - The price to screen for.
  * `priceLowerThan` - The price to screen for.
  * `volumeMoreThan` - The volume to screen for.
  * `volumeLowerThan` - The volume to screen for.
  * `betaMoreThan` - The beta to screen for.
  * `betaLowerThan` - The beta to screen for.
  * `dividendMoreThan` - The dividend to screen for.
  * `dividendLowerThan` - The dividend to screen for.
  * `isEtf` - Whether or not to screen for ETFs.
  * `sector` - The sector to screen for.
  * `industry` - The industry to screen for.
  * `exchange` - The exchange to screen for.
  * `country` - The country to screen for.
  * `limit` - The number of results to return.
  """
  def screener(opts \\ []), do: get("#{@api_v3}/stock-screener", opts)

  @doc false
  defp get(url, params \\ []) do
    api_key = Application.get_env(:fmp_client, :api_key)
    params = params |> Keyword.put_new(:apikey, api_key)

    case Req.get(url, params: params, decode_json: [keys: :atoms]) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        case body do
          %{"Error Message" => error} ->
            {:error, error}

          _ ->
            {:ok, body}
        end

      {:ok, %Req.Response{status: 403}} ->
        {:error, "invalid subscription"}

      {:ok, %Req.Response{status: code}} ->
        {:error, "request failed with status: #{code}"}

      {:error, error} ->
        {:error, error}
    end
  end
end
