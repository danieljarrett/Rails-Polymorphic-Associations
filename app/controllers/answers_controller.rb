class AnswersController < ApplicationController
  include QuestionsHelper
  include AnswersHelper

  before_action :set_answer, only: [:edit, :update, :destroy]

  def new
    set_contexts

    @answer = Answer.new(question_id: params[:question_id])
  end

  def create
    set_contexts

    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to dyn_question_path(@context, @id, @answer.question), notice: 'Answer created.'
    else
      render :new
    end
  end
  
  def edit
    set_contexts
  end

  def update
    set_contexts

    if @answer.update(answer_params)
      redirect_to dyn_question_path(@context, @id, @answer.question), notice: 'Answer updated.'
    else
      render :edit
    end
  end

  def destroy
    set_contexts

    question = @answer.question
    @answer.destroy

    redirect_to dyn_question_path(@context, @id, question), notice: 'Answer destroyed.'
  end

  private

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:body, :user_id, :question_id)
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