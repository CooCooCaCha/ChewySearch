Rails.application.routes.draw do
    root 'videos#search'

    get 'reset'  => 'videos#reset_index'
    get 'create' => 'videos#create_index'
    get 'upload' => 'users#upload'

    get 'user/:user' => 'users#get'

    get  'videos/:video'           => 'videos#video'
    get  'videos'                  => 'videos#search'
    get  'videos/:video/tags'      => 'videos#tags'
    post 'videos'                  => 'videos#upload'
    post 'videos/:video/tags/:tag' => 'tags#tag_video'

    get  'tags'      => 'tags#search'
    get  'tags/:tag' => 'tags#tag'
    post 'tags'      => 'tags#create'

    post 'users' => 'users#create'

    get 'test' => 'users#test'
end