defmodule FMP do
  alias FMP.Profile

  @base_url "https://financialmodelingprep.com/api/v3"

  @doc """
  Fetches a company profile from the FMP API.

  ## Examples

    iex> {:ok, profile} = FMP.get_profile("AAPL")
    iex> profile.symbol
    "AAPL"
  """
  def get_profile(symbol) do
    resp = get("#{@base_url}/profile/#{symbol}")

    case resp do
      {:ok, []} ->
        {:error, :not_found}
      {:ok, resp} ->
        {:ok, Profile.from_json(resp)}
      _ ->
        resp
    end
  end

  @doc false
  def get(url) do
    api_key = Application.get_env(:fmp_client, :api_key)

    case HTTPoison.get("#{url}?apikey=#{api_key}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, {:unexpected_status_code, code}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
