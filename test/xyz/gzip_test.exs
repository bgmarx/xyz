defmodule Xyz.GzipTest do
  use ExUnit.Case
  doctest Xyz.Gzip

  use Plug.Test

  test "ungzipped if 'gzip' is absent from 'accept-encoding' header" do
    opts = Xyz.Gzip.init([])

    resp =
      conn(:get, "/foo")
      |> put_req_header("content-type", "application/json")
      |> Xyz.Gzip.call(opts)
      |> send_resp(200, "Hello")

    assert resp.req_headers == [{"content-type", "application/json"}]
    assert resp.resp_body   == "Hello"
  end

  test "gzips resp.body if 'gzip' is present in 'accept-encoding' header" do
    zipped_hello = :zlib.gzip("Hello")

    opts = Xyz.Gzip.init([])

    resp =
      conn(:get, "/foo")
      |> put_req_header("accept-encoding", "gzip, deflate")
      |> Xyz.Gzip.call(opts)
      |> send_resp(200, "Hello")

    assert resp.req_headers           == [{"accept-encoding", "gzip, deflate"}]
    assert resp.resp_headers          == [{"cache-control", "max-age=0, private, must-revalidate"},
                                          {"content-encoding", "gzip"}]
    assert resp.resp_body             == zipped_hello
    assert :zlib.gunzip(zipped_hello) == "Hello"
  end
end
