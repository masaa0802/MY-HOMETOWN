class MapsController < ApplicationController
  def map
    @maps = Map.all
  end

  def post_params
    params.require(:map).permit(:address, :latitude, :longitude)
  end
end
