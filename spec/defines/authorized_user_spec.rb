require 'spec_helper'

describe 'githosting::authorized_user' do
  let(:title) { 'foobar' }

  describe 'should add ssh key' do
    let(:params) { {} }
    let(:pre_condition) { "ssh_authorized_key { 'foobar':
      key    => 'my-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    specify { should contain_ssh_authorized_key('githosting_foobar').with(
        'ensure' => 'present',
        'user'   => 'git',
        'key'    => 'my-key',
        'type'   => 'ssh-rsa'
      )
    }
  end

  describe 'should add ssh key' do
    let(:params) { {:ensure => 'absent'} }

    specify { should contain_ssh_authorized_key('githosting_foobar').with_ensure('absent') }
  end

  describe 'should support custom username' do
    let(:params) { {:username => 'custom-user'} }
    let(:pre_condition) { "ssh_authorized_key { 'custom-user':
      key    => 'another-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    specify { should contain_ssh_authorized_key('githosting_custom-user').with_key('another-key') }
  end
end
