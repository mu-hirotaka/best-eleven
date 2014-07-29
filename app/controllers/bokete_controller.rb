class BoketeController < ApplicationController
  def index
  end
  def select
  end
  def list
    @user_bokete_images = UserBoketeImage.all.order("id DESC")
  end
  def show

    @image_id = params[:image].to_i
    @comment = params[:comment].to_s

    UserBoketeImage.create(:base_image_id => @image_id, :comment => @comment, :image_id => 0)

    @user_bokete_images = UserBoketeImage.all.order("id DESC")

#    positions = {
#      1  => { :x => 30, :y => 30, :name => 'yasuda' }, 
#    }
#
#    base = Magick::Image.read("public/images/yasuda.png").first
#
#    # draw text
#    dr = Magick::Draw.new
#    dr.font = 'ヒラギノ丸ゴ-Pro-W4'
#    dr.stroke('transparent')
#    dr.fill('black')
#    dr.pointsize = 18
#    position = positions[image_id]
#    dr.text(position[:x], position[:y], comment)
#    dr.draw(base)
#
#    obj = UserBoketeImage.create(:base_image_id => image_id, :comment => comment, :image_id => 0)
#    base.write("public/images/output/bokete/#{obj.id}.png")
#    send_data(base.to_blob, :type => 'image/jpeg', :disposition => 'inline')
  end
end
