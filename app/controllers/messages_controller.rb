class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @messages = current_user.inbox
    respond_to do |format|
      format.html #index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(:first, :conditions => ['id = ? and (to_id = ? or from_id = ?)', params[:id], current_user.id,current_user.id])
    if @message.from_id != current_user.id
      changeStatus(@message) if @message.status == 1 || @message.status == 3
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end
  
  def outbox
    @messages = current_user.outbox
    render :action => "index"
  end
  
  def new
    @message = Message.new
  end
  
  # POST /messages
  # POST /messages.xml
  def create
    if params[:message]['recipient']
      error = true if params[:message]['recipient'] == current_user.login
      to_user = User.find_by_login(params[:message]['recipient']) 
      error = true unless to_user
      params[:message]['to_id'] = to_user.id unless error
    end
    params[:message]['from_id'] = current_user.id
    params[:message]['status'] = 1
    @message = Message.new(params[:message])
    if @message.save and !error
      flash[:notice] = 'Сообщение отправлено.'
      redirect_to :back
    elsif !error
      flash[:error] = 'Сообщение не было отправлено.'
      redirect_to :back
    else
      flash[:error] = 'Этому пользователю запрещено отправка писем =)'
      redirect_to :back
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  # Статусы
  def getStatus(status)
    statuses = ['Личное новое', 'Личное прочитаное', 'Системное новое', 'Системное прочитаное']
    statuses[status-1]
  end
  
  # Сменить стутус на "прочитанное"
  def changeStatus(message)
    message.update_attributes(:status => message.status+1)
  end
  
end
