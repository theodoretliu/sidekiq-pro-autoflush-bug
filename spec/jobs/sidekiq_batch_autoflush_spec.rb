# bin/rspec spec/jobs/sidekiq_batch_autoflush_spec.rb

require "rails_helper"

RSpec.describe "Sidekiq Pro batch autoflush" do
  it "reports each enqueued job exactly once" do
    batch = Sidekiq::Batch.new
    batch.autoflush = 2

    jids = batch.jobs do
      4.times { NoopJob.perform_async }
    end

    expect(batch.status.total).to eq(jids.size)
  end
end
