class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless UrlUtil.valid_url? value
      record.errors.add(attribute, (options[:message] || I18n.t(:"validations.commons.invalid_url")))
    end
  end
end