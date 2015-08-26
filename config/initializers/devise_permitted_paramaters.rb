module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :handle
    devise_parameter_sanitizer.for(:account_update) << :handle
  end

end

DeviseController.include DevisePermittedParameters