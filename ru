from tkinter import *
import geocoder
from tkcalendar import Calendar, DateEntry
from tkinter import Label, Tk, ttk
from PIL import Image, ImageTk
import requests
from tkinter import font
import smtplib
from datetime import timedelta
from datetime import datetime
from datetime import *
import os
sring_my = '''\n\n\n\nHello!\n\nI am called to rescue you from the hellish chaos of life. Where you can define your path, divide it into stages, understand the possibilities of time and your pace. And what is very important, you can see all the work done and admire yourself.\n\nI'll always keep you posted.'''
type_to_image = {'programming': Image.open("pc.png"), 'health': Image.open("m.png"), 'erudition': Image.open("cr.png"), 'work':Image.open("money.png"), 'cleanliness': Image.open("c.png")}
                                                 #gmail_message
#smtpobj = smtplib.SMTP('smtp.gmail.com', 587)
#smtpobj.starttls()
#smtpobj.login('anastasiya.schabanowa2014@gmail.com','№№№!')
#smtpobj.sendmail("anastasiya.schabanowa2014@gmail.com", "№№№№!")
#smtpObj.quit()




#Работа с календарем удаление
def updateLabel(a):
    labelblue.config(text="Selected Date: " + tkc.get_date(), font=85)
    for i in frame3.winfo_children():                                          #тут др фрейм
        i.destroy()
    print('current dict state : ',dict_)
    curr_date = tkc.get_date()
    dict_for_variables = {}
    for i in range( len(dict_[curr_date])):
         dict_for_variables[curr_date] = dict_for_variables.get(curr_date,[]) + [IntVar()]
         dict_for_variables[curr_date][i].set(dict_[curr_date][i][-1])
    for i in range( len(dict_[curr_date])): #восстановление окна с задачами
         current_task = dict_[curr_date][i][0] 
         #current_task[-1].pack(fil=X, font=40)
         print(current_task)
         curr_frame = Frame(frame3,  background='white',borderwidth=0,highlightthickness=0,bd=0) 
         curr_frame.pack(side='top',fill = X) 
         #a = 'Checkbutton' + str(i) + '_'.join(curr_date.split('/'))
         #locals()[a] = IntVar() # в a переменая кнопки
         #dict_for_variables[curr_date] = dict_for_variables.get(curr_date,[]) + [eval(a)]
         print('dict_for_variables', dict_for_variables)
         #eval(a).set(dict_[curr_date][i][-1])
         def callBackFunc():                 #обновление всех галочек по текущей дате
             print('функция работает исправно')
             n =0
             print('dict_for_variables',dict_for_variables)
             for form in frame3.winfo_children():
                 for widget in form.winfo_children():
                      #print(widget)
                      #print(type(widget))
                      if str(type(widget)) == "<class 'tkinter.Checkbutton'>":
                          print('dict_for_variables[curr_date][n]',repr(dict_for_variables[curr_date][n]))
                          print('dict_for_variables[curr_date][n].get()', dict_for_variables[curr_date][n].get())
                          #print('widget.variable.get()', widget.variable.get())
                          dict_[curr_date][n][-1] = dict_for_variables[curr_date][n].get()
                          print(dict_)
                          n += 1

                   
         current_task = Checkbutton(curr_frame, text = current_task, font=45,bg='white',  
                      variable = dict_for_variables[curr_date][i], 
                      onvalue = 1, 
                      offvalue = 0, highlightthickness=0,bd=0                         # command= callBackFunc aaaaaaaaaaaaaaaaaaaaa Checkbutton.command
                      )
         print('current_task.cget("text")',current_task.cget("text"))
         current_task['command'] = callBackFunc
         #print('dict_[curr_date][i]', dict_[curr_date][i] )
         print()
         #dict_[curr_date][i][-1] = eval(a).get()
         print(dict_)
         current_task.pack(side='left', padx=7)
         print(dict_)
         img = type_to_image[dict_[curr_date][i][1]]   #Image.open('mass.png') 
         resized_image = img.resize((30, 30))
         photo = ImageTk.PhotoImage(resized_image)
         lab = Label(curr_frame, image=photo )
         lab.image = photo
         lab.pack(side='right')


