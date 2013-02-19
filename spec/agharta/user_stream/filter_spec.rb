
require 'spec_helper'

describe Agharta::UserStream::Filter do
  before do
    Context = Class.new do
      include Agharta::Configuration
    end
    @context = Context.new
    @filter = Agharta::UserStream::Filter.new(@context)
  end

  describe '#track' do
    it 'should set it to track parameter' do
      @filter.track('twitter', 'tumblr')
      @filter.params[:track].should == 'twitter,tumblr'
    end
  end

  describe '#locations' do
    it 'should set it to locations parameter' do
      @filter.locations(-122.75, 36.8, -121.75, 37.8)
      @filter.params[:locations].should == '-122.75,36.8,-121.75,37.8'
    end
  end

  describe '#follow' do
    it 'should set it to follow parameter' do
      @filter.follow(60032150)
      @filter.params[:follow].should == '60032150'
    end
  end

  describe '#execute' do
    before do
      @connection = @filter.send(:connection)
      @filter.stub(:connection).and_return(@connection)
      @connection.should_receive(:filter)
    end

    it 'should call TweetStream#filter' do
      @filter.execute
    end
  end
end
