class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_genres, only: [:new, :edit, :index, :create, :update]
  before_action :authenticate_admin!

  def top
    now = Time.current
    @orders = Order.where(created_at: now.all_day)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Itrem.new(product_params)
    if @item.save
      flash[:notice] = "新商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def index
    @item = Item.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:success] = "商品内容をを変更しました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :explanation,
       :genre_id, :tax_out_price, :is_sale)
  end

  def set_genres
    @genres = Genre.where(is_valid: true)
  end
  
end
