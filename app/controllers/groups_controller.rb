class GroupsController < ApplicationController
  def index
    @page_title = 'Groups'
    @groups = group_payload
  end

  private

  def group_payload
    [
      {
        group_name: 'Group One',
        group_image: 'group.jpg'
      },
      {
        group_name: 'Group Two',
        group_image: 'group-1.png'
      },
      {
        group_name: 'Group Three',
        group_image: 'group-2.png'
      },
      {
        group_name: 'Group Four',
        group_image: 'group-3.jpg'
      },
      {
        group_name: 'Group Five',
        group_image: 'group-4.gif'
      }
    ]
  end
end
