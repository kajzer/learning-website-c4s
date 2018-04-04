module ApplicationHelper
    
    def avatar_url(user, size: 40)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        if user.image
            image_url = user.image + "?sz=#{size}"
        else
            image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        end
        image_tag(image_url, alt: user.name, class: "gravatar circle responsive_img")
    end
    
end
