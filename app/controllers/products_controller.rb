class ProductsController < ApplicationController


  def index
    @products = Product.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
    @vendors = Vendor.all
    @order_item = current_order.order_items.new

    if params[:category1]
      @products = Product.where(:category1 => params[:category1])
    else
      
    end
    @products = @products.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)

    if params[:vendor]
      @vendor = Vendor.find(params[:vendor])
    else
      @vendor = Vendor.all
    end
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
  end

  def reserve_product
    @product = Product.find(params[:id])
    data = request.parameters
    quant = data[:qty]
    @product.reserve(quant)
    redirect_to @product
  end

  def buy
    @product = Product.find(params[:id])
    # @order_item = current_order.order_items.new
  end

  def trending
    @products = Product.all.order("created_at DESC")
    @vendors = Vendor.all
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :moq, :when_ready, :brand, :sku, :properties, :msrp, :vendor_id, :category1, :category2, :upc, :restructions, :warehouse_zip, :warranty, :link1, :link1_title, :link2, :link2_title, :restrictions, :image)
  end

end
