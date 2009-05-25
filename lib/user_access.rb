module UserAccess
  protected
  # def getAccessControllers(role)
  #   controllers = []
  #   for controller in UserAccessC.find_all_by_user_role(role)
  #     controllers << controller.controller
  #   end
  #   role = Role.find_by_rolename('Default').id
  #   if role
  #     for controller in UserAccessC.find_all_by_user_role(role)
  #       controllers << controller.controller
  #     end
  #   end
  #   controllers
  # end

  def getAccessActions(role, controller)
    actions = []
    for action in UserAccessAction.find(:all, :conditions => ['user_role = ? and controller = ?', role, controller])
      actions << action.action
    end
    if role = Role.find_by_rolename('Anonymouse')
      for action in UserAccessAction.find(:all, :conditions => ['user_role = ? and controller = ?', role.id, controller])
        actions << action.action
      end
    end
    actions
  end

  def hello!
    roles_active = System.find_by_key('roles_active').value
    if roles_active == 'true'
      access = true
      user_role = Role.find_by_id(current_user.role) if logged_in? and current_user.role
      user_role = Role.find_by_rolename('User') if logged_in? and !current_user.role
      
      role = user_role.id if user_role
      
      unless role
        if user_role = Role.find_by_rolename('Anonymouse')
          role = user_role.id
        end      
      end
      if role
        unless isAdmin?(role)
          current_controller = getCurrentController()
          actions = getAccessActions(role, current_controller)
          current_action = params['action']
          access = false if !actions.include?(current_action)
          if !access
            redirect_to root_url
            # render :text => "permissions!"
          end
        end
      end
    end
  end
  
  def getCurrentController
    controller = params['controller']
    cc = []
    cc = controller.split('_')
    current_controller = ''
    for c in cc
      current_controller += c.capitalize
    end
    current_controller
  end
  
  def isAdmin?(role)
    Role.find(role).rolename == 'Administrator'
  end
end