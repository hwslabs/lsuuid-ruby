# LSUUID (Lexicographically Sortable Universally Unique Identifier)

LSUUID is a lexicographically sortable identifier with format similar to UUIDv4. 
UUID has some limitations which are already listed and addressed by [ULID](https://github.com/ulid/spec).

LSUUID provides the following improvements over ulid :-
- The timestamp component in ulid is in milliseconds whereas LSUUID uses nanoseconds so that chance of collision is reduced 1000 times
- Ability to bucket the generated identifiers with a prefix is provided by LSUUID
- LSUUID adheres to the UUIDv4 format there by allowing the storage of the identifier in the UUID datatype of data stores which is more efficient than a string which is required for ulid.

*Note: For use cases where format of the identifier is not a matter of concern, using ULID over LSUUID might be a better choice.*

## Specification
Below is the structure of LSUUID.

**Without Prefix:**
```
 Sample LSUUID: 619bd0ef-2a04-5068-d3c4-f6fac6809edb

 619bd0ef-2a04-5068-      d3c4-f6fac6809edb

|------------------|     |-----------------|
     Timestamp                Randomness
       64bits                   64bits
```

**With Prefix:**
```
 Sample LSUUID: 619bd0ef-2a04-5068-d3c4-f6fac6809edb

 619bd0      ef-2a04-5068-d3c4-f6      fac6809edb

|------|    |--------------------|    |----------|
 Prefix            Timestamp           Randomness
 24bits             64bits               40bits
```

### Components:

**Timestamp**
- 64 bit integer
- UNIX-time in nanoseconds

**Randomness**
- 64 bits (40 bits in case a prefix is specified)
- Cryptographically secure source of randomness, if possible

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lsuuid'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lsuuid

## Usage

### Generate a UUID:
```ruby
irb(main):001:0> LSUUID.generate
=> "619bd0ef-2a04-5068-d3c4-f6fac6809edb"
```
Generates a UUID based on the method call time.
### Timestamp specific UUIDs:
```ruby
irb(main):001:0> t = Time.now     
=> 2021-11-22 22:49:02 +0530
irb(main):002:0> LSUUID.generate(time: t)
=> "619bd106-0c6b-ba28-7811-f5787dab02d4"
```
### Modes:
#### **ceil**
```ruby
irb(main):001:0> LSUUID.generate(time: t, mode: :ceil)
=> "619bd106-0c6b-ba28-ffff-ffffffffffff"
irb(main):002:0>  LSUUID.generate(time: t, mode: :ceil, prefix: 0)
=> "00000061-9bd1-060c-6bba-28ffffffffff"
```

#### **floor**
```ruby
irb(main):001:0> LSUUID.generate(time: t, mode: :floor)
=> "619bd106-0c6b-ba28-0000-000000000000"
irb(main):002:0>  LSUUID.generate(time: t, mode: :ceil, prefix: 0)
=> "00000061-9bd1-060c-6bba-280000000000"
```

### Prefix
```ruby
irb(main):001:0> LSUUID.generate(prefix: 0, time: t)
=> "00000061-9bd1-060c-6bba-28428c7e196d"
irb(main):002:0> LSUUID.generate(prefix: 1000, time: t)
=> "0003e861-9bd1-060c-6bba-28d9cb973352"
irb(main):003:0> LSUUID.generate(prefix: 16_777_215, time: t)
=> "ffffff61-9bd1-060c-6bba-2826264c51e0"
```
**Note:** Prefix can be an integer between 0 and 16,777,215

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hwslabs/lsuuid.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
