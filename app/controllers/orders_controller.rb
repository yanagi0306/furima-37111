class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_out_check
  def index

   @order_address = OrderAddress.new
  end
  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index

    end
  end

  private

  def order_address_params
    params.require(:order_address)
      .permit(
        :postal_code,
        :municipal,
        :house_number,
        :prefecture_id,
        :phone_number,
        :building,

      )
      .merge(token: params[:token],user_id:current_user.id,item_id:params[:item_id],user_id:current_user.id)
  end

  def sold_out_check
    @item = Item.find(params[:item_id])
    if @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = "sk_test_f80d565f34981075ecc075c5"
      Payjp::Charge.create(
        amount: @item.price,
        card: params[:token],
        currency: 'jpy'
      )
  end
end
