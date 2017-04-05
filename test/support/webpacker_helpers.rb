module WebpackerHelpers
  module_function

  def when_webpacker_available
    if defined?(Webpacker)
      yield
    end
  end

  def compile
    clear_webpacker_packs
    Dir.chdir("./test/dummy") do
      Rake::Task['webpacker:compile'].invoke
    end
    # Reload cached JSON manifest:
    Webpacker::Manifest.load
  end

  def clear_webpacker_packs
    packs_directory = File.expand_path("../dummy/public/packs", __FILE__)
    FileUtils.rm_rf(packs_directory)
  end
end
