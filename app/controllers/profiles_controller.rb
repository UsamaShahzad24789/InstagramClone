class ProfilesController < ApplicationController
    before_action :authenticate_account!
    
    def index
        if !Profile.account_has_profile(current_account.id).exists?
            redirect_to new_profile_path
        else
            @profile=Profile.find_by(account_id:current_account.id)
        end
    end

    def new
        @profile=Profile.new
    end
    
    def create
        @profile=Profile.new(profile_params)
        @profile.update(email:current_account.email,account_id:current_account.id)
        if @profile.save
            redirect_to profiles_path
        else
            render :new , status: :unprocessable_entity
        end
    end
    private
        def profile_params
            params.require(:profile).permit(:user_name,:profile_picture);
        end
end
