defmodule Atmanirbhar.Catalog.TaxonomyImporter do

  @file_name "taxonomy-with-ids.en-US.csv"

  def say_hello do
    file_path = Path.join("apps/atmanirbhar/priv/repo/", @file_name)

    file_path
    |> File.stream!
    |> NimbleCSV.RFC4180.parse_stream()
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
    IO.puts cat0
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
    IO.puts Enum.join([cat0, cat1], " -> ")
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
    IO.puts Enum.join([cat0, cat1, cat2], " -> ")
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
    IO.puts Enum.join([cat0, cat1, cat2, cat3], " -> ")
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
    IO.puts Enum.join([cat0, cat1, cat2, cat3, cat4], " -> ")
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
    IO.puts Enum.join([cat0, cat1, cat2, cat3, cat4, cat5], " -> ")
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
    IO.puts Enum.join([cat0, cat1, cat2, cat3, cat4, cat5, cat6], " -> ")
  end

end
