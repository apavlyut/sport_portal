class Message < ActiveRecord::Base
  validates_presence_of :body, :to_id, :from_id

  belongs_to :sender, :class_name => 'User', :foreign_key => :from_id
  belongs_to :reciever, :class_name => 'User', :foreign_key => :to_id

  attr_accessor :recipient
  
  
  def sendInvite(from_id, from_name, to_id)
    params = {}
    params[:message] = {}
    params[:message]['to_id'] = to_id
    params[:message]['from_id'] = from_id
    params[:message]['status'] = 3
    params[:message]['title'] = 'Приглашение в друзья'
    params[:message]['body'] = 
          'Пользователь <a href="/users/'+from_id.to_s+'">'+from_name+'</a> желает добавить вас в друзья.<br />
          <a href="/users/acceptInvite/'+from_id.to_s+'">Подтвердите</a> или <a href="/users/ignoreInvite/'+from_id.to_s+'">отклоните</a>.'
    message = Message.new(params[:message])
    message.save
  end
end
