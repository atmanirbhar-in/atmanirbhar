defmodule Atmanirbhar.Catalog.MasterData do

  def list do
  end

  # Blueprint of
  def examples do
    [
      %{
        product: "birthday cake",
        variants: "chocolate, butterscotch, redvelvet",
        ocassion: "birthday, anniversary, promotion",
        audience: "all"
      },
      %{
        product: "ghee",
        when: "festive, casual, food ingredients"
      },
      %{
        product: "food item - sweet",
        name: "Rasgulla"
      },
      %{
        product: "fashion blouse",
        audience: "women"
      },
      %{
        product: "Rangoli"
      },
      %{
        product: "bhagwan vastra",
        ocassion: "festival"
      }
    ]
  end

end
