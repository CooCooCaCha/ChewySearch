class VideoTag < ActiveRecord::Base
	belongs_to :video
	belongs_to :tag

	update_index 'video#video', :video, urgent: true
	update_index 'tag#tag'    , :tag  , urgent: true
end
