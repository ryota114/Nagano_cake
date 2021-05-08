class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = Customer.find(current_customer.id)
  end 
  
  def edit
    @customer = Customer.find(current_customer.id)
  end 
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to my_page_path
  end 
  
  def unsubscribe
  end 
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    # ログアウトさせる
    reset_session
    redirect_to root_path
  end 
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :first_name_kana, :last_name, :last_name_kana,
                                     :postal_code, :address, :telephone_number, :email )
  end 
  
end
