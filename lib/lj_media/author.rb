require 'contracts'
require 'active_support/cache'
require 'active_support/cache/memory_store'

module LJMedia

  # Public: Represents the post author
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
    Contract Integer, String => LJMedia::Author
    def self.new(userid, username)
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
    Contract Integer, String => Any
    def initialize(userid, username)
      @id       = userid
      @username = username
      @type     = (/\Aext_\d+\z/ === username) ? :identity : :local
    end
  end
end
