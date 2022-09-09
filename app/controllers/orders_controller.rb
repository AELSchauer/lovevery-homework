class OrdersController < ApplicationController
  def new
    @order = Order.new(product: Product.find(params[:product_id]))
  end

  def create
    user = User.find_or_create_by(user_params)
    @order = Order.create(order_params.merge(user: user, user_facing_id: SecureRandom.uuid[0..7]))
    if @order.valid?
      Purchaser.new.purchase(@order, credit_card_params)
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
    @order = Order.find_by(id: params[:id]) || Order.find_by(user_facing_id: params[:id])
  end

private

  def order_params
    params.require(:order).permit(:shipping_name, :product_id, :zipcode, :address).merge(paid: false)
  end

  def user_params
    {
      full_name: params.require(:order)[:user_full_name],
      parent_name: params.require(:order)[:shipping_name],
      birthdate: Date.parse(params.require(:order)[:user_birthdate]),
    }
  end

  def credit_card_params
    params.require(:order).permit( :credit_card_number, :expiration_month, :expiration_year)
  end
end
