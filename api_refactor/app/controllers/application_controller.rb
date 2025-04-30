# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      User.find_by(token:)
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
