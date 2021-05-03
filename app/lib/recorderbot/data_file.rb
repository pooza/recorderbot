module Recorderbot
  class DataFile
    def load
      @data ||= JSON.parse(File.read(path)) rescue {}
      return @data
    end

    def save(result)
      @data = nil
      File.write(path, result.to_json)
    end

    def path
      return File.join(Environment.dir, 'tmp/recording.json')
    end
  end
end
