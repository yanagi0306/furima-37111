class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_item, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    unless @item.user.id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params
      .require(:item)
      .permit(
        :name,
        :description,
        :status_id,
        :shipping_bearer_id,
        :shipping_day_id,
        :price,
        :prefecture_id,
        :category_name_id,
        :image,
      )
      .merge(user_id: current_user.id)
  end
end
