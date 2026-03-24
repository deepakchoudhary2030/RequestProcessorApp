class Request < ApplicationRecord
    STATUSES = %w[pending processing completed failed cancelled]

    validates :request_id, presence: true, uniqueness: true
    validates :status, inclusion: { in: STATUSES }

    before_validation :set_default_status, on: :create

    def set_default_status
        self.status ||= "pending"
    end

    def completed?
        status == "completed"
    end

    def cancelled?
        status == "cancelled"
    end
end
