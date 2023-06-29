defmodule FMP do
  @api_v3 "https://financialmodelingprep.com/api/v3"
  @api_v4 "https://financialmodelingprep.com/api/v4"

  @doc """
  Fetches the trading hours for the current year from the FMP API.

  ## Response

  ```elixir
  %{
    isTheCryptoMarketOpen: true,
    isTheEuronextMarketOpen: true,
    isTheForexMarketOpen: true,
    isTheStockMarketOpen: true,
    stockExchangeName: "New York Stock Exchange",
    stockMarketHolidays: [],
    stockMarketHours: %{
      closingHour: "04:00 p.m. ET",
      openingHour: "09:30 a.m. ET"
    }
  }}
  ```
  """
  def trading_hours, do: get("#{@api_v3}/is-the-market-open")

  @doc """
  Fetches a list of all delisted companies from the FMP API.

  ## Parameters

  * `:page` - The page number to fetch.

  ## Response

  ```elixir
  [
    %{
      companyName: "Constrained Capital ESG Orphans ETF",
      delistedDate: "2023-06-27",
      exchange: "AMEX",
      ipoDate: "2022-05-18",
      symbol: "ORFN"
    },
  ]
  ```
  """
  def companies_delisted(params \\ %{}),
    do: get("#{@api_v3}/delisted-companies", params)

  @doc """
  Fetches a list of companies in the S&P 500 from the FMP API.

  ## Response

  ```elixir
  [
    %{
      cik: "0000066740",
      dateFirstAdded: "1957-03-04",
      founded: "1902",
      headQuarter: "Saint Paul, Minnesota",
      name: "3M",
      sector: "Industrials",
      subSector: "Industrial Conglomerates",
      symbol: "MMM"
    },
  ]
  ```
  """
  def companies_sp500, do: get("#{@api_v3}/sp500_constituent")

  @doc """
  Fetches the history of companies in the S&P 500 from the FMP API.

  ## Response

  ```elixir
  [
    %{
      addedSecurity: "",
      date: "2022-11-01",
      dateAdded: "November 1, 2022",
      reason: "Elon Musk acquired Twitter.",
      removedSecurity: "Twitter",
      removedTicker: "TWTR",
      symbol: "TWTR"
    },
  ]
  ```
  """
  def companies_sp500_historical, do: get("#{@api_v3}/historical/sp500_constituent")

  @doc """
  Fetches a list of companies in the NASDAQ from the FMP API.

  ## Response

  ```elixir
  [
    %{
      cik: "0000718877",
      dateFirstAdded: nil,
      founded: "1983-06-10",
      headQuarter: "Santa Monica, CALIFORNIA",
      name: "Activision Blizzard",
      sector: "Communication Services",
      subSector: "Communication Services",
      symbol: "ATVI"
    },
  ]
  ```
  """
  def companies_nasdaq, do: get("#{@api_v3}/nasdaq_constituent")

  @doc """
  Fetches a list of companies in the Dow Jones from the FMP API.

  ## Response

  ```elixir
  [
    %{
      cik: "0000066740",
      dateFirstAdded: "1994-01-01",
      founded: "1946-01-14",
      headQuarter: "Saint Paul, MINNESOTA",
      name: "3M Co",
      sector: "Industrials",
      subSector: "Industrials",
      symbol: "MMM"
    }
  ]
  ```
  """
  def companies_dow_jones, do: get("#{@api_v3}/dowjones_constituent")

  @doc """
  Fetches the history of companies in the Dow Jones from the FMP API.

  ## Response

  ```elixir
  [
    %{
      addedSecurity: "",
      date: "2004-04-08",
      dateAdded: "April 8, 2004",
      reason: "Market capitalization change",
      removedSecurity: "AT&T Inc",
      removedTicker: "T",
      symbol: "T"
    },
  ]
  ```
  """
  def companies_dow_jones_historical, do: get("#{@api_v3}/historical/dowjones_constituent")

  @doc """
  Fetches a company by cik from the FMP API.

  ## Inputs

  * `cik` - The CIK of the company.

  ## Response

  ```elixir
  %{
    cik: "0001067983",
    name: "BERKSHIRE HATHAWAY INC"
  }
  ```
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

  ## Inputs

  * `cusip` - The CUSIP of the company.

  ## Response

  ```elixir
  %{
    company: "AAON INC",
    cusip: "000360206",
    ticker: "AAON"
  }
  ```
  """
  def company_by_cusip(cusip) do
    case get("#{@api_v3}/cusip/#{cusip}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company profile from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    cik: "0000320193",
    zip: "95014",
    isEtf: false,
    isin: "US0378331005",
    lastDiv: 0.96,
    volAvg: 56915709,
    cusip: "037833100",
    phone: "408 996 1010",
    price: 187.9799,
    industry: "Consumer Electronics",
    state: "CA",
    ceo: "Mr. Timothy D. Cook",
    beta: 1.289436,
    exchange: "NASDAQ Global Select",
    isActivelyTrading: true,
    mktCap: 2956679531330,
    changes: -0.0801,
    exchangeShortName: "NASDAQ",
    address: "One Apple Park Way",
    isFund: false,
    companyName: "Apple Inc.",
    city: "Cupertino",
    fullTimeEmployees: "164000",
    description: "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide.",
    website: "https://www.apple.com",
    isAdr: false,
    dcfDiff: 4.15176,
    country: "US",
    currency: "USD",
    range: "124.17-188.62",
    image: "https://financialmodelingprep.com/image-stock/AAPL.png",
    ipoDate: "1980-12-12",
    symbol: "AAPL",
    dcf: 150.082,
    sector: "Technology",
    defaultImage: false
  }
  ```
  """
  def company_profile(symbol) do
    case get("#{@api_v3}/profile/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's outlook from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    financialsAnnual: %{
      balance: [],
      cash: [],
      income: []
    },
    financialsQuarter: %{
      balance: [],
      cash: [],
      income: []
    },
    insideTrades: [],
    keyExecutives: [],
    metrics: %{},
    profile: %{},
    rating: [],
    ratios: [],
    splitsHistory: [],
    stockDividend: [],
    stockNews: []
  }
  ```
  """
  def company_outlook(symbol), do: get("#{@api_v4}/company-outlook", %{symbol: symbol})

  @doc """
  Fetches a company's core information from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    businessAddress: "ONE APPLE PARK WAY,CUPERTINO CA 95014,(408) 996-1010",
    cik: "0000320193",
    exchange: "NASDAQ",
    fiscalYearEnd: "09-25",
    mailingAddress: "ONE APPLE PARK WAY,CUPERTINO CA 95014",
    registrantName: "Apple Inc.",
    sicCode: "3571",
    sicDescription: "ELECTRONIC COMPUTERS",
    sicGroup: "Consumer Electronics",
    stateLocation: "CA",
    stateOfIncorporation: "CA",
    symbol: "AAPL",
    taxIdentificationNumber: "94-2404110"
  }
  ```
  """
  def company_core_information(symbol) do
    case get("#{@api_v4}/company-core-information", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical employee count from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      acceptanceTime: "2022-10-27 18:01:14",
      cik: "0000320193",
      companyName: "Apple Inc.",
      employeeCount: 164000,
      filingDate: "2022-10-28",
      formType: "10-K",
      periodOfReport: "2022-09-24",
      source: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/0000320193-22-000108-index.htm",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def employee_count_historical(symbol),
    do: get("#{@api_v4}/historical/employee_count", %{symbol: symbol})

  @doc """
  Fetches a company's shares float from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    date: "2023-06-27 20:05:33",
    floatShares: 15712029576,
    freeFloat: 99.89401006085002,
    outstandingShares: 15728700416,
    source: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/aapl-20220924.htm",
    symbol: "AAPL"
  }
  ```
  """
  def shares_float(symbol) do
    case get("#{@api_v4}/shares_float", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the list of cik from the FMP API.

  ## Response

  ```elixir
  [
    %{
      cik: "0000002230",
      name: "ADAMS DIVERSIFIED EQUITY FUND, INC."
    },
  ]
  ```
  """
  def cik_list, do: get("#{@api_v3}/cik_list")

  @doc """
  Searches for a cik by name from the FMP API.

  ## Inputs

  * `name` - The name of the company.

  ## Response

  ```elixir
  [
    %{
      cik: "0000949012",
      name: "BERKSHIRE ASSET MANAGEMENT LLC/PA"
    },
  ]
  ```
  """
  def cik_search(name), do: get("#{@api_v3}/cik-search/#{name}")

  @doc """
  Fetches the earnings calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the earnings calendar.
  * `to` - The end date of the earnings calendar.

  ## Reponse

  ```elixir
  [
    %{
      date: "2023-06-27",
      eps: nil,
      epsEstimated: -0.07,
      fiscalDateEnding: "2023-09-30",
      revenue: nil,
      revenueEstimated: 30520000,
      symbol: "MDF.TO",
      time: "bmo",
      updatedFromDate: "2023-06-27"
    },
  ]
  ```
  """
  def earnings_calendar(params \\ %{}), do: get("#{@api_v3}/earning_calendar", params)

  @doc """
  Fetches the confirmed earnings calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the earnings calendar.
  * `to` - The end date of the earnings calendar.

  ## Response

  ```elixir
  [
    %{
      date: "2023-08-11",
      exchange: "NASDAQ",
      publicationDate: "2023-05-11",
      symbol: "HALO",
      time: "16:30",
      title: "HeartBeam Reports First Quarter 2023 Financial Results",
      url: "http://www.businesswire.com/news/home/20230511005753/en/HeartBeam-Reports-First-Quarter-2023-Financial-Results",
      when: "post market"
    },
  ]
  ```
  """
  def earnings_calendar_confirmed(params \\ %{}),
    do: get("#{@api_v4}/earning-calendar-confirmed", params)

  @doc """
  Fetches the historical earnings calendar for a given symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `from` - The start date of the earnings calendar.
  * `to` - The end date of the earnings calendar.

  ## Response

  ```elixir
  [
    %{
      date: "2024-05-02",
      eps: nil,
      epsEstimated: nil,
      fiscalDateEnding: "2024-06-30",
      revenue: nil,
      revenueEstimated: nil,
      symbol: "AAPL",
      time: "bmo",
      updatedFromDate: "2023-06-27"
    },
  ]
  ```
  """
  def earnings_calendar_historical(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical/earning_calendar/#{symbol}", params)

  @doc """
  Fetches the IPO calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the IPO calendar.
  * `to` - The end date of the IPO calendar.

  ## Response

  ```elixir
  [
    %{
      actions: "Expected",
      company: "PHINIA Inc.",
      date: "2023-07-05",
      exchange: "NYSE",
      marketCap: nil,
      priceRange: nil,
      shares: nil,
      symbol: "PHIN"
    },
  ]
  ```
  """
  def ipo_calendar(params \\ %{}), do: get("#{@api_v3}/ipo_calendar", params)

  @doc """
  Fetches the IPO calendar prospectus from the FMP API.

  ## Parameters

  * `from` - The start date of the IPO calendar.
  * `to` - The end date of the IPO calendar.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2023-06-28 07:55:48",
      cik: "0001558740",
      discountsAndCommissionsPerShare: 0,
      discountsAndCommissionsTotal: 0,
      filingDate: "2023-06-28",
      form: "S-1/A",
      ipoDate: "2010-04-29",
      pricePublicPerShare: 55288,
      pricePublicTotal: 0,
      proceedsBeforeExpensesPerShare: 0,
      proceedsBeforeExpensesTotal: 0,
      symbol: "WNLV",
      url: "https://www.sec.gov/Archives/edgar/data/1558740/000182912623004445/winvestgroup_s1a6.htm"
    },
  ]
  ```
  """
  def ipo_calendar_prospectus(params \\ %{}),
    do: get("#{@api_v4}/ipo-calendar-prospectus", params)

  @doc """
  Fetches the confirmed IPO calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the IPO calendar.
  * `to` - The end date of the IPO calendar.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2023-01-31 15:04:42",
      cik: "0001936702",
      effectivenessDate: "2023-01-31",
      filingDate: "2023-01-31",
      form: "CERT",
      symbol: "CETUU",
      url: "https://www.sec.gov/Archives/edgar/data/1936702/000135445723000056/8A_Cert_CETU.pdf"
    },
  ]
  ```
  """
  def ipo_calendar_confirmed(params \\ %{}),
    do: get("#{@api_v4}/ipo-calendar-confirmed", params)

  @doc """
  Fetches the stock split calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the stock split calendar.
  * `to` - The end date of the stock split calendar.

  ## Response

  ```elixir
  [
    %{
      date: "2023-07-28",
      denominator: 10,
      label: "July 28, 23",
      numerator: 1,
      symbol: "8547.HK"
    },
  ]
  ```
  """
  def stock_split_calendar(params \\ %{}),
    do: get("#{@api_v3}/stock_split_calendar", params)

  @doc """
  Fetches the dividend calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the dividend calendar.
  * `to` - The end date of the dividend calendar.

  ## Response

  ```elixir
  [
    %{
      adjDividend: nil,
      date: "2023-09-28",
      declarationDate: nil,
      dividend: nil,
      label: "September 28, 23",
      paymentDate: nil,
      recordDate: nil,
      symbol: "SZHFF"
    },
  ]
  ```
  """
  def dividends_calendar(params \\ %{}),
    do: get("#{@api_v3}/stock_dividend_calendar", params)

  @doc """
  Fetches the historical dividend calendar for a given symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    historical: [
      %{
        adjDividend: 0.24,
        date: "2023-05-12",
        declarationDate: "2023-05-04",
        dividend: 0.24,
        label: "May 12, 23",
        paymentDate: "2023-05-18",
        recordDate: "2023-05-15"
      },
    ],
    symbol: "AAPL"
  }
  ```
  """
  def dividends_historical(symbol),
    do: get("#{@api_v3}/historical-price-full/stock_dividend/#{symbol}")

  @doc """
  Fetches the economoic calendar from the FMP API.

  ## Parameters

  * `from` - The start date of the economic calendar.
  * `to` - The end date of the economic calendar.

  ## Response

  ```elixir
  [
    %{
      actual: nil,
      change: 0,
      changePercentage: 0,
      country: "JP",
      currency: "JPY",
      date: "2023-07-05 23:50:00",
      estimate: nil,
      event: "Stock Investment by Foreigners (Jul/01)",
      impact: "Low",
      previous: nil
    },
  ]
  ```
  """
  def economic_calendar(params \\ %{}),
    do: get("#{@api_v3}/economic_calendar", params)

  @doc """
  Fetches a company's financial reports dates from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      date: "2022",
      linkJson: "https://fmpcloud.io/api/v4/financial-reports-json?symbol=AAPL&year=2022&period=FY&apikey=YOUR_API_KEY",
      linkXlsx: "https://fmpcloud.io/api/v4/financial-reports-xlsx?symbol=AAPL&year=2022&period=FY&apikey=YOUR_API_KEY",
      period: "FY",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def financial_reports_dates(symbol),
    do: get("#{@api_v4}/financial-reports-dates", %{symbol: symbol})

  @doc """
  Fetches a company's income statements from the FMP API.

  ## Inputs

  * `cik_or_symbol` - The CIK or symbol of the company.

  ## Parameters

  * `period` - The period of the income statements. Can be `quarter` or `annual`.
  * `limit` - The number of income statements to return.

  ## Response

  ```elixir
  [
    %{
      grossProfitRatio: 0.4330963056,
      link: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/0000320193-22-000108-index.htm",
      costAndExpenses: 274891000000,
      incomeBeforeTaxRatio: 0.3020404333,
      grossProfit: 170782000000,
      otherExpenses: 0,
      netIncomeRatio: 0.2530964071,
      totalOtherIncomeExpensesNet: -334000000,
      operatingIncome: 119437000000,
      weightedAverageShsOut: 16215963000,
      researchAndDevelopmentExpenses: 26251000000,
      netIncome: 99803000000,
      ebitdaratio: 0.3310467428,
      epsdiluted: 6.11,
      depreciationAndAmortization: 11104000000,
      calendarYear: "2022",
      generalAndAdministrativeExpenses: 0,
      reportedCurrency: "USD",
      operatingIncomeRatio: 0.302887444,
      symbol: "AAPL",
      revenue: 394328000000,
      fillingDate: "2022-10-28",
      interestExpense: 2931000000,
      finalLink: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/aapl-20220924.htm",
      acceptedDate: "2022-10-27 18:01:14",
      costOfRevenue: 223546000000,
      cik: "0000320193",
      incomeBeforeTax: 119103000000,
      operatingExpenses: 51345000000,
      weightedAverageShsOutDil: 16325819000,
      date: "2022-09-24",
      period: "FY",
      eps: 6.15,
      ebitda: 130541000000,
      sellingGeneralAndAdministrativeExpenses: 25094000000,
      sellingAndMarketingExpenses: 0,
      interestIncome: 2825000000,
      incomeTaxExpense: 19300000000
    },
  ]
  ```
  """
  def income_statements(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's income statement growth from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the income statement growth. Can be `quarter` or `annual`.
  * `limit` - The number of income statement growths to return.

  ## Response

  ```elixir
  [
    %{
      date: "2022-09-24",
      growthCostAndExpenses: 0.07016444243736082,
      growthCostOfRevenue: 0.04960536385874796,
      growthDepreciationAndAmortization: -0.015951790145338533,
      growthEBITDA: 0.08573353405471043,
      growthEBITDARatio: 0.0072320103774037164,
      growthEPS: 0.08465608465608473,
      growthEPSDiluted: 0.08912655971479501,
      growthGeneralAndAdministrativeExpenses: 0,
      growthGrossProfit: 0.11741997958596143,
      growthGrossProfitRatio: 0.03662743860969033,
      growthIncomeBeforeTax: 0.0906169018469512,
      growthIncomeBeforeTaxRatio: 0.011762297331617908,
      growthIncomeTaxExpense: 0.32856061127555586,
      growthInterestExpense: 0.10812854442344046,
      growthNetIncome: 0.05410857625686523,
      growthNetIncomeRatio: -0.02210637578477297,
      growthOperatingExpenses: 0.16993642764372138,
      growthOperatingIncome: 0.09626522501353844,
      growthOperatingIncomeRatio: 0.017002231252019266,
      growthOtherExpenses: 0,
      growthResearchAndDevelopmentExpenses: 0.19791001186456147,
      growthRevenue: 0.07793787604184606,
      growthSellingAndMarketingExpenses: 0,
      growthTotalOtherIncomeExpensesNet: -2.294573643410853,
      growthWeightedAverageShsOut: -0.029058205865996313,
      growthWeightedAverageShsOutDil: -0.03196576277656596,
      period: "FY",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def income_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/income-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's balance sheets from the FMP API.

  ## Inputs

  * `cik_or_symbol` - The CIK or symbol of the company.

  ## Parameters

  * `period` - The period of the balance sheets. Can be `quarter` or `annual`.
  * `limit` - The number of balance sheets to return.

  ## Response

  ```elixir
  [
    %{
      otherCurrentAssets: 21223000000,
      capitalLeaseObligations: 0,
      link: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/0000320193-22-000108-index.htm",
      taxPayables: 0,
      shortTermDebt: 21110000000,
      cashAndShortTermInvestments: 48304000000,
      totalLiabilitiesAndStockholdersEquity: 352755000000,
      intangibleAssets: 0,
      minorityInterest: 0,
      totalAssets: 352755000000,
      longTermDebt: 98959000000,
      deferredRevenueNonCurrent: 0,
      totalNonCurrentAssets: 217350000000,
      goodwillAndIntangibleAssets: 0,
      othertotalStockholdersEquity: 0,
      otherLiabilities: 0,
      taxAssets: 0,
      accumulatedOtherComprehensiveIncomeLoss: -11109000000,
      calendarYear: "2022",
      netDebt: 96423000000,
      reportedCurrency: "USD",
      totalEquity: 50672000000,
      symbol: "AAPL",
      shortTermInvestments: 24658000000,
      fillingDate: "2022-10-28",
      otherCurrentLiabilities: 60845000000,
      cashAndCashEquivalents: 23646000000,
      totalLiabilities: 302083000000,
      netReceivables: 60932000000,
      otherNonCurrentAssets: 54428000000,
      totalCurrentAssets: 135405000000,
      finalLink: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/aapl-20220924.htm",
      totalStockholdersEquity: 50672000000,
      deferredTaxLiabilitiesNonCurrent: 0,
      commonStock: 64849000000,
      acceptedDate: "2022-10-27 18:01:14",
      otherAssets: 0,
      cik: "0000320193",
      accountPayables: 64115000000,
      totalDebt: 120069000000,
      longTermInvestments: 120805000000,
      retainedEarnings: -3068000000,
      otherNonCurrentLiabilities: 49142000000,
      preferredStock: 0,
      date: "2022-09-24",
      period: "FY",
      goodwill: 0,
      propertyPlantEquipmentNet: 42117000000,
      totalInvestments: 145463000000,
      ...
    },
  ]
  ```
  """
  def balance_sheets(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's balance sheet growth from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the balance sheet growths. Can be `quarter` or `annual`.
  * `limit` - The number of balance sheet growths to return.

  ## Response

  ```elixir
  [
    %{
      growthOtherCurrentLiabilities: 0.281136167435201,
      growthTotalLiabilitiesAndStockholdersEquity: 0.004994273536902924,
      growthTaxAssets: 0,
      growthLongTermDebt: -0.09300130148662768,
      growthAccountPayables: 0.17077223672917846,
      growthShortTermInvestments: -0.10978735694429402,
      growthOtherAssets: 0,
      growthInventory: -0.24832826747720366,
      growthOtherNonCurrentAssets: 0.11420909332842023,
      growthTaxPayables: 0,
      growthTotalLiabilities: 0.04921990052516047,
      growthIntangibleAssets: 0,
      growthOtherCurrentAssets: 0.5040039685351854,
      growthTotalAssets: 0.004994273536902924,
      growthPropertyPlantEquipmentNet: 0.06787525354969574,
      growthTotalCurrentAssets: 0.004219941261977513,
      growthOtherLiabilities: 0,
      growthOtherNonCurrentLiabilities: -0.07844350679793717,
      growthCommonStock: 0.1304628257648392,
      growthTotalStockholdersEquity: -0.19682992550324932,
      growthShortTermDebt: 0.35207839620828796,
      growthDeferrredTaxLiabilitiesNonCurrent: 0,
      growthTotalDebt: -0.03728381401390325,
      symbol: "AAPL",
      growthGoodwill: 0,
      growthGoodwillAndIntangibleAssets: 0,
      growthLongTermInvestments: -0.055303142863845724,
      growthRetainedEarnings: -1.5516001438331535,
      growthAccumulatedOtherComprehensiveIncomeLoss: -69.15337423312883,
      growthCashAndCashEquivalents: -0.3232398397252433,
      growthTotalNonCurrentAssets: 0.005477272096444399,
      growthDeferredRevenue: 0.0394114555964267,
      growthCashAndShortTermInvestments: -0.22885103529749837,
      growthDeferredRevenueNonCurrent: 0,
      date: "2022-09-24",
      period: "FY",
      growthOthertotalStockholdersEquity: 0,
      growthNetDebt: 0.07400394301562727,
      growthTotalInvestments: -0.06500359952691932,
      growthTotalNonCurrentLiabilities: -0.08822207583527775,
      growthNetReceivables: 0.18300780491593213,
      growthTotalCurrentLiabilities: 0.22713398841258836
    },
  ]
  ```
  """
  def balance_sheet_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/balance-sheet-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's cash flow statements from the FMP API.

  ## Inputs

  * `cik_or_symbol` - The CIK or symbol of the company.

  ## Parameters

  * `period` - The period of the cash flow statements. Can be `quarter` or `annual`.
  * `limit` - The number of cash flow statements to return.

  ## Response

  ```elixir
  [
    %{
      deferredIncomeTax: 895000000,
      link: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/0000320193-22-000108-index.htm",
      acquisitionsNet: -306000000,
      commonStockRepurchased: -89402000000,
      cashAtBeginningOfPeriod: 35929000000,
      operatingCashFlow: 122151000000,
      otherInvestingActivites: -1780000000,
      cashAtEndOfPeriod: 24977000000,
      capitalExpenditure: -10708000000,
      accountsReceivables: -1823000000,
      investmentsInPropertyPlantAndEquipment: -10708000000,
      salesMaturitiesOfInvestments: 67363000000,
      netIncome: 99803000000,
      changeInWorkingCapital: 1200000000,
      accountsPayables: 9448000000,
      netCashUsedForInvestingActivites: -22354000000,
      stockBasedCompensation: 9038000000,
      depreciationAndAmortization: 11104000000,
      calendarYear: "2022",
      effectOfForexChangesOnCash: 0,
      reportedCurrency: "USD",
      freeCashFlow: 111443000000,
      otherFinancingActivites: 3037000000,
      symbol: "AAPL",
      fillingDate: "2022-10-28",
      dividendsPaid: -14841000000,
      finalLink: "https://www.sec.gov/Archives/edgar/data/320193/000032019322000108/aapl-20220924.htm",
      acceptedDate: "2022-10-27 18:01:14",
      commonStockIssued: 0,
      netChangeInCash: -10952000000,
      cik: "0000320193",
      otherWorkingCapital: -7909000000,
      otherNonCashItems: 111000000,
      date: "2022-09-24",
      period: "FY",
      netCashProvidedByOperatingActivities: 122151000000,
      debtRepayment: -9543000000,
      purchasesOfInvestments: -76923000000,
      inventory: 1484000000,
      netCashUsedProvidedByFinancingActivities: -110749000000
    },
  ]
  ```
  """
  def cash_flow_statements(cik_or_symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement/#{cik_or_symbol}", params)

  @doc """
  Fetches a company's cash flow statement growth from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the cash flow statement growth. Can be `quarter` or `annual`.
  * `limit` - The number of cash flow statement growths to return.

  ## Response

  ```elixir
  [
    %{
      growthSalesMaturitiesOfInvestments: -0.3673825868918043,
      growthCashAtBeginningOfPeriod: -0.09701173691221192,
      growthOperatingCashFlow: 0.17409984813241317,
      growthOtherWorkingCapital: -0.7693512304250559,
      growthFreeCashFlow: 0.1989177326175594,
      growthInventory: 1.5616956850870554,
      growthNetCashProvidedByOperatingActivites: 0.17409984813241317,
      growthAccountsReceivables: 0.8199506172839506,
      growthOtherFinancingActivites: -0.7938221317040054,
      growthDepreciationAndAmortization: -0.015951790145338533,
      growthInvestmentsInPropertyPlantAndEquipment: 0.03400992331980154,
      growthCommonStockRepurchased: -0.03990880645799165,
      growthDividendsPaid: -0.025851938895417155,
      growthCapitalExpenditure: 0.03400992331980154,
      growthDebtRepayment: -0.09062857142857143,
      growthAccountsPayables: -0.23349018335226351,
      growthNetChangeInCash: -1.8373056994818653,
      growthDeferredIncomeTax: 1.1874738165060745,
      growthNetCashUsedForInvestingActivites: -0.5368855276727398,
      growthCommonStockIssued: -1,
      growthOtherInvestingActivites: -4.056818181818182,
      growthNetCashUsedProvidedByFinancingActivities: -0.18634644842693862,
      symbol: "AAPL",
      growthPurchasesOfInvestments: 0.29787874915569834,
      growthChangeInWorkingCapital: 1.2443494196701284,
      growthStockBasedCompensation: 0.14318239311915001,
      growthNetIncome: 0.05410857625686523,
      growthAcquisitionsNet: -8.272727272727273,
      growthOtherNonCashItems: 1.7551020408163265,
      date: "2022-09-24",
      period: "FY",
      growthCashAtEndOfPeriod: -0.3048234017089259,
      growthEffectOfForexChangesOnCash: 0
    },
  ]
  ```
  """
  def cash_flow_statement_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/cash-flow-statement-growth/#{symbol}", params)

  @doc """
  Fetches a company's financial growth from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the financial growth. Can be `quarter` or `annual`.
  * `limit` - The number of financial growths to return.

  ## Response

  ```elixir
  [
    %{
      operatingCashFlowGrowth: 0.17409984813241317,
      weightedAverageSharesGrowth: -0.029058205865996313,
      threeYDividendperShareGrowthPerShare: 0.19733255359833798,
      freeCashFlowGrowth: 0.1989177326175594,
      epsgrowth: 0.08465608465608473,
      dividendsperShareGrowth: 0.05655348764792707,
      threeYRevenueGrowthPerShare: 0.7264312385752475,
      fiveYNetIncomeGrowthPerShare: 1.6564176904593655,
      epsdilutedGrowth: 0.08912655971479501,
      fiveYDividendperShareGrowthPerShare: 0.4957689252907237,
      tenYDividendperShareGrowthPerShare: 8.62842256095334,
      receivablesGrowth: 0.18300780491593213,
      fiveYRevenueGrowthPerShare: 1.213791990178702,
      debtGrowth: -0.03728381401390325,
      fiveYOperatingCFGrowthPerShare: 1.4717912851614252,
      symbol: "AAPL",
      assetGrowth: 0.004994273536902924,
      netIncomeGrowth: 0.05410857625686523,
      bookValueperShareGrowth: -0.17279276744584973,
      sgaexpensesGrowth: 0.14203795567287125,
      fiveYShareholdersEquityGrowthPerShare: -0.5135153119200997,
      weightedAverageSharesDilutedGrowth: -0.03196576277656596,
      inventoryGrowth: -0.24832826747720366,
      grossProfitGrowth: 0.11741997958596143,
      revenueGrowth: 0.07793787604184606,
      tenYShareholdersEquityGrowthPerShare: -0.30807952624500173,
      tenYRevenueGrowthPerShare: 3.0668993761434575,
      tenYNetIncomeGrowthPerShare: 2.860169220093998,
      date: "2022-09-24",
      tenYOperatingCFGrowthPerShare: 2.8770123198895177,
      rdexpenseGrowth: 0.19791001186456147,
      period: "FY",
      threeYShareholdersEquityGrowthPerShare: -0.3621293491290547,
      operatingIncomeGrowth: 0.09626522501353844,
      threeYOperatingCFGrowthPerShare: 1.0051619005026309,
      threeYNetIncomeGrowthPerShare: 1.0574046479668893,
      ebitgrowth: 0.09626522501353844
    },
  ]
  ```
  """
  def financial_growth(symbol, params \\ %{}),
    do: get("#{@api_v3}/financial-growth/#{symbol}", params)

  @doc """
  Fetches a company's revenue product segmentation from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      date: "2022-09-24",
      products: [
        %{
          name: "Mac",
          revenue: 40177000000
        },
      ]
    },
  ]
  ```
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

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      countries: [
        %{
          name: "CHINA",
          revenue: 74200000000
        },
      ],
      date: "2022-09-24"
    },
  ]
  ```
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

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the key metrics. Can be `quarter` or `annual`.
  * `limit` - The number of key metrics to return.

  ## Response

  ```elixir
  [
    %{
      shareholdersEquityPerShare: 3.124822127430853,
      marketCap: 2439367314090,
      averageReceivables: 56219000000,
      capexToRevenue: -0.02715505873283155,
      roic: 0.5861678044404918,
      roe: 1.9695887275023682,
      interestDebtPerShare: 7.585118441624466,
      daysPayablesOutstanding: 104.6852773031054,
      dividendYield: 0.006083954603424043,
      netIncomePerShare: 6.154614437637777,
      ptbRatio: 48.14034011071204,
      evToOperatingCashFlow: 20.75947240783948,
      tangibleAssetValue: 50672000000,
      grahamNumber: 20.801963754945305,
      evToSales: 6.430662580618166,
      investedCapital: 2.3695334701610355,
      intangiblesToTotalAssets: 0,
      capexPerShare: -0.6603369778285755,
      interestCoverage: 40.74957352439441,
      averagePayables: 59439000000,
      priceToSalesRatio: 6.186137718067193,
      currentRatio: 0.8793560286267226,
      pfcfRatio: 21.888923611981014,
      daysSalesOutstanding: 56.400204905560855,
      revenuePerShare: 24.31727304755197,
      netCurrentAssetValue: -166678000000,
      peRatio: 24.441823533260525,
      symbol: "AAPL",
      operatingCashFlowPerShare: 7.532762624088375,
      stockBasedCompensationToRevenue: 0.022920005680550203,
      inventoryTurnover: 45.19733117670845,
      workingCapital: -18577000000,
      capexToOperatingCashFlow: -0.08766199212450164,
      researchAndDdevelopementToRevenue: 0.06657148363798665,
      pbRatio: 48.14034011071204,
      bookValuePerShare: 3.124822127430853,
      capexToDepreciation: -0.9643371757925072,
      evToFreeCashFlow: 22.754146192134094,
      receivablesTurnover: 6.471607693822622,
      debtToEquity: 2.3695334701610355,
      daysOfInventoryOnHand: 8.07569806661716,
      payablesTurnover: 3.486641191608828,
      earningsYield: 0.040913477615088595,
      netDebtToEBITDA: 0.738641499605488,
      grahamNetNet: -12.67929632054538,
      payoutRatio: 0.14870294480125848,
      pocfratio: 19.970096962693717,
      tangibleBookValuePerShare: 3.124822127430853,
      incomeQuality: 1.2239211246154926,
      ...
    },
  ]
  ```
  """
  def key_metrics(symbol, params \\ %{}), do: get("#{@api_v3}/key-metrics/#{symbol}", params)

  @doc """
  Fetches a company's key metrics TTM from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the key metrics. Can be `quarter` or `annual`.
  * `limit` - The number of key metrics to return.

  ## Response

  ```elixir
  [
    %{
      pbRatioTTM: 48.047473502204056,
      interestCoverageTTM: 32.28054038516815,
      evToSalesTTM: 7.947142656219894,
      priceToSalesRatioTTM: 7.726604866843247,
      payablesTurnoverTTM: 5.095051810455233,
      pocfratioTTM: 27.253384234468538,
      averageReceivablesTTM: 45039500000,
      tangibleBookValuePerShareTTM: 3.9372517681147596,
      investedCapitalTTM: 1.7634898162746548,
      evToFreeCashFlowTTM: 31.391987908472665,
      intangiblesToTotalAssetsTTM: 0,
      salesGeneralAndAdministrativeToRevenueTTM: 0,
      interestDebtPerShareTTM: 7.1636724389969215,
      stockBasedCompensationToRevenueTTM: 0.02625845570573495,
      pfcfRatioTTM: 30.52084214993333,
      cashPerShareTTM: 3.5390799380306293,
      receivablesTurnoverTTM: 10.727179030056547,
      netIncomePerShareTTM: 5.974541073077516,
      daysSalesOutstandingTTM: 34.02572092600527,
      dividendYieldTTM: 0.004916082991938681,
      daysPayablesOutstandingTTM: 71.63813314930509,
      netDebtToEBITDATTM: 0.6860761947846318,
      dividendPerShareTTM: 0.93,
      freeCashFlowYieldTTM: 0.03276449565472375,
      returnOnTangibleAssetsTTM: 0.28396254816955685,
      ptbRatioTTM: 48.047473502204056,
      bookValuePerShareTTM: 3.9372517681147596,
      enterpriseValueOverEBITDATTM: 24.722952961490616,
      inventoryTurnoverTTM: 29.24445335471799,
      revenuePerShareTTM: 24.39293364719189,
      grahamNetNetTTM: -11.621141467296766,
      debtToEquityTTM: 1.7634898162746548,
      evToOperatingCashFlowTTM: 27.92747938747445,
      capexToOperatingCashFlowTTM: -0.11036282669002774,
      workingCapitalTTM: -7162000000,
      researchAndDevelopementToRevenueTTM: 0.07458938703436814,
      capexToRevenueTTM: -0.03140523766862722,
      incomeQualityTTM: 1.1618197432173112,
      netCurrentAssetValueTTM: -157089000000,
      averagePayablesTTM: 50431500000,
      earningsYieldTTM: 0.03158208575698435,
      dividendYieldPercentageTTM: 0.49160829919386806,
      marketCapTTM: 2975476901197,
      debtToMarketCapTTM: 0.036839472676095435,
      currentRatioTTM: 0.9403539454507599,
      freeCashFlowPerShareTTM: 6.175273896739083,
      operatingCashFlowPerShareTTM: 6.941339775364198,
      capexToDepreciationTTM: -1.0531173807035876,
      averageInventoryTTM: 7151000000,
      ...
    }
  ]
  ```
  """
  def key_metrics_ttm(symbol, params \\ %{}),
    do: get("#{@api_v3}/key-metrics-ttm/#{symbol}", params)

  @doc """
  Fetches a company's financial ratios from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the financial ratios. Can be `quarter` or `annual`.
  * `limit` - The number of financial ratios to return.

  ## Response

  ```elixir
  [
    %{
      effectiveTaxRate: 0.16204461684424407,
      priceToFreeCashFlowsRatio: 21.888923611981014,
      operatingProfitMargin: 0.30288744395528594,
      dividendYield: 0.006083954603424043,
      companyEquityMultiplier: 6.961536943479634,
      returnOnAssets: 0.2829244092925685,
      daysOfInventoryOutstanding: 8.07569806661716,
      pretaxProfitMargin: 0.30204043334482966,
      priceFairValue: 48.14034011071204,
      capitalExpenditureCoverageRatio: -11.407452372058275,
      enterpriseValueMultiple: 19.42524045388039,
      returnOnEquity: 1.9695887275023682,
      assetTurnover: 1.1178523337727317,
      operatingCycle: 64.47590297217802,
      daysOfSalesOutstanding: 56.400204905560855,
      dividendPayoutRatio: 0.14870294480125848,
      interestCoverage: 40.74957352439441,
      quickRatio: 0.7094075930952969,
      priceToSalesRatio: 6.186137718067193,
      currentRatio: 0.8793560286267226,
      grossProfitMargin: 0.43309630561360085,
      priceBookValueRatio: 48.14034011071204,
      symbol: "AAPL",
      operatingCashFlowPerShare: 7.532762624088375,
      priceToOperatingCashFlowsRatio: 19.970096962693717,
      inventoryTurnover: 45.19733117670845,
      priceCashFlowRatio: 19.970096962693717,
      returnOnCapitalEmployed: 0.6008713457059057,
      dividendPaidAndCapexCoverageRatio: 29.555044761674328,
      netIncomePerEBT: 0.8379553831557559,
      receivablesTurnover: 6.471607693822622,
      fixedAssetTurnover: 9.362680152907377,
      priceEarningsRatio: 24.441823533260525,
      freeCashFlowOperatingCashFlowRatio: 0.9123380078754983,
      payablesTurnover: 3.486641191608828,
      longTermDebtToCapitalization: 0.6613535965140913,
      daysOfPayablesOutstanding: 104.6852773031054,
      priceSalesRatio: 6.186137718067193,
      payoutRatio: 0.14870294480125848,
      debtEquityRatio: 2.3695334701610355,
      cashConversionCycle: -40.209374330927375,
      debtRatio: 0.3403750478377344,
      priceToBookRatio: 48.14034011071204,
      operatingCashFlowSalesRatio: 0.30977003915522106,
      priceEarningsToGrowthRatio: 2.8871904048663968,
      cashFlowToDebtRatio: 1.0173400294830472,
      date: "2022-09-24",
      shortTermCoverageRatios: 5.786404547607769,
      ebitPerRevenue: 0.30288744395528594,
      ...
    },
  ]
  ```
  """
  def financial_ratios(symbol, params \\ %{}), do: get("#{@api_v3}/ratios/#{symbol}", params)

  @doc """
  Fetches a company's financial scores from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    altmanZScore: 8.750505326729295,
    ebit: "1.14277E11",
    marketCap: "2.908551280927E12",
    piotroskiScore: 7,
    retainedEarnings: "4.336E9",
    revenue: "3.85095E11",
    symbol: "AAPL",
    totalAssets: "3.3216E11",
    totalLiabilities: "2.70002E11",
    workingCapital: "-7.162E9"
  }
  ```
  """
  def financial_scores(symbol) do
    case get("#{@api_v4}/score", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's enterprise value from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the enterprise value. Can be `quarter` or `annual`.
  * `limit` - The number of enterprise values to return.

  ## Response

  ```elixir
  [
    %{
      addTotalDebt: 120069000000,
      date: "2022-09-24",
      enterpriseValue: 2535790314090,
      marketCapitalization: 2439367314090,
      minusCashAndCashEquivalents: 23646000000,
      numberOfShares: 16215963000,
      stockPrice: 150.43,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def enterprise_value(symbol, params \\ %{}),
    do: get("#{@api_v3}/enterprise-values/#{symbol}", params)

  @doc """
  Fetches a company's discounted cash flow from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    "Stock Price": 189.3084,
    date: "2023-06-28",
    dcf: 190.7567806294802,
    symbol: "AAPL"
  }
  ```
  """
  def discounted_cash_flow(symbol) do
    case get("#{@api_v3}/discounted-cash-flow/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical discounted cash flow from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `period` - The period of the discounted cash flow. Can be `quarter` or `annual`.
  * `limit` - The number of discounted cash flows to return.

  ## Response

  ```elixir
  [
    %{
      date: "2022-09-24",
      dcf: 150.91,
      price: 149.45,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def discounted_cash_flow_historical(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-discounted-cash-flow-statement/#{symbol}", params)

  @doc """
  Fetches a company's historical daily discounted cash flow from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `limit` - The number of discounted cash flows to return.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-27",
      dcf: 189.6178293751834,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def discounted_cash_flow_historical_daily(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-daily-discounted-cash-flow/#{symbol}", params)

  @doc """
  Fetches a company's advanced discounted cash flow TTM from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      dilutedSharesOutstanding: 16325819000,
      totalCash: 168589077025,
      equityValue: 1641196681544,
      depreciation: 25206142748,
      depreciationPercentage: 3.77,
      afterTaxCostOfDebt: 2.05,
      year: "2027",
      costOfEquity: 10.11,
      terminalValue: 2018638597229,
      wacc: 9.81,
      capitalExpenditure: -23333184509,
      ebitPercentage: 27.1,
      receivables: 105907058832,
      equityValuePerShare: 100.53,
      freeCashFlowT1: 157559323541,
      longTermGrowthRate: 2,
      payablePercentage: 17.09,
      netDebt: 96423000000,
      capitalExpenditurePercentage: -3.49,
      totalEquity: 3090804053080,
      debtWeighting: 3.74,
      symbol: "AAPL",
      beta: 1.289436,
      revenue: 668397140360,
      ebiat: 152780938838,
      taxRate: 16.2,
      inventories: 10159631317,
      revenuePercentage: 11.13,
      taxRateCash: 15644181,
      sumPvUfcf: 473047849905,
      ebitdaPercentage: 30.87,
      totalDebt: 120069000000,
      riskFreeRate: 4.02,
      ufcf: 154469925040,
      totalCapital: 3210873053080,
      payable: 114229934778,
      totalCashPercentage: 25.22,
      price: 189.32,
      presentTerminalValue: 1264571831639,
      ebitda: 206321020852,
      ebit: 181114878104,
      marketRiskPremium: 4.72,
      inventoriesPercentage: 1.52,
      enterpriseValue: 1737619681544,
      receivablesPercentage: 15.84,
      equityWeighting: 96.26,
      costofDebt: 2.44
    },
  ]
  ```
  """
  def advanced_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's advanced levered discounted cash flow from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      dilutedSharesOutstanding: 16325819000,
      equityValue: 1815304981783,
      afterTaxCostOfDebt: 2.05,
      year: "2027",
      costOfEquity: 10.11,
      terminalValue: 2221695886382,
      operatingCashFlow: 193341425461,
      wacc: 9.81,
      capitalExpenditure: -23333184509,
      operatingCashFlowPercentage: 28.93,
      pvLfcf: 106501298919,
      equityValuePerShare: 111.19,
      freeCashFlowT1: 173408405771,
      longTermGrowthRate: 2,
      sumPvLfcf: 519951345666,
      netDebt: 96423000000,
      capitalExpenditurePercentage: -3.49,
      freeCashFlow: 170008240952,
      totalEquity: 3090804053080,
      debtWeighting: 3.74,
      symbol: "AAPL",
      beta: 1.289436,
      revenue: 668397140360,
      taxRate: 16.2,
      revenuePercentage: 11.13,
      totalDebt: 120069000000,
      riskFreeRate: 4.02,
      totalCapital: 3210873053080,
      price: 189.32,
      presentTerminalValue: 1391776636116,
      marketRiskPremium: 4.72,
      enterpriseValue: 1911727981783,
      equityWeighting: 96.26,
      costofDebt: 2.44
    },
  ]
  ```
  """
  def advanced_levered_discounted_cash_flow(symbol),
    do: get("#{@api_v4}/advanced_levered_discounted_cash_flow", %{symbol: symbol})

  @doc """
  Fetches a company's insider roster from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      owner: "JUNG ANDREA",
      transactionDate: "2023-05-16",
      typeOfOwner: "director"
    },
  ]
  ```
  """
  def insider_roster(symbol), do: get("#{@api_v4}/insider-roaster", %{symbol: symbol})

  @doc """
  Fetches a company's insider roster statistics from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      averageBought: 110298.8333,
      averageSold: 37903.8286,
      buySellRatio: 0.1714,
      cik: "0000320193",
      pPurchases: 0,
      purchases: 6,
      quarter: 2,
      sSales: 11,
      sales: 35,
      symbol: "AAPL",
      totalBought: 661793,
      totalSold: 1326634,
      year: 2023
    },
  ]
  ```
  """
  def insider_roster_statistics(symbol),
    do: get("#{@api_v4}/insider-roaster-statistic", %{symbol: symbol})

  @doc """
  Fetches a company's key executives from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      currencyPay: "USD",
      gender: "female",
      name: "Ms. Deirdre  O'Brien",
      pay: 5019783,
      title: "Senior Vice President of People & Retail",
      titleSince: 1676248586,
      yearBorn: 1967
    },
  ]
  ```
  """
  def key_executives(symbol), do: get("#{@api_v3}/key-executives/#{symbol}")

  @doc """
  Fetches a company's executive compensation from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2023-01-12 16:31:22",
      all_other_compensation: 17137,
      bonus: 0,
      cik: "0000320193",
      companyName: "Apple Inc.",
      filingDate: "2023-01-12",
      incentive_plan_compensation: 3577000,
      industryTitle: "ELECTRONIC COMPUTERS",
      nameAndPosition: "Jeff Williams Chief Operating Officer",
      salary: 1000000,
      stock_award: 21657687,
      symbol: "AAPL",
      total: 26251824,
      url: "https://www.sec.gov/Archives/edgar/data/320193/000130817923000019/0001308179-23-000019-index.htm",
      year: 2020
    },
  ]
  ```
  """
  def executive_compensation(symbol),
    do: get("#{@api_v4}/governance/executive_compensation", %{symbol: symbol})

  @doc """
  Fetches the executive compensation benchmark for a year from the FMP API.

  ## Inputs

  * `year` - The year to fetch the benchmark for.

  ## Response

  ```elixir
  [
    %{
      averageCompensation: 578390.7777777778,
      industryTitle: "ABRASIVE, ASBESTOS & MISC NONMETALLIC MINERAL PRODS",
      year: 2020
    },
  ]
  ```
  """
  def executive_compensation_benchmark(year),
    do: get("#{@api_v4}/executive-compensation-benchmark", %{year: year})

  @doc """
  Fetches a company's market capitalization from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    date: "2023-06-28",
    marketCap: 2975634188201,
    symbol: "AAPL"
  }
  ```
  """
  def market_cap(symbol) do
    case get("#{@api_v3}/market-capitalization/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical market capitalization from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `limit` - The number of results to return.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-27",
      marketCap: 2968932181240,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def market_cap_historical(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-market-capitalization/#{symbol}", params)

  @doc """
  Fetches a company's peers from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    peersList: ["LPL", "SNEJF", "PCRFY", "SONO", "VZIO", "MICS", "WLDSW", "KOSS", "GPRO", "SONY"],
    symbol: "AAPL"
  }
  ```
  """
  def peers(symbol) do
    case get("#{@api_v4}/stock_peers", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's SIC information using CIK from the FMP API.

  ## Inputs

  * `cik` - The CIK of the company.

  ## Response

  ```elixir
  %{
    businessAdress: "['ONE APPLE PARK WAY', 'CUPERTINO CA 95014']",
    cik: "0000320193",
    industryTitle: "ELECTRONIC COMPUTERS",
    name: "Apple Inc. ",
    phoneNumber: "(408) 996-1010",
    sicCode: "3571",
    symbol: "AAPL"
  }
  ```
  """
  def sic_by_cik(cik) do
    cik = String.pad_leading(cik, 10, "0")

    case get("#{@api_v4}/standard_industrial_classification", %{cik: cik}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's SIC information using symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    businessAdress: "['ONE APPLE PARK WAY', 'CUPERTINO CA 95014']",
    cik: "0000320193",
    industryTitle: "ELECTRONIC COMPUTERS",
    name: "Apple Inc. ",
    phoneNumber: "(408) 996-1010",
    sicCode: "3571",
    symbol: "AAPL"
  }
  ```
  """
  def sic_by_symbol(symbol) do
    case get("#{@api_v4}/standard_industrial_classification", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches SIC information for SIC code from the FMP API.

  ## Inputs

  * `sic_code` - The SIC code to fetch information for.

  ## Response

  ```elixir
  [
    %{
      businessAdress: "['ONE APPLE PARK WAY', 'CUPERTINO CA 95014']",
      cik: "0000320193",
      industryTitle: "ELECTRONIC COMPUTERS",
      name: "Apple Inc. ",
      phoneNumber: "(408) 996-1010",
      sicCode: "3571",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def sic_by_code(sic_code),
    do: get("#{@api_v4}/standard_industrial_classification", %{sicCode: sic_code})

  @doc """
  Fetches all SIC information from the FMP API.

  ## Response

  ```elixir
  [
    %{
      businessAdress: "['5301 STEVENS CREEK BLVD, MS 1A-LC', 'P.O. BOX 58059', 'SANTA CLARA CA 95052-8059', '5301 STEVENS CREEK BLVD', 'SANTA CLARA CA 95051']",
      cik: "0001090872",
      industryTitle: "LABORATORY ANALYTICAL INSTRUMENTS",
      name: "AGILENT TECHNOLOGIES, INC. ",
      phoneNumber: "(408) 345-8886",
      sicCode: "3826",
      symbol: "A"
    },
  ]
  ```
  """
  def sic_all, do: get("#{@api_v4}/standard_industrial_classification/all")

  @doc """
  Fetches a list of SIC codes from the FMP API.

  ## Parameters

  * `industry` - The industry to fetch SIC codes for.
  * `sicCode` - The SIC code to fetch information for.

  ## Response

  ```elixir
  [
    %{
      industryTitle: "AGRICULTURAL PRODUCTION-CROPS",
      office: "Office of Life Sciences",
      sicCode: "100"
    },
  ]
  ```
  """
  def sic_list(params \\ %{}),
    do: get("#{@api_v4}/standard_industrial_classification_list", params)

  @doc """
  Fetches a company's historical chart from the FMP API.

  ## Inputs

  * `interval` - The interval to fetch historical data for.
  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      close: 189.3901,
      date: "2023-06-28 11:07:00",
      high: 189.4,
      low: 189.31,
      open: 189.3278,
      volume: 120772
    },
  ]
  ```
  """
  def chart_historical(interval, symbol),
    do: get("#{@api_v3}/historical-chart/#{interval}/#{symbol}")

  @doc """
  Fetches historical chart with full data for the symbols from the FMP API.

  ## Inputs

  * `symbols` - The symbols of the companies.

  ## Parameters

  * `from` - The start date of the historical data.
  * `to` - The end date of the historical data.
  * `serietype` - The type of series to fetch.

  ## Response

  ```elixir
  %{
    historical: [
      %{
        adjClose: 189.1662,
        change: 1.24,
        changeOverTime: 0.0065779812,
        changePercent: 0.65779812,
        close: 189.1662,
        date: "2023-06-28",
        high: 189.34,
        label: "June 28, 23",
        low: 187.6,
        open: 187.93,
        unadjustedVolume: 14699547,
        volume: 14699547,
        vwap: 188.7
      },
    ],
    symbol: "AAPL"
  }
  ```
  """
  def chart_historical_full(symbols, params \\ %{}),
    do: get("#{@api_v3}/historical-price-full/#{symbols}", params)

  @doc """
  Fetches quotes for an exchange from the FMP API.

  ## Inputs

  * `exchange` - The exchange to fetch quotes for.

  ## Response

  ```elixir
  [
    %{
      avgVolume: 1997690,
      change: -0.86,
      changesPercentage: -0.7348,
      dayHigh: 117.29,
      dayLow: 115.71,
      earningsAnnouncement: "2023-08-14T10:59:00.000+0000",
      eps: 4.54,
      exchange: "NYSE",
      marketCap: 34316783680,
      name: "Agilent Technologies, Inc.",
      open: 116.7,
      pe: 25.59,
      previousClose: 117.04,
      price: 116.18,
      priceAvg200: 138.2818,
      priceAvg50: 125.9518,
      sharesOutstanding: 295376000,
      symbol: "A",
      timestamp: 1687965038,
      volume: 521314,
      yearHigh: 160.26,
      yearLow: 113.02
    },
  ]
  ```
  """
  def quotes(exchange), do: get("#{@api_v3}/quotes/#{exchange}")

  @doc """
  Fetches quotes from the FMP API.

  ## Inputs

  * `symbols` - The symbols of the companies.

  ## Response

  ```elixir
  [
    %{
      avgVolume: 56915709,
      change: 1.1,
      changesPercentage: 0.5849,
      dayHigh: 189.4297,
      dayLow: 187.6,
      earningsAnnouncement: "2023-07-26T20:00:00.000+0000",
      eps: 5.9,
      exchange: "NASDAQ",
      marketCap: 2975240970691,
      name: "Apple Inc.",
      open: 187.93,
      pe: 32.06,
      previousClose: 188.06,
      price: 189.16,
      priceAvg200: 154.0831,
      priceAvg50: 175.1358,
      sharesOutstanding: 15728700416,
      symbol: "AAPL",
      timestamp: 1687965321,
      volume: 16413308,
      yearHigh: 189.4297,
      yearLow: 124.17
    }
  ]
  ```
  """
  def quote(symbols), do: get("#{@api_v3}/quote/#{symbols}")

  @doc """
  Fetches short quotes from the FMP API.

  ## Inputs

  * `symbols` - The symbols of the companies.

  ## Response

  ```elixir
  [
    %{
      price: 189.0957,
      symbol: "AAPL",
      volume: 16451684
    }
  ]
  ```
  """
  def quote_short(symbols), do: get("#{@api_v3}/quote-short/#{symbols}")

  @doc """
  Fetches price changes from the FMP API.

  ## Inputs

  * `symbols` - The symbols of the companies.

  ## Response

  ```elixir
  [
    %{
      "10Y": 1235.38816,
      "1D": 0.561,
      "1M": 7.80083,
      "1Y": 37.59822,
      "3M": 19.95877,
      "3Y": 109.09392,
      "5D": 1.92132,
      "5Y": 307.79515,
      "6M": 50.04364,
      max: 147243.20218,
      symbol: "AAPL",
      ytd: 51.20732
    }
  ]
  ```
  """
  def price_change(symbols), do: get("#{@api_v3}/stock-price-change/#{symbols}")

  @doc """
  Fetches a OTC prices from the FMP API.

  ## Inputs

  * `symbols` - The symbols of the companies.

  ## Response

  ```elixir
  [
    %{
      fmpLast: 189.36,
      high: 189.4297,
      lastSalePrice: 189.36,
      lastUpdated: "2023-06-28T15:18:52.139+0000",
      low: 187.6,
      open: 187.93,
      prevClose: 188.06,
      symbol: "AAPL",
      volume: 16774975
    }
  ]
  ```
  """
  def otc_prices(symbols), do: get("#{@api_v3}/otc/real-time-price/#{symbols}")

  @doc """
  Fetches a FOREX prices from the FMP API.

  ## Response

  ```elixir
  [
    %{
      ask: "1.09128",
      bid: "1.09128",
      changes: -0.0047599999999998754,
      date: "2023-06-28 11:19:27",
      high: "1.09635",
      low: "1.08968",
      open: "1.09604",
      ticker: "EUR/USD"
    },
  ]
  ```
  """
  def forex, do: get("#{@api_v3}/fx")

  @doc """
  Fetches all of the FOREX quotes from the FMP API.

  ## Response

  ```elixir
  [
    %{
      avgVolume: 0,
      change: 0.0046,
      changesPercentage: 1.134,
      dayHigh: 0.41207,
      dayLow: 0.40668,
      earningsAnnouncement: nil,
      eps: nil,
      exchange: "FOREX",
      marketCap: nil,
      name: "AED/AUD",
      open: 0.4067,
      pe: nil,
      previousClose: 0.40654,
      price: 0.41115,
      priceAvg200: 0.4070623,
      priceAvg50: 0.4075293,
      sharesOutstanding: nil,
      symbol: "AEDAUD",
      timestamp: 1687965478,
      volume: 0,
      yearHigh: 0.440948,
      yearLow: 0.380414
    },
  ]
  ```
  """
  def forex_quotes, do: get("#{@api_v3}/quotes/forex")

  @doc """
  Fetches a FOREX exchange rates for a pair from the FMP API.

  ## Inputs

  * `pair` - The pair of currencies.

  ## Response

  ```elixir
  %{
    ask: "1.09170",
    bid: "1.09170",
    changes: -0.0043400000000000105,
    date: "2023-06-28 11:21:36",
    high: "1.09635",
    low: "1.08968",
    open: "1.09604",
    ticker: "EUR/USD"
  }
  ```
  """
  def exchange_rates(pair) do
    case get("#{@api_v3}/fx/#{pair}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's technical indicator from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.
  * `interval` - The interval of the technical indicator.

  ## Parameters

  * `period` - The period of the technical indicator.
  * `type` - The series type of the technical indicator.

  ## Response

  ```elixir
  [
    %{
      close: 189.17,
      date: "2023-06-28 00:00:00",
      high: 189.4297,
      low: 187.6,
      open: 187.93,
      volume: 17210202,
      wma: 186.64963636363635
    },
  ]
  ```
  """
  def technical_indicator(symbol, interval, params \\ %{}),
    do: get("#{@api_v3}/technical_indicator/#{interval}/#{symbol}", params)

  @doc """
  Fetches a company's historical stock splits from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    historical: [
      %{
        date: "2020-08-31",
        denominator: 1,
        label: "August 31, 20",
        numerator: 4
      },
    ],
    symbol: "AAPL"
  }
  ```
  """
  def stock_splits(symbol), do: get("#{@api_v3}/historical-price-full/stock_split/#{symbol}")

  @doc """
  Fetches a company's price targets from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      adjPriceTarget: 195,
      analystCompany: "Needham",
      analystName: "Laura Martin",
      newsBaseURL: "benzinga.com",
      newsPublisher: "Benzinga",
      newsTitle: "Apple's Vision Pro Price Tag, Release Date Find Little Love On The Street: Why One Analyst Says Disney Acquisition More Likely After WWDC",
      newsURL: "https://www.benzinga.com/analyst-ratings/analyst-color/23/06/32739815/apples-vision-pro-price-tag-release-date-find-little-love-on-the-street-why-one-ana",
      priceTarget: 195,
      priceWhenPosted: 178.8299,
      publishedDate: "2023-06-06T11:32:00.000Z",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def price_targets(symbol), do: get("#{@api_v4}/price-target", %{symbol: symbol})

  @doc """
  Fetches a company's price targets consensus from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    symbol: "AAPL",
    targetConsensus: 180.94,
    targetHigh: 250,
    targetLow: 110,
    targetMedian: 180
  }
  ```
  """
  def price_targets_consenus(symbol) do
    case get("#{@api_v4}/price-target-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's price target summary from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    allTime: 101,
    allTimeAvgPriceTarget: 182.41801980198022,
    lastMonth: 5,
    lastMonthAvgPriceTarget: 204.8,
    lastQuarter: 11,
    lastQuarterAvgPriceTarget: 184,
    lastYear: 49,
    lastYearAvgPriceTarget: 176,
    publishers: "['Benzinga', 'TheFly', 'Pulse 2.0', 'TipRanks Contributor', 'MarketWatch', 'Investing', 'StreetInsider', 'Barrons', \"Investor's Business Daily\"]",
    symbol: "AAPL"
  }
  ```
  """
  def price_target_summary(symbol) do
    case get("#{@api_v4}/price-target-summary", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of price targets by an analyst from the FMP API.

  ## Inputs

  * `analyst_name` - The name of the analyst.

  ## Response

  ```elixir
  [
    %{
      adjPriceTarget: 217,
      analystCompany: "Wolfe Research",
      analystName: "Tim Anderson",
      newsBaseURL: "streetinsider.com",
      newsPublisher: "StreetInsider",
      newsTitle: "Biogen (BIIB) PT Lowered to $217 at Wolfe Research",
      newsURL: "http://www.streetinsider.com/Analyst+PT+Change/Biogen+%28BIIB%29+PT+Lowered+to+%24217+at+Wolfe+Research/19558063.html?si_client=tipranks-19558063-b6246f8ead",
      priceTarget: 217,
      priceWhenPosted: 221.53,
      publishedDate: "2022-02-04T00:00:00.000Z",
      symbol: "BIIB"
    },
  ]
  ```
  """
  def price_targets_by_analyst(analyst_name),
    do: get("#{@api_v4}/price-target-analyst-name", %{name: analyst_name})

  @doc """
  Fetches a list of price targets by an analyst company from the FMP API.

  ## Inputs

  * `company` - The name of the analyst company.

  ## Response

  ```elixir
  [
    %{
      adjPriceTarget: 235,
      analystCompany: "Barclays",
      analystName: "Carter Gould",
      newsBaseURL: "thefly.com",
      newsPublisher: "TheFly",
      newsTitle: "Biogen price target lowered to $235 from $244 at Barclays",
      newsURL: "https://thefly.com/permalinks/entry.php/id3453187/BIIB-Biogen-price-target-lowered-to--from--at-Barclays1643975954",
      priceTarget: 235,
      priceWhenPosted: 221.53,
      publishedDate: "2022-02-04T00:00:00.000Z",
      symbol: "BIIB"
    },
  ]
  ```
  """
  def price_targets_by_analyst_company(company),
    do: get("#{@api_v4}/price-target-analyst-company", %{company: company})

  @doc """
  Fetches a company's upgrades and downgrades from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      action: "downgrade",
      gradingCompany: "UBS",
      newGrade: "Neutral",
      newsBaseURL: "benzinga.com",
      newsPublisher: "Benzinga",
      newsTitle: "Why This Apple Analyst Is Downgrading The Stock As It Hits All-Time Highs",
      newsURL: "https://www.benzinga.com/analyst-ratings/analyst-color/23/06/32835979/why-this-apple-analyst-is-downgrading-the-stock-as-it-hits-all-time-highs",
      previousGrade: "Buy",
      priceWhenPosted: 183.06,
      publishedDate: "2023-06-13T10:06:00.000Z",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def upgrades_and_downgrades(symbol),
    do: get("#{@api_v4}/upgrades-downgrades", %{symbol: symbol})

  @doc """
  Fetches a company's upgrades and downgrades consensus from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    buy: 26,
    consensus: "Buy",
    hold: 7,
    sell: 1,
    strongBuy: 0,
    strongSell: 0,
    symbol: "AAPL"
  }
  ```
  """
  def upgrades_and_downgrades_consenus(symbol) do
    case get("#{@api_v4}/upgrades-downgrades-consensus", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of upgrades and downgrades by an analyst company from the FMP API.

  ## Inputs

  * `company` - The name of the analyst company.

  ## Response

  ```elixir
  [
    %{
      action: "hold",
      gradingCompany: "Barclays",
      newGrade: "Equal-Weight",
      newsBaseURL: "benzinga.com",
      newsPublisher: "Benzinga",
      newsTitle: "Barclays Maintains Equal-Weight on Altice USA, Lowers Price Target to $17",
      newsURL: "https://www.benzinga.com/news/22/02/25712046/barclays-maintains-equal-weight-on-altice-usa-lowers-price-target-to-17",
      previousGrade: "Equal-Weight",
      priceWhenPosted: 11.52,
      publishedDate: "2022-02-18T08:14:00.000Z",
      symbol: "ATUS"
    },
  ]
  ```
  """
  def upgrades_and_downgrades_by_company(company),
    do: get("#{@api_v4}/upgrades-downgrades-grading-company", %{company: company})

  @doc """
  Fetches a company's rating from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    date: "2023-06-27",
    rating: "S",
    ratingDetailsDCFRecommendation: "Strong Buy",
    ratingDetailsDCFScore: 5,
    ratingDetailsDERecommendation: "Strong Buy",
    ratingDetailsDEScore: 5,
    ratingDetailsPBRecommendation: "Strong Buy",
    ratingDetailsPBScore: 5,
    ratingDetailsPERecommendation: "Strong Buy",
    ratingDetailsPEScore: 5,
    ratingDetailsROARecommendation: "Neutral",
    ratingDetailsROAScore: 3,
    ratingDetailsROERecommendation: "Strong Buy",
    ratingDetailsROEScore: 5,
    ratingRecommendation: "Strong Buy",
    ratingScore: 5,
    symbol: "AAPL"
  }
  ```
  """
  def rating(symbol) do
    case get("#{@api_v3}/rating/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a company's historical rating from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `limit` - The number of results to return.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-27",
      rating: "S",
      ratingDetailsDCFRecommendation: "Strong Buy",
      ratingDetailsDCFScore: 5,
      ratingDetailsDERecommendation: "Strong Buy",
      ratingDetailsDEScore: 5,
      ratingDetailsPBRecommendation: "Strong Buy",
      ratingDetailsPBScore: 5,
      ratingDetailsPERecommendation: "Strong Buy",
      ratingDetailsPEScore: 5,
      ratingDetailsROARecommendation: "Neutral",
      ratingDetailsROAScore: 3,
      ratingDetailsROERecommendation: "Strong Buy",
      ratingDetailsROEScore: 5,
      ratingRecommendation: "Strong Buy",
      ratingScore: 5,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def rating_historical(symbol, params \\ %{}),
    do: get("#{@api_v3}/historical-rating/#{symbol}", params)

  @doc """
  Fetches a company's social sentiment from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.
  * `page` - The page of the results to fetch.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-28 16:00:00",
      stocktwitsComments: 9,
      stocktwitsImpressions: 735299,
      stocktwitsLikes: 48,
      stocktwitsPosts: 110,
      stocktwitsSentiment: 0.5574,
      symbol: "AAPL",
      twitterComments: 0,
      twitterImpressions: 0,
      twitterLikes: 0,
      twitterPosts: 0,
      twitterSentiment: 0
    },
  ]
  ```
  """
  def social_sentiment(symbol, page \\ 0),
    do: get("#{@api_v4}/historical/social-sentiment", %{symbol: symbol, page: page})

  @doc """
  Fetches a company's stock grade from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Paramaters

  * `limit` - The number of results to return.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-23",
      gradingCompany: "Tigress Financial",
      newGrade: "Strong Buy",
      previousGrade: "Strong Buy",
      symbol: "AAPL"
    },
  ]
  ```
  """
  def stock_grade(symbol, params \\ %{}),
    do: get("#{@api_v4}/grade", Map.merge(%{symbol: symbol}, params))

  @doc """
  Fetches a company's earnings surprises from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      actualEarningResult: 1.52,
      date: "2023-05-04",
      estimatedEarning: 1.43,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def earnings_surprises(symbol),
    do: get("#{@api_v3}/earnings-surprises/#{symbol}")

  @doc """
  Fetches a company's analyst estimates from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `limit` - The number of results to return.
  * `period` - The period of the analyst estimates.

  ## Response

  ```elixir
  [
    %{
      date: "2024-12-30",
      estimatedEbitAvg: 122695743672.57257,
      estimatedEbitHigh: 147234892407.08707,
      estimatedEbitLow: 98156594938.05806,
      estimatedEbitdaAvg: 134268627163.48918,
      estimatedEbitdaHigh: 161122352596.187,
      estimatedEbitdaLow: 107414901730.79135,
      estimatedEpsAvg: 6.261209481744006,
      estimatedEpsHigh: 7.513451378092808,
      estimatedEpsLow: 5.0089675853952045,
      estimatedNetIncomeAvg: 102921415056.97354,
      estimatedNetIncomeHigh: 123505698068.36824,
      estimatedNetIncomeLow: 82337132045.57883,
      estimatedRevenueAvg: 367041614877.70483,
      estimatedRevenueHigh: 440449937853.78265,
      estimatedRevenueLow: 293633291901.6271,
      estimatedSgaExpenseAvg: 25607172516.092632,
      estimatedSgaExpenseHigh: 30728607019.311157,
      estimatedSgaExpenseLow: 20485738012.874107,
      numberAnalystEstimatedRevenue: 10,
      numberAnalystsEstimatedEps: 10,
      symbol: "AAPL"
    },
  ]
  ```
  """
  def analyst_estimates(symbol, params \\ %{}),
    do: get("#{@api_v3}/analyst-estimates/#{symbol}", params)

  @doc """
  Fetches a list of a company's earnings call transcripts from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    [2, 2023, "2023-05-04 21:35:32"],
  ]
  ```
  """
  def earnings_call_transcript(symbol),
    do: get("#{@api_v4}/earning_call_transcript", %{symbol: symbol})

  @doc """
  Fetches the earnings call transcripts for a company for a given year.

  ## Inputs

  * `symbol` - The symbol of the company.
  * `year` - The year of the earnings call transcript.

  ## Response

  ```elixir
  [
    %{
      content: "",
      date: "2020-10-29 23:40:53",
      quarter: 4,
      symbol: "AAPL",
      year: 2020
    },
  ]
  ```
  """
  def earnings_call_transcript(symbol, year),
    do: get("#{@api_v4}/batch_earning_call_transcript/#{symbol}", %{year: year})

  @doc """
  Fetches the earnings call transcripts for a company for a given year and quarter.

  ## Inputs

  * `symbol` - The symbol of the company.
  * `year` - The year of the earnings call transcript.
  * `quarter` - The quarter of the earnings call transcript.

  ## Response

  ```elixir
  %{
    content: "",
    date: "2020-01-28 21:35:41",
    quarter: 1,
    symbol: "AAPL",
    year: 2020
  }
  ```
  """
  def earnings_call_transcript(symbol, year, quarter) do
    case get("#{@api_v3}/earning_call_transcript/#{symbol}", %{year: year, quarter: quarter}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches a list of company's notes from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      cik: "0000320193",
      exchange: "NASDAQ",
      symbol: "AAPL",
      title: "1.000% Notes due 2022"
    },
  ]
  ```
  """
  def company_notes(symbol), do: get("#{@api_v4}/company-notes", %{symbol: symbol})

  @doc """
  Fetches a company's ESG score from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      ESGScore: 54.43,
      acceptedDate: "2023-02-02 18:01:30",
      cik: "0000320193",
      companyName: "Apple Inc.",
      date: "2022-12-31",
      environmentalScore: 50,
      formType: "10-Q",
      governanceScore: 63.3,
      socialScore: 50,
      symbol: "AAPL",
      url: "https://www.sec.gov/Archives/edgar/data/320193/000032019323000006/0000320193-23-000006-index.htm"
    },
  ]
  ```
  """
  def esg_scores(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data", %{symbol: symbol})

  @doc """
  Fetches a company's ESG risk rating from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      ESGRiskRating: "B",
      cik: "0000320193",
      companyName: "Apple Inc.",
      industry: "ELECTRONIC COMPUTERS",
      industryRank: "7 out of 7",
      symbol: "AAPL",
      year: 2022
    },
  ]
  ```
  """
  def esg_risk_ratings(symbol),
    do: get("#{@api_v4}/esg-environmental-social-governance-data-ratings", %{symbol: symbol})

  @doc """
  Fetches a sector ESG score benchmarks from the FMP API.

  ## Inputs

  * `year` - The year of the ESG score benchmarks.

  ## Response

  ```elixir
  [
    %{
      ESGScore: 63.73,
      environmentalScore: 61.77,
      governanceScore: 63.29,
      sector: "FLAT GLASS",
      socialScore: 66.14,
      year: 2020
    },
  ]
  ```
  """
  def esg_sector_benchmarks(year),
    do: get("#{@api_v4}/esg-environmental-social-governance-sector-benchmark", %{year: year})

  @doc """
  Fetches a company's mutual fund holders from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      change: -315010,
      dateReported: "2022-09-30",
      holder: "LGT Fund Management Co Ltd.",
      shares: 33000,
      weightPercent: nil
    },
  ]
  ```
  """
  def mutual_fund_holders(symbol), do: get("#{@api_v3}/mutual-fund-holder/#{symbol}")

  @doc """
  Fetches a company's institutional holders from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      change: -21614,
      dateReported: "2022-12-31",
      holder: "VICUS CAPITAL",
      shares: 79461
    },
  ]
  ```
  """
  def institutional_holders(symbol), do: get("#{@api_v3}/institutional-holder/#{symbol}")

  @doc """
  Fetches form 13F for a given CIK from the FMP API.

  ## Inputs

  * `cik` - The CIK of the company.
  * `date` - The date of the form 13F.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2020-08-14",
      cik: "0001067983",
      cusip: "922908363",
      date: "2020-06-30",
      fillingDate: "2020-08-14",
      finalLink: "https://www.sec.gov/Archives/edgar/data/1067983/000095012320009058/960.xml",
      link: "https://www.sec.gov/Archives/edgar/data/1067983/000095012320009058/0000950123-20-009058-index.htm",
      nameOfIssuer: "VANGUARD INDEX FDS",
      shares: 43000,
      tickercusip: "VOO",
      titleOfClass: "S&P 500 ETF SHS",
      value: 12187000
    },
  ]
  ```
  """
  def form_13f(cik, date) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v3}/form-thirteen/#{cik}", %{date: date})
  end

  @doc """
  Fetches form 13F filing dates for a given CIK from the FMP API.

  ## Inputs

  * `cik` - The CIK of the company.

  ## Response

  ```elixir
  ["2023-03-31", "2022-12-31"]
  ```
  """
  def form_13f_filing_dates(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v3}/form-thirteen-date/#{cik}")
  end

  @doc """
  Fetches form 13F allocation dates from the FMP API.

  ## Response

  ```elixir
  [
    %{date: "2023-03-31"},
    %{date: "2022-12-31"},
  ]
  ```
  """
  def form_13f_asset_allocation_dates, do: get("#{@api_v4}/13f-asset-allocation-date")

  @doc """
  Fetches form 13F asset allocations for a given date from the FMP API.

  ## Inputs

  * `date` - The date of the form 13F asset allocation.

  ## Response

  ```elixir
  [
    %{date: "2023-03-31"},
    %{date: "2022-12-31"},
  ]
  ```
  """
  def form_13f_asset_allocations(date),
    do: get("#{@api_v4}/13f-asset-allocation-date", %{date: date})

  @doc """
  Fetches a company's institutional ownership from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2021-02-16 16:02:01",
      amountBeneficiallyOwned: "907559761",
      cik: "0000320193",
      citizenshipOrPlaceOfOrganization: "United States Citizen",
      cusip: "037833100",
      filingDate: "2021-02-16",
      nameOfReportingPerson: "Warren E. Buffett",
      percentOfClass: "5.4",
      sharedDispositivePower: "907559761",
      sharedVotingPower: "907559761",
      soleDispositivePower: "0",
      soleVotingPower: "0",
      symbol: "AAPL",
      typeOfReportingPerson: "IN",
      url: "https://www.sec.gov/Archives/edgar/data/320193/000119312521044816/0001193125-21-044816-index.htm"
    },
  ]
  ```
  """
  def insider_ownership_acquisition(symbol),
    do: get("#{@api_v4}/insider/ownership/acquisition_of_beneficial_ownership", %{symbol: symbol})

  @doc """
  Fetches a company's institutional ownership from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      lastTotalCalls: 3320086544859336,
      lastReducedPositions: 2254,
      numberOf13FsharesChange: -227741294,
      investorsHolding: 4319,
      totalCallsChange: -3280478123192336,
      reducedPositionsChange: -6,
      ownershipPercentChange: -0.1001,
      totalInvested: 9223372036854776000,
      totalCalls: 39608421667000,
      closedPositionsChange: 1,
      putCallRatioChange: 167.5535,
      totalPuts: 6637269860174000,
      lastTotalPuts: 61966623290859,
      totalPutsChange: 6575303236883141,
      totalInvestedChange: 9223372036854776000,
      cik: "0000320193",
      reducedPositions: 2248,
      lastNewPositions: 348,
      symbol: "AAPL",
      lastOwnershipPercent: 57.2198,
      putCallRatio: 167.5722,
      ownershipPercent: 57.1197,
      lastPutCallRatio: 0.0187,
      lastIncreasedPositions: 1545,
      lastClosedPositions: 95,
      increasedPositionsChange: 120,
      lastNumberOf13Fshares: 9341603167,
      closedPositions: 96,
      newPositionsChange: -212,
      date: "2023-03-31",
      increasedPositions: 1665,
      numberOf13Fshares: 9113861873,
      investorsHoldingChange: -66,
      newPositions: 136,
      lastInvestorsHolding: 4385,
      lastTotalInvested: 2226503513796631
    },
  ]
  ```
  """
  def institutional_ownership(symbol),
    do: get("#{@api_v4}/institutional-ownership/symbol-ownership", %{symbol: symbol})

  @doc """
  Fetches a company's institutional ownership percentage from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `date` - The date of the institutional ownership percentage.
  * `page` - The page number of the results.

  ## Response

  ```elixir
  [
    %{
      date: "2021-09-30",
      cik: "0000102909",
      filingDate: "2021-11-12",
      investorName: "VANGUARD GROUP INC",
      symbol: "AAPL",
      securityName: "APPLE INC",
      typeOfSecurity: "COM",
      securityCusip: "037833100",
      sharesType: "SH",
      putCallShare: "Share",
      investmentDiscretion: "SOLE",
      industryTitle: "ELECTRONIC COMPUTERS",
      weight: 4.4505,
      lastWeight: 4.3113,
      changeInWeight: 0.1392,
      changeInWeightPercentage: 3.2279,
      marketValue: 179186073000,
      lastMarketValue: 173245709000,
      changeInMarketValue: 5940364000,
      changeInMarketValuePercentage: 3.4289,
      sharesNumber: 1266332667,
      lastSharesNumber: 1264936543,
      changeInSharesNumber: 1396124,
      changeInSharesNumberPercentage: 0.1104,
      quarterEndPrice: 141.2945214521,
      avgPricePaid: 136.5555426888,
      isNew: false,
      isSoldOut: false,
      ownership: 7.5087,
      lastOwnership: 7.5376,
      changeInOwnership: -0.0289,
      changeInOwnershipPercentage: -0.3834,
      holdingPeriod: 32,
      firstAdded: "2013-12-31",
      performance: 5994507414.1991,
      performancePercentage: 3.4704,
      lastPerformance: 18555654047.2223,
      changeInPerformance: -12561146633.0232,
      isCountedForPerformance: true
    }
  ]
  ```
  """
  def institutional_ownership_percentage(symbol, params \\ %{}),
    do:
      get(
        "#{@api_v4}/institutional-ownership/institutional-holders/symbol-ownership-percent",
        Map.merge(%{symbol: symbol}, params)
      )

  @doc """
  Fetches a company's institutional ownership by shares held from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `date` - The date of the institutional ownership percentage.
  * `page` - The page number of the results.

  ## Response

  ```elixir
  [
    %{
      date: "2021-09-30",
      cik: "0001308668",
      filingDate: "2021-10-26",
      investorName: "GUIDESTONE CAPITAL MANAGEMENT, LLC",
      symbol: "AAPL",
      securityName: "APPLE INC",
      typeOfSecurity: "COM",
      securityCusip: "037833100",
      sharesType: "SH",
      putCallShare: "Share",
      investmentDiscretion: "SOLE",
      industryTitle: "ELECTRONIC COMPUTERS",
      weight: 100,
      lastWeight: 100,
      changeInWeight: 0,
      changeInWeightPercentage: 0,
      marketValue: 83304000,
      lastMarketValue: 80631000,
      changeInMarketValue: 2673000,
      changeInMarketValuePercentage: 3.3151,
      sharesNumber: 588722,
      lastSharesNumber: 588722,
      changeInSharesNumber: 0,
      changeInSharesNumberPercentage: 0,
      quarterEndPrice: 141.2945214521,
      avgPricePaid: 136.5555426888,
      isNew: false,
      isSoldOut: false,
      ownership: 0.0035,
      lastOwnership: 0.0035,
      changeInOwnership: 0,
      changeInOwnershipPercentage: -0.4932,
      holdingPeriod: 8,
      firstAdded: "2019-12-31",
      performance: 2789941.0555,
      performancePercentage: 3.4704,
      lastPerformance: 8814163.2552,
      changeInPerformance: -6024222.1997,
      isCountedForPerformance: true
    }
  ]
  ```
  """
  def institutional_ownership_by_shares_held(symbol, params \\ %{}),
    do:
      get(
        "#{@api_v4}/institutional-ownership/institutional-holders/symbol-ownership",
        Map.merge(%{symbol: symbol}, params)
      )

  @doc """
  Fetches a institution's portfolio holdings from the FMP API.

  ## Inputs

  * `cik` - The CIK of the institution.

  ## Parameters

  * `date` - The date of the portfolio holdings.
  * `page` - The page number of the results.

  ## Response

  ```elixir
  [
    %{
      date: "2021-09-30",
      cik: "0001067983",
      filingDate: "2021-11-15",
      symbol: "AAPL",
      securityName: "APPLE INC",
      typeOfSecurity: "COM",
      securityCusip: "037833100",
      sharesType: "SH",
      putCallShare: "Share",
      investmentDiscretion: "DFND",
      weight: 42.7776,
      lastWeight: 41.465,
      changeInWeight: 1.3126,
      changeInWeightPercentage: 3.1656,
      sharesNumber: 887135554,
      lastSharesNumber: 887135554,
      changeInSharesNumber: 0,
      changeInSharesNumberPercentage: 0,
      isNew: false,
      firstAdded: "2016-03-31",
      quarterEndPrice: 141.5,
      avgPricePaid: 37.32,
      isSoldOut: false,
      ownership: 5.3808,
      lastOwnership: 5.3348,
      changeInOwnership: 0.046,
      changeInOwnershipPercentage: 0.8628,
      holdingPeriod: 23,
      isCountedForPerformance: true,
      marketValue: 125529681000,
      lastMarketValue: 121502087000,
      changeInMarketValue: 4027594000,
      changeInMarketValuePercentage: 3.3148,
      performance: 4027595415,
      lastPerformance: 13138477554,
      changeInPerformance: -9110882138,
      performancePercentage: 3.3148,
      updatedAt: "2023-06-28T03:38:37.327Z",
      investorName: "BERKSHIRE HATHAWAY INC",
      industryTitle: "ELECTRONIC COMPUTERS"
    }
  ]
  ```
  """
  def institution_portfolio_holdings(cik, params \\ %{}),
    do:
      get("#{@api_v4}/institutional-ownership/portfolio-holdings", Map.merge(%{cik: cik}, params))

  @doc """
  Fetches a institution's portfolio summary from the FMP API.

  ## Inputs

  * `cik` - The CIK of the institution.

  ## Response

  ```elixir
  [
    %{
      turnover: 0.1458,
      turnoverAlternateSell: 0.0028,
      portfolioSize: 48,
      performance1yearRelativeToSP500Percentage: -15.8331,
      performanceSinceInception: 119254395874.8329,
      performancePercentage: 0,
      performance: 0,
      investorName: "BERKSHIRE HATHAWAY INC",
      performancePercentage1year: -25.1281,
      averageHoldingPeriodTop10: 22,
      performance1year: -99654324862.06,
      changeInMarketValue: 324809745069881,
      previousMarketValue: 299007622119,
      performance5yearRelativeToSP500Percentage: 47.42,
      performanceRelativeToSP500Percentage: -7.0272,
      securitiesAdded: 3,
      performance3yearRelativeToSP500Percentage: -39.3917,
      averageHoldingPeriod: 18,
      changeInMarketValuePercentage: 108629.2526,
      averageHoldingPeriodTop20: 24,
      lastPerformance: 12542861514.83,
      cik: "0001067983",
      performance5year: 81337437961.4915,
      performanceSinceInceptionRelativeToSP500Percentage: 24.6331,
      securitiesRemoved: 4,
      performancePercentage5year: 47.42,
      changeInPerformance: -12542861514.83,
      performance3year: 37334377500.4895,
      date: "2023-03-31",
      performanceSinceInceptionPercentage: 146.9551,
      marketValue: 325108752692000,
      turnoverAlternateBuy: 0.308,
      performancePercentage3year: 19.601
    },
  ]
  ```
  """
  def institution_portfolio_summary(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/institutional-ownership/portfolio-holdings-summary", %{cik: cik})
  end

  @doc """
  Fetches a institution's portfolio dates from the FMP API.

  ## Inputs

  * `cik` - The CIK of the institution.

  ## Response

  ```elixir
  [
    %{date: "2023-03-31"},
    %{date: "2022-12-31"},
  ]
  ```
  """
  def institution_portfolio_dates(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/institutional-ownership/portfolio-date", %{cik: cik})
  end

  @doc """
  Fetches a institution's portfolio industry summary from the FMP API.

  ## Inputs

  * `cik` - The CIK of the institution.
  * `date` - The date of the portfolio holdings.

  ## Parameters

  * `page` - The page number of the results.

  ## Response

  ```elixir
  [
    %{
      changeInPerformance: -9110882139,
      changeInWeight: 1.3126,
      changeInWeightPercentage: 3.1656,
      cik: "0001067983",
      date: "2021-09-30",
      industryTitle: "ELECTRONIC COMPUTERS",
      investorName: "BERKSHIRE HATHAWAY INC",
      lastPerformance: 13138477554,
      lastWeight: 41.465,
      performance: 4027595415,
      performancePercentage: -69.345,
      weight: 42.7776
    },
  ]
  ```
  """
  def institution_industry_summary(cik, date, params \\ %{}) do
    cik = String.pad_leading(cik, 10, "0")

    get(
      "#{@api_v4}/institutional-ownership/industry/portfolio-holdings-summary",
      Map.merge(%{cik: cik, date: date}, params)
    )
  end

  @doc """
  Fetches insider trading transactions from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the stock.
  * `companyCik` - The CIK of the company.
  * `reportingCik` - The CIK of the reporting institution.
  * `transactionType` - The type of transaction.
  * `page` - The page number of the results.

  ## Response

  ```elixir
  [
    %{
      acquistionOrDisposition: "D",
      companyCik: "0000320193",
      filingDate: "2023-05-18 18:32:21",
      formType: "4",
      link: "https://www.sec.gov/Archives/edgar/data/320193/000032019323000070/0000320193-23-000070-index.htm",
      price: 0,
      reportingCik: "0001051401",
      reportingName: "JUNG ANDREA",
      securitiesOwned: 0,
      securitiesTransacted: 68642,
      securityName: "Common Stock",
      symbol: "AAPL",
      transactionDate: "2023-05-16",
      transactionType: "G-Gift",
      typeOfOwner: "director"
    },
  ]
  ```
  """
  def insider_trading(params \\ %{}),
    do: get("#{@api_v4}/insider-trading", params)

  @doc """
  Fetches insider trading transactions types from the FMP API.

  ## Response

  ```elixir
  ["A-Award", "C-Conversion", "D-Return"]
  ```
  """
  def insider_trading_transactions_type, do: get("#{@api_v4}/insider-trading-transaction-type")

  @doc """
  Fetches a list of commitment of traders report from the FMP API.

  ## Response

  ```elixir
  [
    %{
      short_name: "Natural Gas (NG)",
      trading_symbol: "NG"
    },
  ]
  ```
  """
  def commitment_of_traders_report_list, do: get("#{@api_v4}/commitment_of_traders_report/list")

  @doc """
  Fetches a commitment of traders report from and to a date from the FMP API.

  ## Inputs

  * `from` - The from date.
  * `to` - The to date.

  ## Response

  ```elixir
  [
    %{
      comm_positions_short_other: 0,
      comm_positions_short_all: 32931,
      change_in_noncomm_spead_all: -388,
      traders_tot_rept_short_other: 0,
      conc_gross_le_4_tdr_short_other: 0,
      pct_of_oi_tot_rept_short_ol: 86.4,
      conc_net_le_4_tdr_short_ol: 52,
      noncomm_positions_spread_other: 0,
      pct_of_oi_tot_rept_short_all: 86.4,
      traders_tot_rept_long_ol: 54,
      conc_gross_le_4_tdr_short_all: 52,
      traders_noncomm_spread_other: 0,
      traders_noncomm_spread_all: 8,
      comm_positions_long_old: 39709,
      traders_noncomm_long_other: 0,
      traders_tot_rept_long_all: 54,
      pct_of_oi_tot_rept_long_all: 79.4,
      traders_tot_rept_short_ol: 50,
      change_in_open_interest_all: 294,
      tot_rept_positions_long_all: 65018,
      tot_rept_positions_short_all: 70703,
      noncomm_positions_spread_old: 1481,
      traders_comm_short_other: 0,
      pct_of_oi_tot_rept_long_other: 0,
      conc_net_le_8_tdr_short_all: 62.6,
      traders_noncomm_spead_ol: 8,
      traders_tot_rept_short_all: 50,
      change_in_tot_rept_short_all: 2458,
      market_and_exchange_names: "DOW JONES INDUSTRIAL AVG- x $5 - CHICAGO BOARD OF TRADE",
      conc_net_le_4_tdr_long_other: 0,
      pct_of_oi_tot_rept_short_other: 0,
      pct_of_oi_comm_long_all: 48.5,
      pct_of_oi_noncomm_long_ol: 29.1,
      traders_noncomm_short_other: 0,
      noncomm_positions_short_old: 36291,
      conc_gross_le_8_tdr_short_other: 0,
      tot_rept_positions_short_other: 0,
      traders_noncomm_long_ol: 27,
      traders_tot_ol: 91,
      pct_of_oi_noncomm_short_ol: 44.3,
      pct_of_oi_noncomm_short_all: 44.3,
      conc_net_le_4_tdr_short_other: 0,
      cftc_contract_market_code: "124603",
      noncomm_positions_long_other: 0,
      change_in_nonrept_long_all: 1270,
      pct_of_oi_noncomm_spread_other: 0,
      cftc_region_code: "0",
      pct_of_oi_tot_rept_long_ol: 79.4,
      conc_gross_le_8_tdr_long_other: 0,
      ...
    },
  ]
  ```
  """
  def commitment_of_traders_report(from, to),
    do: get("#{@api_v4}/commitment_of_traders_report", %{from: from, to: to})

  @doc """
  Fetches a commitment of traders report from a symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol.

  ## Response

  ```elixir
  [
    %{
      comm_positions_short_other: 0,
      comm_positions_short_all: 1468089,
      change_in_noncomm_spead_all: -114713,
      traders_tot_rept_short_other: 0,
      conc_gross_le_4_tdr_short_other: 0,
      pct_of_oi_tot_rept_short_ol: 88.6,
      conc_net_le_4_tdr_short_ol: 23.1,
      noncomm_positions_spread_other: 0,
      pct_of_oi_tot_rept_short_all: 88.6,
      traders_tot_rept_long_ol: 349,
      conc_gross_le_4_tdr_short_all: 24.1,
      traders_noncomm_spread_other: 0,
      traders_noncomm_spread_all: 40,
      comm_positions_long_old: 1716868,
      traders_noncomm_long_other: 0,
      traders_tot_rept_long_all: 349,
      pct_of_oi_tot_rept_long_all: 89.1,
      traders_tot_rept_short_ol: 354,
      change_in_open_interest_all: -683653,
      tot_rept_positions_long_all: 1980661,
      tot_rept_positions_short_all: 1971213,
      noncomm_positions_spread_old: 53563,
      traders_comm_short_other: 0,
      pct_of_oi_tot_rept_long_other: 0,
      conc_net_le_8_tdr_short_all: 31.9,
      traders_noncomm_spead_ol: 40,
      traders_tot_rept_short_all: 354,
      change_in_tot_rept_short_all: -628581,
      market_and_exchange_names: "E-MINI S&P 500 - CHICAGO MERCANTILE EXCHANGE",
      conc_net_le_4_tdr_long_other: 0,
      pct_of_oi_tot_rept_short_other: 0,
      pct_of_oi_comm_long_all: 77.2,
      pct_of_oi_noncomm_long_ol: 9.5,
      traders_noncomm_short_other: 0,
      noncomm_positions_short_old: 449561,
      conc_gross_le_8_tdr_short_other: 0,
      tot_rept_positions_short_other: 0,
      traders_noncomm_long_ol: 72,
      traders_tot_ol: 524,
      pct_of_oi_noncomm_short_ol: 20.2,
      pct_of_oi_noncomm_short_all: 20.2,
      conc_net_le_4_tdr_short_other: 0,
      cftc_contract_market_code: "13874A",
      noncomm_positions_long_other: 0,
      change_in_nonrept_long_all: -87889,
      pct_of_oi_noncomm_spread_other: 0,
      cftc_region_code: "0",
      pct_of_oi_tot_rept_long_ol: 89.1,
      conc_gross_le_8_tdr_long_other: 0,
      ...
    },
  ]
  ```
  """
  def commitment_of_traders_report(symbol),
    do: get("#{@api_v4}/commitment_of_traders_report/#{symbol}")

  @doc """
  Fetches a commitment of traders report analysis from and to a date from the FMP API.

  ## Inputs

  * `from` - The from date.
  * `to` - The to date.

  ## Response

  ```elixir
  [
    %{
      changeInNetPosition: -0.62,
      currentLongMarketSituation: 64.95,
      currentShortMarketSituation: 35.05,
      date: "2020-12-29 00:00:00",
      exchange: "RANDOM LENGTH LUMBER - CHICAGO MERCANTILE EXCHANGE",
      marketSentiment: "Increasing Bearish",
      marketSituation: "Bullish",
      name: "Lumber (LS)",
      netPostion: 319,
      previousLongMarketSituation: 64.68,
      previousMarketSituation: "Bullish",
      previousNetPosition: 321,
      previousShortMarketSituation: 35.32,
      reversalTrend: false,
      sector: "SOFTS",
      symbol: "LS"
    },
  ]
  ```
  """
  def commitment_of_traders_report_analysis(from, to),
    do: get("#{@api_v4}/commitment_of_traders_report_analysis", %{from: from, to: to})

  @doc """
  Fetches a commitment of traders report analysis from a symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol.

  ## Response

  ```elixir
  [
    %{
      changeInNetPosition: 27.78,
      currentLongMarketSituation: 31.86,
      currentShortMarketSituation: 68.14,
      date: "2023-06-20 00:00:00",
      exchange: "E-MINI S&P 500 - CHICAGO MERCANTILE EXCHANGE",
      marketSentiment: "Increasing Bullish",
      marketSituation: "Bearish",
      name: "S&P 500 E-Mini (ES)",
      netPostion: -239331,
      previousLongMarketSituation: 30.46,
      previousMarketSituation: "Bearish",
      previousNetPosition: -331413,
      previousShortMarketSituation: 69.54,
      reversalTrend: true,
      sector: "INDICES",
      symbol: "ES"
    },
  ]
  ```
  """
  def commitment_of_traders_report_analysis(symbol),
    do: get("#{@api_v4}/commitment_of_traders_report_analysis/#{symbol}")

  @doc """
  Fetches a list of senate trading for a symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      amount: "$15,001 - $50,000",
      assetDescription: "Apple Inc. - Common Stock",
      assetType: "Stock",
      comment: "--",
      dateRecieved: "2023-04-03",
      firstName: "Thomas",
      lastName: "R. Carper",
      link: "https://efdsearch.senate.gov/search/view/ptr/83caeb49-28d0-4805-8599-c6d92c3afdd7/",
      office: "Carper, Thomas R. (Senator)",
      owner: "Spouse",
      symbol: "AAPL",
      transactionDate: "2023-03-07",
      type: "Sale (Partial)"
    },
  ]
  ```
  """
  def senate_trading(symbol), do: get("#{@api_v4}/senate-trading", %{symbol: symbol})

  @doc """
  Fetches a list of senate disclosures for a symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  [
    %{
      amount: "$1,001 - $15,000",
      assetDescription: "Apple Inc.",
      capitalGainsOver200USD: "False",
      disclosureDate: "2023-06-11",
      disclosureYear: "2023",
      district: "NJ05",
      link: "https://disclosures-clerk.house.gov/public_disc/ptr-pdfs/2023/20023087.pdf",
      owner: "joint",
      representative: "Josh Gottheimer",
      ticker: "AAPL",
      transactionDate: "2023-05-16",
      type: "purchase"
    },
  ]
  ```
  """
  def senate_disclosures(symbol), do: get("#{@api_v4}/senate-disclosure", %{symbol: symbol})

  @doc """
  Fetches ciks by name from the FMP API.

  ## Parameters

  * `name` - The name of the company.
  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      reportingCik: "0001709188",
      reportingName: "1003652 Canada Inc."
    },
  ]
  ```
  """
  def cik_mapper_name(params \\ %{}),
    do: get("#{@api_v4}/mapper-cik-name", params)

  @doc """
  Fetches ciks by symbol from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Response

  ```elixir
  %{
    companyCik: "0000012927",
    symbol: "BA"
  }
  ```
  """
  def cik_mapper_company(symbol) do
    case get("#{@api_v4}/mapper-cik-company/#{symbol}") do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the symbols of all companies from the FMP API.

  ## Response

  ```elixir
  [
    %{
      exchange: "New York Stock Exchange",
      exchangeShortName: "NYSE",
      name: "Scorpio Tankers Inc.",
      price: 43.11,
      symbol: "STNG",
      type: "stock"
    },
  ]
  ```
  """
  def symbols, do: get("#{@api_v3}/stock/list")

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.

  ## Response

  ```elixir
  [
    %{
      exchange: "New York Stock Exchange",
      exchangeShortName: "NYSE",
      name: "Seadrill Limited",
      price: 38.195,
      symbol: "SDRL",
      type: "stock"
    },
  ]
  ```
  """
  def symbols_exchanges, do: get("#{@api_v3}/available-traded/list")

  @doc """
  Fetches the symbols of all indexes from the FMP API.

  ## Response

  ```elixir
  [
    %{
      currency: "TRY",
      exchangeShortName: "INDEX",
      name: "BIST 100",
      stockExchange: "Istanbul",
      symbol: "XU100.IS"
    },
  ]
  ```
  """
  def symbols_indexes, do: get("#{@api_v3}/symbol/available-indexes")

  @doc """
  Fetches the symbols of all euro next companies from the FMP API.

  ## Response

  ```elixir
  [
    %{
      currency: "EUR",
      exchangeShortName: "EURONEXT",
      name: "Compagnie de l'Odet",
      stockExchange: "Paris",
      symbol: "ODET.PA"
    },
  ]
  ```
  """
  def symbols_euronext, do: get("#{@api_v3}/symbol/available-euronext")

  @doc """
  Fetches the symbols of all TSX companies from the FMP API.

  ## Response

  ```elixir
  [
    %{
      currency: "CAD",
      exchangeShortName: "TSX",
      name: "ShaMaran Petroleum Corp.",
      stockExchange: "TSXV",
      symbol: "SNM.V"
    },
  ]
  ```
  """
  def symbols_tsx, do: get("#{@api_v3}/symbol/available-tsx")

  @doc """
  Fetches the symbols of all crypto currencies from the FMP API.

  ## Response

  ```elixir
  [
    %{
      currency: "USD",
      exchangeShortName: "CRYPTO",
      name: "NFTX",
      stockExchange: "CCC",
      symbol: "NFTXUSD"
    }
  ]
  ```
  """
  def symbols_crypto, do: get("#{@api_v3}/symbol/available-cryptocurrencies")

  @doc """
  Fetches the symbols of all forex currencies from the FMP API.

  ## Response

  ```elixir
  [
    %{
      currency: "EUR",
      exchangeShortName: "FOREX",
      name: "MYR/EUR",
      stockExchange: "CCY",
      symbol: "MYREUR"
    },
  ]
  ```
  """
  def symbols_forex, do: get("#{@api_v3}/symbol/available-forex-currency-pairs")

  @doc """
  Fetches the symbols of all commodities from the FMP API.

  ## Response

  ```elixir
  [
    %{
      currency: "USX",
      exchangeShortName: "COMMODITY",
      name: "Oat Futures",
      stockExchange: "CBOT",
      symbol: "OUSX"
    },
  ]
  ```
  """
  def symbols_commodities, do: get("#{@api_v3}/symbol/available-commodities")

  @doc """
  Fetches the symbol changes from the FMP API.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-26",
      name: "Kartoon Studios, Inc. Common Stock",
      newSymbol: "TOON",
      oldSymbol: "GNUS"
    },
  ]
  ```
  """
  def symbol_changes, do: get("#{@api_v4}/symbol_change")

  @doc """
  Fetches mutual funds by name from the FMP API.

  ## Inputs

  * `name` - The name of the mutual fund.

  ## Response

  ```elixir
  [
    %{
      cik: "0001072962",
      symbol: "WRVBX",
      classId: "C000073823",
      seriesId: "S000024814",
      entityName: "WADDELL & REED ADVISORS FUNDS",
      entityOrgType: "30",
      seriesName: "Waddell & Reed Advisors Vanguard Fund",
      className: "Class B",
      reportingFileNumber: "811-09435",
      address1: "6300 LAMAR AVE",
      city: "OVERLAND PARK",
      zipCode: "66202",
      state: "KS",
      address2: "NULL"
    }
  ]
  ```
  """
  def mutual_fund(name), do: get("#{@api_v4}/mutual-fund-holdings/name", %{name: name})

  @doc """
  Fetches mutual funds holdings from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the mutual fund.
  * `cik` - The CIK of the mutual fund.
  * `date` - The date of the mutual fund.

  ## Response

  ```elixir
  [
    %{
      cik: "0000036405",
      acceptanceTime: "2022-03-01 15:10:05",
      date: "2021-12-31",
      symbol: "DLR",
      name: "Digital Realty Trust Inc",
      lei: "549300HKCZ31D08NEI41",
      title: "DIGITAL REALTY",
      cusip: "253868103",
      isin: "US2538681030",
      balance: 2252480,
      units: "NS",
      cur_cd: "USD",
      valUsd: 398396138,
      pctVal: 0.212623765335,
      payoffProfile: "Long",
      assetCat: "EC",
      issuerCat: "CORP",
      invCountry: "US",
      isRestrictedSec: "N",
      fairValLevel: "1",
      isCashCollateral: "N",
      isNonCashCollateral: "N",
      isLoanByFund: "N"
    }
  ]
  ```
  """
  def mutual_fund_portfolio_holdings(params \\ %{}),
    do: get("#{@api_v4}/mutual-fund-holdings", params)

  @doc """
  Fetches mutual funds portfolio dates from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the mutual fund.
  * `cik` - The CIK of the mutual fund.

  ## Response

  ```elixir
  [
    %{date: "2021-12-31"},
    %{date: "2021-09-30"},
  ]
  ```
  """
  def mutual_fund_portfolio_dates(params \\ %{}),
    do: get("#{@api_v4}/mutual-fund-holdings/portfolio-date", params)

  @doc """
  Fetches the symbols of all ETFs from the FMP API.

  ## Response

  ```elixir
  [
    %{
      exchange: "New York Stock Exchange Arca",
      exchangeShortName: "AMEX",
      name: "Brand Value ETF",
      price: 16.145,
      symbol: "BVAL",
      type: "etf"
    },
  ]
  ```
  """
  def etfs, do: get("#{@api_v3}/etf/list")

  @doc """
  Fetches information about an ETF from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the ETF.

  ## Response

  ```elixir
  %{
    assetClass: "Equity",
    aum: 411831.86,
    avgVolume: 79626941,
    cusip: "78462F103",
    description: "The Trust seeks to achieve its investment objective by holding a portfolio of the common stocks that are included in the index (the “Portfolio”), with the weight of each stock in the Portfolio substantially corresponding to the weight of such stock in the index.",
    domicile: "US",
    etfCompany: "SPDR",
    expenseRatio: 0.0945,
    holdingsCount: 503,
    inceptionDate: "1993-01-22",
    isin: "US78462F1030",
    name: "SPDR S&P 500 ETF Trust",
    nav: 436.2,
    navCurrency: "USD",
    sectorsList: [
      %{exposure: 2.18, industry: "Basic Materials"},
      %{exposure: 8.75, industry: "Communication Services"},
      %{exposure: 10.31, industry: "Consumer Cyclical"},
      %{exposure: 6.83, industry: "Consumer Defensive"},
      %{exposure: 4.17, industry: "Energy"},
      %{exposure: 12.01, industry: "Financial Services"},
      %{exposure: 13.77, industry: "Healthcare"},
      %{exposure: 8.01, industry: "Industrials"},
      %{exposure: 0.15000000000000568, industry: "Other"},
      %{exposure: 2.5, industry: "Real Estate"},
      %{exposure: 28.64, industry: "Technology"},
      %{exposure: 2.68, industry: "Utilities"}
    ],
    symbol: "SPY",
    website: "https://www.ssga.com/us/en/institutional/etfs/funds/spdr-sp-500-etf-trust-spy"
  }
  ```
  """
  def etf(symbol) do
    case get("#{@api_v4}/etf-info", %{symbol: symbol}) do
      {:ok, resp} -> {:ok, hd(resp)}
      {:error, _} = error -> error
    end
  end

  @doc """
  Fetches the portfolio dates of an ETF from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the ETF.
  * `cik` - The CIK of the ETF.

  ## Response

  ```elixir
  [
    %{date: "2021-12-31"},
    %{date: "2021-09-30"},
  ]
  ```
  """
  def etf_portfolio_dates(params \\ %{}),
    do: get("#{@api_v4}/etf-holdings/portfolio-date", params)

  @doc """
  Fetches the holdings of an ETF from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the ETF.

  ## Response

  ```elixir
  [
    %{
      asset: "AAPL",
      cusip: "037833100",
      isin: "037833100",
      marketValue: 24014689573.86,
      name: "APPLE INC",
      sharesNumber: 166560477,
      updated: "2023-06-28",
      weightPercentage: 6.515
    }
  ]
  ```
  """
  def etf_holdings(symbol), do: get("#{@api_v3}/etf-holder/#{symbol}")

  @doc """
  Fetches the historical holdings of an ETF from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the ETF.
  * `ciK` - The CIK of the ETF.
  * `date` - The date of the holdings.

  ## Response

  ```elixir
  [
    %{
      cik: "0000036405",
      acceptanceTime: "2022-03-01 15:10:05",
      date: "2021-12-31",
      symbol: "DLR",
      name: "Digital Realty Trust Inc",
      lei: "549300HKCZ31D08NEI41",
      title: "DIGITAL REALTY",
      cusip: "253868103",
      isin: "US2538681030",
      balance: 2252480,
      units: "NS",
      cur_cd: "USD",
      valUsd: 398396138,
      pctVal: 0.212623765335,
      payoffProfile: "Long",
      assetCat: "EC",
      issuerCat: "CORP",
      invCountry: "US",
      isRestrictedSec: "N",
      fairValLevel: "1",
      isCashCollateral: "N",
      isNonCashCollateral: "N",
      isLoanByFund: "N"
    }
  ]
  ```
  """
  def etf_holdings_historical(params \\ %{}), do: get("#{@api_v4}/etf-holdings", params)

  @doc """
  Fetches the stock exposure of an ETF from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the ETF.

  ## Response

  ```elixir
  [
    %{
      assetExposure: "SPY",
      etfSymbol: "VWNFX",
      marketValue: 77322308,
      sharesNumber: 188872,
      weightPercentage: 0.15
    },
  ]
  ```
  """
  def etf_stock_exposure(symbol), do: get("#{@api_v3}/etf-stock-exposure/#{symbol}")

  @doc """
  Fetches the country weightings of an ETF from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the ETF.

  ## Response

  ```elixir
  [
    %{
      country: "United States",
      weightPercentage: "97.46%"
    },
  ]
  ```
  """
  def etf_country_weightings(symbol), do: get("#{@api_v3}/etf-country-weightings/#{symbol}")

  @doc """
  Fetches the sector weightings of an ETF from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the ETF.

  ## Response

  ```elixir
  [
    %{
      sector: "Basic Materials",
      weightPercentage: "2.18%"
    },
  ]
  ```
  """
  def etf_sector_weightings(symbol), do: get("#{@api_v3}/etf-sector-weightings/#{symbol}")

  @doc """
  Fetches sectors PE ratios for a given date from the FMP API.

  ## Inputs

  * `date` - The date of the PE ratios.

  ## Parameters

  * `exchange` - The exchange of the PE ratios.

  ## Response

  ```elixir
  [
    %{
      date: "2021-05-07",
      exchange: "NYSE",
      pe: "52.576622727619",
      sector: "Basic Materials"
    },
  ]
  ```
  """
  def pe_ratios_sectors(date, params \\ %{}),
    do: get("#{@api_v4}/sector_price_earning_ratio", Map.merge(%{date: date}, params))

  @doc """
  Fetches industries PE ratios for a given date from the FMP API.

  ## Inputs

  * `date` - The date of the PE ratios.

  ## Parameters

  * `exchange` - The exchange of the PE ratios.

  ## Response

  ```elixir
  [
    %{
      date: "2021-05-07",
      exchange: "NYSE",
      industry: "Auto Manufacturers",
      pe: "62.1420462666667"
    },
  ]
  ```
  """
  def pe_ratios_industries(date, params \\ %{}),
    do: get("#{@api_v4}/industry_price_earning_ratio", Map.merge(%{date: date}, params))

  @doc """
  Fetches sectors performance from the FMP API.

  ## Response

  ```elixir
  [
    %{
      changesPercentage: "0.10216%",
      sector: "Materials"
    },
  ]
  ```
  """
  def sectors_performance, do: get("#{@api_v3}/sector-performance")

  @doc """
  Fetches historical sectors performance from the FMP API.

  ## Parameters

  * `limit` - The limit of the historical sectors performance.

  ## Response

  ```elixir
  [
    %{
      basicMaterialsChangesPercentage: 0.10216,
      communicationServicesChangesPercentage: 1.2309,
      conglomeratesChangesPercentage: nil,
      consumerCyclicalChangesPercentage: 0.29035,
      consumerDefensiveChangesPercentage: -0.07442,
      date: "2023-06-28",
      energyChangesPercentage: 0.57783,
      financialChangesPercentage: nil,
      financialServicesChangesPercentage: 0.11721,
      healthcareChangesPercentage: -0.44422,
      industrialsChangesPercentage: 0.47828,
      realEstateChangesPercentage: 0.64395,
      servicesChangesPercentage: nil,
      technologyChangesPercentage: 1.53299,
      utilitiesChangesPercentage: -0.2837
    },
  ]
  ```
  """
  def sectors_performance_historical(params \\ %{}),
    do: get("#{@api_v3}/historical-sectors-performance", params)

  @doc """
  Fetches top gainers from the FMP API.

  ## Response

  ```elixir
  [
    %{
      change: 3.219,
      changesPercentage: 53.4718,
      name: "Minerva Neurosciences, Inc.",
      price: 9.239,
      symbol: "NERV"
    },
  ]
  ```
  """
  def top_gainers, do: get("#{@api_v3}/stock_market/gainers")

  @doc """
  Fetches top losers from the FMP API.

  ## Response

  ```elixir
  [
    %{
      change: -2.059,
      changesPercentage: -37.4364,
      name: "American Rebel Holdings, Inc.",
      price: 3.441,
      symbol: "AREB"
    },
  ]
  ```
  """
  def top_losers, do: get("#{@api_v3}/stock_market/losers")

  @doc """
  Fetches most active stocks from the FMP API.

  ## Response

  ```elixir
  [
    %{
      change: -0.0213,
      changesPercentage: -15.5702,
      name: "Mullen Automotive, Inc.",
      price: 0.1155,
      symbol: "MULN"
    },
  ]
  ```
  """
  def top_active, do: get("#{@api_v3}/stock_market/actives")

  @doc """
  Fetches market risk premiums for each country from the FMP API.

  ## Response

  ```elixir
  [
    %{
      continent: "North America",
      country: "British Virgin Islands",
      countryRiskPremium: 11.19,
      totalEquityRiskPremium: 17.13
    },
  ]
  ```
  """
  def market_risk_preminum, do: get("#{@api_v4}/market_risk_premium")

  @doc """
  Fetches treasury rates from the FMP API.

  ## Parameters

  * `from` - The start date of the treasury rates.
  * `to` - The end date of the treasury rates.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-27",
      month1: 5.17,
      month2: 5.31,
      month3: 5.44,
      month6: 5.46,
      year1: 5.33,
      year10: 3.77,
      year2: 4.74,
      year20: 4.03,
      year3: 4.38,
      year30: 3.84,
      year5: 4.02,
      year7: 3.9
    },
  ]
  ```
  """
  def treasury_rates(params \\ %{}), do: get("#{@api_v4}/treasury", params)

  @doc """
  Fetches economic indicators from the FMP API.

  ## Inputs

  * `name` - The name of the economic indicator.

  ## Parameters

  * `from` - The start date of the economic indicator.
  * `to` - The end date of the economic indicator.

  ## Response

  ```elixir
  [
    %{
      date: "2023-01-01",
      value: 26486.287
    },
  ]
  ```
  """
  def ecomonic_indicators(name, params \\ %{}),
    do: get("#{@api_v4}/economic", Map.merge(%{name: name}, params))

  @doc """
  Fetches crowdfunding offerings from the FMP API.

  ## Inputs

  * `cik` - The CIK of the company.

  ## Response

  ```elixir
  [
    %{
      shortTermDebtPriorFiscalYear: 2214117,
      accountsReceivablePriorFiscalYear: 0,
      currentNumberOfEmployees: 5,
      accountsReceivableMostRecentFiscalYear: 0,
      netIncomePriorFiscalYear: -10860,
      totalAssetPriorFiscalYear: 248472,
      legalStatusForm: "Corporation",
      overSubscriptionAccepted: "Y",
      jurisdictionOrganization: "DE",
      taxesPaidMostRecentFiscalYear: 0,
      maximumOfferingAmount: 1070000,
      formType: "C-U",
      costGoodsSoldMostRecentFiscalYear: 2445024,
      intermediaryCommissionFileNumber: "007-00007",
      issuerStateOrCountry: "KS",
      financialInterest: "Two percent (2%) of securities of the total amount of investments raised in the offering, along the same terms as investors.",
      securityOfferedOtherDescription: "Non-Voting Common Stock",
      overSubscriptionAllocationType: "Other",
      totalAssetMostRecentFiscalYear: 497717,
      cik: "0001916078",
      longTermDebtPriorFiscalYear: 105850,
      cashAndCashEquiValentMostRecentFiscalYear: 150142,
      offeringAmount: 10000,
      securityOfferedType: "Other",
      offeringDeadlineDate: "07-19-2022",
      nameOfIssuer: "OYO Fitness, Inc",
      shortTermDebtMostRecentFiscalYear: 3286745,
      formSignification: "Progress Update",
      revenueMostRecentFiscalYear: 4344154,
      numberOfSecurityOffered: 5000,
      costGoodsSoldPriorFiscalYear: 5737776,
      cashAndCashEquiValentPriorFiscalYear: 54571,
      longTermDebtMostRecentFiscalYear: 82243,
      intermediaryCompanyName: "StartEngine Capital, LLC",
      issuerWebsite: "https://www.oyofitness.com/",
      issuerZipCode: "66524",
      offeringPrice: 2,
      issuerStreet: "374 N. 750TH RD",
      revenuePriorFiscalYear: 11078510,
      issuerCity: "OVERBROOK",
      intermediaryCommissionCik: "0001665160",
      taxesPaidPriorFiscalYear: 0,
      acceptanceTime: "2022-07-21 17:28:54",
      compensationAmount: "7 - 13 percent",
      netIncomeMostRecentFiscalYear: -964551
    },
  ]
  ```
  """
  def crowdfunding_offerings(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/crowdfunding-offerings", %{cik: cik})
  end

  @doc """
  Fetches fundraising from the FMP API.

  ## Inputs

  * `cik` - The CIK of the company.

  ## Response

  ```elixir
  [
    %{
      relatedPersonZipCode: "21230",
      dateOfFirstSale: "2022-05-31",
      relatedPersonLastName: "Leroux",
      issuerPhoneNumber: "443-336-7007",
      salesCommissions: 0,
      relatedPersonCity: "Baltimore",
      minimumInvestmentAccepted: 0,
      totalAmountSold: 0,
      totalOfferingAmount: 10000000,
      revenueRange: "Decline to Disclose",
      grossProceedsUsed: 0,
      hasNonAccreditedInvestors: false,
      issuerStateOrCountry: "MD",
      issuerStreet: "921 E FORT AVE",
      isBusinessCombinationTransaction: false,
      relatedPersonRelationship: "Executive Officer, Director",
      totalAmountRemaining: 10000000,
      relatedPersonFirstName: "Jennifer",
      federalExemptionsExclusions: "06b",
      cik: "0001870523",
      formSignification: "Notice of Exempt Offering of Securities",
      yearOfIncorporation: "2021",
      durationOfOfferingIsMoreThanYear: false,
      acceptanceTime: "2022-07-25 14:13:21",
      isAmendment: false,
      relatedPersonStreet: "921 E Fort Ave",
      relatedPersonStateOrCountryDescription: "MARYLAND",
      issuerCity: "BALTIMORE",
      formType: "D",
      incorporatedWithinFiveYears: true,
      entityName: "Marinalife, Inc.",
      jurisdictionOfIncorporation: "DELAWARE",
      industryGroupType: "Other Energy",
      securitiesOfferedAreOfEquityType: true,
      entityType: "Corporation",
      relatedPersonStateOrCountry: "MD",
      findersFees: 0,
      totalNumberAlreadyInvested: 0,
      issuerStateOrCountryDescription: "MARYLAND",
      issuerZipCode: "21230"
    },
  ]
  ```
  """
  def fundraising(cik) do
    cik = String.pad_leading(cik, 10, "0")
    get("#{@api_v4}/fundraising", %{cik: cik})
  end

  @doc """
  Fetches the list of FMP articles from the FMP API.

  ## Parameters

  * `page` - The page number.
  * `size` - The size of the pages.

  ## Response

  ```elixir
  %{
    content: [
      %{
        author: "Davit Kirakosyan",
        content: "<p><a href='https://financialmodelingprep.com/financial-summary/GIS'>General Mills (NYSE:GIS)</a> shares plunged around 5% intra-day today after the company reported its Q4 earnings results, with revenue of $5 billion missing the Street estimate of $5.17 billion. EPS was $1.12, compared to the Street estimate of $1.07.</p>\n<p>General Mills has outlined its financial targets for fiscal 2024. The company expects organic net sales to grow between 3% and 4%. General Mills also anticipates a 4% to 6% increase in adjusted diluted EPS in constant currency, relative to the base value of $4.30 earned in fiscal 2023. The company also hiked its quarterly dividend by 9.3% to $0.59 per share, or $2.36 annualized, for an annual yield of 2.9%.</p>\n",
        date: "2023-06-28 12:46:00",
        image: "https://cdn.financialmodelingprep.com/images/fmp-1687970811905.jpg",
        link: "https://financialmodelingprep.com/market-news/fmp-general-mills-stock-plummets-5-following-q4-earnings-",
        site: "Financial Modeling Prep",
        tickers: "NYSE:GIS",
        title: "General Mills Stock Plummets 5% Following Q4 Earnings "
      },
    ],
    empty: false,
    first: true,
    last: false,
    number: 0,
    numberOfElements: 20,
    pageable: %{
      offset: 0,
      pageNumber: 0,
      pageSize: 20,
      paged: true,
      sort: %{empty: false, sorted: true, unsorted: false},
      unpaged: false
    },
    size: 20,
    sort: %{empty: false, sorted: true, unsorted: false},
    totalElements: 2623,
    totalPages: 132
  }
  ```
  """
  def fmp_articles(params \\ %{}), do: get("#{@api_v3}/fmp/articles", params)

  @doc """
  Fetches the list of stock news from the FMP API.

  ## Parameters

  * `tickers` - The list of tickers.
  * `limit` - The number of news to return.
  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      image: "https://cdn.snapi.dev/images/v1/w/c/fed2x-1951924.jpg",
      publishedDate: "2023-06-28 12:45:47",
      site: "GuruFocus",
      symbol: "FDX",
      text: "FedEx Corp. ( FDX , Financial) is undergoing a significant transformation with its DRIVE initiative to create a more efficient global logistics network. This bullish catalyst involves streamlining operations, optimizing cash flow and modernizing the fleet while focusing on last-mile delivery.",
      title: "FedEx: Transforming Logistics",
      url: "https://www.gurufocus.com/news/2030719/fedex-transforming-logistics"
    }
  ]
  ```
  """
  def news_stock(params \\ %{}), do: get("#{@api_v3}/stock_news", params)

  @doc """
  Fetches the list of crypto news from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the crypto.
  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      image: "https://www.coindesk.com/resizer/k9OceICGoUUFPcg68ayZ69Y8O7g=/800x600/cloudfront-us-east-1.images.arcpublishing.com/coindesk/IURCTTVB2ZHCTKOG4IIGPOW5U4.png",
      publishedDate: "2023-06-28T16:20:00.000Z",
      site: "coindesk",
      symbol: "",
      text: "Digital community platform Coordinape is rolling out CoSoul, which allows users to create a digital resume on-chain...",
      title: "This Free-to-Mint Soulbound NFT Tracks Your Web3 Work History",
      url: "https://www.coindesk.com/web3/2023/06/28/this-free-to-mint-soulbound-nft-tracks-your-web3-work-history/?utm_medium=referral&utm_source=rss&utm_campaign=headlines"
    },
  ]
  ```
  """
  def news_crypto(params \\ %{}), do: get("#{@api_v4}/crypto_news", params)

  @doc """
  Fetches the list of forex news from the FMP API.

  ## Parameters

  * `symbol` - The symbol of the crypto.
  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      image: "https://images.financemagnates.com/images/European%20Union_id_952f7554-8c67-473f-9302-c4460b207b1a_size900.jpg",
      publishedDate: "2023-06-28T16:35:01.000Z",
      site: "financemagnates",
      symbol: "",
      text: "The European Commission has introduced reforms to the regulations governing the electronic payments sector, among them, mitigating fraud by enabling the payment service providers to share information. It comes at a time the fintech ecosystem is growing. Also included in the revised Payment Service Directive are the measures that would extend the refund rights for consumers who fall victim to fraud, the EU said.The commission is also planning to allow non-banks payment service providers to access...",
      title: "EU Unveils Sweeping Reforms to Drive Growth in Fintechs",
      url: "https://www.financemagnates.com//fintech/payments/eu-unveils-sweeping-reforms-to-drive-growth-in-fintechs/"
    },
  ]
  ```
  """
  def news_forex(params \\ %{}), do: get("#{@api_v4}/forex_news", params)

  @doc """
  Fetches the list of general news from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      image: "https://cdn.i-scmp.com/sites/default/files/styles/1280x720/public/d8/images/canvas/2023/06/28/92856814-672c-4928-8a23-f323216702de_f923daaa.jpg?itok=fM6QtB4k",
      publishedDate: "2023-06-28T23:13:37.000Z",
      site: "scmp",
      text: "Controversial private member’s bill from lawmaker Tommy Cheung designed to cut size of Chinese University Council to get first reading in Legco on Thursday...",
      title: "Chinese University says no opportunity given to scrutinise controversial Hong Kong private member’s bill to change council’s composition",
      url: "https://www.scmp.com/news/hong-kong/education/article/3225814/chinese-university-says-no-opportunity-given-scrutinise-controversial-hong-kong-private-members-bill?utm_source=rss_feed"
    },
  ]
  ```
  """
  def news_general(page \\ 0), do: get("#{@api_v4}/general_news", %{page: page})

  @doc """
  Fetches the list of press releases from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.
  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      date: "2023-06-22 09:00:00",
      symbol: "AAPL",
      text: "FREMONT, CALIF.--(BUSINESS WIRE)--ALERTENTERPRISE, INC., THE LEADING CYBER-PHYSICAL SECURITY CONVERGENCE SOFTWARE COMPANY, HAS ANNOUNCED A NEW PARTNERSHIP WITH HID, THE WORLDWIDE LEADER IN TRUSTED IDENTITY SOLUTIONS, TO OFFER EMPLOYEE BADGE IN APPLE WALLET. ALERTENTERPRISE BECOMES ONE OF THE FIRST ORGANIZATIONS TO JOIN THE HID® ORIGO™ TECHNOLOGY PARTNER PROGRAM, A LANDMARK INITIATIVE BY HID TO UNITE TOP-TIER SOLUTION PROVIDERS IN THE MISSION TO CREATE THE FUTURE OF MOBILE CREDENTIALING. THIS PA.",
      title: "ALERTENTERPRISE PARTNERS WITH HID TO OFFER EMPLOYEE BADGE IN APPLE WALLET"
    },
  ]
  ```
  """
  def press_releases(symbol, page \\ 0),
    do: get("#{@api_v3}/press-releases/#{symbol}", %{page: page})

  @doc """
  Fetches the list of sec filings of a company from the FMP API.

  ## Inputs

  * `symbol` - The symbol of the company.

  ## Parameters

  * `type` - The type of the filing.
  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2023-05-18 18:32:21",
      cik: "0000320193",
      fillingDate: "2023-05-18 00:00:00",
      finalLink: "https://www.sec.gov/Archives/edgar/data/320193/000032019323000070/xslF345X04/wf-form4_168444912415136.xml",
      link: "https://www.sec.gov/Archives/edgar/data/320193/000032019323000070/0000320193-23-000070-index.htm",
      symbol: "AAPL",
      type: "4"
    },
  ]
  ```
  """
  def sec_filings(symbol, params \\ %{}), do: get("#{@api_v3}/sec_filings/#{symbol}", params)

  @doc """
  Fetches the SEC rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      cik: "0001089113",
      date: "2023-06-28 12:49:29",
      done: true,
      form_type: "6-K",
      link: "https://www.sec.gov/Archives/edgar/data/1089113/000165495423008502/0001654954-23-008502-index.htm",
      ticker: "HBCYF",
      title: "6-K - HSBC HOLDINGS PLC (0001089113) (Filer)"
    },
  ]
  ```
  """
  def rss_feed(page \\ 0), do: get("#{@api_v3}/rss_feed", %{page: page})

  @doc """
  Fetches the insider trading rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ```elixir
  [
    %{
      fillingDate: "2023-06-28 12:19:56",
      issuerCik: "0001156375",
      link: "https://www.sec.gov/Archives/edgar/data/1156375/000115637523000114/0001156375-23-000114-index.htm",
      reportingCik: "0001556974",
      symbol: "CME",
      title: "4 - CME GROUP INC. (0001156375) (Issuer)"
    },
  ]
  ```
  """
  def rss_feed_insider_trading(page \\ 0),
    do: get("#{@api_v4}/insider-trading-rss-feed", %{page: page})

  @doc """
  Fetches the price targets rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  """
  def rss_feed_price_targets(page \\ 0),
    do: get("#{@api_v4}/price-target-rss-feed", %{page: page})

  @doc """
  Fetches the upgrades and downgrades rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      action: "initialise",
      gradingCompany: "RBC Capital",
      newGrade: "Outperform",
      newsBaseURL: "benzinga.com",
      newsPublisher: "Benzinga",
      newsTitle: "Workday Has A 'Long Runway Of Growth,' Says Bullish Analyst",
      newsURL: "https://www.benzinga.com/analyst-ratings/analyst-color/23/06/33043262/workday-has-a-long-runway-of-growth-says-bullish-analyst",
      previousGrade: nil,
      priceWhenPosted: 226.66,
      publishedDate: "2023-06-28T11:42:00.000Z",
      symbol: "WDAY"
    },
  ]
  ```
  """
  def rss_feed_upgrades_and_downgrades(page \\ 0),
    do: get("#{@api_v4}/upgrades-downgrades-rss-feed", %{page: page})

  @doc """
  Fetches the stock news sentiment rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ```elixir
  [
    %{
      image: "https://cdn.benzinga.com/files/images/story/2023/06/28/beige-ge32c93731_640.jpg?optimize=medium&dpr=1&auto=webp&height=800&width=1456&fit=crop",
      publishedDate: "2023-06-28T16:44:37.000Z",
      sentiment: "Positive",
      sentimentScore: 0.9217,
      site: "benzinga",
      symbol: "OSTK",
      text: "Overstock.com, Inc. (NASDAQ: OSTK) shares are trading higher on Wednesday continuing the stock's recent upward momentum. What to Know: According to a report from Reuters, a U.S. bankruptcy judge has reportedly approved Overstock.com's $21.5 million acquisition of the Bed Bath & Beyond brand name, business data and digital ...Full story available on Benzinga.com...",
      title: "What's Going On With Overstock.com Shares Wednesday?",
      url: "https://www.benzinga.com/news/23/06/33046755/whats-going-on-with-overstock-com-shares-wednesday"
    },
  ]
  ```
  """
  def rss_feed_stock_news_sentiment(page \\ 0),
    do: get("#{@api_v4}/stock-news-sentiments-rss-feed", %{page: page})

  @doc """
  Fetches the institutional ownership rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      acceptedDate: "2023-06-28 11:28:54",
      cik: "0001649910",
      date: "2023-03-31",
      name: "RELATIVE VALUE PARTNERS GROUP, LLC"
    },
  ]
  ```
  """
  def rss_feed_institutional_ownership(page \\ 0),
    do: get("#{@api_v4}/institutional-ownership/rss_feed", %{page: page})

  @doc """
  Fetches the senate trading rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      amount: "$1,001 - $15,000",
      assetDescription: "Essex Property Trust, Inc. Common Stock",
      assetType: "Stock",
      comment: "--",
      dateRecieved: "2023-05-17",
      firstName: "Sheldon",
      lastName: "Whitehouse",
      link: "https://efdsearch.senate.gov/search/view/ptr/9fc025a0-f893-47b2-9252-a2820737a409/",
      office: "Whitehouse, Sheldon (Senator)",
      owner: "Spouse",
      symbol: "ESS",
      transactionDate: "2023-04-18",
      type: "Sale (Full)"
    },
  ]
  ```
  """
  def rss_feed_senate_trading(page \\ 0),
    do: get("#{@api_v4}/senate-trading-rss-feed", %{page: page})

  @doc """
  Fetches the senate disclosures rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      amount: "$15,001 - $50,000",
      assetDescription: "US Treasury Bills, 6-month",
      capitalGainsOver200USD: "False",
      disclosureDate: "2023-06-16",
      disclosureYear: "2023",
      district: "IN02",
      link: "https://disclosures-clerk.house.gov/public_disc/ptr-pdfs/2023/20023174.pdf",
      owner: "",
      representative: "Rudy Yakym",
      ticker: "",
      transactionDate: "2023-06-15",
      type: "purchase"
    },
  ]
  ```
  """
  def rss_feed_senate_disclosures(page \\ 0),
    do: get("#{@api_v4}/senate-disclosure-rss-feed", %{page: page})

  @doc """
  Fetches the mergers and acquisitions rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      acceptanceTime: "2023-06-23 20:12:52",
      cik: "0001922858",
      companyName: "EF HUTTON ACQUISITION CORP I",
      symbol: "EFHTW",
      targetedCik: "0001922858",
      targetedCompanyName: "EF HUTTON ACQUISITION CORPORATION I",
      targetedSymbol: "EFHTU",
      transactionDate: "2023-06-23",
      url: "https://www.sec.gov/Archives/edgar/data/1922858/000149315223022309/forms-4.htm"
    },
  ]
  ```
  """
  def rss_feed_mergers_and_acquisitions(page \\ 0),
    do: get("#{@api_v4}/mergers-acquisitions-rss-feed", %{page: page})

  @doc """
  Fetches the crowdfunding offerings rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      longTermDebtPriorFiscalYear: 0,
      shortTermDebtPriorFiscalYear: 3177,
      totalAssetPriorFiscalYear: 41624,
      formType: "C-U",
      shortTermDebtMostRecentFiscalYear: 4018,
      cashAndCashEquiValentPriorFiscalYear: 15784,
      issuerStreet: "11929 SE OAK ST",
      maximumOfferingAmount: 124000,
      formSignification: "Progress Update",
      issuerCity: "PORTLAND",
      netIncomeMostRecentFiscalYear: 15793,
      currentNumberOfEmployees: 3,
      acceptanceTime: "2023-06-28 10:40:12",
      fillingDate: "2023-06-28T00:00:00.000Z",
      taxesPaidMostRecentFiscalYear: 0,
      financialInterest: "MainVest, Inc. owns no interest in the Company, directly or indirectly, and will not acquire an interest as part of the Offering, nor is there any arrangement for MainVest, Inc. to acquire an interest.",
      issuerWebsite: "http://rockybuttecoffee.com",
      securityOfferedOtherDescription: nil,
      offeringPrice: 1,
      offeringDeadlineDate: "06-23-2023",
      cashAndCashEquiValentMostRecentFiscalYear: 33303,
      cik: "0001971701",
      revenuePriorFiscalYear: 118764,
      accountsReceivableMostRecentFiscalYear: 0,
      companyName: "Rocky Butte Coffee Roasters, LLC",
      overSubscriptionAllocationType: "First-come, first-served basis",
      numberOfSecurityOffered: 0,
      totalAssetMostRecentFiscalYear: 42191,
      jurisdictionOrganization: "OR",
      longTermDebtMostRecentFiscalYear: 0,
      nameOfIssuer: "Rocky Butte Coffee Roasters, LLC",
      costGoodsSoldMostRecentFiscalYear: 76683,
      offeringAmount: 40000,
      taxesPaidPriorFiscalYear: 0,
      accountsReceivablePriorFiscalYear: 0,
      revenueMostRecentFiscalYear: 208087,
      intermediaryCommissionFileNumber: "007-00162",
      intermediaryCommissionCik: "0001746059",
      intermediaryCompanyName: "MainVest, Inc.",
      overSubscriptionAccepted: "Y",
      issuerStateOrCountry: "OR",
      date: "05-10-2017",
      costGoodsSoldPriorFiscalYear: 44455,
      issuerZipCode: "97216",
      compensationAmount: "MainVest will be paid Four and one half (4.5) Percent of the amount of the Offering raised by \"In-Network Users\" of the Platform plus Nine (9) Percent of the amount of the Offering raised by all other investors.",
      netIncomePriorFiscalYear: 18063,
      legalStatusForm: "Limited Liability Company",
      securityOfferedType: "Debt"
    },
  ]
  ```
  """
  def rss_feed_crowdfunding_offerings(page \\ 0),
    do: get("#{@api_v4}/crowdfunding-offerings-rss-feed", %{page: page})

  @doc """
  Fetches the fundraising rss feed from the FMP API.

  ## Inputs

  * `page` - The page number.

  ## Response

  ```elixir
  [
    %{
      findersFees: 0,
      totalNumberAlreadyInvested: 5,
      isBusinessCombinationTransaction: false,
      acceptanceTime: "2023-06-28 13:16:00",
      hasNonAccreditedInvestors: false,
      totalOfferingAmount: 0,
      issuerZipCode: "84043",
      isAmendment: false,
      entityName: "Axia Business Park Partners, LLC",
      issuerPhoneNumber: "8013199269",
      durationOfOfferingIsMoreThanYear: false,
      formSignification: "Notice of Exempt Offering of Securities",
      issuerStreet: "4421 N THANKSGIVING WAY SUITE 204",
      relatedPersonCity: "Lehi",
      incorporatedWithinFiveYears: true,
      relatedPersonStateOrCountryDescription: "UTAH",
      relatedPersonRelationship: "Executive Officer, Director",
      dateOfFirstSale: "2023-04-25",
      minimumInvestmentAccepted: 0,
      totalAmountSold: 2050000,
      formType: "D",
      federalExemptionsExclusions: "06b, 3C, 3C.1",
      relatedPersonZipCode: "84043",
      securitiesOfferedAreOfEquityType: true,
      issuerStateOrCountryDescription: "UTAH",
      salesCommissions: 0,
      issuerCity: "LEHI",
      industryGroupType: "Pooled Investment Fund",
      totalAmountRemaining: 0,
      grossProceedsUsed: 0,
      cik: "0001982309",
      relatedPersonLastName: "Long",
      relatedPersonFirstName: "Jeremy",
      yearOfIncorporation: "2022",
      revenueRange: nil,
      jurisdictionOfIncorporation: "DELAWARE",
      entityType: "Limited Liability Company",
      relatedPersonStreet: "4421 N Thanksgiving Way Suite 204",
      issuerStateOrCountry: "UT",
      relatedPersonStateOrCountry: "UT"
    },
  ]
  ```
  """
  def rss_feed_fundraising(page \\ 0),
    do: get("#{@api_v4}/fundraising-rss-feed", %{page: page})

  @doc """
  Search via ticker and company name from the FMP API.

  ## Inputs

  * `query` - The query to search for.

  ## Parameters

  * `limit` - The number of results to return.
  * `exchange` - The exchange to search in.

  ## Response

  ```elixir
  [
    %{
      currency: "CAD",
      exchangeShortName: "NEO",
      name: "Apple Inc.",
      stockExchange: "NEO",
      symbol: "AAPL.NE"
    },
  ]
  ```
  """
  def search(query, params \\ %{}),
    do: get("#{@api_v3}/search", Map.merge(%{query: query}, params))

  @doc """
  Search via ticker from the FMP API.

  ## Inputs

  * `query` - The query to search for.

  ## Parameters

  * `limit` - The number of results to return.
  * `exchange` - The exchange to search in.

  ## Response

  ```elixir
  [
    %{
      currency: "CAD",
      exchangeShortName: "NEO",
      name: "Apple Inc.",
      stockExchange: "NEO",
      symbol: "AAPL.NE"
    },
  ]
  ```
  """
  def search_ticker(query, params \\ %{}),
    do: get("#{@api_v3}/search-ticker", Map.merge(%{query: query}, params))

  @doc """
  Search via company name from the FMP API.

  ## Inputs

  * `query` - The query to search for.

  ## Parameters

  * `limit` - The number of results to return.
  * `exchange` - The exchange to search in.

  ## Response

  ```elixir
  [
    %{
      currency: "CAD",
      exchangeShortName: "NEO",
      name: "Apple Inc.",
      stockExchange: "NEO",
      symbol: "AAPL.NE"
    },
  ]
  ```
  """
  def search_name(query, params \\ %{}),
    do: get("#{@api_v3}/search-name", Map.merge(%{query: query}, params))

  @doc """
  Search for institutions from the FMP API.

  ## Inputs

  * `name` - The name of the institution to search for.

  ## Response

  ```elixir
  [
    %{
      cik: "0000949012",
      name: "BERKSHIRE ASSET MANAGEMENT LLC/PA"
    },
  ]
  ```
  """
  def search_institutions(name), do: get("#{@api_v4}/institutional-ownership/name", %{name: name})

  @doc """
  Search for mergers and acquisitions from the FMP API.

  ## Inputs

  * `name` - The name of the merger or acquisition to search for.

  ## Response

  ```elixir
  %{
    acceptanceTime: "2022-07-18 07:58:48",
    cik: "0001556263",
    companyName: "Syros Pharmaceuticals, Inc.",
    symbol: "SYRS",
    targetedCik: nil,
    targetedCompanyName: "TYME",
    targetedSymbol: "TYME",
    transactionDate: "2022-07-18",
    url: "https://www.sec.gov/Archives/edgar/data/1556263/000119312522195811/d365321ds4.htm"
  }
  ```
  """
  def search_mergers_and_acquisitions(name),
    do: get("#{@api_v4}/mergers-acquisitions/search", %{name: name})

  @doc """
  Search for crowdfunding offerings from the FMP API.

  ## Inputs

  * `name` - The name of the crowdfunding offering to search for.

  ## Response

  ```elixir
  [
    %{
      cik: "0001912939",
      date: "2022-07-20 17:06:10",
      name: "Enotap LLC"
    },
  ]
  ```
  """
  def search_crowdfunding_offerings(name),
    do: get("#{@api_v4}/crowdfunding-offerings/search", %{name: name})

  @doc """
  Search for fundraising from the FMP API.

  ## Inputs

  * `name` - The name of the fundraising to search for.

  ## Response

  ```elixir
  [
    %{
      cik: "0001870523",
      date: "2022-07-25 14:13:21",
      name: "Marinalife, Inc."
    }
  ]
  ```
  """
  def search_fundraising(name),
    do: get("#{@api_v4}/fundraising/search", %{name: name})

  @doc """
  Screen stocks from the FMP API.

  ## Parameters

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

  ## Response

  ```elixir
  [
    %{
      beta: 1.38345,
      companyName: "Bank of America Corporation",
      country: "US",
      exchange: "New York Stock Exchange",
      exchangeShortName: "NYSE",
      industry: "Banks—Diversified",
      isActivelyTrading: true,
      isEtf: false,
      lastAnnualDividend: 72.5,
      marketCap: 9688295317096,
      price: 1206.1345,
      sector: "Financial Services",
      symbol: "BAC-PL",
      volume: 613
    },
  ]
  ```
  """
  def screener(params \\ %{}), do: get("#{@api_v3}/stock-screener", params)

  @doc false
  defp get(url, params \\ %{}) do
    api_key = Application.get_env(:fmp_client, :api_key)
    url = if params == %{}, do: url, else: "#{url}?#{URI.encode_query(params)}"

    url =
      if String.contains?(url, "?"),
        do: "#{url}&apikey=#{api_key}",
        else: "#{url}?apikey=#{api_key}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode!(body, keys: :atoms) do
          %{"Error Message": message} -> {:error, message}
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
