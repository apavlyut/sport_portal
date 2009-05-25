class CartController < ApplicationController
  
  # Показать карзину
  def show
    cart = findCart
    if cart 
      @orders = Ordering.find_all_by_order_id(cart.id)
      @sum = cart.sum
    end
  end
  
  # Уничтожение корзины
  def removeCart
    cart = findCart
    orders = Ordering.find_all_by_order_id(cart.id)
    orders.each do |order|
      order.destroy
    end
    cart.destroy
    redirect_to '/shop/'
  end
  
  # Оформить заказ
  def makeOrder
    order = findCart
    params[:data]['status'] = 2
    order.update_attributes(params[:data])
    redirect_to '/shop/'
  end


  private
  # Найти корзину
  def findCart
    id = @current_user.id if logged_in?
    id = session[:aid] unless logged_in?
    cart = Order.find_by_user_id(id, :conditions => ['status = ?', 1])
  end
  
  
end
