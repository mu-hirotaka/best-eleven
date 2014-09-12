class FormationController < ApplicationController
  def index
    @formations = {
      1 => { :title => '4-4-2(ダイアモンド)' },
      2 => { :title => '3-4-3' }
    }
  end
  def update
    redirect_to :selection_root
  end
end
