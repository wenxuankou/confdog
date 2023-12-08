# frozen_string_literal: true

RSpec.describe Confdog do

  let(:redis) { Redis.new }
  let(:prefix) { 'confdog.hello' }
  let(:url) { ENV['REDIS_URL'] || 'redis://127.0.0.1:6379/0' }

  it "has a version number" do
    expect(Confdog::VERSION).not_to be nil
  end

  it "could get value from redis" do
    redis.set('confdog.test.a', 'aaa')
    expect(redis.get('confdog.test.a')).to eq('aaa')
    redis.del('confdog.test.a')
  end

  it "could config and get config" do
    Confdog.setup do |config|
      config.prefix = prefix
      config.url = url
    end

    expect(Confdog.configuration.prefix).to eq(prefix)
    expect(Confdog.configuration.url).to eq(url)
  end

  it "could load config and get config" do
    redis.set('confdog.test.a', 'aaa')
    redis.set('confdog.test.b', 'bbb')
    Confdog.setup do |config|
      config.prefix = 'confdog'
      config.url = url
    end
    expect(Confdog['test.a']).to eq('aaa')
    expect(Confdog['test.b']).to eq('bbb')
    redis.del('confdog.test.a')
    redis.del('confdog.test.b')
  end
end
