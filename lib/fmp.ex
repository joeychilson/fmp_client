defmodule FMP do
  @api_v3 "https://financialmodelingprep.com/api/v3"
  @api_v4 "https://financialmodelingprep.com/api/v4"

  @doc """
  Fetches the trading hours for the current year from the FMP API.
  """
  def trading_hours, do: get("#{@api_v3}/is-the-market-open")

  @doc """
  Fetches a list of all delisted companies from the FMP API.
  """
  def delisted_companies(params \\ %{}),
    do: get("#{@api_v3}/delisted-companies", params)

  @doc """
  Fetches the earnings calendar from the FMP API.
  """
  def earnings_calendar(params \\ %{}), do: get("#{@api_v3}/earning_calendar", params)

  @doc """
  Fetches the confirmed earnings calendar from the FMP API.
  """
  def earnings_calendar_confirmed(params \\ %{}),
    do: get("#{@api_v4}/earning-calendar-confirmed", params)

  @doc """
  Fetches the historical earnings calendar for a given symbol from the FMP API.
  """
  def historical_earnings_calendar(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical/earning_calendar/#{symbol}", params)

  @doc """
  Fetches the IPO calendar from the FMP API.
  """
  def ipo_calendar(params \\ %{}), do: get("#{@api_v3}/ipo_calendar", params)

  @doc """
  Fetches the IPO calendar prospectus from the FMP API.
  """
  def ipo_calendar_prospectus(params \\ %{}),
    do: get("#{@api_v4}/ipo-calendar-prospectus", params)

  @doc """
  Fetches the confirmed IPO calendar from the FMP API.
  """
  def ipo_calendar_confirmed(params \\ %{}),
    do: get("#{@api_v4}/ipo-calendar-confirmed", params)

  @doc """
  Fetches the stock split calendar from the FMP API.
  """
  def stock_split_calendar(params \\ %{}),
    do: get("#{@api_v3}/stock_split_calendar", params)

  @doc """
  Fetches the dividend calendar from the FMP API.
  """
  def dividend_calendar(params \\ %{}),
    do: get("#{@api_v3}/stock_dividend_calendar", params)

  @doc """
  Fetches the historical dividend calendar for a given symbol from the FMP API.
  """
  def historical_dividends(symbol),
    do: get("#{@api_v3}/historical-price-full/stock_dividend/#{symbol}")

  @doc """
  Fetches the economoic calendar from the FMP API.
  """
  def economic_calendar(params \\ %{}),
    do: get("#{@api_v3}/economic-calendar", params)

  @doc """
  Fetches a company's financial reports dates from the FMP API.
  """
  def financial_reports_dates(symbol),
    do: get("#{@api_v4}/financial-reports-dates", %{symbol: symbol})

  @doc """
  Fetches a list of a company's earnings call transcripts from the FMP API.
  """
  def earnings_call_transcript(symbol),
    do: get("#{@api_v4}/earning_call_transcript", %{symbol: symbol})

  @doc """
  Fetches the earnings call transcripts for a company for a given year.
  """
  def earnings_call_transcript(symbol, year),
    do: get("#{@api_v4}/batch_earning_call_transcript/#{symbol}", %{year: year})

  @doc """
  Fetches the earnings call transcripts for a company for a given year and quarter.
  """
  def earnings_call_transcript(symbol, year, quarter) do
    case get("#{@api_v3}/earning_call_transcript/#{symbol}", %{year: year, quarter: quarter}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's income statements from the FMP API.
  """
  def income_statements(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's income statement growth from the FMP API.
  """
  def income_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's balance sheets from the FMP API.
  """
  def balance_sheets(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's balance sheet growth from the FMP API.
  """
  def balance_sheet_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's cash flow statements from the FMP API.
  """
  def cash_flow_statements(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's cash flow statement growth from the FMP API.
  """
  def cash_flow_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's financial growth from the FMP API.
  """
  def financial_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/financial-growth/#{symbol}", params)

  @doc """
  Fetches a company's revenue product segmentation from the FMP API.
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
  """
  def key_metrics(symbol, params \\ %{}), do: get("#{@api_v3}/key-metrics/#{symbol}", params)

  @doc """
  Fetches a company's key metrics TTM from the FMP API.
  """
  def key_metrics_ttm(symbol, params \\ %{}),
    do: get("#{@api_v3}/key-metrics-ttm/#{symbol}", params)

  @doc """
  Fetches a company's financial ratios from the FMP API.
  """
  def financial_ratios(symbol, params \\ %{}), do: get("#{@api_v3}/ratios/#{symbol}", params)

  @doc """
  Fetches a company's financial scores from the FMP API.
  """
  def financial_scores(symbol) do
    case get("#{@api_v4}/score", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's enterprise value from the FMP API.
  """
  def enterprise_value(symbol, params \\ %{}),
    do: get("#{@api_v3}/enterprise-values/#{symbol}", params)

  @doc """
  Fetches a company's discounted cash flow from the FMP API.
  """
  def discounted_cash_flow(symbol) do
    case get("#{@api_v3}/discounted-cash-flow/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical discounted cash flow from the FMP API.
  """
  def historical_discounted_cash_flow(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-discounted-cash-flow-statement/#{symbol}", params)

  @doc """
  Fetches a company's historical daily discounted cash flow from the FMP API.
  """
  def historical_daily_discounted_cash_flow(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-daily-discounted-cash-flow/#{symbol}", params)

  @doc """
  Fetches a company's advanced discounted cash flow TTM from the FMP API.
  """
  def advanced_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's advanced levered discounted cash flow from the FMP API.
  """
  def advanced_levered_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_levered_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's key executives from the FMP API.
  """
  def key_executives(symbol), do: get("#{@api_v3}/key-executives/#{symbol}")

  @doc """
  Fetches a company's executive compensation from the FMP API.
  """
  def executive_compensation(symbol),
    do: get("#{@api_v4}/governance/executive_compensation", %{symbol: symbol})

  @doc """
  Fetches the executive compensation benchmark for a year from the FMP API.
  """
  def executive_compensation_benchmark(year),
    do: get("#{@api_v4}/executive-compensation-benchmark", %{year: year})

  @doc """
  Fetches a company's market capitalization from the FMP API.
  """
  def market_cap(symbol) do
    case get("#{@api_v3}/market-capitalization/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical market capitalization from the FMP API.
  """
  def historical_market_cap(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-market-capitalization/#{symbol}", params)

  @doc """
  Fetches a company's peers from the FMP API.
  """
  def peers(symbol) do
    case get("#{@api_v4}/stock_peers", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company profile from the FMP API.
  """
  def profile(symbol) do
    case get("#{@api_v3}/profile/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's outlook from the FMP API.
  """
  def company_outlook(symbol), do: get("#{@api_v4}/company-outlook", %{symbol: symbol})

  @doc """
  Fetches a company's core information from the FMP API.
  """
  def company_core_information(symbol) do
    case get("#{@api_v4}/company-core-information", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's SIC information using CIK from the FMP API.
  """
  def sic_by_cik(cik) do
    case get("#{@api_v4}/standard_industrial_classification", %{cik: cik}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's SIC information using symbol from the FMP API.
  """
  def sic_by_symbol(symbol) do
    case get("#{@api_v4}/standard_industrial_classification", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches SIC information for SIC code from the FMP API.
  """
  def sic_by_code(sic_code),
    do: get("#{@api_v4}/standard_industrial_classification", %{sicCode: sic_code})

  @doc """
  Fetches all SIC information from the FMP API.
  """
  def all_sics, do: get("#{@api_v4}/standard_industrial_classification/all")

  @doc """
  Fetches a list of SIC codes from the FMP API.
  """
  def sic_list(params \\ %{}),
    do: get("#{@api_v4}/standard_industrial_classification_list", params)

  @doc """
  Fetches a company's historical employee count from the FMP API.
  """
  def historical_employee_count(symbol),
    do: get("#{@api_v4}/historical/employee_count", %{symbol: symbol})

  @doc """
  Fetches a company's shares float from the FMP API.
  """
  def shares_float(symbol) do
    case get("#{@api_v4}/shares_float", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical chart from the FMP API.
  """
  def historical_chart(interval, symbol),
    do: get("#{@api_v3}/historical-chart/#{interval}/#{symbol}")

  @doc """
  Fetches historical chart with full data for the symbols from the FMP API.
  """
  def historical_chart_full(symbols, params \\ %{}),
    do: get("#{@api_v3}/historical-price-full/#{symbols}", params)

  @doc """
  Fetches quotes for an exchange from the FMP API.
  """
  def quotes(exchange), do: get("#{@api_v3}/quotes/#{exchange}")

  @doc """
  Fetches quotes from the FMP API.
  """
  def quote(symbols), do: get("#{@api_v3}/quote/#{symbols}")

  @doc """
  Fetches short quotes from the FMP API.
  """
  def quote_short(symbols), do: get("#{@api_v3}/quote-short/#{symbols}")

  @doc """
  Fetches price changes from the FMP API.
  """
  def price_change(symbols), do: get("#{@api_v3}/stock-price-change/#{symbols}")

  @doc """
  Fetches a OTC prices from the FMP API.
  """
  def otc_prices(symbols), do: get("#{@api_v3}/otc/real-time-price/#{symbols}")

  @doc """
  Fetches a company's technical indicator from the FMP API.
  """
  def technical_indicator(symbol, interval, params \\ %{}),
    do: get("#{@api_v3}/technical_indicator/#{interval}/#{symbol}", params)

  @doc """
  Fetches a company's historical stock splits from the FMP API.
  """
  def stock_splits(symbol), do: get("#{@api_v3}/historical-price-full/stock_split/#{symbol}")

  @doc """
  Fetches a company's price targets from the FMP API.
  """
  def price_targets(symbol), do: get("#{@api_v4}/price-target", %{symbol: symbol})

  @doc """
  Fetches a company's price targets consensus from the FMP API.
  """
  def price_targets_consenus(symbol) do
    case get("#{@api_v4}/price-target-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's price target summary from the FMP API.
  """
  def price_target_summary(symbol) do
    case get("#{@api_v4}/price-target-summary", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of price targets by an analyst from the FMP API.
  """
  def price_targets_by_analyst(analyst_name),
    do: get("#{@api_v4}/price-target-analyst-name", %{name: analyst_name})

  @doc """
  Fetches a list of price targets by an analyst company from the FMP API.
  """
  def price_targets_by_analyst_company(company),
    do: get("#{@api_v4}/price-target-analyst-company", %{company: company})

  @doc """
  Fetches a company's upgrades and downgrades from the FMP API.
  """
  def upgrades_and_downgrades(symbol),
    do: get("#{@api_v4}/upgrade-downgrade", %{symbol: symbol})

  @doc """
  Fetches a company's upgrades and downgrades consensus from the FMP API.
  """
  def upgrades_and_downgrades_consenus(symbol) do
    case get("#{@api_v4}/upgrade-downgrade-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of upgrades and downgrades by an analyst company from the FMP API.
  """
  def upgrades_and_downgrades_by_company(company),
    do: get("#{@api_v4}/upgrade-downgrade-analyst-company", %{company: company})

  @doc """
  Fetches a company's rating from the FMP API.
  """
  def rating(symbol) do
    case get("#{@api_v3}/rating/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical rating from the FMP API.
  """
  def historical_rating(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-rating/#{symbol}", params)

  @doc """
  Fetches a list of company's notes from the FMP API.
  """
  def company_notes(symbol), do: get("#{@api_v4}/company-notes", %{symbol: symbol})

  @doc """
  Fetches a company's ESG score from the FMP API.
  """
  def esg_scores(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data", %{symbol: symbol})

  @doc """
  Fetches a company's ESG risk rating from the FMP API.
  """
  def esg_risk_ratings(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data-ratings", %{symbol: symbol})

  @doc """
  Fetches a sector ESG score benchmarks from the FMP API.
  """
  def esg_sector_benchmarks(year),
    do: get("#{@api_v4}/esg-sector-benchmark", %{year: year})

  @doc """
  Fetches acquistion of beneficial ownership from the FMP API.
  """
  def acquisition_of_beneficial_ownership(symbol),
    do: get("#{@api_v4}/insider-trading/acquisition-of-beneficial-ownership/#{symbol}")

  @doc """
  Fetches a company's institutional ownership from the FMP API.
  """
  def institutional_stock_ownership(symbol),
    do: get("#{@api_v4}/insider/ownership/acquisition_of_beneficial_ownership", %{symbol: symbol})

  @doc """
  Fetches a company's institutional ownership by holders from the FMP API.
  """
  def stock_ownership_by_holders(symbol, params \\ %{}),
    do:
      get(
        "#{@api_v4}/institutional-ownership/institutional-holders/symbol-ownership-percent",
        Map.merge(%{symbol: symbol}, params)
      )

  @doc """
  Fetches a list of commitment of traders report from the FMP API.
  """
  def commitment_of_traders_report_list, do: get("#{@api_v4}/commitment_of_traders_report/list")

  @doc """
  Fetches a commitment of traders report from and to a date from the FMP API.
  """
  def commitment_of_traders_report(from, to),
    do: get("#{@api_v4}/commitment_of_traders_report", %{from: from, to: to})

  @doc """
  Fetches a commitment of traders report from a symbol from the FMP API.
  """
  def commitment_of_traders_report(symbol),
    do: get("#{@api_v4}/commitment_of_traders_report/#{symbol}")

  @doc """
  Fetches a commitment of traders report analysis from and to a date from the FMP API.
  """
  def commitment_of_traders_report_analysis(from, to),
    do: get("#{@api_v4}/commitment_of_traders_report_analysis", %{from: from, to: to})

  @doc """
  Fetches a commitment of traders report analysis from a symbol from the FMP API.
  """
  def commitment_of_traders_report_analysis(symbol),
    do: get("#{@api_v4}/commitment_of_traders_report_analysis/#{symbol}")

  @doc """
  Fetches the symbols of all companies from the FMP API.
  """
  def symbols, do: get("#{@api_v3}/stock/list")

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.
  """
  def tradable_symbols, do: get("#{@api_v3}/available-traded/list")

  @doc """
  Fetches the symbol changes from the FMP API.
  """
  def symbol_changes, do: get("#{@api_v4}/symbol_change")

  @doc """
  Fetches the symbols of all ETFs from the FMP API.
  """
  def etfs, do: get("#{@api_v3}/etf/list")

  @doc """
  Fetches information about an ETF from the FMP API.
  """
  def etf(symbol) do
    case get("#{@api_v4}/etf-info", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the holdings of an ETF from the FMP API.
  """
  def etf_holdings(symbol), do: get("#{@api_v3}/etf-holder/#{symbol}")

  @doc """
  Fetches the stock exposure of an ETF from the FMP API.
  """
  def etf_stock_exposure(symbol), do: get("#{@api_v3}/etf-stock-exposure/#{symbol}")

  @doc """
  Fetches the country weightings of an ETF from the FMP API.
  """
  def etf_country_weightings(symbol), do: get("#{@api_v3}/etf-country-weightings/#{symbol}")

  @doc """
  Fetches the sector weightings of an ETF from the FMP API.
  """
  def etf_sector_weightings(symbol), do: get("#{@api_v3}/etf-sector-weightings/#{symbol}")

  @doc """
  Fetches sectors PE ratios for a given date from the FMP API.
  """
  def sectors_pe_ratios(date), do: get("#{@api_v4}/sector_price_earning_ratio", %{date: date})

  @doc """
  Fetches industries PE ratios for a given date from the FMP API.
  """
  def industries_pe_ratios(date),
    do: get("#{@api_v4}/industry_price_earning_ratio", %{date: date})

  @doc """
  Fetches sectors performance from the FMP API.
  """
  def sectors_performance, do: get("#{@api_v3}/sector_performance")

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
  def most_active, do: get("#{@api_v3}/stock_market/most-active")

  @doc """
  Fetches historical sectors performance from the FMP API.
  """
  def historical_sectors_performance(params \\ %{}),
    do: get("#{@api_v3}/historical-sectors-performance", params)

  @doc """
  Fetches the list of FMP articles from the FMP API.
  """
  def fmp_articles(params \\ %{}), do: get("#{@api_v3}/fmp/articles", params)

  @doc """
  Fetches the list of stock news from the FMP API.
  """
  def stock_news(params \\ %{}), do: get("#{@api_v3}/stock_news", params)

  @doc """
  Fetches the list of crypto news from the FMP API.
  """
  def crypto_news(params \\ %{}), do: get("#{@api_v4}/crypto_news", params)

  @doc """
  Fetches the list of forex news from the FMP API.
  """
  def forex_news(params \\ %{}), do: get("#{@api_v4}/forex_news", params)

  @doc """
  Fetches the list of general news from the FMP API.
  """
  def general_news(params \\ %{}), do: get("#{@api_v4}/general_news", params)

  @doc """
  Fetches the list of press releases from the FMP API.
  """
  def press_releases(symbol, params \\ %{}),
    do: get("#{@api_v3}/press-releases/#{symbol}", params)

  @doc """
  Fetches the list of sec filings of a company from the FMP API.
  """
  def sec_filings(symbol, params \\ %{}), do: get("#{@api_v3}/sec_filings/#{symbol}", params)

  @doc """
  Fetches the SEC rss feed from the FMP API.
  """
  def rss_feed(page \\ 0), do: get("#{@api_v3}/rss_feed", %{page: page})

  @doc """
  Fetches the price targets rss feed from the FMP API.
  """
  def price_targets_rss_feed(page \\ 0),
    do: get("#{@api_v4}/price-target-rss-feed", %{page: page})

  @doc """
  Fetches the upgrades and downgrades rss feed from the FMP API.
  """
  def upgrades_and_downgrades_rss_feed(page \\ 0),
    do: get("#{@api_v4}/upgrades-downgrades-rss-feed", %{page: page})

  @doc """
  """
  def stock_news_sentiment_rss_feed(page \\ 0),
    do: get("#{@api_v4}/stock-news-sentiments-rss-feed", %{page: page})

  @doc """
  Search via ticker and company name from the FMP API.
  """
  def search(query, params \\ %{}),
    do: get("#{@api_v3}/search", Map.merge(%{query: query}, params))

  @doc """
  Search via ticker from the FMP API.
  """
  def search_ticker(query, params \\ %{}),
    do: get("#{@api_v3}/search-ticker", Map.merge(%{query: query}, params))

  @doc """
  Search via company name from the FMP API.
  """
  def search_name(query, params \\ %{}),
    do: get("#{@api_v3}/search-name", Map.merge(%{query: query}, params))

  @doc """
  Screen stocks from the FMP API.
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
