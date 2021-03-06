class QuestionsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
      @questions = Question.all
  end

  def new
    if params[:back]
      @question = Question.new(questions_params)
      @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    else
      @question = Question.new
    end
  end

  def create
    @question = Question.new(questions_params)
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    # @question.user_id = current_user.id
    if @question.save
      redirect_to root_path, notice:"投稿されました"
    else
      redirect_to root_path, alert:"未入力の項目があります"
      @question = Question.new(questions_params)
    end
  end

  def edit
  end

  def update
    @question.update(questions_params)
    redirect_to questions_path, notice:"投稿を更新しました"
  end

  def destroy
    @question.destroy
    redirect_to root_path, alert:"投稿を削除しました"
  end

  def show
  end

  private
    def questions_params
      params.require(:question).permit(:title,:content)
    end
    def set_question
      @question = Question.find(params[:id])
    end
end
