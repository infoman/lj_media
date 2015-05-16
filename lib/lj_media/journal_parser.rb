require 'sax-machine'
require 'feedjira'
require 'lj_media/post_parser'

module LJMedia
  class JournalParser
    include SAXMachine
    include Feedjira::FeedUtilities

    element  :"lj:journalid",   as: :id,        class: Integer
    element  :"lj:journaltype", as: :type
    element  :"lj:journal",     as: :name
    element  :title
    element  :description
    element  :link
    element  :lastBuildDate,    as: :published

    elements :item,             as: :posts,     class: PostParser
  end
end
