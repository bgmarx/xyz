defmodule Xyz.Gzip do
  @moduledoc """
  Conditionally Gzip response body
  if headers are present
  """

  import Plug.Conn

  @doc false
  def init(opts), do: opts

  @doc """
  Adds content-encoding, gzip header
  and gzips the body if "gzip" is present
  in the "accept-encoding" header
  """
  @spec call(%Plug.Conn{}, []) :: %Plug.Conn{}
  def call(conn, _opts \\ []) do
    conn
    |> get_req_header("accept-encoding")
    |> Enum.join(",")
    |> String.downcase
    |> String.contains?("gzip")
    |> gzip_if_present(conn)
  end

  defp gzip_if_present(true, conn)  do
    register_before_send(conn, &zip_response/1)
  end
  defp gzip_if_present(false, conn), do: conn

  defp zip_response(conn) do
    conn
    |> put_resp_header("content-encoding", "gzip")
    |> Map.put(:resp_body, :zlib.gzip(conn.resp_body))
  end
end
