require 'feedjira'
require 'lj_media/journal_parser'
require 'lj_media/post'

module LJMedia
  class Journal
    attr_reader :feed, :posts

    def initialize(username)
      feed_url = "http://#{username}.livejournal.com/data/rss?unfold_embed=1"
      feed_xml = Feedjira::Feed.fetch_raw feed_url

      @feed  = Feedjira::Feed.parse_with JournalParser, feed_xml
      @posts = @feed.posts.map { |post| Post.new(post) }
    end

    def inspect
      "#<#{self.class} #{feed.link}, @posts=#{posts.inspect}>"
    end
  end
end
