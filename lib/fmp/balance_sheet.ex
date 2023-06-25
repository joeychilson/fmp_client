defmodule FMP.BalanceSheet do
  defstruct [
    :date,
    :symbol,
    :reported_currency,
    :cik,
    :filling_date,
    :accepted_date,
    :calendar_year,
    :period,
    :cash_and_cash_equivalents,
    :short_term_investments,
    :cash_and_short_term_investments,
    :net_receivables,
    :inventory,
    :other_current_assets,
    :total_current_assets,
    :property_plant_equipment_net,
    :goodwill,
    :intangible_assets,
    :goodwill_and_intangible_assets,
    :long_term_investments,
    :tax_assets,
    :other_non_current_assets,
    :total_non_current_assets,
    :other_assets,
    :total_assets,
    :account_payables,
    :short_term_debt,
    :tax_payables,
    :deferred_revenue,
    :other_current_liabilities,
    :total_current_liabilities,
    :long_term_debt,
    :deferred_revenue_non_current,
    :deferred_tax_liabilities_non_current,
    :other_non_current_liabilities,
    :total_non_current_liabilities,
    :other_liabilities,
    :capital_lease_obligations,
    :total_liabilities,
    :preferred_stock,
    :common_stock,
    :retained_earnings,
    :accumulated_other_comprehensive_income_loss,
    :other_total_stockholders_equity,
    :total_stockholders_equity,
    :total_equity,
    :total_liabilities_and_stockholders_equity,
    :minority_interest,
    :total_liabilities_and_total_equity,
    :total_investments,
    :total_debt,
    :net_debt,
    :link,
    :final_link
  ]

  def from_json(list) do
    Enum.map(list, fn data ->
      %FMP.BalanceSheet{
        date: Date.from_iso8601!(data["date"]),
        symbol: data["symbol"],
        reported_currency: data["reportedCurrency"],
        cik: data["cik"],
        filling_date: Date.from_iso8601!(data["fillingDate"]),
        accepted_date: data["acceptedDate"],
        calendar_year: data["calendarYear"],
        period: data["period"],
        cash_and_cash_equivalents: data["cashAndCashEquivalents"],
        short_term_investments: data["shortTermInvestments"],
        cash_and_short_term_investments: data["cashAndShortTermInvestments"],
        net_receivables: data["netReceivables"],
        inventory: data["inventory"],
        other_current_assets: data["otherCurrentAssets"],
        total_current_assets: data["totalCurrentAssets"],
        property_plant_equipment_net: data["propertyPlantEquipmentNet"],
        goodwill: data["goodwill"],
        intangible_assets: data["intangibleAssets"],
        goodwill_and_intangible_assets: data["goodwillAndIntangibleAssets"],
        long_term_investments: data["longTermInvestments"],
        tax_assets: data["taxAssets"],
        other_non_current_assets: data["otherNonCurrentAssets"],
        total_non_current_assets: data["totalNonCurrentAssets"],
        other_assets: data["otherAssets"],
        total_assets: data["totalAssets"],
        account_payables: data["accountPayables"],
        short_term_debt: data["shortTermDebt"],
        tax_payables: data["taxPayables"],
        deferred_revenue: data["deferredRevenue"],
        other_current_liabilities: data["otherCurrentLiabilities"],
        total_current_liabilities: data["totalCurrentLiabilities"],
        long_term_debt: data["longTermDebt"],
        deferred_revenue_non_current: data["deferredRevenueNonCurrent"],
        deferred_tax_liabilities_non_current: data["deferredTaxLiabilitiesNonCurrent"],
        other_non_current_liabilities: data["otherNonCurrentLiabilities"],
        total_non_current_liabilities: data["totalNonCurrentLiabilities"],
        other_liabilities: data["otherLiabilities"],
        capital_lease_obligations: data["capitalLeaseObligations"],
        total_liabilities: data["totalLiabilities"],
        preferred_stock: data["preferredStock"],
        common_stock: data["commonStock"],
        retained_earnings: data["retainedEarnings"],
        accumulated_other_comprehensive_income_loss: data["accumulatedOtherComprehensiveIncomeLoss"],
        other_total_stockholders_equity: data["othertotalStockholdersEquity"],
        total_stockholders_equity: data["totalStockholdersEquity"],
        total_equity: data["totalEquity"],
        total_liabilities_and_stockholders_equity: data["totalLiabilitiesAndStockholdersEquity"],
        minority_interest: data["minorityInterest"],
        total_liabilities_and_total_equity: data["totalLiabilitiesAndTotalEquity"],
        total_investments: data["totalInvestments"],
        total_debt: data["totalDebt"],
        net_debt: data["netDebt"],
        link: data["link"],
        final_link: data["finalLink"]
      }
    end)
  end
end