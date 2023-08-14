# frozen_string_literal: true

module AvatarCreator
    extend ActiveSupport::Concern
    included do
        def name_creator
            debugger
            profile = Profile.find_by(account_id: current_account.id)
            @user_name_for_api = profile.user_name.gsub(" ", "+")
            api_url = "https://ui-avatars.com/api/?name=#{user_name_for_api}"
        
            response = HTTParty.get(api_url)
        
            if response.success?
                image_data = response.body  # Assuming the image data is in the response body
                
                if image_data.present?
                  avatar_filename = "#{user_name_for_api}_avatar.jpg"  # Choose a suitable filename
          
                  profile.profile_picture.attach(io: StringIO.new(image_data), filename: avatar_filename, content_type: 'image/jpeg')
                end
            end
          end
    end
  end
  