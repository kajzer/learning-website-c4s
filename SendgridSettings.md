For those who don't have paid Mandrill account, this section is for you as you now can use Sendgrid instead for free (first 12K emails/month).

Step 1: Go to Sendgrid to register a new account for free plan (12K emails/month). You can use the random info for address, company, website.
Step 2: Check your email and click on the confirm link that Sendgrid sent to complete the process.
Step 3: Install gem Sendgrid. Open Gemfile and add new gem (you can remove gem Mandrill if you want)
1
gem 'sendgrid-ruby'
Step 4A: Open config\environments\development.rb, replace your STMP settings as below:
1
2
3
4
5
6
7
8
config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    enable_starttls_auto: true,
    user_name: 'YOUR_SENDGRID_USERNAME',
    password: 'YOUR_SENDGRID_PASSWORD',
    authentication: 'plain'
}
Step 4B: Open config\initializers\devise.rb, update config.mailer_sender as below:
1
config.mailer_sender = 'YOUR_NAME <your_email@abc.com>'
Step 5: Open Terminal and install new gem
1
$bundle install
Step 6: Restart the server
1
$rails s
Step 7: Create template for our transactional email with Sendgrid. Go to https://sendgrid.com/templates
Step 8: Click "Create Template" button > Enter the name of template > Click "Save" button > Click "Actions" button and select Add Version option.
Step 9: Design the template as you want. Don't forget enter the Template name before click "Save" button.
Step 10: Go back to this page: https://app.sendgrid.com/settings/api_keys and create General API Key. For now, we can select full access for all options. Click Save button and copy the API key. NOTE: The key is only displayed one time, so please copy and save it somewhere.
Step 11: Open your Terminal, run:
1
$rails g mailer MyMailer
Step 12: Open app/mailer/my_mailer.rb and UPDATE as below
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
class MyMailer < ActionMailer::Base

  def sendgrid_client
    @sendgrid_client ||= SendGrid::API.new(api_key: "Your General API KEY")
  end

  def new_user(user)
    template_id = "template_id_of_new_user"

    data = {
      "personalizations": [
        {
          "to": [
            {
              "email": user.email
            }
          ],
          "substitutions": {
            "-name-": "USER_NAME",
            "-content-": user.name
          },
          "subject": "Welcome to Code4Pro"
        }
      ],
      "from": {
        "email": "code4startup@gmail.com"
      },
      "template_id": template_id
    }

    sendgrid_client.client.mail._("send").post(request_body: data)
  end
end
Step 13: Open the User model and a callback function to send email after create new user:
1
2
3
4
5
6
7
8
class User < ActiveRecord::Base
  ## ...
  after_create :send_notification

  def send_notification
    MyMailer.new_user(self).deliver
  end
end