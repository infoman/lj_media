require 'spec_helper'

describe LJMedia::Journal do
  before(:context) do
    @comm = LJMedia::Journal.new 'ru-chp'

    # TODO: change to some user that do not renames himself so often
    #       and has some undercores in username
    @user = LJMedia::Journal.new 'v-glaza-smotri'
  end

  describe '#new' do
    it 'must not accept usernames starting with underscore or dash' do
      expect { LJMedia::Journal.new '-test' }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new '_test' }.to raise_error(LJMedia::Error::InvalidUsername)
    end

    it 'must not accept usernames ending with underscore or dash' do
      expect { LJMedia::Journal.new 'test-' }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'test_' }.to raise_error(LJMedia::Error::InvalidUsername)
    end

    it 'must not accept usernames containing 2 or more subsequent underscores/dashes' do
      expect { LJMedia::Journal.new 'te--st'  }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'te__st'  }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'te-_st'  }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'te_-st'  }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'te---st' }.to raise_error(LJMedia::Error::InvalidUsername)
    end

    it 'must not accept usernames containing characters other than latin letters, numbers and underscores/dashes' do
      expect { LJMedia::Journal.new 'фываtest' }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'test!@#$' }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new 'te st'    }.to raise_error(LJMedia::Error::InvalidUsername)
      expect { LJMedia::Journal.new "test\n"   }.to raise_error(LJMedia::Error::InvalidUsername)
    end

    it 'must not accept usernames longer than 15 characters' do
      expect { LJMedia::Journal.new 'testverylongname' }.to raise_error(LJMedia::Error::InvalidUsername)
    end

    it 'must not accept empty usernames' do
      expect { LJMedia::Journal.new '' }.to raise_error(LJMedia::Error::InvalidUsername)
    end

    it 'must not accept non-string username arguments' do
      expect { LJMedia::Journal.new 12345 }.to raise_error(ParamContractError)
    end
  end

  describe '#feed' do
    it 'must be an instance of LJMedia::JournalParser' do
      expect(@comm.feed).to be_a(LJMedia::JournalParser)
      expect(@user.feed).to be_a(LJMedia::JournalParser)
    end
  end

  describe '#id' do
    it 'must be a positive Integer' do
      expect(@comm.id).to be_an(Integer)
      expect(@user.id).to be_an(Integer)

      expect(@comm.id).to be > 0
      expect(@user.id).to be > 0
    end
  end

  describe '#type' do
    it 'must be :community for community journals' do
      expect(@comm.type).to be(:community)
    end

    it 'must be :personal  for personal journals' do
      expect(@user.type).to be(:personal)
    end
  end

  describe '#name' do
    it 'must return an original LiveJournal username' do
      expect(@comm.name).to eq('ru_chp')
      expect(@user.name).to eq('v_glaza_smotri')
    end
  end

  describe '#title' do
    it 'must have a String value' do
      expect(@comm.title).to be_a(String)
      expect(@user.title).to be_a(String)
    end
  end

  describe '#description' do
    it 'must have a String value' do
      expect(@comm.description).to be_a(String)
      expect(@user.description).to be_a(String)
    end
  end

  describe '#link' do
    it 'must be a journal URL' do
      expect(@comm.link).to be_an(URI::HTTP).and eq(URI 'http://ru-chp.livejournal.com/')
      expect(@user.link).to be_an(URI::HTTP).and eq(URI 'http://v-glaza-smotri.livejournal.com/')
    end
  end

  describe '#published' do
    it 'must have a Time value' do
      expect(@comm.published).to be_a(Time)
      expect(@user.published).to be_a(Time)
    end

    it 'must not be in the beginning of Unix Epoch' do
      expect(@comm.published.year).to be > 1970
      expect(@user.published.year).to be > 1970
    end
  end

  describe '#posts' do
    it 'must be an array of LJMedia::Post entries' do
      expect(@comm.posts).to be_an(Array)
      expect(@user.posts).to be_an(Array)

      [@comm, @user].each do |journal|
        expect(journal.posts).to all(be_a LJMedia::Post)
      end
    end
  end
end
