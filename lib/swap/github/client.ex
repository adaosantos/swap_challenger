defmodule Swap.Github.Client do
  use HTTPoison.Base

  def process_request_url(url) do
    Application.get_env(:swap, :github)[:url] <> url
  end

  # def process_response_body(body) do
  #   body
  #   |> Jason.decode!(keys: :atoms)
  # end

  def process_request_headers(headers) when is_map(headers) do
    Enum.into(headers, [])
    |> Keyword.merge(auth_headers())
  end

  def process_request_headers(headers) do
    Keyword.merge(headers, auth_headers())
  end

  defp auth_headers, do: [Authorization: "Basic #{credentials()}"]

  defp credentials do
    "#{Application.get_env(:swap, :github)[:username]}:#{Application.get_env(:swap, :github)[:access_token]}"
    |> Base.encode64()
  end
end
