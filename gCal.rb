require 'googleauth'
require 'google/apis/calendar_v3'
require 'google_calendar'
require 'pry'


YOUR_CLIENT_ID = '372464072161-75rvmh9u1c65uuun02u0hvpa9rcb5n54.apps.googleusercontent.com'
YOUR_SECRET = 'meraOceQiCeIN7jsSMGIJYq6'
YOUR_CALENDAR_ID = 'graymatterexperience2@gmail.com'

cal = Google::Calendar.new(:client_id     => YOUR_CLIENT_ID,
                           :client_secret => YOUR_SECRET,
                           :calendar      => YOUR_CALENDAR_ID,
                           :redirect_url  => "urn:ietf:wg:oauth:2.0:oob" # this is what Google uses for 'applications'
                           )

