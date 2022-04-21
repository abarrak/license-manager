class ExpiryCalculator
  def calculate record
    expiry_date = case record
      when Date
        record
      when DateTime
        record
      when ApplicationRecord
        record.current_expire_date
      else
    end
    days = (Date.today..expiry_date).count
    days.zero? ? 0 : days - 1
  end
end
