# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_link(name, options, ancor = false)
    unless link_to_unless_current(name, options).to_a.join("").include? "<a"
      "<a class='current'>#{name}&nbsp;&darr;</a>"
    else
      name = "#{name}&nbsp;&rarr;" if ancor
      link_to name, options
    end
  end
  
  def howManyNewMessages?
    my_messages = Message.find(:all, :conditions=>['(to_id = ? and status = 1) or (to_id = ? and status = 3)', current_user.id, current_user.id])
    '(новых: '+ my_messages.length.to_s + ')' if my_messages.length > 0
  end
  
  
end
