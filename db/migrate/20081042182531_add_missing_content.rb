class AddMissingContent < ActiveRecord::Migration
  def self.up
    WeekDay.create (
      :title => "Понедельник",
      :short_name => "Пн",
      :number => 1
    )
    WeekDay.create (
      :title => "Вторник",
      :short_name => "Вт",
      :number => 2
    )
    WeekDay.create (
      :title => "Среда",
      :short_name => "Ср",
      :number => 3
    )
    WeekDay.create (
      :title => "Четверг",
      :short_name => "Чт",
      :number => 4
    )
    WeekDay.create (
      :title => "Пятница",
      :short_name => "Пт",
      :number => 5
    )
    WeekDay.create (
      :title => "Суббота",
      :short_name => "Сб",
      :number => 6
    )
    WeekDay.create (
      :title => "Воскресенье",
      :short_name => "Вс",
      :number => 7
    )
  end

  def self.down
  end
end
