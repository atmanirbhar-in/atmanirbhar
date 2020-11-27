defmodule Mix.Tasks.ImportCategories do
  use Mix.Task

  @requirements ["app.start"]
  @shortdoc "upload categories csv and import them. update existing"
  def run(_) do
    Atmanirbhar.Catalog.TaxonomyImporter.say_hello()
  end

end
