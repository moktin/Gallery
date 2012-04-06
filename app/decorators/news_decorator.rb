class NewsDecorator < ApplicationDecorator
  decorates :news

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"),
  #                   :class => 'timestamp'
  #   end

  def display_date
    display_date = "// "
    if start_at and end_at
      if start_at.month == end_at.month and start_at.year == end_at.year
        display_date << "#{I18n.t('from_to')} #{I18n.l(start_at, :format => :really_short)} #{I18n.t('to')} #{I18n.l(end_at, :format => :short)}"
      elsif start_at.year == end_at.year
        display_date << "#{I18n.t('from_to')} #{I18n.l(start_at, :format => :some_short)} #{I18n.t('to')} #{I18n.l(end_at, :format => :short)}"
      else
        display_date << "#{I18n.t('from_to')} #{I18n.l(start_at, :format => :short)} #{I18n.t('to')} #{I18n.l(end_at, :format => :short)}"
      end
    elsif start_at
      display_date << "#{I18n.t('from')} #{I18n.l(start_at, :format => :short)}"
    end
    (display_date << " //").html_safe
  end
end
