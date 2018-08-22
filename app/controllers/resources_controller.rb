class ResourcesController < ApplicationController
  def index
    @page_title = 'Resources'
    @resources = resources_payload
  end

  private

  def resources_payload
    # I think I can have a key as a string
    [
      {
        "Starting a Business" => [
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          }
        ]
      },
      {
        "Market Research" => [
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          }
        ]
      },
      {
        "Finance tips/tools" => [
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          },
          {
            source: 'this is the source',
            link: 'https://www.google.com'
          }
        ]
      },
      {
        "Marketing" => []
      },
      {
        "Web Development" => []
      },
      {
        "Web Design" => []
      },
      {
        "Project Management" => []
      },
      {
        "Funding Resources" => []
      },
      {
        "Pitch resources" => []
      },
      {
        "Social Media Management" => []
      },
      {
        "Miscellaneous" => []
      }
    ]
  end
end
