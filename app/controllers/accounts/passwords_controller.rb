# frozen_string_literal: true

module Accounts
  class PasswordsController < Devise::PasswordsController

    def update
      format = params[:format]
      account = Account.find_by(id: params[:id])
      if account.update(password: format[:password])
        account.update(password: format[:password_confirmation])
        account.update(reset_password_token: params[:reset_password_token])
        redirect_to new_account_session_path
      else
        render :new
      end
    end

  end
end
