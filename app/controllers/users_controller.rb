class UsersController < ApplicationController
	def get
		render :json => User.find( params[:user] ).as_json
	end

	def create
		@user = User.new params[:user]
		@user.save

		render :json => @user
	end

	def test
		@result = Tag.select( :id ).joins(:video_tags).where( video_tags: {video_id: 1} )

		render :json => @result
	end
end
