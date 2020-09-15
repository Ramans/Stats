Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    resources :stats, only: [:index, :new] do
        collection do
            get "short_url"
            get "clicks_count_update"
        end
    end

    root :to => "stats#new"

    match '*a', :to => 'stats#routing_404', via: :all
end
