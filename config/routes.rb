Rails.application.routes.draw do

  get 'artist/index'

  get 'artist/show'

  get 'artist/new'

  get 'artist/create'

  get 'artist/edit'

  get 'artist/update'

  get 'artist/destroy'

  get '/', to: 'welcome#home'
	resources :artists
end
