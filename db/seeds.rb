# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

[
  { :id => 1, :type_id => 1, :full_name => '武藤嘉紀', :short_name => '武藤', :valid_st => 1 },
  { :id => 2, :type_id => 1, :full_name => '皆川佑介', :short_name => '皆川', :valid_st => 1 },
  { :id => 3, :type_id => 1, :full_name => '大迫勇也', :short_name => '大迫', :valid_st => 1 },
  { :id => 4, :type_id => 1, :full_name => '柿谷曜一朗', :short_name => '柿谷', :valid_st => 1 },
  { :id => 5, :type_id => 1, :full_name => '本田圭佑', :short_name => '本田', :valid_st => 1 },
  { :id => 6, :type_id => 1, :full_name => '岡崎慎司', :short_name => '岡崎', :valid_st => 1 },
  { :id => 7, :type_id => 1, :full_name => '柴崎岳', :short_name => '柴崎', :valid_st => 1 },
  { :id => 8, :type_id => 1, :full_name => '扇原貴宏', :short_name => '扇原', :valid_st => 1 },
  { :id => 9, :type_id => 1, :full_name => '森岡亮太', :short_name => '森岡', :valid_st => 1 },
  { :id => 10, :type_id => 1, :full_name => '田中順也', :short_name => '田中', :valid_st => 1 },
  { :id => 11, :type_id => 1, :full_name => '細貝萌', :short_name => '細貝', :valid_st => 1 },
  { :id => 12, :type_id => 1, :full_name => '長谷部誠', :short_name => '長谷部', :valid_st => 1 },
  { :id => 13, :type_id => 1, :full_name => '松原健', :short_name => '松原', :valid_st => 1 },
  { :id => 14, :type_id => 1, :full_name => '酒井高徳', :short_name => '酒井高', :valid_st => 1 },
  { :id => 15, :type_id => 1, :full_name => '坂井達弥', :short_name => '坂井', :valid_st => 1 },
  { :id => 16, :type_id => 1, :full_name => '酒井宏樹', :short_name => '酒井宏', :valid_st => 1 },
  { :id => 17, :type_id => 1, :full_name => '吉田麻也', :short_name => '吉田', :valid_st => 1 },
  { :id => 18, :type_id => 1, :full_name => '森重真人', :short_name => '森重', :valid_st => 1 },
  { :id => 19, :type_id => 1, :full_name => '長友佑都', :short_name => '長友', :valid_st => 1 },
  { :id => 20, :type_id => 1, :full_name => '水本裕貴', :short_name => '水本', :valid_st => 1 },
  { :id => 21, :type_id => 1, :full_name => '林彰洋', :short_name => '林', :valid_st => 1 },
  { :id => 22, :type_id => 1, :full_name => '西川周作', :short_name => '西川', :valid_st => 1 },
  { :id => 23, :type_id => 1, :full_name => '川島永嗣', :short_name => '川島', :valid_st => 1 },
  { :id => 24, :type_id => 1, :full_name => '遠藤保仁', :short_name => '遠藤', :valid_st => 1 },
  { :id => 25, :type_id => 1, :full_name => '香川真司', :short_name => '香川', :valid_st => 1 },
  { :id => 26, :type_id => 1, :full_name => '清武弘嗣', :short_name => '清武', :valid_st => 1 },
  { :id => 27, :type_id => 1, :full_name => '斎藤学', :short_name => '斎藤', :valid_st => 1 },
  { :id => 28, :type_id => 1, :full_name => '内田篤人', :short_name => '内田', :valid_st => 1 },
  { :id => 29, :type_id => 1, :full_name => '山口蛍', :short_name => '山口', :valid_st => 1 },
  { :id => 30, :type_id => 1, :full_name => '今野泰幸', :short_name => '今野', :valid_st => 1 },
  { :id => 31, :type_id => 1, :full_name => '権田修一', :short_name => '権田', :valid_st => 1 },
  { :id => 32, :type_id => 2, :full_name => '阿部慎之助', :short_name => '阿部', :valid_st => 1 },
  { :id => 33, :type_id => 2, :full_name => 'ダルビッシュ有', :short_name => 'ダルビッシュ', :valid_st => 1 },
  { :id => 34, :type_id => 2, :full_name => '田中将大', :short_name => '田中', :valid_st => 1 },
  { :id => 35, :type_id => 3, :full_name => 'EXILE', :short_name => 'EXILE', :valid_st => 1 },
  { :id => 36, :type_id => 3, :full_name => 'みのもんた', :short_name => 'みのもんた', :valid_st => 1 },
  { :id => 37, :type_id => 3, :full_name => '矢口真里', :short_name => '矢口', :valid_st => 1 },
].each do |record|
  player = Player.where(:id => record[:id]).first
  if player
    player.type_id = record[:type_id]
    player.full_name = record[:full_name]
    player.short_name = record[:short_name]
    player.valid_st = record[:valid_st]
  else
    player = Player.new(record)
  end
  player.save
end

[
  { :id => 1, :type_name => '4-4-2', :title => '4-4-2(ダイヤモンド)', :css_title => '4-4-2-a', :image_position => '{"1":{"x":"270","y":"100"},"2":{"x":"540","y":"100"},"3":{"x":"405","y":"320"},"4":{"x":"120","y":"450"},"5":{"x":"405","y":"580"},"6":{"x":"670","y":"450"},"7":{"x":"55","y":"790"},"8":{"x":"280","y":"830"},"9":{"x":"530","y":"830"},"10":{"x":"750","y":"790"},"11":{"x":"405","y":"1100"}}', :text_position => '' },
  { :id => 2, :type_name => '3-4-3', :title => '3-4-3(ダイヤモンド)', :css_title => '3-4-3-a', :image_position => '{"1":{"x":"405","y":"100"},"2":{"x":"160","y":"180"},"3":{"x":"650","y":"180"},"4":{"x":"130","y":"520"},"5":{"x":"405","y":"370"},"6":{"x":"670","y":"520"},"7":{"x":"405","y":"630"},"8":{"x":"180","y":"830"},"9":{"x":"405","y":"870"},"10":{"x":"630","y":"830"},"11":{"x":"405","y":"1100"}}', :text_position => '' },
].each do |record|
  formation = Formation.where(:id => record[:id]).first
  if formation
    formation.type_name = record[:type_name]
    formation.title = record[:title]
    formation.css_title = record[:css_title]
    formation.image_position = record[:image_position]
    formation.text_position = record[:text_position]
  else
    formation = Formation.new(record)
  end
  formation.save
end

[
  { :id => 1, :title => '伝説の酒豪', :description => '', :valid_player_type_ids => '[]' },
  { :id => 2, :title => 'アイドル', :description => '', :valid_player_type_ids => '[]' },
  { :id => 3, :title => '野球', :description => '', :valid_player_type_ids => '[]' },
].each do |record|
  question = Question.where(:id => record[:id]).first
  if question
    question.title = record[:title]
    question.description = record[:description]
    question.valid_player_type_ids = record[:valid_player_type_ids]
  else
    question = Question.new(record)
  end
  question.save
end

