require 'time'

module Recorderbot
  class EPGStation
    def initialize
      @config = Config.instance
      @http = Ginseng::HTTP.new
      @http.base_uri = @config['/epgs/url']
    end

    def queues
      return @http.get('/api/recording?isHalfWidth=false')['records'].map do |record|
        [record['id'].to_s.adler32.to_s, record]
      end.to_h
    rescue => e
      warn e.message
      exit 1
    end

    def summary(queue)
      values = ['name', 'description', 'extended'].select {|k| queue[k].present?}.map do |key|
        [key, queue[key]]
      end.to_h
      values.merge!(['startAt', 'endAt'].map do |v|
        [v, Time.at(queue[v] / 1000).strftime('%R')]
      end.to_h)
      return values
    end
  end
end
