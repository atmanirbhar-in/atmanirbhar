defmodule Atmanirbhar.Catalog.TaxonomyImporter do
  import Ecto.Query, warn: false
  alias Atmanirbhar.Repo
  alias Atmanirbhar.Catalog
  alias Atmanirbhar.Catalog.Taxonomy
  # alias NimbleCSV
  # alias NimbleCSV.RFC4180

  @file_name "taxonomy-with-ids.en-US.csv"
  @empty_cell ""

  def import do
    file_path = Path.join("priv/repo/", @file_name)

    file_path
    |> File.stream!
    |> NimbleCSV.RFC4180.parse_stream([])
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
    create_record(uniq, cat0, cat0, "")
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
      full_name = Enum.join([cat0, cat1], " -> ")
      create_record(uniq, cat1, full_name, cat0)
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
    full_name = Enum.join([cat0, cat1, cat2], " -> ")
    create_record(uniq, cat2, full_name, cat1)
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
    full_name = Enum.join([cat0, cat1, cat2, cat3], " -> ")
    create_record(uniq, cat3, full_name, cat2)
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
    parent_uniq = Catalog.get_taxonomy_by_name!(parent_name)

    changes = %{ uniq: uniq,
                 name: name,
                 full_name: fullname,
                 parent_uniq: parent_uniq
               }

    result =
      case Repo.get_by(Taxonomy, uniq: uniq) do
        nil  -> %Taxonomy{}   # not found, we build one
        taxonomy -> taxonomy    # exists, let's use it
      end
      |> Taxonomy.changeset(changes)
      |> Repo.insert_or_update

    case result do
      {:ok, _struct}       -> IO.puts "created" # Inserted or updated with success
      {:error, _changeset} -> IO.puts "failed" # Something went wrong
    end
  end

end
