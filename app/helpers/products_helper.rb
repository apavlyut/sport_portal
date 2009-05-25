module ProductsHelper
  def getTitle
    transcrib = params[:title]
    title = 'Магазин'
    title = Category.find_by_transcrib(transcrib.capitalize).title if Category.find_by_transcrib(transcrib.capitalize)
    title
  end
end
