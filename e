from email.message import EmailMessage
import ssl
import smtplib 

with open('settings.txt', mode='r') as file:# закоментить
    email = eval(file.read())[0]     # закоментить
email_sender = 'anastasiya.schabanowa2014@gmail.com'
email_password = 'hjmq rhrj kvjc gnjw'
email_receiver = email               # вставить твой маил 

subject = 'Check out 1..2..3..'
body = '''
here will be placed some text generated by AI
'''

em = EmailMessage()
em['From'] = email_sender
em['To'] = email_receiver
em['subject'] = subject
em.set_content(body)

context = ssl.create_default_context()

with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as smtp:
   smtp.login(email_sender, email_password)
   smtp.sendmail(email_sender, email_receiver, em.as_string())
