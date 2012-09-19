require 'helper'

class TestClass
  include Babelfish
  translates :a, :b, :c
end

class I18n; end

class TestBabelfish < Test::Unit::TestCase
  context 'translates' do
    setup do
      @model = TestClass.new
      @fields = [:a, :b, :c]
      I18n.stubs(:locale).returns(:es)
      I18n.stubs(:default_locale).returns(:en)
    end

    should 'define a method for each attribute' do
      @fields.each do |field|
        assert @model.respond_to? field
      end
    end

    should 'define a setter for each attribute' do
      @fields.each do |field|
        assert @model.respond_to? "#{field}="
      end
    end

    should 'access the db based on the locale' do
      @model.expects(:read_attribute).with('a_es').returns(true)
      @model.a
    end

    should 'raise on set' do
      begin
        @model.a = 1
        assert false
      rescue
        assert true
      end
    end

    should 'default when no attribute for current locale' do
      @model.expects(:read_attribute).with('a_es').returns(nil)
      @model.expects(:read_attribute).with('a_en').returns(true)
      @model.a
    end

    should 'raise when no attribute' do
      @model.expects(:read_attribute).twice.returns(nil)
      begin
        @model.a
        assert false
      rescue
        assert true
      end
    end
  end
end
