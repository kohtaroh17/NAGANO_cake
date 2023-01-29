class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:contact]

  def show
    @customer = current_customer
	end

	def edit
	  @customer = current_customer
	end

	def quit
	  @customer = current_customer
	end

  def update
        @customer = current_customer
        if @customer.update(customer_params)
        flash[:update] = "You have updated user info successfully."
        redirect_to customer_path(@customer.id)
        else
        render 'edit'
        end
    end

  def quit
        # @customer = Customer.find(current_customer.id)
        # @customer.update(is_deleted: true)
        # reset_session
        # flash[:notice] = "Thank you for the good rating. We hope to see you again."
        # redirect_to root_path
        
    end
    
  def out
        @customer = Customer.find(current_customer.id)
        @customer.update(is_deleted: true)
        reset_session
        flash[:notice] = "Thank you for the good rating. We hope to see you again."
        redirect_to root_path
  end
    

	private

	def customer_params
   params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :postal_code, :address, :phone_number)
  end

end
