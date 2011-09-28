require 'spec_helper'

describe Guard::Lacquer do
  let(:guard) { described_class.new([], options) }
  let(:options) { {} }

  subject { guard }

  describe '#initialize' do
    its(:options) { should == options }
  end
end

