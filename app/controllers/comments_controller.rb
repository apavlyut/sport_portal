class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    unless logged_in?
      flash[:error] = 'You\'re not logged in'
      redirect_to :back
    else
      post = Post.find_by_id(params[:id])
      params[:comment]['author'] = current_user.id
      params[:comment]['post'] = params[:id]
      @comment = Comment.new(params[:comment])
      replies = post.replies || 0
      replies += 1
      @id = params['num'].to_i
      post.update_attribute('replies', replies)
      respond_to do |format|
        if @comment.save
          flash[:notice] = 'Комментарий добавлен'
          format.html { redirect_to :back }
          format.js
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @id = params[:id]
    comment = Comment.find(@id)
    post = Post.find_by_id(comment.post)
    comment.destroy
    (replies = post.replies - 1) if post.replies > 0
    post.update_attribute('replies', replies)
    respond_to do |format|
      format.html { 
        redirect_to :back
        flash[:notice] = 'Комментарий делитед!' 
      }
      format.xml  { head :ok }
      format.js
    end
  end
end
