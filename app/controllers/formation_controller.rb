class FormationController < ApplicationController
  def index
    @formations = Formation.all
  end
end
