class ClaimMailer < ApplicationMailer

  default from: 'claims@mybandsource.com'

  def claim_email(artist, email)
    @artist = artist
    @email = email
    mail(to: 'chris.susskind@mybandsource.com', subject: "Claim: #{@artist} wants a profile.")
  end
end
