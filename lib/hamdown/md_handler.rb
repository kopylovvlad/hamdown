require 'cgi'
require 'markdown'
require_relative 'md_regs/abstract_reg'
require_relative 'md_regs/code'
require_relative 'md_regs/fonts'
require_relative 'md_regs/links'
require_relative 'md_regs/fonts2'
require_relative 'md_regs/headers'
require_relative 'md_regs/images'
require_relative 'md_regs/images_with_title'
require_relative 'md_regs/list'
require_relative 'md_regs/quotes'

module Hamdown
  # Module to recognize markdown patterns in text and compile it to html/haml
  module MdHandler
    # list of objects with rules:
    # how to recognize markdown patterns by reg_ex
    # how to replace it by html
    OBJECTS = [
      # lists should be before fonts
      MdRegs::List,
      MdRegs::Headers,
      MdRegs::Images,
      MdRegs::ImagesWithTitle,
      MdRegs::Code,
      # font should be before fonts2
      MdRegs::Fonts,
      MdRegs::Links,
      MdRegs::Fonts2,
      MdRegs::Quotes
    ].freeze

    # render text (haml + html) to html
    def self.perform(text = '')
      OBJECTS.each do |object|
        text = object.new.perform(text)
      end
      text
    end
  end
end
