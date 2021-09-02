class HomeController < ApplicationController
  def index
    @search_params = animal_search_params
    @animals = Animal.search(@search_params)
    # @animals = Animal.all
  end

  private

  def animal_search_params
    params.fetch(:search, {}).permit(:species, :sex, :body, :color, :price)
  end
end
