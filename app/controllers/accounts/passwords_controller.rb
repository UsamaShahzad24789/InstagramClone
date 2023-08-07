# frozen_string_literal: true

class Accounts::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    #manually updating password that is being sent thorugh params when set password form is submitted
    format=params[:format]
    account=Account.find_by(id:params[:id])
    if account.update(password:format[:password])
      account.update(password:format[:password_confirmation])
      account.update(reset_password_token:params[:reset_password_token])
      redirect_to new_account_session_path
    else
      render :new
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
