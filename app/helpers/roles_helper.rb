module RolesHelper
  def is_cheked_controller?(controller)
    hehe = UserAccessC.find(:first, :conditions => ['user_role = ? and controller = ?', @role.id, controller])
    hehe
  end
  def is_checked_action?(controller, action)
    hehe = UserAccessAction.find(:first, :conditions => ['user_role = ? and action = ? and controller = ?', @role.id, action, controller])
    hehe
  end
end
