class ResourcesController < ApplicationController
  def index
    @page_title = 'Resources'
    @resources = resources_payload
  end

  private


  def resources_payload
    # I have 'card_image' but do not use. I want to control the image
    # Ask client
    [
      {
        "resource" => "Starting a Business",
        "resource_links" => [
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          }
        ],
        "description" => 'This is a breif description. Less than 250 chars. This
        resource has lots of links scroll down.',
        "card_image" => 'resources.png'
      },
      {
        "resource" => "Market Research",
        "resource_links" => [
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          }
        ],
        "description" => 'This is a breif description. Less than 250 chars.',
        "card_image" => nil
      },
      {
        "resource" => "Finance tips/tools",
        "resource_links" => [
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          }
        ],
        "description" => 'This is a breif description. Less than 250 chars.',
        "card_image" => nil
      },
      {
        "resource" => "Marketing",
        "resource_links" => [],
        "card_image" => nil
      },
      {
        "resource" => "Web Development",
        "resource_links" => [],
        "card_image" => nil
      },
      {
        "resource" => "Web Design",
        "resource_links" => [],
        "card_image" => nil
      },
      {
        "resource" => "Project Management",
        "resource_links" => [],
        "card_image" => nil
      }
    ]
  end
end
