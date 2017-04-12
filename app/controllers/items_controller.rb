class ItemsController < ApplicationController
before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @items = Item.where(:user_id => current_user.id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  @item.destroy
  respond_to do |format|
    format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    format.json { head :no_content }
  end
end

  private

    def item_params
      params.require(:item).permit(:title, :description)
    end

    def find_item
      @item = Item.find(params[:id])
    end
end
