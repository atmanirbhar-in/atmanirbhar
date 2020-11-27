defmodule Atmanirbhar.Catalog.TaxonomyImporter do
  import Ecto.Query, warn: false
  alias Atmanirbhar.Repo
  alias Atmanirbhar.Catalog.Taxonomy

  @file_name "taxonomy-with-ids.en-US.csv"
  @empty_cell ""

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
        cat1: @empty_cell,
        cat2: @empty_cell,
        cat3: @empty_cell,
        cat4: @empty_cell,
        cat5: @empty_cell,
        cat6: @empty_cell
               }) do
    # find or update record with uniq
    # parent_id = nil


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
    # find or update record with uniq
    # parent_id = id of cat0
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
    # find or update record with uniq
    # parent_id = id of cat1
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
    # find or update record with uniq
    # parent_id = id of cat2
    # name = cat3
    # full name = joined_array
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

  def create_record(uniq, name, fullname, parent_name) do
    parent_uniq = Catalog.find(parent_name)
    changeset = Atmanirbhar.Catalog.change_taxonomy(
      %Taxonomy{
        uniq: uniq,
        name: name,
        full_name: fullname,
        parent_uniq: parent_uniq
      }
    )

    Repo.insert_or_update changeset
  end

end
