module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_admin!, only: %i[update destory]

      def index
        data, total_count = User.search_data

        render json: {
          status: true,
          data: data,
          total_count: total_count
        }
      end

      def update
        object.update!(status: params[:status])

        render json: {
          status: true,
          message: 'User Updated Successfully..!!'
        }
      end

      def destroy
        object.destroy!

        render json: {
          status: true,
          message: 'User Deleted Successfully..!!'
        }
      end
    end
  end
end
