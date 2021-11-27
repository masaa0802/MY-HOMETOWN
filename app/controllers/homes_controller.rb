class HomesController < ApplicationController
  def top
  end
  def about
    @images = HomeImage.all
  end
end
