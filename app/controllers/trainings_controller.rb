class TrainingsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @training = Training.all
  end

  def show
    @training = Training.find(params[:id])
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    @training.user_id = current_user.id
    if @training.save
      redirect_to training_path(@training), notice: '投稿に成功しました。'
    else
      render :new
  end
  end

  def edit
    @training = Training.find(params[:id])
    if @training.user != current_user
      redirect_to trainings_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @training = Training.find(params[:id])
    if @training.update(training_params)
      redirect_to training_path(@training), notice: '更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    training = Training.find(params[:id])
    training.destroy
    redirect_to trainings_path
  end

  private
  def training_params
    params.require(:training).permit(:title, :body, :image, :comment)
  end
end
