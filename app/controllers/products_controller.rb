class ProductsController < ApplicationController
 # layout 'shop'
  before_filter :showCart

  # Покажем корзину
  # def showCart
  #   session[:aid] ||= rand(1000000)+1000000 unless logged_in?
  #   unless @cart = isSetCart?
  #     @cart = Order.new(:user_id => @current_user.id, :status => 1, :login => @current_user.login) if @current_user
  #     @cart = Order.new(:user_id => session[:aid], :status => 1, :login => 'Anonymouse') unless @current_user
  #     @cart.save
  #   end
  #   @cart
  # end
  # 
  # #Проверим, существует ли корзина
  # def isSetCart?
  #   status = 1
  #   id = @current_user.id if @current_user
  #   id = session[:aid] unless logged_in?
  #   @cart = Order.find(:first, :conditions => ['user_id = ? and status = ?', id, status])
  # end

  # GET /products
  # GET /products.xml
  def index
    if request.request_uri == "/products"
      redirect_to '/shop/'
    else
      loadProducts
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @products }
      end
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @categories = Category.find(:all, :order => 'lft ASC')
    @categories.each do |c|
      spaces = "-" * c.level.to_i
      c['title'] = spaces+c['title']
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @categories = Category.find(:all, :order => 'lft ASC')
  end

  # POST /products
  # POST /products.xml
  def create
    params[:image]['title'] = params[:product]['title']
    @image = Image.new(params[:image])
    if @image.save
      params[:product]['image_id'] = @image.id
    end
    @product = Product.new(params[:product])
    @product.save
    
    # Если нет ни одной категории в базе он выдавал ошибку при создании нового товара
    if params[:product]['category_ids']
      params[:product]['category_ids'].each do |c|
        categorization = Categorization.new(:category_id => c, :product_id => @product.id)
        categorization.save
      end
    end
    # render :partial => "/stuff/gm"
    respond_to do |format|
      if 
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    @image_old = Image.find(@product.image_id)
    if params[:product]['title']
      params[:image]['title'] = params[:product]['title']
      @image = Image.new(params[:image])
      if @image.save
        params[:product]['image_id'] = @image.id
        @image_old.destroy()
      end
    end
    cats = Categorization.find_all_by_product_id(@product.id)
    cats.each do |cs|
      cs.destroy
    end
    params[:product]['category_ids'].each do |c|
      categorization = Categorization.new(:category_id => c, :product_id => @product.id)
      categorization.save
    end
    

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @image = Image.find(@product.image_id)
    @cp = Categorization.find_all_by_product_id(@product.id)
    @cp.each do |c|
      c.destroy
    end
    @product.destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  def addToCart
    amount = 1
    amount = params[:amount].to_i if params[:amount]
    createCart unless @cart
    @cart.addProduct(params[:id], amount)
    redirect_to :back
  end
  
  def updateCart
    amount = 0
    amount = params[:amount].to_i if params[:amount]
    @cart.updateProduct(params[:id], amount)
    redirect_to :back
  end
  
  
  protected
  
  # Загрузка продуктов по категориям
  def loadProducts
    unless params['title'].nil?
      @category = Category.find_by_transcrib(params['title'].capitalize)
      unless @category.nil?
        if (@category.rgt - @category.lft) > 1
          @categories = Category.find(:all, :conditions => ['lft > ? and lft < ?', @category.lft, @category.rgt])
          @products = []
          @categories.each do |c|
            @products += c.products.find(:all)
          end
          @products = @products.paginate :per_page => 16, :page => params[:page]
        else
          @products = @category.products.paginate :per_page => 16, :page => params[:page]
        end
      else
        findAllProducts
      end
    else
      findAllProducts
    end
  end
  
  # Найти все товары
  def findAllProducts
    @products = Product.paginate :per_page => 16, :page => params[:page]
  end
  
  # Показать карзину
  def showCart
    status = 1
    id = @current_user.id if logged_in?
    id = session[:aid] unless logged_in?
    session[:aid] ||= rand(1000000)+1000000 unless logged_in?
    @cart = Order.find(:first, :conditions => ['user_id = ? and status = ?', id, status])
    @orders = Ordering.find_all_by_order_id(@cart.id) if @cart
    @sum = @cart.sum if @cart
  end
  
  #Создадим корзину
  def createCart
    @cart = Order.new(:user_id => @current_user.id, :status => 1, :login => @current_user.login) if logged_in?
    @cart = Order.new(:user_id => session[:aid], :status => 1, :login => 'Anonymouse') unless logged_in?
    @cart.save    
  end
end
