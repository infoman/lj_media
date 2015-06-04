require 'contracts'
require 'active_support/cache'
require 'active_support/cache/memory_store'

module LJMedia

  # Public: Represents the post author
  class Author
    include Contracts

    # Public: LiveJournal user id
    attr_reader :id

    # Public: LiveJournal username
    attr_reader :username

    # Public: Account type(+local+ or +identity+)
    attr_reader :type

    Contract Integer, String => Exactly[self]
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

    # Public: Parses post author data from user id and username
    #
    # userid   - [ Integer ] LiveJournal user id
    # username - [ String ]  LiveJournal username
    #
    # *TODO*: parse detailed user info from his profile page
    Contract Integer, String => Any
    def initialize(userid, username)
      @id       = userid
      @username = username
      @type     = (/\Aext_\d+\z/ === username) ? :identity : :local
    end
  end
end
