require 'spec_helper'

describe 'githosting::authorized_user' do
  let(:title) { 'foobar' }

  describe 'adds custom ssh key to service user' do
    let(:params) { {:service => 'service'} }
    let(:pre_condition) { "ssh_authorized_key { 'foobar':
      key    => 'my-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    it { should contain_ssh_authorized_key('githosting_foobar').with_user('service').with_key('my-key') }
  end

  describe 'allows to override the username' do
    let(:params) { {:service => 'git', :username => 'custom-user'} }
    let(:pre_condition) { "ssh_authorized_key { 'custom-user':
      key    => 'another-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    it { should contain_ssh_authorized_key('githosting_custom-user').with_key('another-key') }
  end
end
