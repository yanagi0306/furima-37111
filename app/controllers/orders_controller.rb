class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check
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
    params
      .require(:order_address)
      .permit(
        :postal_code,
        :municipal,
        :house_number,
        :prefecture_id,
        :phone_number,
        :building
      )
      .merge(
        token: params[:token],
        user_id: current_user.id,
        item_id: params[:item_id]
      )
  end

  def check
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.order.present? || @item.user_id == current_user.id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
