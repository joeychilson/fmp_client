defmodule FMP do
  alias FMP.BalanceSheet
  alias FMP.CashFlowStatement
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

    iex> {:ok, income_statements} = FMP.get_income_statements("AAPL", period: "quarter", limit: 1)
    iex> Enum.count(income_statements) == 1
    true
  """
  def get_income_statements(cik_or_symbol, params \\ []) do
    url = url_with_params("#{@api_v3}/income-statement/#{cik_or_symbol}", params)
    resp = get(url)

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, IncomeStatement.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches a company's balance sheets from the FMP API.

  ## Examples

    iex> {:ok, balance_sheets} = FMP.get_balance_sheets("320193")
    iex> Enum.count(balance_sheets) > 0
    true

    iex> {:ok, balance_sheets} = FMP.get_balance_sheets("AAPL", period: "quarter", limit: 1)
    iex> Enum.count(balance_sheets) == 1
    true
  """
  def get_balance_sheets(cik_or_symbol, params \\ []) do
    url = url_with_params("#{@api_v3}/balance-sheet-statement/#{cik_or_symbol}", params)
    resp = get(url)

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, BalanceSheet.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches a company's cash flow statements from the FMP API.

  ## Examples

    iex> {:ok, cash_flow} = FMP.get_cash_flow_statements("320193")
    iex> Enum.count(cash_flow) > 0
    true

    iex> {:ok, cash_flow} = FMP.get_cash_flow_statements("AAPL", period: "quarter", limit: 1)
    iex> Enum.count(cash_flow) == 1
    true
  """
  def get_cash_flow_statements(cik_or_symbol, params \\ []) do
    url = url_with_params("#{@api_v3}/cash-flow-statement/#{cik_or_symbol}", params)
    resp = get(url)

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, CashFlowStatement.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches a company's key executives from the FMP API.

  ## Examples

    iex> {:ok, executives} = FMP.get_key_executives("AAPL")
    iex> Enum.count(executives) > 0
    true
  """
  def get_key_executives(symbol) do
    resp = get("#{@api_v3}/key-executives/#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, KeyExecutive.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches a company's market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.get_market_cap("AAPL")
    iex> market_cap.symbol
    "AAPL"
  """
  def get_market_cap(symbol) do
    resp = get("#{@api_v3}/market-capitalization/#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, MarketCap.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches a company's historical market capitalization from the FMP API.

  ## Examples

    iex> {:ok, market_cap} = FMP.get_historical_market_cap("AAPL")
    iex> Enum.count(market_cap) > 0
    true

    iex> {:ok, market_cap} = FMP.get_historical_market_cap("AAPL", limit: 1)
    iex> Enum.count(market_cap) == 1
    true
  """
  def get_historical_market_cap(symbol, params \\ []) do
    url = url_with_params("#{@api_v3}/historical-market-capitalization/#{symbol}", params)
    resp = get(url)

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, MarketCap.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches a company's peers from the FMP API.

  ## Examples

    iex> {:ok, peers} = FMP.get_peers("AAPL")
    iex> peers.symbol
    "AAPL"
  """
  def get_peers(symbol) do
    resp = get("#{@api_v4}/stock_peers?symbol=#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Peers.from_json(resp)}

      _ ->
        resp
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
    resp = get("#{@api_v3}/profile/#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Profile.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches the symbols of all companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_symbols() do
    resp = get("#{@api_v3}/stock/list")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Symbol.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches the symbols of all tradable companies from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_tradable_symbols()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_tradable_symbols() do
    resp = get("#{@api_v3}/available-traded/list")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Symbol.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc """
  Fetches the symbols of all ETFs from the FMP API.

  ## Examples

    iex> {:ok, symbols} = FMP.get_etfs()
    iex> Enum.count(symbols) > 0
    true
  """
  def get_etfs() do
    resp = get("#{@api_v3}/etf/list")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Symbol.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc false
  defp get(url) do
    api_key = Application.get_env(:fmp_client, :api_key)
    if api_key == nil do
      {:error, :api_key_not_set}
    end

    url =
      if String.contains?(url, "?") do
        "#{url}&apikey=#{api_key}"
      else
        "#{url}?apikey=#{api_key}"
      end

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
  defp url_with_params(url, params) do
    queries =
      Enum.map(params, fn {k, v} -> "#{k}=#{v}" end)
      |> Enum.join("&")

    (queries == "" && url) || "#{url}?#{queries}"
  end
end
