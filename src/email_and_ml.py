#Импортируем необходимые модули
from email.message import EmailMessage
import ssl
import smtplib 
from datetime import *
from transformers import pipeline
from transformers import AutoTokenizer, AutoModelForSeq2SeqLM

#Загружаем настройки
with open('settings.txt', mode='r') as file:# закоментить
    email = eval(file.read())[0]     # закоментить
email_sender = 'anastasiya.schabanowa2014@gmail.com'
email_password = 'hjmq rhrj kvjc gnjw'
email_receiver = email               # вставить свой маил

subject = 'Reminder of your task for today'
body = ''
with open('your_story.txt', mode='r') as file:
    date_in_dict = eval(file.read())[datetime.today().date().strftime('%m/%d/%y')]
    print('date_in_dict = ',date_in_dict)
    for index, task in enumerate(date_in_dict,1):
        #print('{task[0]}: {task[-2]}\n', f'{task[0]}: {task[-2]}.')
        body += f'{index}. {task[0]}: {task[-2]};' #берем текст для модели
#print( body)

#Инициируем модель генерации текста письма для отправки
#Выбираем модель en-ru "Helsinki-NLP/opus-mt-ru-en"
tokenizer = AutoTokenizer.from_pretrained("Helsinki-NLP/opus-mt-ru-en")
model = AutoModelForSeq2SeqLM.from_pretrained("Helsinki-NLP/opus-mt-ru-en")

inp = body # текстовая строка для перевода en-ru
input_ids = tokenizer(inp, return_tensors="pt").input_ids # подготовка входных данных для модели
outputs = model.generate(input_ids=input_ids, num_beams=5, num_return_sequences=1) # генерация перевода
generated = tokenizer.batch_decode(outputs, skip_special_tokens=True)[0].split(';') # переведенный текст
print('generated', generated)
generated = ''.join(generated #объединяем текст

#Задаем параметры сообщения e-mail
em = EmailMessage()
em['From'] = email_sender
em['To'] = email_receiver
em['subject'] = subject
em.set_content(generated) #Текст сообщения
context = ssl.create_default_context() #

#Отправляем письмо
with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as smtp:
   smtp.login(email_sender, email_password)
   smtp.sendmail(email_sender, email_receiver, em.as_string())
