class WorkshopsController < ApplicationController
  def index
    @page_title = 'Workshops and Presentations'
    @workshops = workshop_payload
  end

  private

  def workshop_payload
    [
      {
        name: 'Workshop 1',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      },
      {
        name: 'Workshop 2',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      },
      {
        name: 'Workshop 3',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      },
      {
        name: 'Workshop 4',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      }
    ]
  end

end
