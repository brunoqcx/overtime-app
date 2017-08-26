class AuditLogPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def confirm?
    record.user_id == user.id
  end
end
