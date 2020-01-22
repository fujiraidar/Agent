class Users::CommentsController < ApplicationController

    before_action :authenticate_user!

	def create
        @comment = Comment.new(comment_params)
        @help = @comment.help
        @comments = Comment.all
        @comment.user_id = current_user.id
        if @comment.save
            @comment = Comment.new
            # render :create
        end
    end

    private

    def comment_params
    	params.require(:comment).permit(:user_id, :help_id, :comment)
    end
end
