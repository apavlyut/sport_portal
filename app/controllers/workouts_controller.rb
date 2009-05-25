class WorkoutsController < ApplicationController
  include WorkoutModeler
  
  def index
    @workouts = []
    #current_user.workouts.each do |workout|
    #  workout.destroy unless workout.is_complete
    #end if current_user
    @workouts = current_user.workouts if current_user
  end
  
  def print_version
    @workout = Workout.find(params[:id])
    render :layout => 'print'
  end
  
  def show
    @workout = Workout.find(params[:id])
  end
  
  def new
    @workout = current_user.workouts.new
  end
  
  def step_1
    unless params[:days]
      render :update do |page|
        page.alert "Необходимо выбрать хотябы один день!"
      end
    else
      @workout = current_user.workouts.create
      params[:days].each do |day_n|
        @workout.days.create(:day_number => day_n)
      end
      render :update do |page|
        page["step-1"].removeClass "empty_widget"
        page["step-1-title"].addClass "with_icon_ok"
        page["step-1-content"].replace_html ""
        
        page["step-2"].removeClass "upcoming"
        page["step-2"].addClass "empty_widget"
        page["step-2-content"].replace_html :partial => "step2"
      end
    end
  end
  
  def step_2
    @workout = Workout.find(params[:workout_id])
    params[:days].each do |day_id, muscular_groups|
      day = Day.find(day_id)
      muscular_groups.each do |group_id|
        day.muscular_groups << MuscularGroup.find(group_id)
      end
    end unless params[:days].nil?
    
    render :update do |page|
      page["step-2"].removeClass "empty_widget"
      page["step-2-title"].addClass "with_icon_ok"
      page["step-2-content"].replace_html ""
      
      page["step-3"].removeClass "upcoming"
      page["step-3"].addClass "empty_widget"
      page["step-3-content"].replace_html :partial => "step3"
    end
  end
  
  def step_3
    @workout = Workout.find(params[:workout_id])
    render :update do |page|
      page["step-3"].removeClass "empty_widget"
      page["step-3-title"].addClass "with_icon_ok"
      page["step-3-content"].replace_html ""
      
      page["step-4"].removeClass "upcoming"
      page["step-4"].addClass "empty_widget"
      page["step-4-content"].replace_html :partial => "step4", :locals => { :workout => @workout }
    end
  end
  
  def step_4
    @workout = Workout.find(params[:workout_id])
    render :update do |page|
      page["step-4"].removeClass "empty_widget"
      page["step-4-title"].addClass "with_icon_ok"
      page["step-4-content"].replace_html ""
      
      page["step-5"].removeClass "upcoming"
      page["step-5"].addClass "empty_widget"
      page["step-5-content"].replace_html :partial => "step5", :locals => { :workout => @workout }
    end
  end
  
  def step_5
    @workout = Workout.find(params[:workout_id])
    
    @workout.training_mode_id = params[:training_mode_id]
    @workout.difficult_level_id = params[:difficult_level_id]
    @workout.age_level_id = params[:age_level_id]
    @workout.gender = params[:gender]
    @workout.description = params[:description]
    @workout.occupacy_id = params[:occupacy_id]
    @workout.goal_id = params[:goal_id]
    @workout.is_complete = true
    @workout.save!
    if @workout.errors.empty?
      redirect_to workouts_url
    else
      
    end
    #  
    #render :update do |page|
    #  page["step-5"].removeClass "empty_widget"
    #  page["step-5-title"].addClass "with_icon_ok"
    #  page["step-5-content"].replace_html ""
    #  
    #  page["step-6"].removeClass "upcoming"
    #  page["step-6"].addClass "empty_widget"
    #  page["step-6-content"].replace_html :partial => "step6", :locals => { :workout => @workout }
    #end
  end
  
  def step_6
    render :update do |page|
      page["step-6"].removeClass "empty_widget"
      page["step-6-title"].addClass "with_icon_ok"
      page["step-6-content"].replace_html ""
      
      page["finish"].replace_html "Yo finish - вы кончили"
    end
  end
  
  def remove_exercise_set
    set = ExerciseSet.find(params[:exercise_set_id])
    line = set.day_line
    if set.destroy
      render :update do |page|
        page["line-#{line.id}-sets"].replace_html :partial => "exercise_sets", :locals => {:day_line => line}
      end
    else
      page.alert "Че-то не получилось"
    end
  end  
  
  def remove_day_line
    day_line = DayLine.find(params[:day_line_id])
    day = day_line.day
    if day_line.destroy
      render :update do |page|
        page["day-#{day.id}-exercises-drop-place"].replace_html :partial => "day_line", :locals => {:day_lines => day.day_lines}
      end
    else
      page.alert "Че-то не получилось"
    end
  end
  
  def add_set_to_day_line
    day_line = DayLine.find(params[:sets][:line_id])
    exercise_set = day_line.exercise_sets.new
    exercise_set.time_rest = params[:sets][:rest]
    exercise_set.weight = params[:sets][:weight]
    exercise_set.repetitions = params[:sets][:reps]
    exercise_set.save!
    render :update do |page|
      page["line-#{day_line.id}-sets"].replace_html :partial => "exercise_sets", :locals => {:day_line => day_line}
    end
  end
  
  def add_exercise
    logger.info "Starting with method 'add_exercise':"
    day_id = params[:day_id]
    workout_id = params[:id]
    exercise_id = params[:jquery_id].split("_")[1]
    exercise = Exercise.find(exercise_id)
    
    day = Day.find(params[:day_id])
    if day.exercises.include? exercise
      logger.info "Exercise #{exercise.id} exist in a day ..."
      render :update do |page|
        page.alert "Упражнение #{exercise.title} уже есть в вашем списке. Зачем повторяться, дорогой?"
        # Если это первое упражнени то он тупорылит - надо чинить
        page["day-#{day_id}-exercises-drop-place"].replace_html :partial => "day_line", :locals => {:day_lines => day.day_lines}
      end
    else
      logger.info "Exercise #{exercise.id} no exist in a day ..."
      logger.info "Trying to crete a new day_line object for day.id = #{day.id}"
      if day_line = day.day_lines.create
        logger.info "Day line created"
      else
        logger.error "Day line not created - ????"
      end
      logger.info "Assigning exercise with id = #{exercise.id} to day_line ..."
      day_line.exercise = exercise 
      logger.info "OK - Assgned. Saving day_line ..."
      day_line.save!
      logger.info "OK - Day line saved. now Rendering uddate to user page with params: exercise.id = #{exercise.id} and day_line.id = #{day_line.id} and day.id = #{day.id} ... " 
      render :update do |page|
        logger.info "replacing with partial ..."
        page["day-#{day_id}-exercises-drop-place"].replace_html :partial => "day_line", :locals => {:day_lines => day.day_lines}
        logger.info "Raplaced - and what happened? params: exercise.id = #{exercise.id} and day_line.id = #{day_line.id} and day.id = #{day.id} "
      end
    end
    logger.info "Done with method 'add_exercise'."
  end
  
end
