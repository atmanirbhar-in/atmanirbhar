defmodule Atmanirbhar.Marketplace.AdvertisementAdmin do
  def widgets(_schema, _conn) do
    [
      %{
        type: "tidbit",
        title: "Advertisement count",
        content: length(Atmanirbhar.Marketplace.list_advertisements()),
        icon: "thumbs-up",
        order: 1,
        width: 4
      },
      %{
        type: "tidbit",
        title: "Directory listings",
        content: length(Atmanirbhar.Marketplace.list_shops()),
        icon: "thumbs-up",
        order: 2,
        width: 4
      },
      %{
        type: "tidbit",
        title: "Todays Deals",
        content: "0",
        icon: "thumbs-up",
        order: 3,
        width: 4
      },

      %{
        type: "tidbit",
        title: "Average Reviews",
        content: "4.7 / 5.0",
        icon: "thumbs-up",
        order: 5,
        width: 6,
      },
      %{
        type: "progress",
        title: "Pancakes",
        content: "Customer Satisfaction",
        percentage: 79,
        order: 4,
        width: 6,
      },
      %{
        type: "chart",
        title: "This week's Users",
        order: 8,
        width: 12,
        content: %{
          x: ["Mon", "Tue", "Wed", "Thu", "Today"],
          y: [150, 230, 75, 240, 290],
          y_title: "users"
        }
      }
    ]
  end
end
