class HomesController < ApplicationController
  def top
  end
  def about
    @image = HomeImage.find(1)
    @image = HomeImage.find(2)
    @image = HomeImage.find(3)
    @image = HomeImage.find(4)
    @image = HomeImage.find(5)
  end
end
