# For each of the following scenarios, write down the models, columns, validations and associations you might use to implement it.

# 1. You are building an online learning platform (much like this!). You’ve got many different courses, 
# each with a title and description, and each course has multiple lessons. Lesson content consists of a title and body text.
model Course
columns: title:string, [unique: true, not null]
description: string
id: integer

has_many lessons

model Lesson
columns: title:string [unique: true, not null]
body: text
course_id: integer[present: true]

belongs_to course

# 2. You are building the profile tab for a new user on your site. You are already storing your user’s username and email, 
# but now you want to collect demographic information like city, state, country, age and gender. 
# Think – how many profiles should a user have? How would you relate this to the User model?

model User
columns: 
username:string [uniqu: true] 
email:string [unique: true]
id: integer
has_one personal_info

model personal_info
columns:
city:string [not null]
state:string [not null]
country:string [not null]
age: integer[ validates > 0, not null]
gender:string [not null]

belongs_to user

# 3. You want to build a virtual pinboard, so you’ll have users on your platform who can create “pins”. 
# Each pin will contain the URL to an image on the web. Users can comment on pins (but can’t comment on comments).

model User
columns: 
username:string [unique: true] 
email:string [unique: true]
id: integer

has_many pins
has_many comments

model Pin 
columns:
URL: string[not null]
user_id: integer[not null]
id: integer

belongs_to user
has_many comments

model Comment
columns:
user_id: integer [not null]
pin_id: integer [not null]
id:integer 
body: text [not null]

belongs_to user
belongs_to pin

# 4. You want to build a message board like Hacker News. Users can post links. Other users can comment on these submissions or 
# comment on the comments. How would you make sure a comment knows where in the hierarchy it lives?

model post
link: string
id: integer

belongs_to user
has_many comments as commentable

model comment
body: text

belongs_to commentable, polymorphic true
has_many comments as commentable
