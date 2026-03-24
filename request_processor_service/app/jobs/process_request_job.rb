class ProcessRequestJob < ApplicationJob
  queue_as :default

  retry_on StandardError, attempts: 3

  def perform(request_id)
    request = Request.find_by(request_id: request_id)

    return unless request
    return if request.completed? || request.cancelled?

    request.update(status: "processing")

    Rails.logger.info "Sidekiq processing request #{request_id}"

    sleep(3)

    if rand < 0.3
      raise "Random failure"
    end

    request.update(status: "completed")

  rescue => e
    request.update(status: "failed", error_message: e.message)
    Rails.logger.error "Error for #{request_id}: #{e.message}"
    raise e
  end
end