= Totito

This is a simple gem to aid in the translation of Rails models, using I18n.

== Installation

Just add the gem to the `Gemfile`:

    gem 'totito'

and install it:

    bundle install


== Usage

The usage of this gem is very simple. First, you should have your database prepared with some fields named `field_LANGUAGE`, where LANGUAGE is the different languages you want to use. For example, in a migration:

    class CreateBook < ActiveRecord::Migration
      def change
        create_table :projects do |t|
          t.string :slug
          t.string :name_es
          t.string :name_en
          t.string :screenshot
          t.text :description_es
          t.text :description_en
          t.boolean :published, default: false
        end
      end
    end

Now, in the model, you just have to say what you want translated:

    class Book < ActiveRecord::Base
      attr_accessible :slug, :screenshot, :published

      translates :name, :description
    end

As simple as that. Now, when you call one of those fields, you will get the one specified by `I18n.locale`, or, if it is not found, the one specified by `I18n.default_locale`.

    book = Book.create(name_es: 'El Hobbit', name_en: 'The Hobbit')
    I18n.locale = :es
    book.name
    # => 'El Hobbit'
    I18n.locale = :en
    book.name
    # => 'The Hobbit'
