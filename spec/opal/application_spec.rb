require 'spec_helper'

describe Inesita::Application do
  let(:application) { Inesita::Application }
  let(:layout) { Class.new { include Inesita::Layout } }
  let(:store) { Class.new { include Inesita::Store } }
  let(:router) do
    Class.new do
      include Inesita::Router

      class TestComponent
        include Inesita::Component
      end

      def routes
        route '/', to: TestComponent
      end
    end
  end

  it 'should respond to #render' do
    expect(application.new(router: router)).to respond_to(:render)
  end

  it 'should fail with wrong :router class' do
    expect { application.new(router: Class) }.to raise_error Inesita::Error
  end

  it 'should not fail with :router class' do
    expect { application.new(router: router) }.not_to raise_error
  end

  it 'should fail with wrong :layout class' do
    expect { application.new(layout: Class) }.to raise_error Inesita::Error
  end

  it 'should not fail with :layout class' do
    expect { application.new(layout: layout) }.not_to raise_error
  end

  it 'should fail with wrong :store class' do
    expect { application.new(store: Class) }.to raise_error Inesita::Error
  end

  it 'should not fail with :layout class' do
    expect { application.new(router: router) }.not_to raise_error
  end
end
