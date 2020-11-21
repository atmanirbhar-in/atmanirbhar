defmodule AtmanirbharWeb.BulkUploadController do
  use AtmanirbharWeb, :controller
  alias Atmanirbhar.BulkUpload.BusinessImportJob

  # reference
  # https://stackoverflow.com/questions/43891367/how-to-import-users-from-csv-file-with-elixir-phoenix
  # TODO: map headers
  def import_city_data(conn, %{"user" => user_params}) do
    user_params["file"].path
    |> File.stream!()
    |> CSV.decode
    |> Enum.map(fn(user) ->
      BusinessImportJob.changeset(%BusinessImportJob{},
        %{name: Enum.at(user, 0),
          email: Enum.at(user, 1)})
          |> Repo.insert
    end)
    |> Enum.filter(fn
    {:error, cs} -> true
      _ -> false
    end)
    |> case do
         [] ->
           conn
           |> put_flash(:info, "Imported")
           |> redirect(to: Routes.live_home_path(conn, :index))
         errors ->
           errors = parse_errors(errors)  # create this fun
           conn
           |> put_flash(:erorr, errors)
           |> render("import.html")
       end
  end

  defp parse_errors(errors) do
    # errors
    :some_error
  end

end
