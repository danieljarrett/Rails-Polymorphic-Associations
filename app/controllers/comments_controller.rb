class CommentsController < ApplicationController
  include QuestionsHelper
  include CommentsHelper

  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    set_contexts
    
    @comment = Comment.new(item_type: params[:item_type], item_id: params[:item_id])
  end

  def create
    set_contexts

    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to dyn_question_path(@context, @id, @comment.question), notice: 'Comment created.'
    else
      render :new
    end
  end
  
  def edit
    set_contexts
  end

  def update
    set_contexts

    if @comment.update(comment_params)
      redirect_to dyn_question_path(@context, @id, @comment.question), notice: 'Comment updated.'
    else
      render :edit
    end
  end

  def destroy
    set_contexts

    question = @comment.question
    @comment.destroy

    redirect_to dyn_question_path(@context, @id, question), notice: 'Comment destroyed.'
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :user_id, :item_type, :item_id)
    end

    def default_contexts
      [:user, :tag]
    end

    def set_contexts(array = default_contexts)
      array.each do |ctxt|
        if params["#{ctxt}_id".intern]
          @context = ctxt
          @id = params["#{ctxt}_id".intern]
          return
        end
      end

      @context = :none
    end
end