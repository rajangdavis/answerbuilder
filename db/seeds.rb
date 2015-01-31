# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
Answer.create(language: 'English', series:'QT', tagline: 'Your DVR is set to record video whenever motion is detected 24/7. You can create your own schedule.', title: 'Motion Detection Schedule')
Step.create(number: 1,step_type:'Step' ,step:'Right-click with the mouse to open the [bold]Control Bar[/bold] at the bottom left of the screen.' ,image:'i.imgur.com/4miCe0n.png' ,offset: 0,answer_id:1 )
Step.create(number: 2,step_type:'Step' ,step:'Click on the [bold]Main Menu[/bold].' ,image:'i.imgur.com/JmcFbei.png' ,offset: 0,answer_id:1 )
Step.create(number: 3,step_type:'Step' ,step:'Click on [bold]Setup[/bold].' ,image:'i.imgur.com/YewRFF6.png' ,offset: 0,answer_id:1 )
Step.create(number: 4,step_type:'Step' ,step:'Click on [bold]Alarm[/bold].' ,image:'i.imgur.com/csCcPPc.png' ,offset: 0,answer_id:1 )
Step.create(number: 5,step_type:'Step' ,step:'Click on [bold]Motion[/bold].' ,image:'i.imgur.com/koyuEzd.png' ,offset: 0,answer_id:1 )
Step.create(number: 6,step_type:'Step' ,step:'Select the [bold]Schedule[/bold] tab.' ,image:'i.imgur.com/SLpoI7S.png' ,offset: 1,answer_id:1 )
Step.create(number: 6,step_type:'Information' ,step:'Motion detection will only occur if the [bold]Enable[/bold] box is checked for that camera under the [bold]Motion[/bold] tab.' ,image:'i.imgur.com/ss2Jkm9.png' ,offset: 0,answer_id:1 )
Step.create(number: 7,step_type:'Step' ,step:'Select the Channel you want to schedule.' ,image:'i.imgur.com/ImVXzl8.png' ,offset: 1,answer_id:1 )
Step.create(number: 8,step_type:'Step' ,step:'Select the [bold]Eraser[/bold] button and click in a time block to turn off motion detection.[br]' ,image:'i.imgur.com/Bw0NpB6.png' ,offset: 2,answer_id:1 )
Step.create(number: 8,step_type:'Information ' ,step:'Areas filled with blue are times when motion detection is active.[br]The [bold]Eraser[/bold] button is used to turn off motion detection.[br]The [bold]Pencil[/bold] button turns motion detection back on.' ,image:'i.imgur.com/V5lPHn3.png' ,offset: 1,answer_id:1 )
Step.create(number: 9,step_type:'Step' ,step:'Click [bold]Apply[/bold] to save your settings.' ,image:'i.imgur.com/9WTIbne.png' ,offset: 2,answer_id:1 )
Step.create(number: 10,step_type:'Information' ,step:'In order to copy schedules to another channel, please follow the following steps:[br][br]1. Select the schedule you want to copy.[br]2. Using the pull-down, select the channel(s) you want to apply the settings to.[br]3. Click [bold]Copy[/bold].[br]4. Click [bold]Apply[/bold] to save your settings.[br]' ,image:'i.imgur.com/l80bOTQ.png' ,offset: 2,answer_id:1 )
Step.create(number: 10,step_type:'Step' ,step:'Repeat for additional cameras, or click [bold]Exit[/bold] to close.' ,image:'' ,offset: 0,answer_id: 1)