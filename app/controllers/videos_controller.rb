class VideosController < ApplicationController
	def video
		@video = Video.find( params[:video] )

		respond_to do |format|
			format.html
			format.json { render :json => @video.as_json }
		end
	end

	def search
		@videos = Video.search params
		@q      = params[:q] if params.has_key?(:q)
		
		respond_to do |format|
			format.html
			format.json { render :json => { results: @videos }.as_json }
		end
	end

	def tags
		render :json => { tags: Video.find( params[:video] ).tags }.as_json
	end

	def upload
		video = Video.new title: params[:title], video_url: "", thumb_url: ""
        video.save

    	render :json => video.as_json
	end

	def reset_index
        VideoIndex.reset!
        TagIndex.reset!
        redirect_to action: 'search'
	end

	def create_index
        VideoIndex.create!
        TagIndex.create!
        redirect_to action: 'search'
	end
end
