# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def check_status
    return unless current_account.status == 'de_activated'

    redirect_to admins_status_path
  end

  def role
    return unless current_account.role == 'admin'

    redirect_to admins_path
  end
end
