class PoeetsController < ApplicationController
  before_action :set_poeet, only: [:edit, :update,:destroy, :show]
  def index
    @poeets = Poeet.all.order(id: :desc)
    @user = current_user
    @favorites = current_user.favorites
  end

  def new
    @poeet = Poeet.new
    respond_to do |format| 
      format.html{ redirect_to @poeet, notice: 'ポイートしました' }
      format.js {} 
    end
  end

  def create
    @poeet = current_user.poeets.build(poeet_params)
    @user = current_user
    respond_to do |format|
      if params[:back]
        format.js {render :new} 
      else
        if @poeet.save
          ContactMailer.contact_mail(@poeet).deliver  ##追記
          format.js {redirect_to poeets_path,notice: 'ポイートしました'}
        else
          format.html { render :new }
          format.json { render json: @poeet.errors, status: :unprocessable_entity }
          format.js{ render :new}
        end
      end
    end
  end

  def show
    respond_to do |format| 
      format.html{ redirect_to @poeet }
      format.js {} 
    end
  end

  def edit
     if @poeet.user_id != current_user.id
      redirect_to poeets_path, notice: "あなたのポイートではありません"
    end
  end

  def destroy
    if @poeet.user_id == current_user.id
      @poeet.destroy
      redirect_to poeets_path,notice:"ポイートを削除しました"
    else
      redirect_to poeets_path, notice: "あなたのポイートではないので削除できません。"
    end
  end

  def update
    if params[:back]
      render :edit
    else
      if @poeet.user_id == current_user.id
        if @poeet.update(poeet_params)
          redirect_to poeets_path,notice: "ポイートを編集しました"
        else
          render :edit
        end
      else
        redirect_to poeets_path,notice: "あなたのポイートではありません"
      end
    end
  end

  def confirm
    @poeet = current_user.poeets.build(poeet_params)
    @poeet.id = params[:id]
    logger.debug("action_name")
    logger.debug(action_name)
    respond_to do |format| 
      if @poeet.invalid?
        if @poeet.id?
          format.html { render :edit }
          format.js{ render :edit}
        else
          format.html { render :new }
          format.js{ render :new}
        end
      else
        format.html {redirect_to poeets_path, notice: 'ポイートしました'}
        format.json { render :index, status: :created, location: @poeet }
        format.js { @status = "success"}
      end
    end
  end

  private
  def poeet_params
    params.require(:poeet).permit(:id, :content, :image, :image_cache)
  end

  def set_poeet
    @poeet = Poeet.find(params[:id])
  end
end
