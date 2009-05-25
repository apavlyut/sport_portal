module MessagesHelper
  
  def getClass(status)
    cl = 'new_message'         if status.to_i == 1
    cl = 'message'             if status.to_i == 2
    cl = 'new_system_message'  if status.to_i == 3
    cl = 'system_message'      if status.to_i == 4
    cl
  end
  
end
