defmodule AtmanirbharWeb.AudienceSliderComponent do
  use AtmanirbharWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
      <div class="audience-slider">
      <label>Audience</label>
    <input id="min" type="range" name="min" min="0" max="100" step="10" value="30" class="range-slider w-full" list="tickmarks">
        <input id="max" type="range" name="max" min="0" max="100" step="10" value="50" class="range-slider w-full" list="tickmarks">

        <datalist id="tickmarks" class="">
          <option value="0" label="newborn">New Born</option>
          <option value="10" label="toddler">Toddler</option>
          <option value="20">Pre School</option>
          <option value="30">School Going</option>
          <option value="40" label="college"></option>
          <option value="50"></option>
          <option value="60"></option>
          <option value="70"></option>
          <option value="80">Pets, Cat, Dogs</option>
          <option value="90">Plants & Garden</option>
          <option value="100" label="100%"></option>
        </datalist>
      </div>
    """
    end

  def handle_event("move", _, socket) do
    {:no_reply, socket}
  end


end
