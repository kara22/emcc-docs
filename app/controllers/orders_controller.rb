class OrdersController < ApplicationController

  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all.order(:order_date)
  end

  def new
    @order = Order.new
  end

  def create
   @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
        redirect_to root_path
    else
        render :new
    end
  end

  def show
  end

  def edit
  end

  def update
      @order.update(order_params)
      flash[:notice] = "Confirmation: vous avez édité un bon de commande"
      redirect_to root_path

  end

  def destroy
   if @order.user == current_user || current_user.author?
     @order.destroy
     flash[:notice] = "Confirmation: vous avez supprimé une commande"
     redirect_to root_path
    else
      flash[:alert] = "Vous n'avez pas posté cette commande, donc la suppression est impossible."
      redirect_to root_path
    end
  end

  private

   def order_params
    params.require(:order).permit(:entity, :supplier,:order_number ,:order_date , :designation, :total_price, :order_signatory, :delivery_scheduled, :bon_de_commande)
  end

  def find_order
  @order = Order.find(params[:id])
  end

end
