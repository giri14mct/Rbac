module Api
  module V1
    class CommentsController < ApplicationController
      def create
        Comment.create!(create_params)

        render json: {
          status: true,
          message: 'Created Successfully..!!'
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
