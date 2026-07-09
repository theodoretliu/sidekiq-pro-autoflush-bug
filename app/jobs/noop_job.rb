class NoopJob
  include Sidekiq::Job

  sidekiq_options queue: "autoflush_repro"

  def perform
  end
end
