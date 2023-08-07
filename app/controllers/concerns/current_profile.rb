module CurrentProfile
  extend ActiveSupport::Concern
  included do
    def current_profile
      account_id=current_account.id;
      profile=Profile.find_by(account_id:account_id)
      profile=profile.id
    end
  end
end
