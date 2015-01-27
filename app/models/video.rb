class Video < ActiveRecord::Base
	has_many :video_tags, :dependent => :destroy
	has_many :tags, :through => :video_tags
	belongs_to :user

	update_index 'video#video',  :self, urgent: true

	class << self
		def search( params={} )
			q    = params[:q]    if params.has_key?(:q)
			tags = params[:tags] if params.has_key?(:tags)

			query = VideoIndex.query( match_all: {} )

			if q or tags
		        sort_query  = VideoIndex.order{ s('_score = _score * 1') }
		        title_query = VideoIndex.query( match: { title: q    } ) if q
	    	    tags_query  = VideoIndex.filter( term: { tags:  tags } ) if tags

	        	query = [title_query, tags_query, sort_query].compact.reduce(:merge)
	        end

	        return query.to_a
		end
	end
end
