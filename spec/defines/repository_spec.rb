require 'spec_helper'

describe 'githosting::repository' do
  let(:title) { 'example' }
  let(:repo) { '/var/git/example.git' }

  describe 'by default' do
    specify { should contain_vcsrepo(repo).with(
        'ensure'   => 'bare',
        'provider' => 'git',
        'user'     => 'git',
      )
    }
  end

  describe 'with ensure => absent' do
    let(:params) { {:ensure => 'absent'} }

    specify { should contain_vcsrepo(repo).with_ensure('absent') }
  end
end
