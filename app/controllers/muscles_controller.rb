class MusclesController < ApplicationController
  def index
    @muscles = Muscle.find(:all)
  end
  
  def new
    @muscle = Muscle.new
    @musclular_group = MuscularGroup.find(params[:muscular_group_id])
  end
  
  def edit
    @muscle = Muscle.find(params[:id])
  end
  
  def show
    @muscle = Muscle.find(params[:id])
  end
  
  def create
    @muscle = Muscle.new(params[:muscle])
    @muscle.save
    if @muscle.errors.empty?
      flash[:notice] = "Мышца успешно добавлена"
      redirect_to @muscle
    else
      render new_muscle_url
    end
  end
  
  def update
    @muscle = Muscle.find(params[:id])
    
    if @muscle.update_attributes(params[:muscle])
      flash[:notice] = 'Мышца успешно изменена.'
      redirect_to @muscle
    else
      render :action => "edit"
    end
  end
  
  def destroy
    muscle = Muscle.find(params[:id])
    if muscle.destroy
      flash[:notice] = "Мышца успешно удалена"
      redirect_to muscles_url
    else
      flash[:error] = "Произошла ошибка при удалении мышцы."
      redirect_to muscles_url
    end
  end
end
