defmodule Atmanirbhar.Catalog.TaxonomyImporter do

  @file_name "taxonomy-with-ids.en-US.csv"

  def say_hello do
    file_path = Path.join("apps/atmanirbhar/priv/repo/", @file_name)
    IO.puts "Hello, World!, #{file_path}"
    # IO.puts File.exists?(file_path)
    # IO.puts "-----"
    # IO.puts inspect File.read(file_path)
  end

  # just cat0
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         :error <- Map.fetch(row, "cat1"),
           :error <- Map.fetch(row, "cat2"),
           :error <- Map.fetch(row, "cat3"),
           :error <- Map.fetch(row, "cat4"),
           :error <- Map.fetch(row, "cat5"),
           :error <- Map.fetch(row, "cat6")
      do
      #
    end
  end

  # just cat1
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         {:ok, cat1} <- Map.fetch(row, "cat1"),
           :error <- Map.fetch(row, "cat2"),
           :error <- Map.fetch(row, "cat3"),
           :error <- Map.fetch(row, "cat4"),
           :error <- Map.fetch(row, "cat5"),
           :error <- Map.fetch(row, "cat6")
      do
      #
    end
  end

  # just cat2
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         {:ok, cat1} <- Map.fetch(row, "cat1"),
         {:ok, cat2} <- Map.fetch(row, "cat2"),
           :error <- Map.fetch(row, "cat3"),
           :error <- Map.fetch(row, "cat4"),
           :error <- Map.fetch(row, "cat5"),
           :error <- Map.fetch(row, "cat6")
      do
      #
    end
  end


  # just cat3
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         {:ok, cat1} <- Map.fetch(row, "cat1"),
         {:ok, cat2} <- Map.fetch(row, "cat2"),
         {:ok, cat3} <- Map.fetch(row, "cat3"),
           :error <- Map.fetch(row, "cat4"),
           :error <- Map.fetch(row, "cat5"),
           :error <- Map.fetch(row, "cat6")
      do
      #
    end
  end

  # just cat4
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         {:ok, cat1} <- Map.fetch(row, "cat1"),
         {:ok, cat2} <- Map.fetch(row, "cat2"),
         {:ok, cat3} <- Map.fetch(row, "cat3"),
         {:ok, cat4} <- Map.fetch(row, "cat4"),
           :error <- Map.fetch(row, "cat5"),
           :error <- Map.fetch(row, "cat6")
      do
      #
    end
  end

  # just cat5
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         {:ok, cat1} <- Map.fetch(row, "cat1"),
         {:ok, cat2} <- Map.fetch(row, "cat2"),
         {:ok, cat3} <- Map.fetch(row, "cat3"),
         {:ok, cat4} <- Map.fetch(row, "cat4"),
         {:ok, cat5} <- Map.fetch(row, "cat5"),
           :error <- Map.fetch(row, "cat6")
      do
      #
    end
  end

  # just cat6
  defp process(row) do
    with {:ok, cat0} <- Map.fetch(row, "cat0"),
         {:ok, cat1} <- Map.fetch(row, "cat1"),
         {:ok, cat2} <- Map.fetch(row, "cat2"),
         {:ok, cat3} <- Map.fetch(row, "cat3"),
         {:ok, cat4} <- Map.fetch(row, "cat4"),
         {:ok, cat5} <- Map.fetch(row, "cat5"),
         {:ok, cat6} <- Map.fetch(row, "cat6")
      do
      #
    end
  end


end
