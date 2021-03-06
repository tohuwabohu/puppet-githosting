require 'spec_helper'

describe 'githosting' do
  let(:title) { 'githosting' }

  describe 'by default' do
    let(:params) { {} }

    specify { should contain_package('git').with_ensure('latest') }
    specify { should contain_user('git').with_ensure('present') }
    specify { should contain_user('git').with_shell('/usr/bin/git-shell') }
    specify { should contain_user('git').with_home('/var/git') }
    specify { should contain_user('git').with_system(true) }
    specify { should contain_group('git').with_ensure('present') }
    specify { should contain_group('git').with_system(true) }
  end

  describe 'should install custom git package' do
    let(:params) { {:git_package_name => 'dunno'} }

    specify { should contain_package('dunno') }
  end

  describe 'should install custom git version' do
    let(:params) { {:git_package_ensure => '1.2.3'} }

    specify { should contain_package('git').with_ensure('1.2.3') }
  end

  describe 'creates custom user' do
    let(:params) { {:service_name => 'foobar'} }

    specify { should contain_user('foobar').with_ensure('present') }
    specify { should contain_group('foobar').with_ensure('present') }
  end

  describe 'with service_uid => 123' do
    let(:params) { {:service_uid => 123} }

    specify { should contain_user('git').with_uid(123).with_gid('git') }
    specify { should contain_group('git').with_gid('') }
  end

  describe 'with service_gid => 123' do
    let(:params) { {:service_gid => 123} }

    specify { should contain_user('git').with_uid('').with_gid('git') }
    specify { should contain_group('git').with_gid(123) }
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

    specify { should contain_githosting__repository('foobar') }
  end

  describe 'with ensure => absent' do
    let(:params) { {:ensure => 'absent', :authorized_users => ['foobar'], :repositories => ['foobar']} }

    specify { should contain_user('git').with_ensure('absent') }
    specify { should contain_githosting__authorized_user('foobar').with_ensure('absent') }
    specify { should contain_githosting__repository('foobar').with_ensure('absent') }
  end
end
