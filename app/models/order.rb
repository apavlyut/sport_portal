class Order < ActiveRecord::Base
  has_many :orderings
  has_many :products, :through => :orderings
  
  # Добавляем продукт в модель
  def addProduct(product, amount)
    # Проверка наличия продукта в модели
    old_order = Ordering.find(:first, :conditions => ['order_id = ? and product_id = ?', self.id, product])
    # Либо наращиваем просто изменяем количество товара, если он уже добавлен в модель,
    # либо создаем новый элемент
    if old_order
      old_order.update_attributes(:amount => old_order.amount+amount)
    else
      new_order = Ordering.new(:order_id => self.id, :product_id => product, :amount => amount)
      new_order.save
    end
  end
  
  # Обновляем данные
  def updateProduct(product, amount)
    old_order = Ordering.find(:first, :conditions => ['order_id = ? and product_id = ?', self.id, product])
    if amount > 0
      old_order.update_attributes(:amount => amount)
    else
      old_order.destroy
    end
    
  end
  
  # Подсчитываем сумму заказа
  def sum
    orders = Ordering.find_all_by_order_id(self.id)
    sum = 0
    orders.each do |order|
      price = Product.find_by_id(order.product_id).price
      sum += price*order.amount
    end
    sum
  end
end
