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

    it { should contain_ssh_authorized_key('githosting_foobar').with_user('git').with_key('my-key') }
  end

  describe 'allows to override the username' do
    let(:params) { {:username => 'custom-user'} }
    let(:pre_condition) { "ssh_authorized_key { 'custom-user':
      key    => 'another-key',
      type   => 'ssh-rsa',
      user   => 'foobar',
    }" }

    it { should contain_ssh_authorized_key('githosting_custom-user').with_key('another-key') }
  end
end
