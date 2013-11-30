require 'spec_helper'

describe 'githosting' do
    let(:title) { 'githosting' }

    describe 'installs latest git' do
      let(:params) { { } }

      it { should contain_package('git').with_ensure('latest') }
    end

  describe 'creates user git' do
    let(:params) { { } }

    it { should contain_user('git').with_ensure('present') }
  end
end
