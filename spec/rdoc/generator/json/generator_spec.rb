require 'spec_helper'

describe RDoc::Generator::JSON::Generator do

  let(:subject) { described_class.new(store, options) }
  let(:store) { "store" }
  let(:options) { {some: 'options'} }

  it 'stores the options' do
    expect(subject.options).to eql(options)
  end

  it 'stores the store' do
    expect(subject.store).to eql(store)
  end

end
