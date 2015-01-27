class VideoIndex < Chewy::Index
    settings analysis: {
    	analyzer: {
    		title: {
    			tokenizer: 'keyword',
    			filter: ['lowercase', 'substring']
    		}
    	},
        filter: {
            substring: {
                type: "nGram",
                min_gram: 3,
                max_gram: 20
            }
        }
    }

    define_type Video.includes( :tags ) do
        field :title, analyzer: 'title'
        field :tags, index: 'not_analyzed', value: ->{ tags.map(&:label) }
    end
end