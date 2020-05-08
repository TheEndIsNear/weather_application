defmodule WeatherApplication.RequestParamsTest do
  use ExUnit.Case
  alias WeatherApplication.RequestParams

  describe "changeset" do
    test "given a valid zip code, return a valid changeset" do
      changeset = RequestParams.changeset(%{zip: "88007"})

      assert changeset.valid?()
    end

    test "given an invalid zip code, changeset should be invalid" do
      changeset = RequestParams.changeset(%{zip: "8"})

      refute changeset.valid?()
    end

    test "changeset requires a zipcode value" do
      changeset = RequestParams.changeset(%{})

      refute changeset.valid?()
    end
  end
end
