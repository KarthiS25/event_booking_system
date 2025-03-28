# Event Booking API

Things you may want to cover:

* Ruby version: 3.3.1

* Rails version: 7.1.3.2

* Postgresql version: 16.3

* Redis: 7.4.2

## Setup Instructions

## Installation

* Clone the repository:

   `git clone https://github.com/KarthiS25/event_booking_system`
   `cd event-booking-api`

* Install dependencies:

   `bundle install`

* Connect with the dev team and get the `database.yml` and `.env` file

    Database file path - `config/database.yml`

    ENV file path - `.env`

* Start the Redis server (for Sidekiq):

   `redis-server`

* Start the Rails server:

   `rails s`

* Start Sidekiq in a separate terminal:

   `bundle exec sidekiq`

## API Endpoints

## Authentication

* User authentication is handled via Devise & JWT.

* Sign in

  * `/api/v1/users/sign-in` (All users login api)

  * `/api/v1/users` (User sign up/register)

* Events

  * `POST /api/v1/event-organizers/events` (Create an event - Organizer only)

  * `GET /api/v1/event-organizers/events` (List all events)

  * `PUT /api/v1/event-organizers/events/:id` (Update an event - Organizer only)

  * `DELETE /api/v1/event-organizers/events/:id` (Delete an event - Organizer only)

* Bookings

  * `POST /api/v1/users/events/:event_id/book-event` (Create a booking - Customer only)
  * `GET /api/v1/users/bookings` (List of bookings - Customer only)
  * `GET /api/v1/users/bookings/:id/cancel-booking` (Cancel booking - Customer only)

* Background Jobs

  * `BookingConfirmationJob`: Sends a confirmation message when a booking is created.

  * `NotifyCustomersJob`: Sends notifications to customers when an event is updated.

* Notes

  Sidekiq must be running for background jobs to work.

  All API requests require authentication.
