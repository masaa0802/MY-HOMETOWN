class MapsController < ApplicationController
  def map
    @map = Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:address, :latitude, :longitude)
  end
end
