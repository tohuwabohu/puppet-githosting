require 'spec_helper'

describe 'githosting::repository' do
  let(:title) { 'example' }
  let(:exec_command) { '/usr/bin/git init --bare /var/git/example.git' }

  describe 'by default' do
    specify { should contain_exec(exec_command).with_user('git') }
  end

  describe 'with ensure => absent' do
    let(:params) { {:ensure => 'absent'} }

    specify { should_not contain_exec(exec_command) }
    specify { should contain_file('/var/git/example.git').with_ensure('absent') }
  end
end
