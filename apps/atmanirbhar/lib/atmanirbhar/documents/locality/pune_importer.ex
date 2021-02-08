defmodule Atmanirbhar.Documents.Locality.PuneImporter do
  # use import_recorder?
  # behaviour
  @empty_cell "NA"
  @state_name "MAHARASHTRA"
  @city_name "Pune"
  @sub_district_name "Pune City"
  @no_sub_district_name "All Localities"

  # missing cities

  def import_record(
        %{
          district_name: "PUNE"
        } = args
      ) do
    # import_record(%{args | district_name: "Pune"})
    import_record(Map.put(args, :district_name, "Pune"))
  end

  # def import_record(%{
  #       state: @state_name,
  #       district_name: district_name,
  #       sub_dist_name: sdn,
  #       village_name: village_name,
  #       locality_detail1: locality_detail1,
  #       locality_detail2: locality_detail2,
  #       locality_detail3: locality_detail3,
  #       office_name: office_name,
  #       pincode: pincode
  #            } = args) do
  #   import_record(%{args | district_name: @city_name})
  # end

  # def import_record(%{
  #       state: @state_name,
  #       district_name: @city_name,
  #       sub_dist_name: sdn,
  #       village_name: village_name,
  #       locality_detail1: @no_sub_district_name,
  #       locality_detail2: locality_detail2,
  #       locality_detail3: locality_detail3,
  #       office_name: office_name,
  #       pincode: pincode
  #            }) do
  #   # import_record
  # end

  # def import_record(%{
  #       state: @state_name,
  #       district_name: @city_name,
  #       sub_dist_name: sdn,
  #       village_name: village_name,
  #       locality_detail1: @no_sub_district_name,
  #       locality_detail2: locality_detail2,
  #       locality_detail3: locality_detail3,
  #       office_name: office_name,
  #       pincode: pincode
  #                   }) do
  #   IO.puts "village is is #{village_name}"
  #   #
  #   # This is a taluka
  #   # set villagename / subdistname
  # end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: @empty_cell,
        locality_detail2: @empty_cell,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
      }) do
    # mostly road names
    # IO.puts "loc det 001 - #{locality_detail3} - #{office_name}"
    # import_record
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: @empty_cell,
        locality_detail2: locality_detail2,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    # IO.puts "loc det 010 - #{locality_detail2} - #{office_name}"
    # import_record
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: @empty_cell,
        locality_detail2: locality_detail2,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
      }) do
    # IO.puts "loc det 011 - #{locality_detail2} - #{locality_detail3} - #{office_name}"
    # import_record
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: @empty_cell,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    # IO.puts "loc det 100 - #{locality_detail1} - #{office_name}"
    # import_record
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: @empty_cell,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
      }) do
    IO.puts("loc det 101 - #{locality_detail1} - #{locality_detail3} - #{office_name}")
    # import_record
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    IO.puts("loc det 110 - #{locality_detail1} - #{locality_detail2} - #{office_name}")
    # import_record
  end

  # 2
  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
      }) do
    # IO.puts "loc det 111 - #{locality_detail1} - #{locality_detail2} - #{locality_detail3} - #{office_name}"
    # import_record
    # IO.puts "loc det 2 - #{locality_detail1} - #{office_name}"
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: sdn,
        village_name: village_name,
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    # IO.puts "loc det 3 - #{locality_detail1} - #{office_name}"
    # IO.puts "loc det 1 - #{locality_detail1} - #{office_name}"
    # import_record
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: @city_name,
        village_name: @sub_district_name,
        locality_detail1: locality_detail1,
        locality_detail2: @empty_cell,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    # Pune city
    # landmark = locality_detail1

    # anand nagar
    # parvati SO

    # aundh
    # locality_detail1
    # landmark = locality_detail2

    # bhosari
    # locality_detail1 = NA
    # locality_detail2 = landmark
    # locality_detail3 = NA

    # Dhankawadi
    # locality_detail1: landmark
    # locality_detail2: NA
    # locality_detail3: NA

    IO.puts("loc det 1 - #{locality_detail1}")
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: @sub_district_name,
        village_name: @sub_district_name,
        locality_detail1: @empty_cell,
        locality_detail2: locality_detail2,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    IO.puts("loc det 4 - #{locality_detail2} - #{office_name}")
    #
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: @sub_district_name,
        village_name: @sub_district_name,
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: @empty_cell,
        office_name: office_name,
        pincode: pincode
      }) do
    #
  end

  def import_record(%{
        state: @state_name,
        district_name: @city_name,
        sub_dist_name: @sub_district_name,
        village_name: @sub_district_name,
        locality_detail1: locality_detail1,
        locality_detail2: locality_detail2,
        locality_detail3: locality_detail3,
        office_name: office_name,
        pincode: pincode
      }) do
    # IO.puts "loc det 5 - #{locality_detail2} - #{office_name}"
    # Pune city
  end

  # def import_record(%{
  #       state: @state_name,
  #       district_name: @city_name,
  #       sub_dist_name: @sub_district_name,
  #       village_name: @sub_district_name,
  #       locality_detail1: locality_detail1,
  #       locality_detail2: locality_detail2,
  #       locality_detail3: locality_detail3,
  #       office_name: office_name,
  #       pincode: pincode
  #            }) do
  #   # Pune city
  # end
end
