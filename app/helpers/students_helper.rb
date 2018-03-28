module StudentsHelper
  def get_social_media(socialMedia)
      social_media_icons = {
          "facebook" => "facebook.png",
          "twitter" => "twitter.png",
          "linkedin" => "linkedin.png",
          "instagram" => "instagram.png"
      }

    # TODO must rendor a a partial with someting like wrong address check the address
    if social_media_icons.key?(socialMedia[0])
      tag.div(id: socialMedia[0], class: 'col m2 pl right') do
        content_tag(:a, image_tag(social_media_icons[socialMedia[0]], class: socialMedia[0]), href: socialMedia[1] || 'www.FIXTHIS.com', class: 'btn-floating sm-btn-fab waves-effect waves-light', target: '_blank')
      end
    end

  end
end
