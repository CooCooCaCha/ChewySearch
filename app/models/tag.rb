class Tag < ActiveRecord::Base
	has_one :tag_types
	has_many :video_tags, :dependent => :destroy
	has_many :videos, :through => :video_tags

	update_index 'tag#tag', :self, urgent: true

	class << self
		def search( params={} )
			query = TagIndex.query( match_all: {} )
	        query = TagIndex.query( match: { label: params[:q] } ) if params.has_key?(:q)

	        return query.to_a
		end
	end
end
