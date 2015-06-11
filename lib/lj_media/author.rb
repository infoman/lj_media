require 'contracts'
require 'feedjira'
require 'nokogiri'
require 'active_support/cache'
require 'active_support/cache/memory_store'

# Additional methods for Nokogiri::HTML::Document to allow it to be cached
# properly. Do not use them directly. Refer to Nokogiri documentation
# if you need direct parser access.
# @api private
class Nokogiri::HTML::Document
  include Contracts

  # Dumps profile page document to html to save it in the cache
  # @param level internal value passed from Marshal
  # @return string prepared for caching
  # @api private
  Contract Integer => String
  def _dump(level)
    self.to_html
  end

  # Restores parser object from cached page to not load it again
  # @param html cached HTML content
  # @return restored document parser
  # @api private
  Contract String => Nokogiri::HTML::Document
  def self._load(html)
    Nokogiri::HTML(html)
  end
end

module LJMedia

  # Represents the post author
  class Author
    include Contracts

    # @return [Integer] LiveJournal user id
    attr_reader :id

    # @return [String] LiveJournal username
    attr_reader :username

    # @return [Symbol] account type(`:local` or `:identity`)
    attr_reader :type

    # Creates a new Author object or return the existing one from cache
    #
    # @param userid   LiveJournal user id
    # @param username LiveJournal username
    Contract Integer, Maybe[String] => LJMedia::Author
    def self.new(userid, username = nil)
      @@cache ||= ActiveSupport::Cache::MemoryStore.new

      if cached_value = @@cache.read(userid)
        cached_value
      else
        cached_value = super
        @@cache.write(userid, cached_value)
        cached_value
      end
    end

    # Parses post author data from user id and username
    #
    # @param userid   LiveJournal user id
    # @param username LiveJournal username
    #
    # @todo parse detailed user info from his profile page
    # @todo raise some useful error if user does not exist or when LJ server
    #       fails
    Contract Integer, Maybe[String] => LJMedia::Author
    def initialize(userid, username = nil)
      @id       = userid
      @username = (username || profile.at_css('span.ljuser').attribute('lj:user').value)
      @type     = (/\Aext_\d+\z/ === username) ? :identity : :local

      self
    end

    # @private
    Contract None => String
    def inspect
      "#<#{self.class} @id=#{id}, @username=#{username.inspect}, @type=#{type.inspect}>"
    end

    private
    Contract None => Nokogiri::HTML::Document
    def profile
      if @profile.nil?
        profile_url = "http://www.livejournal.com/profile?userid=#{@id}"
        @profile    = Nokogiri::HTML(Feedjira::Feed.fetch_raw profile_url)
      end
      @profile
    end
  end
end
