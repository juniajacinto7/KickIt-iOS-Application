Original App Design Project
===

# KickIt

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
KickIt is a casual hangout app that allows users to mark interesting locations on a map for their friends and, if they choose, other users. Users can create location invites that prompt friends and/or other users on their devices. The app provides directions for users that accept the invites.

### App Evaluation

- **Category:** Social Media / Travel
- **Mobile:** KickIt would primarily be more effective on mobile but future development for laptops and desktops may be viable for providing more access options for users.
- **Story:** Provides a map layout which users can place markers and images onto. The markers have an extra option for invites that users can fill out and send to friends and/or random users. The app sends a notification and an invite to the sendee and if the sendee clicks accept then the map sends directons.
- **Market:** This app is free-to-use and available to everyone. However, filters can be applied by users to hone in on certain markers. Users can also block invites on their device. Users can set an age limit for more explicit locations.
- **Habit:** Users can use this app for setting up parties and other events at specific locations so usage depends on how socially active the user is.
- **Scope:** In early stages, KickIt will probably be limited to marking interesting locations and sending invites. With further development, providing directions may become a later feature. The app may feature hotspots and videos for locations similar to Snapchat's SnapMaps. Potential integration into Snapchat and other social media platforms.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] User logs in to access account settings and view friends
* [x] User accesses a map that can focus and expand with details becoming more explicit as the map focuses
* [x] User can place and delete a marker on any location on the map
* [x] Markers have an extra option for adding text and images which can be used for details about the location or what is going on at that location
* [x] User can log in and log out
* [x] User can upload photos

**Optional Nice-to-have Stories**

* [x] Map visually displays popularity/activity hotspots
* [ ] Videos can be applied to markers
* [ ] Users can rate hotspots/activities

### 2. Screen Archetypes

* Login
* Register
   * Upon download or opening of the app, the user is prompted to login to access the app's features
* Map Screen
   * After logging in or registering, user views the map of their local area. Users can view invites and markers, both private and public.
* Profile Screen
   * Users can open their profile and view their settings and preferences.
* Events Screen
   * Users can view private and public events in the area specified on the map. Clicking on a marker will navigate to the locations and/or event's description here.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Map Display
* Profile and Settings
* Even
**Flow Navigation** (Screen to Screen)

* Forced login
   * if no login, create account
* Map marker clicked
   * Clicking marker navigates to events screen
* Events list
   * Displays private and public events
   * Clicking an event will show its location on the map
* Profile
   * Toggle settings and preferences
* Chat
   * Chat with friends/strangers about event details

## Wireframes
<img src="https://i.imgur.com/kRNrU4D.jpg" width=600>

## Schema 

### Models

**Post**
| Property | Type | Description |
| -------- | ---- | ----------- | 
| objectID | String | unique id for the user post (default field) |
| author | Pointer to User | image author |
| image | File | image that user post | 
| location | FIND HOW TO SAVE LOC ON PARSE | image that user post | 
| title | String | title posted by author |
| caption | String | image caption by author |
| commentsCount | Number | number of comments posted to an image |
| likesCount | Number | number of likes for post |
| createdAt | DateTime | date when post is created (default field) |

**User**
| Property | Type | Description |
| -------- | ---- | ----------- | 
| objectID | String | unique id for the user (default field) |
| firstName | String | users first name |
| lastName | String | users last name |
| profilePic | File | image of user |
| age | String | age of user |
| email | String | email for user login |
| profileIntro | String | a small intro for user profiles |

**Comment** 
| Property | Type | Description |
| -------- | ---- | ----------- | 
| objectID | String | unique id for the user post (default field) |
| author | Pointer to User | image author |
| comment | String | comment by user |

**Bookmark**
| Property | Type | Description |
| -------- | ---- | ----------- | 
| objectID | String | unique id for the user post (default field) |
| author | Pointer to User | bookmark author |
| Bookmark | Pointer to Post | post that users want to save |

