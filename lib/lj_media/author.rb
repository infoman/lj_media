require 'contracts'

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
