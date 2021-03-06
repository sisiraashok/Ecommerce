class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :find_user, :find_product, only: %i[ new ]
  # GET /orders or /orders.json
  def index
    @orders = Order.all
    # @total_products_in_the_last_order= current_user.order.last.products
    # @total_amount_for_last_order= current_user.order.last.products.pluck(:price).inject(0,:+)

  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        # binding.pry
        # ProductOrder.create(product_order_params)
        @order.product_orders.create(product_order_params)
        format.html { redirect_to orders_url, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:total, :status, :user_id, :product_id)
    end

    def product_order_params
       params.require(:order).permit( :product_id, :quantity)
      # params.fetch(:user_id, :product_id, :quantity)
    end
    def find_user
      @user= User.find(params[:user_id])
    end

    def find_product
      @product= Product.find(params[:product_id])
    end
end
