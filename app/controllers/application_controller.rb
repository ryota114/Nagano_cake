class ApplicationController < ActionController::Base
  # deviseの導入により、初期値以外のデータ操作の許可、今回の場合は登録時
  # devise利用の機能が使われる場合にその前にconfigure_permitted_parametersが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # ユーザー登録の際に,性、名などのデータ操作が許可される
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:last_name_kana,
                                                       :first_name_kana,:postal_code,:address,
                                                       :telephone_number,:is_deleted])
  end
end
