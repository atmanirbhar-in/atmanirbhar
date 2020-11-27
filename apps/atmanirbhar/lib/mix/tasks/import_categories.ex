defmodule Mix.Tasks.ImportCategories do
  use Mix.Task

  @requirements ["app.start"]
  @shortdoc "upload categories csv and import them. update existing"
  def run(_) do
    Mix.Task.run "app.start"
    Atmanirbhar.Catalog.TaxonomyImporter.import()
  end

end
