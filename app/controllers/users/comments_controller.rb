class Users::CommentsController < ApplicationController

	def create
        @comment = Comment.new(comment_params)
        @help = @comment.help
        @comments = Comment.all
        @comment.engineer_id = current_user.id
        if @comment.save
            @comment = Comment.new
            # render :create
        end
    end

    private

    def comment_params
    	params.require(:comment).permit(:engineer_id, :help_id, :comment)
    end
end
