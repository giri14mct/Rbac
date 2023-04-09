module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_admin!, only: :update

      def index
        data, total_count = check_role_is_admin? ? Comment.search_data : Comment.search_data(status: :published)

        render json: {
          status: true,
          data: data,
          total_count: total_count
        }
      end

      def create
        Comment.create!(create_params)

        render json: {
          status: true,
          message: 'Created Successfully..!!'
        }, status: :created
      end

      def update
        if current_user.admin? && params[:status] == 'published'
          raise InvalidParams, 'You are not authorized to perform this action'
        end

        object.update!(status: params[:status], approved_by: current_user.id)

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

      def check_role_is_admin?
        current_user.admin? || current_user.super_admin?
      end
    end
  end
end
