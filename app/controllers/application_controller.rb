class ApplicationController < ActionController::Base
  include SessionHelper
  include InvoicesHelper
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def get_i18n
    I18n.locale
  end
  def default_url_options
    {locale: I18n.locale}
  end
end
