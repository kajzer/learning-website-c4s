module ApplicationHelper
    
    def avatar_url(user, size: 40)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        if user.image
            image_url = user.image + "?sz=#{size}"
        else
            image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        end
        image_tag(image_url, alt: user.name, class: "gravatar circle responsive_img avatar-small")
    end
    
    class CodeRayify < Redcarpet::Render::HTML
       def block_code(code, language)
          CodeRay.scan(code, language).div(line_numbers: :table) 
       end
    end
    
    def markdown(text)
       coderayified = CodeRayify.new(filter_html: true, hard_wrap: true)
       options = {
           fenced_code_blocks: true,
           no_intra_emphasis: true,
           autolink: true,
           strikethrough: true,
           lax_html_blocks: true,
           superscript: true
       }
       
       markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
       markdown_to_html.render(text).html_safe
       
    end
end
