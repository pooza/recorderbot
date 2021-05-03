module Recorderbot
  class Environment < Ginseng::Environment
    def self.name
      return File.basename(dir)
    end

    def self.dir
      return Recorderbot.dir
    end
  end
end
