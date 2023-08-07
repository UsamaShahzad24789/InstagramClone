class ProfilesController < ApplicationController
    include CurrentProfile
    before_action :authenticate_account!
    skip_before_action :authenticate_account! ,only:[:after_registration_path,:after_confirmation_path]
    def index
        if !Profile.account_has_profile(current_account.id).exists?
            redirect_to new_profile_path
        else
            @profile=Profile.find_by(account_id:current_account.id)
            @posts=Post.where(profile_id:current_profile)
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

    def after_registration_path

    end
    def after_confirmation_path

    end

    private
        def profile_params
            params.require(:profile).permit(:user_name,:profile_picture);
        end
end
