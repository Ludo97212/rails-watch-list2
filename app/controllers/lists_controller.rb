class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def index
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @lists = List.where(sql_query, query: "%#{params[:query]}%")
    else
      @lists = List.order(created_at: :desc).all
    end
  end

  def show
    set_list
  end

  def edit
    set_list
  end

  def update
    set_list
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    set_list
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
