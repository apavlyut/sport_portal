class TopMenusController < ApplicationController
  layout 'application'
  # GET /top_menus
  # GET /top_menus.xml
  def index
    @top_menus = TopMenu.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @top_menus }
    end
  end

  # GET /top_menus/1
  # GET /top_menus/1.xml
  def show
    @top_menu = TopMenu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @top_menu }
    end
  end

  # GET /top_menus/new
  # GET /top_menus/new.xml
  def new
    @top_menu = TopMenu.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @top_menu }
    end
  end

  # GET /top_menus/1/edit
  def edit
    @top_menu = TopMenu.find(params[:id])
  end

  # POST /top_menus
  # POST /top_menus.xml
  def create
    @top_menu = TopMenu.new(params[:top_menu])

    respond_to do |format|
      if @top_menu.save
        flash[:notice] = 'TopMenu was successfully created.'
        format.html { redirect_to(@top_menu) }
        format.xml  { render :xml => @top_menu, :status => :created, :location => @top_menu }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @top_menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /top_menus/1
  # PUT /top_menus/1.xml
  def update
    @top_menu = TopMenu.find(params[:id])

    respond_to do |format|
      if @top_menu.update_attributes(params[:top_menu])
        flash[:notice] = 'TopMenu was successfully updated.'
        format.html { redirect_to(@top_menu) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @top_menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /top_menus/1
  # DELETE /top_menus/1.xml
  def destroy
    @top_menu = TopMenu.find(params[:id])
    @top_menu.destroy

    respond_to do |format|
      format.html { redirect_to(top_menus_url) }
      format.xml  { head :ok }
    end
  end
end
