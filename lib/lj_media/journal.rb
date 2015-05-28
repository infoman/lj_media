require 'feedjira'
require 'lj_media/journal_parser'
require 'lj_media/post'

module LJMedia
  class Journal
    extend Forwardable

    attr_reader :feed
    def_delegators :feed, :posts

    def initialize(username)
      feed_url = "http://#{username}.livejournal.com/data/rss?unfold_embed=1"
      feed_xml = Feedjira::Feed.fetch_raw feed_url

      @feed  = Feedjira::Feed.parse_with JournalParser, feed_xml
    end

    def inspect
      "#<#{self.class} #{feed.link}, @posts=#{posts.inspect}>"
    end
  end
end
