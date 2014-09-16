class QuestionController < ApplicationController
  def index
    @questions = {
      1 => {
        :id => 1,
        :title => '伝説の酒豪',
        :description => '酒豪ベストイレブン',
        :validTypeIds => [],
      },
      2 => {
        :id => 2,
        :title => 'アイドル',
        :description => 'アイドルベストイレブン',
        :validTypeIds => [],
      },
      3 => {
        :id => 3,
        :title => '野球',
        :description => '野球ベストイレブン',
        :validTypeIds => [],
      },
    }
  end
end