#first run
def hello():
    global tkc
    hello = Toplevel(root)
    root['bg'] = 'white'
    hello.title("Hellper_2.0")
    hello.geometry("1000x480")
    #hello.eval('tk::PlaceWindow . center')
    frame1 = Frame(hello, bg='white', width=200, height=200)
    frame1.pack(fill = BOTH, expand = True, side='left')
    frame2 = Frame(hello, bg='white', width=200, height=200)
    frame2.pack(fill = BOTH, expand = True, side='left')
    global icon1 
    #photo = ImageTk.PhotoImage(image)
    Label(frame1, image=icon1, bg='white').pack(fill = BOTH, expand = True, padx=12)
    global my_font 
    noteditor = Text(frame2,wrap='word', bg='white', font=my_font, highlightthickness = 0, borderwidth=0, height=14)
    noteditor.pack(fill=BOTH, expand=1,  padx=35)
   #noteditor.insert(5.5, 'Hello!')
    global sring_my
    noteditor.insert(7.0, sring_my)
    noteditor.config(state=DISABLED)
    def open_settings():
        global tkc
        hello.withdraw()
        settings_window()
    frame3 = Frame(frame2, bg='white', width=200, height=100)
    frame3.pack(fill = BOTH, expand = True, side='bottom')   
    global my_font2
    btn = Button(frame3, bg='white', text='start settings', font=my_font2, foreground='red', justify=RIGHT, command=open_settings, highlightthickness = 0, borderwidth=0)
    btn.configure(width=200, height=100)
    btn.pack(anchor='se')    	    

#settings window
def settings_window():
    global tkc
    settings.deiconify()
    frame1 = Frame(settings, bg='white')
    frame1.pack()   
    title = Label(frame1, text='Settings', font=my_font2, bg='white', highlightthickness=0, bd=0, pady=15).pack()
    frame_email = Frame(settings, bg='blue', width=200, height=100)
    frame_email.pack(fill = BOTH, expand = True) 
    title = Label(frame_email, text='Enter your mail: ', font=my_font, bg='white', highlightthickness=0, bd=0, pady=15).pack(side=LEFT, fill = X)
    entry = Entry(frame_email).pack(side=LEFT, fill = X)
    frame_name = Frame(settings, bg='blue', width=200, height=100)
    frame_name.pack(fill = BOTH, expand = True) 
    title = Label(frame_name, text='Enter your name: ', font=my_font, bg='white', highlightthickness=0, bd=0, pady=15).pack(side=LEFT, fill = X)
    entry = Entry(frame_name).pack(side=LEFT, fill = X)    
    frame_work = Frame(settings, bg='blue', width=200, height=100)
    frame_work.pack(fill = BOTH, expand = True) 
    title = Label(frame_work, text='Сhoose your work schedule: ', font=my_font, bg='white', highlightthickness=0, bd=0, pady=15).pack(side=LEFT, fill = X)
    #frame_worktime = Frame(settings, bg='green', width=200, height=100).pack(side=LEFT, fill = X).pack()
    counter = 0
    def select(selected):
         nonlocal counter
         counter +=1
         if counter >1: frame_worktime.destroy()
         frame_worktime = Frame(settings, bg='green', width=200, height=100)
         frame_worktime.pack(side=LEFT, fill = X)
         title = Label(frame_worktime, text='Set your worktime (08:00 20:00): ', font=my_font, bg='white', highlightthickness=0, bd=0, pady=15).pack(side=LEFT, fill = X)
         entry_start = Entry(frame_worktime).pack(side=LEFT, fill = X)
         entry_end = Entry(frame_worktime).pack(side=LEFT, fill = X) 
         title = Label(frame_worktime, text='Last workday: ', font=my_font, bg='white', highlightthickness=0, bd=0, pady=15).pack(side=LEFT, fill = X)
         datentry = DateEntry(frame_worktime)

         datentry.pack(side=LEFT, fill = X)


         list_of_workdays = [] 
        
         def get_schedule(A): # работа над заполнением рабочих дней
             print('HELLO')
             print(list_of_workdays)
  
             if list_of_workdays:
                 tkc.calevent_remove(*list_of_workdays)
             #nonlocal selected
             #nonlocal lastworkday
             step = int(selected.split('/')[-1])
             step_weekend = int(selected.split('/')[0])-1
             date_last = datentry.get_date() +  timedelta(days=int(selected.split('/')[-1])+1)                 #последний введеный выходной день 
             for i in range(130):
                 for j in range(int(selected.split('/')[0])):
                     work_event = tkc.calevent_create(date=date_last, text='EVENT HERE', tags='tag')
                     tkc.tag_config('tag', background='azure2', foreground='dodgerblue4')
                     list_of_workdays.append(work_event)
                     date_last = date_last + timedelta(days=1)
                 date_last = date_last + timedelta(days=step) 
                 
         datentry.bind('<<DateEntrySelected>>', get_schedule)    
                 
    btn = StringVar()
    def f(): 
        selected = btn.get()
        select(selected)
    list_ = ['5/2', '1/3', '2/2']
    for schedule in list_:
        schedule = Radiobutton(frame_work, text=schedule, value=schedule, variable=btn, command=f)
        schedule.pack(side=LEFT, fill = X)

     
    





