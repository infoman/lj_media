module LJMedia
  class Author
    attr_accessor :id, :username, :type

    def initialize(userid, username)
      @id       = userid
      @username = username
      @type     = (/\Aext_\d+\z/ === username) ? :identity : :local
    end
  end
end
