desc 'test all'
task :test do
  ENV['TEST'] = Recorderbot::Package.name
  require 'test/unit'
  Dir.glob(File.join(Recorderbot::Environment.dir, 'test/*.rb')).each do |t|
    require t
  end
end
