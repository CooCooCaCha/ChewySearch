class TagsController < ApplicationController
    def tag
        render :json => Tag.find( params[:tag] ).as_json
    end

    def create
        tag = Tag.new label: params[:label], tag_type_id: 1
        tag.save

        render :json => tag.as_json
    end

    def search
        tags = Tag.search params
        respond_to do |format| 
            format.json { render :json => tags.as_json }
        end
    end

    def tag_video
        video_tag = VideoTag.new video_id: params[:video], tag_id: params[:tag]
        video_tag.save

        render :json => video_tag.as_json
    end
end
