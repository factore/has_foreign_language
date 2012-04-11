require 'spec_helper'
require 'i18n'

# Define some classes so we don't have to load Rails
class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

class Column
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

class FakeAR
  include Factore::HasForeignLanguage
  attr_accessor :title, :title_fr, :title_de

  def initialize(title, title_fr, title_de)
    @title, @title_fr, @title_de = title, title_fr, title_de
  end

  def []=(key,val)
    self.send("#{key}=", val)
  end

  def self.columns
    %w{title title_de title_fr}.inject([]) {|sum, memo| sum << Column.new(memo) }
  end
end

class Company < FakeAR
  has_foreign_language :title
end

describe Company do
  describe "With a default locale of English" do
    before do
      I18n.default_locale = :en
      @company = Company.new("English", "French", "German")
    end

    it ".title should return 'English'" do
      @company.title.should == "English"
    end

    it ".title should return 'French' when the locale is set to :fr" do
      I18n.locale = :fr
      @company.title.should == "French"
    end

    it ".title should return 'German' when the locale is set to :de" do
      I18n.locale = :de
      @company.title.should == "German"
    end

    it ".title_en should be the same as .title" do
      @company.title_en.should == @company.title
    end
  end

  describe "With a default locale of Swedish" do
    before do
      I18n.default_locale = :sw
      Company.send(:has_foreign_language, :title) # Have to send it again since default_locale has changed
      @company = Company.new("Swedish", "French", "German")
    end

    it ".title should return 'Swedish'" do
      @company.title = "Swedish"
      @company.title.should == "Swedish"
    end

    it ".title should return 'French' when the locale is set to :fr" do
      I18n.locale = :fr
      @company.title.should == "French"
    end

    it ".title should return 'German' when the locale is set to :de" do
      I18n.locale = :de
      @company.title.should == "German"
    end

    it ".title_sw should be the same as .title" do
      @company.title_sw.should == @company.title
    end
  end
end