defmodule AtmanirbharWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `AtmanirbharWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, AtmanirbharWeb.PincodeLive.FormComponent,
        id: @pincode.id || :new,
        action: @live_action,
        pincode: @pincode,
        return_to: Routes.pincode_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, AtmanirbharWeb.ModalComponent, modal_opts)
  end
end
