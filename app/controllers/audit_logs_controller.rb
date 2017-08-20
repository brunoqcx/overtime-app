class AuditLogsController < ApplicationController
  def index
    @audit_log = AuditLog.all
  end
end
