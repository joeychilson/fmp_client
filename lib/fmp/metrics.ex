defmodule FMP.FinancialRatios do
  defstruct [
    :date,
    :symbol,
    :period,
    :current_ratio,
    :quick_ratio,
    :cash_ratio,
    :days_of_sales_outstanding,
    :days_of_inventory_outstanding,
    :operating_cycle,
    :days_of_payables_outstanding,
    :cash_conversion_cycle,
    :gross_profit_margin,
    :operating_profit_margin,
    :pretax_profit_margin,
    :net_profit_margin,
    :effective_tax_rate,
    :return_on_assets,
    :return_on_equity,
    :return_on_capital_employed,
    :net_income_per_ebt,
    :ebt_per_ebit,
    :ebit_per_revenue,
    :debt_ratio,
    :debt_equity_ratio,
    :long_term_debt_to_capitalization,
    :total_debt_to_capitalization,
    :interest_coverage,
    :cash_flow_to_debt_ratio,
    :company_equity_multiplier,
    :receivables_turnover,
    :payables_turnover,
    :inventory_turnover,
    :fixed_asset_turnover,
    :asset_turnover,
    :operating_cash_flow_per_share,
    :free_cash_flow_per_share,
    :cash_per_share,
    :payout_ratio,
    :operating_cash_flow_sales_ratio,
    :free_cash_flow_operating_cash_flow_ratio,
    :cash_flow_coverage_ratios,
    :short_term_coverage_ratios,
    :capital_expenditure_coverage_ratio,
    :dividend_paid_and_capex_coverage_ratio,
    :dividend_payout_ratio,
    :price_book_value_ratio,
    :price_to_book_ratio,
    :price_to_sales_ratio,
    :price_earnings_ratio,
    :price_to_free_cash_flows_ratio,
    :price_to_operating_cash_flows_ratio,
    :price_cash_flow_ratio,
    :price_earnings_to_growth_ratio,
    :price_sales_ratio,
    :dividend_yield,
    :enterprise_value_multiple,
    :price_fair_value
  ]

  def from_resp(list) do
    Enum.map(list, fn data ->
      %FMP.FinancialRatios{
        date: data["date"],
        symbol: data["symbol"],
        period: data["period"],
        current_ratio: data["currentRatio"],
        quick_ratio: data["quickRatio"],
        cash_ratio: data["cashRatio"],
        days_of_sales_outstanding: data["daysOfSalesOutstanding"],
        days_of_inventory_outstanding: data["daysOfInventoryOutstanding"],
        operating_cycle: data["operatingCycle"],
        days_of_payables_outstanding: data["daysOfPayablesOutstanding"],
        cash_conversion_cycle: data["cashConversionCycle"],
        gross_profit_margin: data["grossProfitMargin"],
        operating_profit_margin: data["operatingProfitMargin"],
        pretax_profit_margin: data["pretaxProfitMargin"],
        net_profit_margin: data["netProfitMargin"],
        effective_tax_rate: data["effectiveTaxRate"],
        return_on_assets: data["returnOnAssets"],
        return_on_equity: data["returnOnEquity"],
        return_on_capital_employed: data["returnOnCapitalEmployed"],
        net_income_per_ebt: data["netIncomePerEBT"],
        ebt_per_ebit: data["ebtPerEbit"],
        ebit_per_revenue: data["ebitPerRevenue"],
        debt_ratio: data["debtRatio"],
        debt_equity_ratio: data["debtEquityRatio"],
        long_term_debt_to_capitalization: data["longTermDebtToCapitalization"],
        total_debt_to_capitalization: data["totalDebtToCapitalization"],
        interest_coverage: data["interestCoverage"],
        cash_flow_to_debt_ratio: data["cashFlowToDebtRatio"],
        company_equity_multiplier: data["companyEquityMultiplier"],
        receivables_turnover: data["receivablesTurnover"],
        payables_turnover: data["payablesTurnover"],
        inventory_turnover: data["inventoryTurnover"],
        fixed_asset_turnover: data["fixedAssetTurnover"],
        asset_turnover: data["assetTurnover"],
        operating_cash_flow_per_share: data["operatingCashFlowPerShare"],
        free_cash_flow_per_share: data["freeCashFlowPerShare"],
        cash_per_share: data["cashPerShare"],
        payout_ratio: data["payoutRatio"],
        operating_cash_flow_sales_ratio: data["operatingCashFlowSalesRatio"],
        free_cash_flow_operating_cash_flow_ratio: data["freeCashFlowOperatingCashFlowRatio"],
        cash_flow_coverage_ratios: data["cashFlowCoverageRatios"],
        short_term_coverage_ratios: data["shortTermCoverageRatios"],
        capital_expenditure_coverage_ratio: data["capitalExpenditureCoverageRatio"],
        dividend_paid_and_capex_coverage_ratio: data["dividendPaidAndCapexCoverageRatio"],
        dividend_payout_ratio: data["dividendPayoutRatio"],
        price_book_value_ratio: data["priceBookValueRatio"],
        price_to_book_ratio: data["priceToBookRatio"],
        price_to_sales_ratio: data["priceToSalesRatio"],
        price_earnings_ratio: data["priceEarningsRatio"],
        price_to_free_cash_flows_ratio: data["priceToFreeCashFlowsRatio"],
        price_to_operating_cash_flows_ratio: data["priceToOperatingCashFlowsRatio"],
        price_cash_flow_ratio: data["priceCashFlowRatio"],
        price_earnings_to_growth_ratio: data["priceEarningsToGrowthRatio"],
        price_sales_ratio: data["priceSalesRatio"],
        dividend_yield: data["dividendYield"],
        enterprise_value_multiple: data["enterpriseValueMultiple"],
        price_fair_value: data["priceFairValue"]
      }
    end)
  end
end

defmodule FMP.FinancialScores do
  defstruct [
    :symbol,
    :altman_z_score,
    :piotroski_score,
    :working_capital,
    :total_assets,
    :retained_earnings,
    :ebit,
    :market_cap,
    :total_liabilities,
    :revenue
  ]

  def from_resp([data]) do
    %FMP.FinancialScores{
      symbol: data["symbol"],
      altman_z_score: data["altmanZScore"],
      piotroski_score: data["piotroskiScore"],
      working_capital: data["workingCapital"],
      total_assets: data["totalAssets"],
      retained_earnings: data["retainedEarnings"],
      ebit: data["ebit"],
      market_cap: data["marketCap"],
      total_liabilities: data["totalLiabilities"],
      revenue: data["revenue"]
    }
  end
end

defmodule FMP.EnterpriseValue do
  defstruct [
    :symbol,
    :date,
    :stock_price,
    :number_of_shares,
    :market_capitalization,
    :minus_cash_and_cash_equivalents,
    :add_total_debt,
    :enterprise_value
  ]

  def from_resp(list) do
    Enum.map(list, fn data ->
      %FMP.EnterpriseValue{
        symbol: data["symbol"],
        date: data["date"],
        stock_price: data["stockPrice"],
        number_of_shares: data["numberOfShares"],
        market_capitalization: data["marketCapitalization"],
        minus_cash_and_cash_equivalents: data["minusCashAndCashEquivalents"],
        add_total_debt: data["addTotalDebt"],
        enterprise_value: data["enterpriseValue"]
      }
    end)
  end
end
