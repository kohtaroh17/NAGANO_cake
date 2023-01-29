class Public::OrdersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_customer!

  def new
  	@order = Order.new
  	@customer = current_customer
    @address = current_customer.addresses
	end

	def log
    @cart_items = current_customer.cart_items
 		@order = Order.new(order_params)
 		@order.postage = 800
 		@total_price = 0
 		@cart_items.each do |cart_item|
 		  @total_price += (cart_item.item.price * 1.1).floor * cart_item.amount
 		end 
 		
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.last_name +
                          current_customer.first_name

    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address     = ship.address
      @order.name        = ship.name

    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @ship = "1"

      unless @order.valid? == true
        @shipping_addresses = ShippingAddress.where(customer: current_customer)
        render :new
      end
    end
 	end

	def create
	  @address = current_customer.addresses
	  @customer = current_customer
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @total_price = 0
     if @order.save!
      @cart_items = current_customer.cart_items
       @cart_items.each do |cart_item|
         order_item = OrderItem.new(order_id: @order.id)
         order_item.price = cart_item.item.price
         order_item.amount = cart_item.amount
         order_item.item_id = cart_item.item_id
 		     @total_price += (cart_item.item.price * 1.1).floor * cart_item.amount
 		     order_item.save!
       end
       @cart_items.destroy_all
       redirect_to thanks_orders_path
       else
       render "new"
     end
  end

	def thanks
	end

	def index
    @orders = current_customer.orders.page(params[:page])
	end

	def show
	  @order = Order.find(params[:id])
    @order_items = @order.order_items
	end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
