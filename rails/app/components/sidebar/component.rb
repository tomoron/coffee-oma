# frozen_string_literal: true

class Sidebar::Component < ViewComponent::Base
  def initialize(current_user:)
    @current_user = current_user
  end

  def user_signed_in?
    @current_user.present?
  end
end
