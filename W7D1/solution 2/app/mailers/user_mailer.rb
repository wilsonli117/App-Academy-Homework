class UserMailer < ApplicationMailer
    default from: 'from@example.com'

    def welcome_email(user)
        @user = user
        @url = 'http://localhost:3000/session/new'
        attachments['picture.jpg'] = File.read('app/assets/images/picture.jpg')
        mail(to: @user.username, subject: 'Welcome')
    end
end
