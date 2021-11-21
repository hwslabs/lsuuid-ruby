# frozen_string_literal: true

UUID_REGEXP = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i.freeze

RSpec.describe LSUUID do # rubocop:disable  Metrics/BlockLength
  it 'has a version number' do
    expect(LSUUID::VERSION).not_to be nil
  end

  it 'should generate identifier in a valid UUID format' do
    lsuuid = LSUUID.generate
    expect(lsuuid.size).to eq(36)
    expect(!(UUID_REGEXP =~ lsuuid).nil?).to eq(true)
  end

  it 'should generate least possible uuid for given params in floor mode' do
    lsuuid = LSUUID.generate(mode: :floor)
    expect(lsuuid[26..-1]).to eq('0000000000')
  end

  it 'should generate highest possible uuid for given params in ceil mode' do
    lsuuid = LSUUID.generate(mode: :ceil)
    expect(lsuuid[26..-1]).to eq('ffffffffff')
  end

  it 'should generate uuid with first 6 chars as 0s for prefix 0 ' do
    lsuuid = LSUUID.generate(prefix: 0)
    expect(lsuuid[0..5]).to eq('000000')
  end

  it 'should generate uuid with first 6 chars as fs for max prefix[16_777_215]' do
    lsuuid = LSUUID.generate(prefix: 16_777_215)
    expect(lsuuid[0..5]).to eq('ffffff')
  end

  it 'should generate same identifier for same input except for random suffix' do
    time = Time.now
    test_prefix = 15_332
    lsuuid1 = LSUUID.generate(prefix: test_prefix, time: time, mode: :random)
    lsuuid2 = LSUUID.generate(prefix: test_prefix, time: time, mode: :random)
    expect(lsuuid1[0..25]).to eq(lsuuid2[0..25])
    expect(lsuuid1[26..-1]).not_to eq(lsuuid2[26..-1])
  end
end
