module StudentsHelper
  def get_social_media(socialMedia)
    social_media_icons = {
      "facebook" => "facebook.png",
      "twitter" => "twitter.png",
      "linkedin" => "linkedin.png",
      "instagram" => "instagram.png"
    }

    # TODO must rendor a a partial with someting like wrong address check the address
    if socialMedia[1].present? && social_media_icons.key?(socialMedia[0])
      tag.span(id: 'social-media-container', class: 'social-media-icon') do
        content_tag(:a, image_tag(social_media_icons[socialMedia[0]],
                                  class: socialMedia[0]),
                                  href: socialMedia[1] || 'www.FIXTHIS.com',
                                  target: '_blank')
      end
    end

  end
end
