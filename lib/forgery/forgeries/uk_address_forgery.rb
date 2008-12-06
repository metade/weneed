class UkAddressForgery < AddressForgery
  def self.address
    "#{dictionaries[:post_codes].random}, UK"
  end
end
