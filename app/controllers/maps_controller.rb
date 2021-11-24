class MapsController < ApplicationController
  def map
    @maps = Map.all
  end
  
end
