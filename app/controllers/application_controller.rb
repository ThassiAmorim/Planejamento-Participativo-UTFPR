class ApplicationController < ActionController::Base
  protected
  def after_sign_up_path_for(resource)
    users_path # Redireciona para a lista de usuários após o sign-up
  end
end
