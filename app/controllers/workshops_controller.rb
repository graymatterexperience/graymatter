class WorkshopsController < ApplicationController
  before_action :set_page_title
  def index
    @workshops = workshop_payload
  end

  def show
    @workshop = workshop_payload.select { |w| w[:id] == params[:id].to_i }.pop 
  end

  private

  def workshop_payload
    [
      {
        id: 1,
        title: 'Workshop 1',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      },
      {
        id: 2,
        title: 'Workshop 2',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      },
      {
        id: 3,
        title: 'Workshop 3',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      },
      {
        id: 4,
        title: 'Workshop 4',
        url: 'http://www.google.com',
        logo: 'workshop.jpg',
        description: 'I am good at containing small bits of information about this workshop.'
      }
    ]
  end

  private

  def set_page_title
    @page_title = 'Workshops and Presentations'
  end

end
