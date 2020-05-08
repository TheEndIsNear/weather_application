defmodule WeatherApplicationWeb.PageLiveTest do
  use WeatherApplicationWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Weather App!"
    assert render(page_live) =~ "Welcome to Weather App!"
  end

  describe "submission of a zip code" do
    test "using the default measurement", %{conn: conn} do
      {:ok, page_live, _} = live(conn, "/")

      assert "300" ==
               page_live
               |> render_submit(:search, request_params: %{zip: "88007"})
               |> Floki.parse_document!()
               |> Floki.find(".temperature-text")
               |> Floki.text()
    end

    test "using imperial measurements", %{conn: conn} do
      {:ok, page_live, _} = live(conn, "/")

      assert "80" ==
               page_live
               |> render_submit(:search, request_params: %{zip: "88007", units: "imperial"})
               |> Floki.parse_document!()
               |> Floki.find(".temperature-text")
               |> Floki.text()
    end

    test "using metric measurement", %{conn: conn} do
      {:ok, page_live, _} = live(conn, "/")

      assert "20" ==
               page_live
               |> render_submit(:search, request_params: %{zip: "88007", units: "metric"})
               |> Floki.parse_document!()
               |> Floki.find(".temperature-text")
               |> Floki.text()
    end
  end
end
