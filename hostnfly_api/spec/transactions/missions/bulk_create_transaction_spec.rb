require 'rails_helper'

RSpec.describe Missions::BulkCreateTransaction do
  subject { described_class.call(resource: listings) }

  describe 'for valid listings' do
    let(:listings) { create_list(:complete_listing, 5) }
    it 'succeeds' do
      expect(subject).to be_success
    end
  end
end
