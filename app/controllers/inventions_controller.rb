class InventionsController < ApplicationController
  before_action :inventor_only, except: [:index, :show]


  def index
    @inventions= Invention.all
    respond_to do |format|
     format.html { render :index }
     format.json {render json: @inventions}
    end
  end


  def new
    if params[:user_id].to_i != current_user.id
      redirect_to inventions_path
    else
      @invention= Invention.new(user_id: params[:user_id])
    end
  end

  def create
    @user= User.find_by(id: current_user.id)
    @invention= @user.inventions.build(invention_params)
      if @invention.save
        render json: @invention
      else
        flash[:notice]= 'ERROR: Invalid Entry'
        render :new
      end
  end


  def show
    @invention= Invention.find_by(id: params[:id])
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @invention}
    end
  end


  private

  def invention_params
    params.require(:invention).permit(:name, :description, :user_id)
  end
end
