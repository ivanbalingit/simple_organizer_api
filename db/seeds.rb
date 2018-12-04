# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(username: 'testuser', password: 'password')

t1 = u.tasks.create(name: 'task 1 for testuser', due_date: '2018-12-04', details: 'details of task 1')
t2 = u.tasks.create(name: 'task 2 for testuser', due_date: '2018-12-04', details: 'details of task 2')
t3 = u.tasks.create(name: 'task 3 for testuser', due_date: '2018-12-04', details: 'details of task 3')

t2.subtasks.create(name: 'subtask 1 for task 2')
t2.subtasks.create(name: 'subtask 2 for task 2')
t2.subtasks.create(name: 'subtask 3 for task 2')

t1.reminders.create(reminder_date: '2018-12-04', details: 'reminder 1 for task 1')
t2.reminders.create(reminder_date: '2018-12-04', details: 'reminder 1 for task 2')

e1 = u.events.create(name: 'event 1 for testuser', event_date: '2018-12-04', time_start: '10:00', time_end: '11:00', details: 'details of event 1')
e2 = u.events.create(name: 'event 2 for testuser', event_date: '2018-12-04', time_start: '11:00', time_end: '12:00', details: 'details of event 2')
e3 = u.events.create(name: 'event 3 for testuser', event_date: '2018-12-04', time_start: '12:00', time_end: '13:00', details: 'details of event 3')

e1t1 = e1.tasks.create(name: 'task 1 for event 1', due_date: '2018-12-04', details: 'details of e1t1')
e1t2 = e1.tasks.create(name: 'task 2 for event 1', due_date: '2018-12-04', details: 'details of e1t2')
e2t1 = e2.tasks.create(name: 'task 1 for event 2', due_date: '2018-12-04', details: 'details of e2t1')
e2t2 = e2.tasks.create(name: 'task 2 for event 2', due_date: '2018-12-04', details: 'details of e2t2')

e2t1.subtasks.create(name: 'subtask 1 for task 1 of event 2')
e2t1.subtasks.create(name: 'subtask 2 for task 1 of event 2')

e1t1.reminders.create(reminder_date: '2018-12-04', details: 'reminder 1 for task 1 of event 1')
e2t2.reminders.create(reminder_date: '2018-12-04', details: 'reminder 1 for task 2 of event 2')

u.notes.create(note_text: 'note 1 for testuser')
u.notes.create(note_text: 'note 2 for testuser')