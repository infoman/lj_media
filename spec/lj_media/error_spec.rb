require 'spec_helper'

describe LJMedia::Error::InvalidUsername do
  it 'must be initialized by a username and return it via #username attribute' do
    bad_name = '-test'
    expect { raise LJMedia::Error::InvalidUsername, bad_name }.to raise_error { |error|
      expect(error).to be_an(LJMedia::Error::InvalidUsername)
      expect(error.username).to eq(bad_name)
    }
  end

  it 'must not accept non-string username argument (as Journal doesn\'t too)' do
    expect { raise LJMedia::Error::InvalidUsername, 12345 }.to raise_error(ParamContractError)
  end
end
