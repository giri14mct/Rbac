module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_admin!, only: :update

      def create
        Comment.create!(create_params)

        render json: {
          status: true,
          message: 'Created Successfully..!!'
        }
      end

      def update
        status = if current_user.admin?
                   :approved
                 elsif current_user.super_admin?
                   :publised
                 end

        object.update(status: status, approved_by: current_user.id)
        render json: {
          status: true,
          message: 'Saved Successfully..!!'
        }
      end

      private

      def create_params
        params.require(:comment).permit(:content).merge(
          user_id: current_user.id
        )
      end
    end
  end
end
