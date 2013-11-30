require 'spec_helper'

describe 'githosting' do
    let(:title) { 'githosting' }

  describe 'installs custom git package' do
    let(:params) { {:git_package => 'git2'} }

    it { should contain_package('git2') }
  end

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

  describe 'grant user access' do
    let(:params) { {:authorized_users => ['foobar']} }
    let(:pre_condition) { "ssh_authorized_key { 'foobar':
      key    => 'my-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    it { should contain_githosting__authorized_user('foobar') }
  end

  describe 'creates git repository' do
    let(:params) { {:repositories => ['foobar']} }

    it { should contain_githosting__repository('foobar').with_ensure('present') }
  end
end
