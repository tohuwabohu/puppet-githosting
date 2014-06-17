require 'spec_helper'

describe 'githosting' do
  let(:title) { 'githosting' }

  describe 'installs custom git package' do
    let(:params) { {:git_package => 'git2'} }

    specify { should contain_package('git2') }
  end

  describe 'installs latest git by default' do
    let(:params) { {} }

    specify { should contain_package('git').with_ensure('latest') }
  end

  describe 'installs custom git version' do
    let(:params) { {:git_version => '1.2.3'} }

    specify { should contain_package('git').with_ensure('1.2.3') }
  end

  describe 'uses custom git executable' do
    let(:params) { {:git_executable => '/somewhere/else/git', :repositories => ['foobar']} }

    specify { should contain_githosting__repository('foobar').with_git_executable('/somewhere/else/git') }
  end

  describe 'creates user git by default' do
    let(:params) { {} }

    specify { should contain_user('git').with_ensure('present') }
  end

  describe 'sets git shell' do
    let(:params) { {} }

    specify { should contain_user('git').with_shell('/usr/bin/git-shell') }
  end

  describe 'creates custom user' do
    let(:params) { {:service => 'foobar'} }

    specify { should contain_user('foobar').with_ensure('present') }
  end

  describe 'creates home directory by default' do
    let(:params) { {} }

    specify { should contain_user('git').with_home('/var/git') }
  end

  describe 'creates custom home directory' do
    let(:params) { {:data_dir => '/somewhere/else'} }

    specify { should contain_user('git').with_home('/somewhere/else') }
  end

  describe 'grant user access' do
    let(:params) { {:authorized_users => ['foobar']} }
    let(:pre_condition) { "ssh_authorized_key { 'foobar':
      key    => 'my-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    specify { should contain_githosting__authorized_user('foobar') }
  end

  describe 'creates git repository' do
    let(:params) { {:repositories => ['foobar']} }

    specify { should contain_githosting__repository('foobar').with_ensure('present') }
  end
end