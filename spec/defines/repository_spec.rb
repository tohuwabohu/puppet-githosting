require 'spec_helper'

describe 'githosting::repository' do
  let(:title) { 'example' }

  describe 'owned by service user' do
    let(:params) { {:service => 'foobar', :data_dir => '/var/git'} }

    it { should contain_exec('git_repository_example').with_user('foobar') }
  end

  describe 'creates repository in custom location' do
    let(:params) { {:service => 'foobar', :data_dir => '/somewhere/else'} }

    it { should contain_exec('git_repository_example').with_creates('/somewhere/else/example.git/HEAD') }
  end
end
