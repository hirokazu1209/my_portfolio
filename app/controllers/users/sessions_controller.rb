class Users::SessionsController < Devise::SessionsController
  protected

  # ログアウト後のリダイレクト先を変更
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
