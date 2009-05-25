class CategoriesController < ApplicationController
  layout 'application'
  
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.find(:all, :order => 'lft ASC')
    @me = Category.find_by_parent_id(nil).all_children_count
    # @tree = growTree

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new
    @titles_ids = getTitles
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    params[:category]["transcrib"] = transcrib(params[:category]['title'])
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        my_item = Category.find(params[:category]['parent_id'])
        @category.move_to_child_of my_item
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])
    params[:category]["transcrib"] = transcrib(params[:category]['title'])
    new_parent = @category.parent_id == params[:category]['parent_id'].to_i
    respond_to do |format|
      if @category.update_attributes(params[:category])
        my_item = Category.find(params[:category]['parent_id'])
        @category.move_to_child_of my_item unless new_parent
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  # Делаем транскрипцию строки (заголовка категории)
  def transcrib(title)
    letters = {
      'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', 'е' => 'e', 'ё' => 'e',
      'ж' => 'zh', 'з' => 'z', 'и' => 'i', 'й' => 'i', 'к' => 'k', 'л' => 'l', 'м' => 'm',
      'н' => 'n', 'о' => 'o', 'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u',
      'ф' => 'f', 'х' => 'h', 'ц' => 'c', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'shch', 'ъ' => '',
      'ы' => 'i', 'ь' => '', 'э' => 'e', 'ю' => 'u', 'я' => 'ya',
      'А' => 'A', 'Б' => 'B', 'В' => 'V', 'Г' => 'G', 'Д' => 'D', 'Е' => 'E', 'Ё' => 'E',
      'Ж' => 'Zh', 'З' => 'Z', 'И' => 'I', 'Й' => 'I', 'К' => 'K', 'Л' => 'L', 'М' => 'M',
      'Н' => 'N', 'О' => 'O', 'П' => 'P', 'Р' => 'R', 'С' => 'S', 'Т' => 'T', 'У' => 'U',
      'Ф' => 'F', 'Х' => 'H', 'Ц' => 'C', 'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Shch', 'Ъ' => '',
      'Ы' => 'I', 'Ь' => '', 'Э' => 'E', 'Ю' => 'U', 'Я' => 'Ya',
      " " => "_"
    }
    chars = title.split(//)
    # tr_title = title.chars.gsub(/([а-я])/, "*")
    tr_title = ""
    chars.each do |t|
      if letters[t]
        tr_title = tr_title + letters[t]
      else
        tr_title = tr_title + t
      end
    end
    tr_title
  end
  
  # Возвращаем коллекцию title => id для формы редактирования
  def getTitles
    all = Category.find(:all)
    titles = []
    all.each do |me|
      titles<< {:title => me.title, :id => me.id}
    end
    titles
  end
  
  # Создаем хеш "дерево категорий"
  def growTree
    tree = {}
    # Начинаем с рута - у него нет id
    root = Category.find_by_parent_id(nil)
    tree.merge!(root.transcrib => {})
    recursion(tree[root.transcrib], root.id)
    tree
  end
  
  # Рекурсия для Category.find_by_parent_id
  def recursion(parent, id)
    Category.find_all_by_parent_id(id).each do |c|
      parent.merge!({c.transcrib => {}})
      recursion(parent[c.transcrib], c.id)
    end
  end
  
end

