defmodule Atmanirbhar.Repo do
  use Ecto.Repo,
    otp_app: :atmanirbhar,
    adapter: Ecto.Adapters.Postgres
  require Ecto.Query
  @tenant_key {__MODULE__, :org_id}

  def put_org_id(org_id) do
    Process.put(@tenant_key, org_id)
  end

  def get_org_id() do
    Process.get(@tenant_key)
  end

  def default_options(_operation) do
    [org_id: get_org_id()]
  end

  def prepare_query(operation, query, opts) do
    IO.puts "opts has org id?"
    IO.puts inspect(opts)
    cond do
      opts[:skip_org_id] -> {query, opts}

      org_id = opts[:org_id] ->
        {Ecto.Query.where(query, org_id: ^org_id), opts}

      true ->
        raise "expected org_id or skip_org_id to be set"
    end
  end


end
