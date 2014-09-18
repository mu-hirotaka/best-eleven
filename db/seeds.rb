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

