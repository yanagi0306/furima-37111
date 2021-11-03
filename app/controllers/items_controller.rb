class ItemsController < ApplicationController
  def index
  end
  def new
    @item = Item.new

  end
  private
  def item_params
    params.require(:item).parameter(:name,:description,:status_id,:shipping_bearer_id,:shipping_day_id,:price,:prefecture_id,:category_name_id,:image)
  end
end
