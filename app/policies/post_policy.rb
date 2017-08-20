class PostPolicy < ApplicationPolicy
  def update?
    admin? || (user_owner && !post_approved?)
  end

  private
    def user_owner
      record.user_id == user.id || admin?
    end

    def post_approved?
      record.approved?
    end    
end
