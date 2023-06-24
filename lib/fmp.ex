defmodule FMP do
  alias FMP.Executive
  alias FMP.MarketCap
  alias FMP.Peers
  alias FMP.Profile

  @base_url "https://financialmodelingprep.com/api"

  @doc """
  Fetches a company profile from the FMP API.

  ## Examples

    iex> {:ok, profile} = FMP.get_profile("AAPL")
    iex> profile.symbol
    "AAPL"
  """
  def get_profile(symbol) do
    resp = get("#{@base_url}/v3/profile/#{symbol}")

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
  Fetches a company's key executives from the FMP API.

  ## Examples

    iex> {:ok, executives} = FMP.get_key_executives("AAPL")
    iex> Enum.count(executives) > 0
    true
  """
  def get_key_executives(symbol) do
    resp = get("#{@base_url}/v3/key-executives/#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Executive.from_json(resp)}

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
    resp = get("#{@base_url}/v3/market-capitalization/#{symbol}")

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
    iex> market_cap.symbol
    "AAPL"
  """
  def get_historical_market_cap(symbol, limit \\ nil) do
    url =
      if limit do
        "#{@base_url}/v3/historical-market-capitalization/#{symbol}?limit=#{limit}"
      else
        "#{@base_url}/v3/historical-market-capitalization/#{symbol}"
      end

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
    resp = get("#{@base_url}/v4/stock_peers?symbol=#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}

      {:ok, resp} ->
        {:ok, Peers.from_json(resp)}

      _ ->
        resp
    end
  end

  @doc false
  def get(url) do
    api_key = Application.get_env(:fmp_client, :api_key)

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
end
