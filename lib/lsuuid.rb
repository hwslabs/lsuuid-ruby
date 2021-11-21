# frozen_string_literal: true

require_relative 'lsuuid/version'

if RUBY_VERSION >= '2.5'
  require 'securerandom'
else
  require 'sysrandom/securerandom'
end

module LSUUID # :nodoc:
  PREFIX_LEN = 6
  PAD_CHAR = '0'
  FLOOR_CHAR = '0'
  CEIL_CHAR = 'f'
  DEFAULT_RAND_LEN = 16

  class << self
    # We allow 6 chars (24 bits) of UUID to be customizable as per requirement.
    def generate(prefix: nil, time: Time.now, mode: :random)
      prefix_hex = validate_prefix_and_get_hex(prefix)
      result = prefix_hex +
               time.to_i.to_s(16).rjust(8, PAD_CHAR) + time.nsec.to_s(16).rjust(8, PAD_CHAR) +
               random_hex(prefix_hex, mode)
      [result[0..7], result[8..11], result[12..15], result[16..19], result[20..31]].join('-')
    end

    private

    def random_hex(prefix_hex, mode)
      rand_len = DEFAULT_RAND_LEN - prefix_hex.size
      case mode
      when :random then SecureRandom.hex(rand_len / 2)
      when :ceil then ''.rjust(rand_len, CEIL_CHAR)
      when :floor then ''.rjust(rand_len, FLOOR_CHAR)
      else raise "Unknown mode [#{mode}]"
      end
    end

    def validate_prefix_and_get_hex(prefix)
      return '' if prefix.nil?

      raise "Expecting integer Got #{prefix.class.name}" unless prefix.is_a? Integer

      if (prefix > 16_777_215) || prefix.negative?
        raise "Integer prefix out of range. Allowed: min - 0, max - 16,777,215 (hex: ffffff). Got: #{prefix}."
      end

      prefix.to_s(16).rjust(PREFIX_LEN, PAD_CHAR)
    end
  end
end
