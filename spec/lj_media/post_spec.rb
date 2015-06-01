require 'spec_helper'

describe LJMedia::Post do
  before(:context) do
    @comm = LJMedia::Journal.new 'ru-chp'
    @post = @comm.posts.first
  end

  describe '#entry_id' do
    it 'must have a String value' do
      expect(@post.entry_id).to be_a(String)
    end

    it 'must be unique across all journal posts' do
      guids = []
      @comm.posts.each do |post|
        expect(guids).not_to include(post.entry_id)
        guids << post.entry_id
      end
    end
  end

  describe '#published' do
    it 'must have a Time value' do
      expect(@post.published).to be_a(Time)
    end

    it 'must not be in the beginning of Unix Epoch' do
      expect(@post.published.year).to be > 1970
    end
  end

  describe '#title' do
    it 'must have a String or nil value' do
      expect(@post.title).to be_a(String).or be(nil)
    end
  end

  describe '#link' do
    it 'must be an URL of the post in the journal' do
      expect(@post.link).to be_a(URI::HTTP)
      expect(@post.link.host).to end_with('.livejournal.com')
      expect(@post.link.path).to match(/\/\d+\.html/i)
    end
  end

  describe '#content' do
    it 'must be an instance of Loofah::HTML::DocumentFragment' do
      expect(@post.content).to be_a(Loofah::HTML::DocumentFragment)
    end

    it 'can be easily converted to_text or to_html' do
      expect(@post.content).to respond_to(:to_html)
      expect(@post.content).to respond_to(:to_text)
    end
  end

  describe '#tags' do
    it 'must be an Array of String tag names' do
      expect(@post.tags).to be_an(Array)
      expect(@post.tags).to all(be_a String)
    end
  end

  describe '#access' do
    it 'must be a Symbol specifying post access restrictions' do
      expect(@post.access).to be_a(Symbol)
    end

    it 'must be :public for all posts we can access without authentication' do
      expect(@post.access).to be(:public)
    end
  end

  describe '#comments_count' do
    it 'must be a non-negative Integer' do
      expect(@post.comments_count).to be_an(Integer)
      expect(@post.comments_count).not_to be < 0
    end
  end

  describe '#author' do
    it 'must be an instance of LJMedia::Author' do
      expect(@post.author).to be_an(LJMedia::Author)
    end
  end
end
