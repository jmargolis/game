require 'spec_helper'

describe 'game' do
  it 'starts' do
    expect(Game.start).to be_true
  end
end