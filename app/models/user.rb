class User < ActiveRecord::Base
  has_many :followers
  has_many :mailing_lists, through: :followers

  def name
    if self.email.downcase.include?("@mit.edu")
      self.email[0..self.email.index("@") - 1]
    else
      self.email
    end
  end

  def affiliation
    self.kerberos['eduPersonAffiliation']
  end

  def full_name
    self.kerberos['displayName']
  end
  
  def class_year
    year = self.kerberos['mitDirStudentYear']
    if year == "G"
      "Graduated"
    else
      year
    end
  end

  def street
    self.kerberos['street']
  end

  def room
    self.kerberos['roomNumber']
  end


  def visible_attributes
    [:name, :email, :full_name, :room, :street, :affiliation]
  end

  def kerberos
    MIT::LDAP.connect! unless MIT::LDAP.connected?
    @kerberos ||= MIT::LDAP.search(:filter => "(uid=#{self.name})").first || {}
  end
end
