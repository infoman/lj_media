require 'feedjira'
require 'lj_media/journal_parser'

module LJMedia
  class Journal
    attr_reader :feed

    def initialize(username)
      feed_url = "http://#{username}.livejournal.com/data/rss?unfold_embed=1"
      feed_xml = Feedjira::Feed.fetch_raw feed_url

      @feed = Feedjira::Feed.parse_with JournalParser, feed_xml
    end
  end
end
