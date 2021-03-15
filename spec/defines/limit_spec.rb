# frozen_string_literal: true

require 'spec_helper'

describe 'limits::limit' do
  let(:title) { 'namevar' }
  let(:params) do
    {
      'item'  => 'core',
      'value' => 0,
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it do
        is_expected.to compile
      end
    end
  end
end
