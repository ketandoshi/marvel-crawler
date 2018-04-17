require 'digest/md5'
require_relative 'connection'
require_relative 'api_response'

module MarvelCrawler
  module ApiRequest

    class InvalidParameterError < StandardError; end

    class InvalidClientError < StandardError; end

    MARVEL_API_ROUTES = {
      characters: %w(characters character character_comics character_events character_series character_stories),
      comics: %w(comics comic comic_characters comic_creators comic_events comic_stories),
      creators: %w(creators creator creator_comics creator_events creator_series creator_stories),
      events: %w(events event event_characters event_creators event_comics event_stories event_series),
      series: %w(series series series_characters series_comics series_creators series_events series_stories),
      stories: %w(stories story story_characters story_comics story_creators story_events story_series)
    }

    MARVEL_API_ROUTES.each do |group_name, group_methods|
      group_methods.each_with_index do |method_name, index|
        entity = group_name.to_s

        entity_id = entity_property = ''
        entity_property = "/#{method_name.split('_').last}" if index > 1

        define_method "get_#{method_name}" do |args = {}|
          if index > 0
            raise InvalidParameterError, 'You need to provide :id param.' if args[:id].nil?
            entity_id = "/#{args[:id]}"
          end
          # Create the path url
          path = entity + entity_id + entity_property

          args[:page_num] ||= 1 if index != 1

          make_request(
            path,
            sanitize_params(args, entity, entity_id, entity_property)
          )
        end
      end
    end

    def make_request(path, options = {})
      check_for_credentials
      response = Connection.new.connect.get do |request|
        request.url(path, options.merge(auth))
      end
      ApiResponse.new(response).format_response
    end

    def auth(ts_value = timestamp)
      {
        ts: ts_value,
        apikey: api_key,
        hash: generate_hash(ts_value)
      }
    end

    def generate_hash(ts_value)
      Digest::MD5.hexdigest(ts_value + private_key + api_key)
    end

    def timestamp
      Time.now.to_s
    end

    def sanitize_params(args, entity, entity_id, entity_property)
      options = Hash.new.merge(pagination_params(args[:page_num]))

      valid_params = get_entity_valid_params(entity, entity_id, entity_property)

      options.merge(args.keep_if { |key, value| valid_params.include?(key) }) unless args.empty?
      options
    end

    def get_entity_valid_params(entity, entity_id, entity_property)
      valid_params = Hash.new

      case entity
        when 'characters'
          if entity_id.nil?
            valid_params = %w(name nameStartsWith modifiedSince comics series events stories orderBy limit offset).map { |e| e.to_sym}
          elsif !entity_id.nil? && entity_property.nil?
            valid_params = %w(characterId).map { |e| e.to_sym}
          else
            # valid_params for other methods
          end
        when 'comics'
          # comics params
        when 'creators'
          # creators params
        when 'events'
          # events params
        when 'series'
          # series params
        when 'stories'
          # stories params
      end

      valid_params
    end

    def pagination_params(page_num)
      return {} if page_num.nil?
      {
        limit: record_per_page,
        offset: ((page_num - 1) * record_per_page)
      }
    end

    def check_for_credentials
      [:api_key, :private_key].each do |key|
        raise InvalidClientError, "You need to provide :#{key} param." if self.send(key).nil?
      end
    end

  end
end