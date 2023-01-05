class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:contact]

  def show
    @customer = current_customer
	end

	def quit
	end

	def edit
    @customer = current_customer
	end

	def update
    @customer = current_customer
		if @customer.update(customer_params)
       flash[:success] = "登録情報を変更しました"
       redirect_to customers_path
    else
       render :edit
    end
	end

  def contact
  end

	private

	def customer_params
   params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :email, :postal_code, :residence, :phone_numbar)
  end

end
