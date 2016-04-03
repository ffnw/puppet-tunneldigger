require 'spec_helper'
describe 'tunneldigger' do

  context 'with defaults for all parameters' do
    it { should contain_class('tunneldigger') }
  end
end
