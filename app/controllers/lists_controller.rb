class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
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

  def my_lists
    @lists = List.where(user_id: current_user.id)
  end

  def show
    set_list
  end

  def edit
    set_list
  end

  def update
    set_list
    if @list.user == current_user
      if @list.update(list_params)
        redirect_to list_path(@list)
      else
        render :edit
      end
    else
      flash[:alert] = "Vous n'avez pas l'autorisation !!!"
      redirect_to list_path(@list)
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
