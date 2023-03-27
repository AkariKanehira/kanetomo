class SakesController < ApplicationController
  before_action :authenticate_user! 
  def index
    @sakes = Sake.all
    @sakes = @sakes.page(params[:page]).per(5)
  end

  def new
    @sake = Sake.new
  end
  
  def create
    sake = Sake.new(sake_params)
    sake.user_id = current_user.id
    if sake.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end
  def show
    @sake = Sake.find(params[:id])
  end
  def edit
    @sake = Sake.find(params[:id])
  end
  def update
    sake = Sake.find(params[:id])
    if sake.update(sake_params)
      redirect_to :action => "show", :id => sake.id
    else
      redirect_to :action => "new"
    end
  end
  def destroy
    sake = Sake.find(params[:id])
    sake.destroy
    redirect_to :action => "index"
  end
  def sake_params
    params.require(:sake).permit(:cocktail, :image, :body)
  end
end
