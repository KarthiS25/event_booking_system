Rails.application.routes.draw do
  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    username == ENV['SIDEKIQ_USER_NAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end
  mount(Sidekiq::Web => '/sidekiq')

  get "up" => "rails/health#show", as: :rails_health_check

  scope 'api/v1/users' do
    devise_for :users,
               controllers: {
                sessions: 'api/v1/sessions',
                registrations: 'api/v1/registrations', only: %i[create]
               },
               path: '',
               path_names: { sign_in: '/sign-in', sign_out: '/logout' }
  end

  namespace :api do
    namespace :v1 do
      namespace :admin, path: "admins" do
        resources :users
      end

      namespace :event_organizer, path: "event-organizers" do
        resources :events
      end

      namespace :customer, path: "users" do
        get :event_list , path: "event-list", to: "bookings#event_list"
        post "events/:event_id/book-event" , to: "bookings#create"
        resources :bookings do
          delete "cancel-booking", on: :member
        end
      end
    end
  end
end
