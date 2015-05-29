require 'feedjira'
require 'lj_media/journal_parser'
require 'lj_media/post'

module LJMedia

  # Public: This class represents an LJ journal specified by username.
  #
  # See the LJMedia::JournalParser docs for attributes description.
  #
  # Examples
  #
  #   journal = LJMedia::Journal.new('ru-chp')
  #   journal.type #=> :community
  class Journal
    extend Forwardable

    # Internal: Underlying Feedjira parser defined in LJMedia::JournalParser
    #
    # You should only call this if you have a reason for accessing some #
    # of Feedjira provided functionality, and I can not guarantee that it #
    # will not break with Feedjira updates. Only attributes listed in this #
    # document will continue to work until the next major version of lj_media.
    attr_reader :feed

    private
    # Internal: Dummy methods to allow rdoc to correctly parse attr_reader
    # for delegate
    def self.pass_methods(*methods)
      delegate methods => :feed
    end
    public

    ##
    # :attr_reader:
    #
    # Public: \Journal attribute processed by LJMedia::JournalParser
    pass_methods :id, :type, :name,
                 :title, :description,
                 :link, :published,
                 :posts

    # Public: Initialize journal parser by passing a LiveJournal username.
    #
    # username - [ String ] LiveJournal username. Can be personal journal or a community
    #
    # *TODO*: check username validity
    #
    # *TODO*: support custom feed links, including local files for testing #
    # purposes
    def initialize(username)
      feed_url = "http://#{username}.livejournal.com/data/rss?unfold_embed=1"
      feed_xml = Feedjira::Feed.fetch_raw feed_url

      @feed  = Feedjira::Feed.parse_with JournalParser, feed_xml
    end

    # :stopdoc:
    def inspect
      "#<#{self.class} #{feed.link}, @posts=#{posts.inspect}>"
    end
  end
end
