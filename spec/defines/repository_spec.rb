require 'spec_helper'

describe 'githosting::repository' do
  let(:title) { 'example' }
  let(:exec_command) { '/usr/bin/git init --bare /var/git/example.git' }

  describe 'by default' do
    it { should contain_exec(exec_command).with_user('git') }
  end
end
