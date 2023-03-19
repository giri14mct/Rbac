module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_super_admin!, only: %i[update destory]

      def update
        object.update!(status: params[:status])

        render json: {
          status: true,
          message: 'User updated successfully..!!'
        }
      end

      def destroy
        object.destroy!

        render json: {
          status: true,
          message: 'User updated successfully..!!'
        }
      end
    end
  end
end
