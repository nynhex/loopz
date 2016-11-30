class ScrapeJob
  include SuckerPunch::Job

  def perform(link_id)
    ActiveRecord::Base.connection_pool.with_connection do
      begin
        link = ::Link.find(link_id)
        agent = Mechanize.new
        page = agent.get(link.target_url)
        link.title = page.title
        link.save
      end
    end
  end
end