def func():                         # Определяет геолокацию и погоду
     BASE_URL = "https://api.open-meteo.com/v1/forecast"
     g = geocoder.ip('me')
     city = g.latlng
# Параметры запроса для Краснодара
     params = {
     "latitude": city[0],       # широта Краснодара
     "longitude": city[1],      # долгота Краснодара
     "daily": "temperature_2m_min,temperature_2m_max,precipitation_sum", # минимальная и максимальная температура, сумма осадков
     "timezone": "Europe/Moscow" } # временная зона для Краснодара 
     response = requests.get(BASE_URL, params=params)
     data = response.json()
     user_name['text'] =  str(g.city) + ' : '+str(data['daily']['temperature_2m_max'][1])
     





#get_schedule(tkc) #вызываю функцию заполнения рабочими днями

#add events
#print(datetime.strptime(tkc.get_date(), '%m/%d/%y'))
#print(f'tags names - {tkc.tag_names()}')

#color of event
#print(f'tags names - {tkc.tag_names()}')
#event_my = tkc.calevent_create(date=datetime.strptime(tkc.get_date(), '%m/%d/%y'), text='EVENT HERE', tags='tag')
#tkc.tag_config('tag', background='azure3', foreground='white')
#print(tkc.get_calevents(date=datetime.strptime(tkc.get_date(), '%m/%d/%y'), tag=None))

number = 0
position = 0
dict_ = {}
def func1():
    stroka = tkc.get_date()
    

        
    newWindow = Toplevel(root)
    newWindow.title("Add your task/goal")
    newWindow.geometry("700x300")
    class_tasks = ['Goal','Task']
    combobox = ttk.Combobox(newWindow, values=class_tasks)
    combobox.pack() 
    combobox.insert(0, 'Task')
      

    def goal_or_task(a, b=False):

        if combobox.get() == 'Task' or b==True:
              def fetch():
                  task_name, task_type = tasky.get(), combobox1.get()
                  global number
                  dict_[stroka] = dict_.get(stroka, []) + [[task_name, task_type, number, False]]
                  print(dict_)
                  number += 1
                  updateLabel('a')
                  newWindow.destroy()
              newWindow.update()
              frame11 = Frame(newWindow, background='green')
              frame11.pack(fill = BOTH, expand = True)
              print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!', newWindow)
              taskname = Label(frame11, text='Set the task')
              taskname.pack(side=LEFT, fill = BOTH)
              tasky = Entry(frame11)
              tasky.pack(side=LEFT)
              frame22 = Frame(newWindow, background='white')
              frame22.pack(fill = BOTH, expand = True)
              print('!!!!!!!!!!!!!!!!!!!!!!!!',frame22 )
              types_of_tasks = Label(frame22, text='Set type')
              types_of_tasks.pack(side=LEFT, fill = BOTH)
              #tasky.bind('<Return>', fetch)
              tasks_types = ['programming', 'health', 'erudition', 'work', 'cleanliness']
              combobox1 = ttk.Combobox(frame22, values=tasks_types, background='white')
              combobox1.pack(side=LEFT)
              Button(newWindow, text='add task', command=fetch).pack(anchor='se')
              newWindow.protocol("WM_DELETE_WINDOW", updateLabel)                        #close window trigger
        elif combobox.get() == 'Goal':
              newWindow.update()
             
    goal_or_task('a', b=True)            
              
            
    combobox.bind("<<ComboboxSelected>>", goal_or_task)
    
