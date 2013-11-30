require 'spec_helper'

describe 'githosting' do
    let(:title) { 'githosting' }

    describe 'installs latest git by default' do
      let(:params) { {} }

      it { should contain_package('git').with_ensure('latest') }
    end

  describe 'installs custom git version' do
    let(:params) { {:git_version => '1.2.3'} }

    it { should contain_package('git').with_ensure('1.2.3') }
  end

  describe 'creates user git by default' do
    let(:params) { {} }

    it { should contain_user('git').with_ensure('present') }
  end

  describe 'creates custom user' do
    let(:params) { {:service => 'foobar'} }

    it { should contain_user('foobar').with_ensure('present') }
  end

  describe 'creates home directory by default' do
    let(:params) { {} }

    it { should contain_user('git').with_home('/var/git') }
  end

  describe 'creates custom home directory' do
    let(:params) { {:data_dir => '/somewhere/else'} }

    it { should contain_user('git').with_home('/somewhere/else') }
  end
end
