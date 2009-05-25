class AddSomeNewContent < ActiveRecord::Migration
  def self.up
    DifficultLevel.create(
      :title => "Начианющий",
      :description => "Предназначается всем кто не имеет мало опыта в этом."
    )
    DifficultLevel.create(
      :title => "Опытный",
      :description => "Предназначается тем кто имеет опыт от года до трех лет."
    )
    DifficultLevel.create(
      :title => "Профессионал",
      :description => "Предназначается всем профессионалам и людям с опытом от трех лет."
    )
    
    AgeLevel.create (
      :title => "Дети",
      :from_age => 5,
      :to_age => 13
    )
    AgeLevel.create (
      :title => "Подростки",
      :from_age => 14,
      :to_age => 20
    )
    AgeLevel.create (
      :title => "Взрослые",
      :from_age => 21,
      :to_age => 49
    )
    AgeLevel.create (
      :title => "Пожилые",
      :from_age => 50,
      :to_age => 100
    )
    
    Goal.create (
      :title => "Похудение",
      :description => "Избавление от лишней жировой массы организма."
    )
    Goal.create (
      :title => "Набор мышечной массы",
      :description => "Увеличение мышечной массы организма."
    )
    Goal.create (
      :title => "Поддержание формы",
      :description => "Поддержка текущего состояния организма, формы и профилактика здоровья."
    )
    
    Occupacy.create (
      :title => "Дом",
      :description => "Домашние условия."
    )
    Occupacy.create (
      :title => "Спортзал",
      :description => "Обстановка в которой есть специальные тренажеры и инвентарь."
    )
    Occupacy.create (
      :title => "На открытом воздухе",
      :description => "Обстанока природы, города или любого места вне помещения."
    )
    
    StrengthType.create (
      :title => "Аэробная",
      :description => "Кардио нагрузка"
    )
    StrengthType.create (
      :title => "Силовая",
      :description => "ИНтенсивная нагрузка организма"
    )
    
    TrainingMode.create (
      :title => "Линейная",
      :description => "Каждое упражение делается по порядку со всеми необходимыми подходами"
    )
    
    TrainingMode.create (
      :title => "Круговая",
      :description => "Каждое упражение делается по одному подходу. Когда выполнены все упражнения необходимо вернуться в начало и делать по следующему подходу."
    )
  end

  def self.down 
  end
end
