class Image < ActiveRecord::Base

  has_attachment  :content_type => :image,
                  :storage => :file_system,
                  :max_size => 1000.kilobytes,
                  :resize_to => '450x450>',
                  :thumbnails => { :thumb => '150x150>' }

  validates_as_attachment
  
  # after_attachment_saved do |foto|
  #   # delete original file for disk space saving 
  #   FileUtils.rm foto.full_filename if foto.parent.nil?
  # end
end
