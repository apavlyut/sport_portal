module UsersHelper
  
  def getUserRole(id, userid)
    if id
      if Role.find(:first, :conditions => ['id = ?', id])
        Role.find(id).rolename
      else
        'Роль не существует'
      end
    else
      'Роль не задана'
    end
  end
  
end