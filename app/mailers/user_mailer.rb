


def welcome (current_user)
  unless current_user.nil?
    mail(
        :from => "myid@gmail.com",
        :to => current_user.email,
        :subject => "Thank you for signing"
    )
  else
    mail(
        :from => "myid@gmail.com",
        :to => "test@mail.com",
        :subject => "Thank you for signing"
    )
  end
end