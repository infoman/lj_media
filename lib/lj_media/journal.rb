require 'feedjira'
require 'contracts'
require 'lj_media/journal_parser'
require 'lj_media/post'
require 'lj_media/errors'

module LJMedia

  # This class represents an LJ journal specified by username.
  #
  # See the {LJMedia::JournalParser} docs for attributes description.
  #
  # @example
  #   journal = LJMedia::Journal.new('ru-chp')
  #   journal.type #=> :community
  class Journal
    extend Forwardable
    include Contracts

    # @return [LJMedia::JournalParser] underlying Feedjira parser
    #
    # ### Underlying Feedjira parser. Not intended for public use.
    #
    # You should only call this if you have a reason for accessing some
    # of Feedjira provided functionality, and I can not guarantee that it
    # will not break with Feedjira updates. Only attributes listed in this
    # document will continue to work until the next major version of lj_media.
    #
    # @api private
    attr_reader :feed

    # @!group Journal attributes processed by LJMedia::JournalParser
    # @!parse attr_reader :id, :type, :name, :title, :description,
    #                     :link, :published, :posts
    delegate [ :id, :type, :name,
               :title, :description,
               :link, :published,
               :posts ] => :feed
    # @!endgroup

    # Initializes journal parser by passing a LiveJournal username.
    #
    # @param username LiveJournal username. Can be personal journal or a community
    # @raise [LJMedia::Error::InvalidUsername] if the provided username
    #   is not valid according to LiveJournal rules
    # @todo support custom feed links, including local files for testing
    #   purposes
    Contract String => Any
    def initialize(username)
      if /(\A[\-_])|([\-_]\z)|([\-_]{2,})|([^a-zA-Z0-9\-_]+)|(.{16,})|(\A\z)/ === username
        raise LJMedia::Error::InvalidUsername, username
      end

      feed_url = "http://#{username}.livejournal.com/data/rss?unfold_embed=1"
      feed_xml = LJMedia::fetch feed_url

      @feed  = Feedjira::Feed.parse_with JournalParser, feed_xml
    end

    # @private
    Contract None => String
    def inspect
      "#<#{self.class} #{feed.link}, @posts=#{posts.inspect}>"
    end
  end
end
