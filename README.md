# Sidekiq Pro autoflush bug

This is a stock Rails 8.1.3 application demonstrating incorrect Sidekiq Pro 8.1.4 batch totals when autoflush is enabled.

The only application-specific pieces are:

- Sidekiq Pro 8.1.4 and RSpec Rails in the Gemfile
- A native Sidekiq `NoopJob`
- One spec using `Sidekiq::Batch`'s public API

There are no mocks, monkey patches, Sidekiq testing modes, custom initializers, or direct Redis calls.

## Setup

Provide your Sidekiq Pro credentials, then install dependencies:

```sh
bundle install
```

Start an otherwise empty Redis instance:

```sh
docker run --rm --name sidekiq-pro-autoflush-redis -p 6379:6379 redis:7
```

Run the single spec:

```sh
bin/rspec spec/jobs/sidekiq_batch_autoflush_spec.rb
```

Four jobs are enqueued, so the returned JID count is 4. The assertion fails because `Sidekiq::Batch::Status#total` incorrectly returns 10.
