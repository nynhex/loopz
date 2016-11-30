class ScreenshotJob
  include SuckerPunch::Job
  require 'imgkit'

  def perform(link_id)
    ActiveRecord::Base.connection_pool.with_connection do
      begin
        link = ::Link.find(link_id)
        file = Tempfile.new(["template_#{link.id.to_s}", '.jpg'], 'tmp', :encoding => 'ascii-8bit')
        file.write(IMGKit.new(link.target_url, quality: 50, width: 600, height: 200).to_jpg)
        file.flush
        link.snapshot = file
        link.save
        file.unlink
      end
    end
  end
end
