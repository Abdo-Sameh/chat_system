module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def as_indexed_json(_options = {})
      self.as_json(only: [:body])
    end

    settings settings_attributes do
      mapping dynamic: false do
        indexes :body, type: :text
      end
    end

    def self.search(query, filters)
      # set_filters = lambda do |context_type, filter|
      #   @search_definition[:query][:bool][context_type] |= [filter]
      # end
      #
      # @search_definition = {
      #   size: 5,
      #   query: {
      #     bool: {
      #       must: [],
      #       should: [],
      #       filter: []
      #     }
      #   }
      # }
      #
      # if query.blank?
      #   set_filters.call(:must, match_all: {})
      # else
      #   set_filters.call(
      #     :must,
      #     match: {
      #       name: {
      #         query: query,
      #         fuzziness: 1
      #       }
      #     }
      #   )
      # end
      #
      # if filters[:level].present?
      #   set_filters.call(:filter, term: { level: filters[:level] })
      # end

      __elasticsearch__.search({
                                 query: {
                                   bool: {
                                     must: [
                                       {
                                         multi_match: {
                                           query: query,
                                           fields: [:body]
                                         }
                                       }
                                     ]
                                   }
                                 }
                               })
    end
  end
  class_methods do
    def settings_attributes
      {
        index: {
          analysis: {
            analyzer: {
              autocomplete: {
                type: :custom,
                tokenizer: :standard,
                filter: %i[lowercase autocomplete]
              }
            },
            filter: {
              autocomplete: {
                type: :edge_ngram,
                min_gram: 2,
                max_gram: 25
              }
            }
          }
        }
      }
    end
  end
end