class UserForgery < Forgery
  def self.user_parms
    password = BasicForgery.password
    {
      :login => NameForgery.first_name,
      :name => NameForgery.full_name,
      :email => InternetForgery.email_address,
      :password => password,
      :password_confirmation => password,
      :address => { :address => UkAddressForgery.address },
      :need_ids => needs
    }
  end
  
  def self.needs
    @@need_count ||= Need.count
    (0..rand(10)).to_a.map { |a| rand(@@need_count)+1 }.uniq
  end
end
