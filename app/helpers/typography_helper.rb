module TypographyHelper
  def to_redcloth_html string
    unless string.nil?
      r = RedCloth.new string
      r.to_html
    else
      "-"
    end
  end
end

