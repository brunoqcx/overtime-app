module Admin

  def self.admin_types
    ['AdminUser']
  end

  class ApplicationController < Administrate::ApplicationController
    before_filter :authenticate_user!
    before_filter :authenticate_admin

    def authenticate_admin
      unless Admin.admin_types.include?(current_user.try(:type))
        flash[:alert] = 'You are no authorized'
        redirect_to(root_path)
      end
    end
  end
end
