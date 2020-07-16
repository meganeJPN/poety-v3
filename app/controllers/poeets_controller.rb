class PoeetsController < ApplicationController
  before_action :set_poeet, only: [:edit, :update,:destroy]
  def index
    @poeets = Poeet.all.order(id: :desc)
    @user = current_user
    # binding.pry
    # @user = User.find(@poeets.first.user_id)
    
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
    respond_to do |format|
      if params[:back]
        format.js {render :new} 
      else
        if @poeet.save
          format.js {redirect_to poeets_path,notice: 'ポイートしました'}
        else
          format.html { render :new }
          format.json { render json: @poeet.errors, status: :unprocessable_entity }
          format.js{ render :new}
        end
      end
    end
  end

  def edit
  end

  def destroy
    @poeet.destroy
    redirect_to poeets_path,notice:"ポイートを削除しました"
  end

  def update
    if params[:back]
      render :edit
    else
      if @poeet.update(poeet_params)
        redirect_to poeets_path,notice: "ポイートを編集しました"
      else
        render :edit
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
    params.require(:poeet).permit(:id, :content)
  end

  def set_poeet
    @poeet = Poeet.find(params[:id])
  end
end
