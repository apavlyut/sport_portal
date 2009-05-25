class Admin::ExercisesController < ApplicationController
  
  def index
    @exercises = Exercise.find(:all)
  end
  
  def edit
    @exercise = Exercise.find(params[:id])
  end
  
  def update
    exercise = Exercise.find(params[:id])
    unless params[:muscular_group_ids].nil?
      params[:muscular_group_ids].each do |muscular_group_id|
        exercise.muscular_groups << MuscularGroup.find(muscular_group_id)
      end
    end
    
    if params[:first_image].size > 0 
      exercise.first_image = Image.new(:uploaded_data => params[:first_image])
    end unless params[:first_image].nil?
    
    if params[:middle_image].size > 0 
      exercise.middle_image = Image.new(:uploaded_data => params[:middle_image])
    end unless params[:middle_image].nil?
    
    if params[:last_image].size > 0 
      exercise.last_image = Image.new(:uploaded_data => params[:last_image])
    end unless params[:last_image].nil?
    
    if exercise.update_attributes(params[:exercise])
      flash[:notice] = 'Упражнение успешно изменено.'
      redirect_to admin_exercise_url(exercise)
    else
      render :action => "edit"
    end
  end
  
  def new
    @exercise = Exercise.new
  end
  
  def deattach_musclar_group
    exercise = Exercise.find(params[:exercise_id])
    muscular_group = MuscularGroup.find(params[:muscular_group_id])
    if exercise.muscles.include?(muscular_group)
      if exercise.muscles.delete(muscular_group)
        flash[:notice] = "Группа мышц успешно удалена из упражнения"
        redirect_to admin_exercise_url exercise
      else
        flash[:error] = "Произошла ошибка во время удаления мышцы из упражнения"
        redirect_to admin_exercise_url exercise
      end
    end
  end
  
  def create
    exercise = Exercise.new(params[:exercise])
    
    unless params[:muscular_group_ids].nil?
      params[:muscular_group_ids].each do |muscular_group_id|
        exercise.muscular_groups << MuscularGroup.find(muscular_group_id)
      end
    end
    
    if params[:first_image].size > 0 
      exercise.first_image = Image.new(:uploaded_data => params[:first_image])
    end unless params[:first_image].nil?
    
    if params[:middle_image].size > 0 
      exercise.middle_image = Image.new(:uploaded_data => params[:middle_image])
    end unless params[:middle_image].nil?
    
    if params[:last_image].size > 0 
      exercise.last_image = Image.new(:uploaded_data => params[:last_image])
    end unless params[:last_image].nil?
    
    if exercise.save
      flash[:notice] = 'Упражнение успешно создано'
      redirect_to admin_exercise_url(exercise)
    else
      render :action => "new"
    end
  end
  
  def show
    @exercise = Exercise.find(params[:id])
  end
  
  def deattach_muscle
    exercise = Exercise.find(params[:exercise_id])
    mg = MuscularGroup.find(params[:muscular_group_id])
    if exercise.muscular_groups.include? mg
      if exercise.muscular_groups.delete(mg)
        flash[:notice] = "Группа мышц убрана"
        redirect_to admin_exercise_url exercise
      else
        flash[:error] = "Произошла ошибка удаления мышечной группы из упражнения"
        redirect_to admin_exercise_url exercise
      end
    end
  end
  
  def destroy
    @exercise = Exercise.find(params[:id])
    
    if @exercise.destroy
      flash[:notice] = "Упражнение усешно удалено!"
      redirect_to admin_exercises_url
    end
  end
  
end
