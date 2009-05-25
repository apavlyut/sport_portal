module WidgetHelper
  
  def widget(title="Title",id="0", &block)
    concat('<div class="widget" id="widget_'+id+'">', block.binding)
      concat('<div class="widget_nw">', block.binding)
        concat content_tag(:div, title.capitalize, :class => "widget_title"), block.binding
      concat('</div>', block.binding)
      concat('<div class="widget_w">', block.binding)
        concat content_tag(:div, content_tag(:p, capture(&block)), :class => "widget_content"), block.binding
      concat('</div>', block.binding)
      #concat('<div class="widget_sw">', block.binding)
      #  concat content_tag(:div, "ss", :class => "widget_statusbar"), block.binding
      #concat('</div>', block.binding)
    concat('</div>', block.binding)
  end
  
  def widget_js(title="Title", content="Sucker")
    page << "portal.add(new Xilinus.Widget().setTitle('#{title}').setContent('#{content}'), 0);"
  end
  
end