**Like**
| Property | Type | Description |
| -------- | ---- | ----------- | 
| objectID | String | unique id for the user post (default field) |
| author | Pointer to User | like author |
| like | boolean | if a user liked a post |

### Networking
* Map Screen   
  * (Read/GET) Query all posts near user
     ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
* Register
  * (Create/POST) Create a new user object
      ```swift
          let user = PFObject(className:"User")
          user["firstName"] = userInput
          user["lastName"] = userInput
          user["profilePic"] = userInput
          user["age"] = userInput
          user["email"] = userInput
          user["profileIntro"] = userInput
          user.saveInBackground { (succeeded, error)  in
            if (succeeded) {
              // The object has been saved.
            } else {
              // There was a problem, check error.description
            }
          }
* Events Screen 
  * (Read/GET) Query all posts near user
      ```swift
         let query = PFQuery(className:"Post")
         query.whereKey(NEAR USER)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
  * (Create/POST) Create a new like on a post
      ```swift
          let like = PFObject(className:"Like")
          like["author"] = currentUser
          like["like"] = true
          like.saveInBackground { (succeeded, error)  in
            if (succeeded) {
              // The object has been saved.
            } else {
              // There was a problem, check error.description
            }
          }
  * (Delete) Delete existing like
       ```swift
          PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
            if (succeeded) {
              // The array of objects was successfully deleted.
            } else {
              // There was an error. Check the errors localizedDescription.
            }
          }
  * (Create/POST) Create a new comment on a post
       ```swift
          let comment = PFObject(className:"Comment")
          comment["author"] = currentUser
          comment["like"] = true
          comment.saveInBackground { (succeeded, error)  in
            if (succeeded) {
              // The object has been saved.
            } else {
              // There was a problem, check error.description
            }
          }
  * (Delete) Delete existing comment
      ```swift
          PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
            if (succeeded) {
              // The array of objects was successfully deleted.
            } else {
              // There was an error. Check the errors localizedDescription.
            }
          }
  * (Create/POST) Create new bookmark
     ```swift
          let bookmark = PFObject(className:"Bookmark")
          bookmark["author"] = currentUser
          bookmark["like"] = true
          bookmark.saveInBackground { (succeeded, error)  in
            if (succeeded) {
              // The object has been saved.
            } else {
              // There was a problem, check error.description
            }
          }
  * (Delete) Delete existing bookmark
      ```swift
          PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
            if (succeeded) {
              // The array of objects was successfully deleted.
            } else {
              // There was an error. Check the errors localizedDescription.
            }
          }
* Chat Screen
  * (Read/GET) Query all users near author
      ```swift
         let query = PFQuery(className:"Post")
         query.whereKey(NEAR USER)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
* User Profile
  * (Read/GET) Query logged in user object
      ```swift
          let query = PFQuery(className:"User")
          query.getObjectInBackground(withId: "currentUser") { (User, error) in
            if error == nil {
              // Success!
            } else {
              // Fail!
            }
          }
  * (Update/PUT) Update user profile 
      ```swift
          let user = PFObject(className:"User")
          user["firstName"] = userInput
          user["lastName"] = userInput
          user["profilePic"] = userInput
          user["age"] = userInput
          user["email"] = userInput
          user["profileIntro"] = userInput
          user.saveInBackground { (succeeded, error)  in
            if (succeeded) {
              // The object has been saved.
            } else {
              // There was a problem, check error.description
            }
          }
  * (Read/GET) Query all Bookmarks where user is author
     ```swift
         let query = PFQuery(className:"Bookmark")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
  * (Read/GET) Query all Posts where user is author
     ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
  * (Read/GET) Query all Likes where user is author
      ```swift
          let query = PFQuery(className:"Like")
          query.whereKey("author", equalTo: currentUser)
          query.order(byDescending: "createdAt")
          query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
         
## Video Walkthrough
**Presintation**
<img src="http://g.recordit.co/PwXFGWAJ5d.gif" width=250><br>

**App Demo**
<img src="http://g.recordit.co/uZh88amdB4.gif" width=250><br>


