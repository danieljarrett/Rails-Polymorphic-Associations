class QuestionsController < ApplicationController
  include QuestionsHelper

  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    set_context(
      user:   -> {
        @questions = User.find(params[:user_id]).questions
        @anchor = 'User: ' + User.find(params[:user_id]).username
      },
      tag:    -> {
        @questions = Tag.find(params[:tag_id]).questions
        @anchor = 'Tag: ' + Tag.find(params[:tag_id]).topic
      },
      none:   -> {
        @questions = Question.all
        @anchor = 'All'
      }
    )
  end

  def new
    set_context(
      user:   -> { @question = Question.new(user_id: params[:user_id]) },
      tag:    -> { @question = Question.new; @tags = Tag.find(params[:tag_id]).topic },
      none:   -> { @question = Question.new }
    )
  end

  def create
    set_context

    @question = Question.new(question_params)

    if @question.save
      redirect_to dyn_question_path(@context, @id, @question), notice: 'Question created.'
    else
      render :new
    end
  end

  def show
    set_context
  end
  
  def edit
    set_context

    @tags = @question.tags.reduce([]) do |array, tag|
      array << tag.topic
    end .join(', ')
  end

  def update
    set_context

    if @question.update(question_params)
      redirect_to dyn_question_path(@context, @id, @question), notice: 'Question updated.'
    else
      render :edit
    end
  end

  def destroy
    set_context

    @question.destroy

    redirect_to dyn_questions_path(@context, @id), notice: 'Question destroyed.'
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :user_id, :tagstring)
    end

    def default_contexts
      { user: -> {}, tag: -> {}, none: -> {} }
    end

    def set_context(hash = default_contexts)
      hash.except(:none).each do |ctxt, lmbd|
        if params["#{ctxt}_id".intern]
          @context = ctxt
          @id = params["#{ctxt}_id".intern]

          lmbd.call
          return
        end
      end

      @context = :none
      hash[:none].call
    end
end