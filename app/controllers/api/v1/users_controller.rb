module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_admin!, only: %i[update destory]

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
          message: 'User Delted Successfully..!!'
        }
      end
    end
  end
end
