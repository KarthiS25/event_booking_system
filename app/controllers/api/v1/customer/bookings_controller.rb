# frozen_string_literal: true

class Api::V1::Customer::BookingsController < ApplicationController
  before_action :authenticate_customer_user!, except: %i[ event_list ]

  def event_list
    @events = Event.filter_condition(params)
                  .page(params[:page])
                  .per(params[:per_page])

    response_success("Event list",
                      200,
                      array_serializer_for(resource: @events, serializer: EventSerializer),
                      @events.total_pages,
                      @events.total_count
                    )
  end
end
