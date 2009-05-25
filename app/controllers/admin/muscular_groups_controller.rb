class Admin::MuscularGroupsController < ApplicationController
  def index
    @muscular_groups = MuscularGroup.find(:all)
  end
  
  def edit
    @muscular_group = MuscularGroup.find(params[:id])
  end
  
  def show
    @muscular_group = MuscularGroup.find(params[:id])
  end
  
  def new
    @muscular_group = MuscularGroup.new
  end
  
  def create
    @muscular_group = MuscularGroup.new(params[:muscular_group])
    @muscular_group.save
    if @muscular_group.errors.empty?
      flash[:notice] = "Мышечная группа успешно создана"
      redirect_to admin_muscular_groups_url
    else
      flash[:error] = "Возникла ошибка при добавлении мышечной группы."
      render :action => "new"
    end
  end
  
  def destroy
    @muscular_group = MuscularGroup.find(params[:id])
    
    if @muscular_group.destroy
      flash[:notice] = "Мышечная группа успешно удалена!"
      redirect_to admin_muscular_groups_url
    end
  end
  
  def update
    @muscular_group = MuscularGroup.find(params[:id])
    if @muscular_group.update_attributes(params[:muscular_group])
      flash[:notice] = 'Мышца успешно изменена.'
      redirect_to admin_muscular_groups_url
    else
      render :action => "edit"
    end
  end
  
end
