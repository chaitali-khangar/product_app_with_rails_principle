module FormatDate
  extend ActiveSupport::Concern
  def format_date(from_format,to_date,date)
  	Date.strptime(date.strftime(from_format),to_date)
  end
end