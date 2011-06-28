class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :reload_i18n

  private
    def reload_i18n
      I18n.reload! if Rails.env == 'development'
    end
end
