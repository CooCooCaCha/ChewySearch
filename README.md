# ChewySearch
An experiment integrating Elasticsearch with ActiveRecord using the chewy gem.

The first major piece of code is the index file. The index takes fields from ActiveRecord and pushes them to Elasticsearch making them searchable. In this case we are making video titles searchable using the nGram search algorithm.
```ruby
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
```

The other major piece of code is the Activerecord model which has code integrating the index from above. Chewy makes it easy with the 'update_index' association. In this example there is also a search helper function that lets us use the same string to search through video tags and titles.
```ruby
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
``` 
