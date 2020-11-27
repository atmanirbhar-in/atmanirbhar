defmodule Atmanirbhar.Catalog.TaxonomyImporter do

  @file_name "taxonomy-with-ids.en-US.csv"

  def say_hello do
    IO.puts "Hello, World!, #{@file_name}"
    IO.puts File.exists?("/priv/repo/" <> @file_name)
    IO.puts "-----"
  end

end
