# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def check_status
    if current_account.status == 'de_activated'
      redirect_to admins_status_path
    end
  end

  def role
    if current_account.role == 'admin'
      redirect_to admins_path
    end

  end
end
