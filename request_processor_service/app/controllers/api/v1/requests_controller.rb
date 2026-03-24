class Api::V1::RequestsController < ApplicationController
    def create
        request = Request.find_by(request_id: params[:request_id])

        if request
          return render json: { message: "Already exists", status: request.status }, status: :ok
        end

        request = Request.new(request_params)

        if request.save
          ProcessRequestJob.perform_later(request.request_id)

          render json: { message: "Request accepted", id: request.request_id }, status: :created
        else
          render json: { errors: request.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def show
    
    end

    def cancel
    end

    private

    def request_params
        params.require(:request).permit(:request_id, :data)
    end
end
