# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  # customerがログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Customer)
      root_path
    end
  end
  
  # ログイン時に下記判定するように指示
  before_action :reject_inactive_customer, only: [:create]
  
  # もしcustomerのログインがあれば、アクティブなpasswordと、is_deletedのステータス(退会)によって
  # ログインさせず、エラーを吐く
  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
        flash[:error] = 'このアカウントは退会済みです。別のメールアドレスをご登録ください。'
        redirect_to new_customer_session_path
      end 
    end 
  end 
  
end
