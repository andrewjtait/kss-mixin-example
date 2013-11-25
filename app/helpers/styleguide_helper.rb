module StyleguideHelper
  def kss_block(type)
    html = ""
    sections = controller.styleguide.sections

    sections.each do |section|
      section = section[1]
      if section.type == "@#{type}" && section.usage.length > 0
        html << "<div class='#{type}-sample'>"
        html << "<h3>#{section.section}</h3>"
        section.usage.each_with_index do |use,index|
          klass = section.section.gsub('.','-') + "-#{index}"
          html << "<div class='#{klass}'></div>"
        end
        html << "</div>"
      end
    end

    html.html_safe
  end
end
