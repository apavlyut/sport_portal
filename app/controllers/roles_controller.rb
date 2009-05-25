class RolesController < ApplicationController
  # GET /roles
  # GET /roles.xml
  layout 'application'
  def index
    @roles = Role.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = Role.find (params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @tree = getControllerActionsHash
    @role = Role.find(params[:id])
    @roles = Role.public_roles
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        format.html { redirect_to roles_path }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])
    cleanUpControllersActions(@role.id)
    @actions = params[:actions_titles]
    updateControllersActions(@actions, @role.id)
    # render :partial => "/stuff/gm"
    
    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to roles_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find(params[:id])
    if !isAdmin?(@role.id)
      @role.destroy
    end

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
  
  # Активация дисактивация системы ролей
  def activate
    @system = System.find_by_key('roles_active')
    # params[:system]['value'] = 0 if params[:system]['value'].nil?
    # params[:system]['value'] = params[:system]['value'].to_s
    @system.update_attributes(params[:system])
    redirect_to :back
    # render :text => params[:system]['value']
  end
  
  ######---------------------------
  # PRIVATES
  ######---------------------------
  private
  # Возвращаем хеш доступных контроллеров и методов
  def getControllerActionsHash
    role = Role.find_by_id(params['id'])
    tree = getAllControllers
    controllers_actions = {}
    for controller in tree
      mycontroller = controller.to_s+"Controller"
      all_actions = eval(mycontroller).public_instance_methods(false)
      controllers_actions[controller] = all_actions
    end 
    error1 = true if Role.find_by_rolename("Anonymouse").nil?
    error2 = true if Role.find_by_rolename("Admin only").nil?
    if role.rolename != "Anonymouse" and !error1
      not_include = getHashForRole("Anonymouse")
      controllers_actions = doNotInclude(controllers_actions, not_include)
    end
    if role.rolename != "Admin only" and !error2
      not_include = getHashForRole("Admin only")
      controllers_actions = doNotInclude(controllers_actions, not_include)
    end
    controllers_actions
  end
  
  # Возвращаем хеш разрешенных контроллеров и методов для роли
  def getHashForRole(rolename)
    role = Role.find_by_rolename(rolename)
    hash = {}
    if role
      all_actions = UserAccessAction.find(:all, :conditions =>['user_role = ?', role.id])
      for action in all_actions
        hash[action.controller] ||= []
        hash[action.controller] << action.action
      end
    end
    hash
  end
  
  # Сравниваем два массива и возвращаем разницу
  # Нужно, чтобы убрать все дефолтные и админские методы из дерева контроллеров-методов
  def doNotInclude(from, what)
    result = {}
    for controller in what
      for actions in controller[1]
        for action in actions
          if from[controller[0]]
            if from[controller[0]].include?(action)
              from[controller[0]].delete(action)
            end
          end
        end
      end
    end
    # @what = what
    # @from = from    
    # render :partial => "/stuff/gm", :fixtures => [@what, @from]
    @from = from
  end
  
  # Возвращаем массив контроллеров
  def getAllControllers
    controllers = Dir.new("#{RAILS_ROOT}/app/controllers").entries
    controllers_list = []
    controllers.each do |controller|
      if controller =~ /_controller/ 
        controller_title = controller.split('.')
        controller_name = controller_title[0].split('_')
        controller_names = ''
        for c in controller_name
          if(c!="controller")
            controller_names += c.capitalize
          end
        end
        controllers_list << controller_names
      end
    end
    controllers_list
  end

  # Удаляем все права у роли, дабы занести новые
  def cleanUpControllersActions(id)
    @actions = UserAccessAction.find_all_by_user_role(id)
    for action in @actions
      action.destroy
    end
  end
  
  # Обновляем права роли
  def updateControllersActions(actions, id)
    if actions
      for arr in actions
       for action in arr[1]
          new_access = UserAccessAction.new(:user_role => id, :action => action, :controller => arr[0])
          new_access.save
        end
      end
    end
  end
  
  
end
