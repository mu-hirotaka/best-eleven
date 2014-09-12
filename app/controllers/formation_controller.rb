class FormationController < ApplicationController
  def index
    @formations = {
      1 => { :title => '4-4-2(ダイアモンド)', :type => '4-4-2' },
#      2 => { :title => '3-4-3', :type => '3-4-3' }
    }
  end
end
