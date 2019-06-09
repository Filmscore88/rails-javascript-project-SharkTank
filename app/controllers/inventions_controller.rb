class InventionsController < ApplicationController

  def index
    @inventions= Invention.all
  end

  def new

    @invention= Invention.new(inventor_id: params[:inventor_id])

  end

  def create
    @inventor= Inventor.find_by(id: params[:invention][:inventor_id])

    @invention= @inventor.inventions.build(invention_params)
    @invention.save

    if @invention

      redirect_to inventor_invention_path(@inventor, @invention)
    else
      render :new
    end
  end

  def show
    @invention= Invention.find_by(id: params[:id])
  end

  def edit
  end

  def update

  end

  private

  def invention_params

    params.require(:invention).permit(:id, :name, :description, :inventor_id)
  end

end