def record():
    with open('your_story.txt', 'w') as f:
        data = str(dict_)
        f.write(data)
        root.destroy()
def read_dict():
    isempty = os.stat('your_story.txt').st_size 
    print('isempty', isempty)
    if isempty != 0:
        with open('your_story.txt') as f:
            global dict_
            dict_ = eval(f.readlines()[0])
            print('HERE===========',type(dict_))

read_dict()
root = Tk()
root.title('Hellper_2.0')
root['bg'] = '#fafafa'
icon = PhotoImage(file="aaa.png")
icon1 = PhotoImage(file="bb.png")
root.iconphoto(True, icon)
#root.eval('tk::PlaceWindow . center')
root.wm_attributes('-alpha', 0.7)
root.geometry('780x400')
    #create settings window:
settings = Toplevel(root)
root['bg'] = 'white'
settings.title("Hellper_2.0")
settings.geometry("1000x480")
root.protocol("WM_DELETE_WINDOW", record)


#root.wm_withdraw() #скрываем окно до окончания настройки
settings.wm_withdraw() #скрываем окно до окончания настройки
my_font2 = font.Font(family= "Arial", size=17,weight='bold')
my_font = font.Font(family= "Arial", size=17, weight="normal")
hello()
frame = Frame(root, bg='white', width=200, height=200)
frame.pack(fill = BOTH, expand = True, side=RIGHT)

current_font = font.Font(weight='bold', size=13)
dt_now = str(datetime.now()).split()[0].split('-')
tkc = Calendar(frame,selectmode = "day", year=int(dt_now[0]),month=int(dt_now[1]),date=int(dt_now[2]), foreground='darkorange1', font=current_font, background='white', bordercolor='azure2', headersbackground='white', weekendbackground='white', othermonthbackground='floralwhite', weekendforeground='black', othermonthwebackground='floralwhite', showweeknumbers=False, 
day=int(dt_now[2]), disabledselectbackground='yellow', disabledselectforeground='blue', disableddaybackground='pink', selectbackground='green')
tkc.pack(fill='both', expand=True, padx=17, pady=4)
tkc.bind('<<CalendarSelected>>', updateLabel) #нажатие на дату


frame1 = Frame(root, bg='white', width=200, height=200)
#frame.configure(width=520, height=500)
frame1.pack(fill = BOTH, expand = True, side=RIGHT)
frame4 = Frame(frame1, bg='white')
frame4.pack(side='top',fill = X)
frame3 = Frame(frame1, bg='white')
frame3.pack(side=TOP,fill = BOTH,expand = True)
btn1 = Button(frame4, text='ADD', bg='white', command=func1)
btn1.pack(side=LEFT)
labelblue = Label(frame4, text="Selected Date: ", font=40, bg='white')
labelblue.pack(side=LEFT) 
labelblue.config(text="Selected Date: " + tkc.get_date(), font=85)    
 
 
#Для погоды по геолокации
image = Image.open("picture.png")
resized_image = image.resize((28, 28))
photo = ImageTk.PhotoImage(resized_image)

#фрейм с погодой    
frame2 = Frame(frame, bg='white', width=100, height=100)
frame2.pack(side='top', fill = X, pady=13)

#кнопка с фото
#title = Label(frame2, bg='white')
btn = Button(frame2, text='Создать задачу', bg='white', image=photo, command=func)
btn.configure(width=28, height=28)
btn.pack(side=LEFT, padx=17, pady=1)
#title.pack(side='left')

user_name = Label(frame2, text='wheather', font=25, bg='white', highlightthickness=0,bd=0)
user_name.pack(side=LEFT)

btn.invoke() #кнопка погоды нажатие
print('cick') 



updateLabel('a')



root.mainloop()
