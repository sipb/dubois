class User < ActiveRecord::Base
  has_many :subscribers

  def name
    if self.email.downcase.include?("@mit.edu")
      self.email[0..self.email.index("@") - 1]
    else
      self.email
    end
  end

  def affiliation
    kerberos['eduPersonAffiliation']
  end

  def full_name
    kerberos['displayName']
  end
  
  def class_year
    year = kerberos['mitDirStudentYear']
    if year == "G"
      "Graduated"
    else
      year
    end
  end

  def street
    kerberos['street']
  end

  def room
    kerberos['roomNumber']
  end


  def visible_attributes
    [:name, :email, :full_name, :room, :street, :affiliation]
  end

  private

    def kerberos
      MIT::LDAP.connect! unless MIT::LDAP.connected?
      @kerberos ||= MIT::LDAP.search(:filter => "(uid=#{self.name})").first
    end
end
