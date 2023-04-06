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
        role, status = if current_user.admin?
                         if params[:role] == 'super_admin'
                           raise InvalidParams, 'You are not authorized to perform this action'
                         end

                         [params[:role], params[:status]]

                       elsif current_user.super_admin?
                         [params[:role], params[:status]]
                       end

        object.update!(role: role, status: status)

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

      def role
        render json: {
          status: true,
          message: 'Login Successfully..!!',
          data: object.as_json(only: %i[session_token role])
        }
      end
    end
  end
end
