class GiftsController < ApplicationController
  def new
    @gift = Gift.new(
      order: Order.new(product: Product.find(params[:product_id])),
      child: Child.new(
        user: User.new
      )
    )
  end
  
  def create
    @child = Child.joins(:user).find_by(users: user_params.to_h, children: child_params.to_h)
    @order = Order.create(order_params.merge(child: @child, user_facing_id: SecureRandom.uuid[0..7]))
    @gift = Gift.create(gift_params.merge(child: @child, order: @order))
    if @gift.valid?
      Purchaser.new.purchase(@order, credit_card_params)
      redirect_to gift_path(@gift)
    else
      @errors = @gift.errors.full_messages
        .concat(@gift.order.errors.full_messages)
        .uniq
        .map { |e| e == "Shipping name can't be blank" ? nil : e }
        .compact
        .map { |e| e == "Child must exist" ? "Unable to locate child shipping based on information provided" : e }
      @gift = Gift.new(
        gift_params.merge(
          order: @order,
          child: Child.new(
            child_params.merge(user: User.new(user_params))
          )
        )
      )
      render :new
    end
  end

  def show
    @gift = Gift.find_by(id: params[:id]) || Gift.find_by(user_facing_id: params[:id])
  end
  
  private

  def order_params
    latest_shipping_details = @child.try(:latest_shipping_details)

    params.require(:gift).permit(:product_id).merge({
      shipping_name: latest_shipping_details.try(:shipping_name),
      address: latest_shipping_details.try(:address),
      zipcode: latest_shipping_details.try(:zipcode),
      paid: false
    })
  end

  def gift_params
    params.require(:gift).permit(:purchaser_name, :purchaser_email, :gift_message)
  end

  def child_params
    params.require(:child).permit(:full_name, :birthdate)
  end

  def user_params
    params.require(:user).permit(:full_name)
  end

  def credit_card_params
    params.require(:gift).permit(:credit_card_number, :expiration_month, :expiration_year)
  end
end
