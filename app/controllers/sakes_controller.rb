class SakesController < ApplicationController
  before_action :authenticate_user! 

  def top
  end

  def index
    @sakes = Sake.all
    @sakes = @sakes.page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def new
    @sake = Sake.new
    @sake = current_user.sakes.new
  end
  
  def create
    @sake = current_user.sakes.new(sake_params)           
    tag_list = params[:sake][:tag_name].split(nil)  
    if @sake.save
      @sake.save_tag(tag_list)                                                           
      redirect_to sakes_path      
    else
      redirect_to new_sake_path         
    end
  end

  def show
    @sake = Sake.find(params[:id])
    @sake_tags = @sake.tags
  end

  def edit
    @sake = Sake.find(params[:id])
    @tag_list=@sake.tags.pluck(:tag_name).join(nil)
  end

  def update
    sake = Sake.find(params[:id])
    tag_list = params[:sake][:tag_name].split(nil)
    if sake.update(sake_params)
      old_relations = TagMap.where(sake_id: sake.id)
      old_relations.each do |relation|
        relation.delete
      end
      sake.save_tag(tag_list)
      redirect_to sake_path(sake.id), notice:'投稿完了しました:)'
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    sake = Sake.find(params[:id])
    sake.destroy
    redirect_to :action => "index"
  end

  def search
    @tag_list = Tag.all               
    @tag = Tag.find(params[:tag_id])  
    @sakes = @tag.sakes.all           
  end

  def sake_params
    params.require(:sake).permit(:cocktail, :image, :body)
  end
end
