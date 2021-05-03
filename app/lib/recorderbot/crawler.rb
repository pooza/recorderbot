module Recorderbot
  class Crawler
    def initialize
      @config = Config.instance
      @epgs = EPGStation.new
      @data_file = DataFile.new
    end

    def exec
      messages = []
      sleep(@config['/sleep'])
      @data_file.load.each do |k, q|
        messages.push(create_message(q, '録画終了')) unless @epgs.queues[k]
      end
      @epgs.queues.each do |k, q|
        messages.push(create_message(q, '録画開始')) unless @data_file.load[k]
      end
      @data_file.save(@epgs.queues)
      puts messages.map {|m| YAML.dump(m)}.join("=====\n")
    end

    private

    def create_message(queue, message_string)
      message = @epgs.summary(queue)
      message['message'] = message_string
      return message
    end
  end
end
