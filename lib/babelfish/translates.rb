module Babelfish

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def translates(*attrs)
      attrs.each do |att|
        define_method att do
          read_attribute("#{att}_#{::I18n.locale}") ||
            read_attribute("#{att}_#{::I18n.default_locale}") ||
            raise('Attribute not found')
        end

        define_method "#{att}=" do
          raise 'You should not set directly a virtual babel fish attribute!'
        end
      end
    end
  end

end
