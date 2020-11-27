defmodule Atmanirbhar.Documents.LocalityImporter do
  alias Atmanirbhar.Documents.Locality.PuneImporter

  @file_name "locdetails_15feb16_4"
  @empty_cell "NA"


  def import(input_file_name) do
    file_path = Path.join("apps/atmanirbhar/priv/repo/", input_file_name)
    opts = ~w(state district_name sub_dist_name village_name locality_detail1 locality_detail2 locality_detail3 office_name pincode)a

    file_path
    |> File.stream!
    |> NimbleCSV.RFC4180.parse_stream([])
    |> Stream.map(fn set_of_records ->
      Enum.zip(opts,
        set_of_records
      )
      |> Enum.into(%{})
      |> process_row
    end)
    |> Stream.run

  end

  defp process_row(%{
        state: "MAHARASHTRA",
        district_name: "PUNE",
        sub_dist_name: "Pune City",
        village_name: "Pune City",
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
               } = arg) do
    PuneImporter.import_record(arg)
  end

  # defp process_row(%{
  #       state: "MAHARASHTRA",
  #       district_name: "Pune",
  #       sub_dist_name: "Pune City",
  #       village_name: "Pune City",
  #       locality_detail1: locality_detail1,
  #       locality_detail2: locality_detail2,
  #       locality_detail3: locality_detail3,
  #       office_name: office_name,
  #       pincode: pincode
  #                  } = arg) do
  #   PuneImporter.import_record(arg)
  # end


  defp process_row(%{
        state: "ANDHRA PRADESH",
        district_name: "Hyderabad",
        sub_dist_name: "Hyderabad",
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: @empty_cell,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
               } = arg) do
    # HyderabadImporter.import(arg)
  end


  defp process_row(%{
        state: state,
        district_name: district_name,
        sub_dist_name: sub_dist_name,
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
               }) do
    # IO.puts "other"
    # :skip
  end

  # defp process_row(opts) do
  #   IO.puts inspect(opts)
  # end

end
