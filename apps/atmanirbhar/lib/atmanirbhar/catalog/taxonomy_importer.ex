defmodule Atmanirbhar.Catalog.TaxonomyImporter do

  @file_name "taxonomy-with-ids.en-US.csv"

  def say_hello do
    # NimbleCSV.define(MyParser, separator: "\t", escape: "\"")
    file_path = Path.join("apps/atmanirbhar/priv/repo/", @file_name)
    NimbleCSV.define(MyParser, separator: "\t", escape: "\"")

    file_path
    |> File.stream!
    |> NimbleCSV.RFC4180.parse_stream([skip_headers: false])
    |> Stream.map(fn set_of_records ->
      Enum.zip([:uniq, :cat0, :cat1, :cat2, :cat3, :cat4, :cat5, :cat6],
        set_of_records
      )
      |> Enum.into(%{})
      |> process
    end)
    |> Stream.run

  end

  # upto cat 1
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: "",
        cat2: "",
        cat3: "",
        cat4: "",
        cat5: "",
        cat6: ""
               }) do
    IO.puts "------"
    IO.puts "just cat0"
    IO.puts cat0
    IO.puts "------"
  end

  # upto cat 2
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: cat1,
        cat2: "",
        cat3: "",
        cat4: "",
        cat5: "",
        cat6: ""
               }) do
    IO.puts "------"
    IO.puts "upto cat1"
    IO.puts cat0
    IO.puts cat1
    IO.puts "------"
  end

  # upto cat 2
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: cat1,
        cat2: cat2,
        cat3: "",
        cat4: "",
        cat5: "",
        cat6: ""
               }) do
    IO.puts "upto cat2"
  end

  # upto cat 3
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: cat1,
        cat2: cat2,
        cat3: cat3,
        cat4: "",
        cat5: "",
        cat6: ""
               }) do
    IO.puts "upto cat3"
  end


  # upto cat 4
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: cat1,
        cat2: cat2,
        cat3: cat3,
        cat4: cat4,
        cat5: "",
        cat6: ""
               }) do
    IO.puts "upto cat4"
  end

  # upto cat 5
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: cat1,
        cat2: cat2,
        cat3: cat3,
        cat4: cat4,
        cat5: cat5,
        cat6: ""
               }) do
    IO.puts "upto cat5"
  end

  # upto cat6
  defp process(%{
        uniq: uniq,
        cat0: cat0,
        cat1: cat1,
        cat2: cat2,
        cat3: cat3,
        cat4: cat4,
        cat5: cat5,
        cat6: cat6
               }) do
    IO.puts "upto cat6"
  end

end
