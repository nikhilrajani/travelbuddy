# travelbuddy
State Management: 
1) User --> email,username,profile picture,bio,followers,following
2) Post --> source,destination,date of journey,weight, price,photo,date of publish,user

The above state management provides us the basic functionality required for the task, it also holds potential for further improvements. To make this application interactive between users, we can add features like following, like posts etc. Eventually we can scale this up to a full social media app for travel routes. Right now every user can see every post on the application.

Using various loading bars for showing the loading state is one of the design decisions that I took. I have also added an AppBar at the bottom to switch between the two screen and used snackbars to dispplay errors/success.

The option of delete post is in the postcard itself to ease the design. One can sign out from the application with the iconbutton on the top right of the feed screen.
