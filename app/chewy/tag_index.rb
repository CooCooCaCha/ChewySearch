class TagIndex < Chewy::Index
    settings analysis: {
    	analyzer: {
            tag: {
                tokenizer: 'keyword',
                filter: ['lowercase', 'substring']
            }
    	},       
        filter: {
            substring: {
                type: "nGram",
                min_gram: 2,
                max_gram: 20
            }
        }
    }

    define_type Tag  do
        field :label, analyzer: 'tag'
    end
end