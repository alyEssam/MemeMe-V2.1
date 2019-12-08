# MemeMe-V2.1


MemeMe is a meme-generating app that enables a user to attach a caption to a picture from their phone. After adding text to an image chosen from the Photo Album or Camera, the user can share it with friends. MemeMe also temporarily stores sent memes which users can browse in a table or a grid.
The app has three pages of content:
Meme Editor View: Enables a user to add text to an image and share it. 
Sent Memes View: Enables a user to browse sent memes in a table or a grid.
Meme Detail View: Displays an image of a sent meme
The three pages are described in detail below.
Meme Editor View

The Meme Editor View consists of an image view overlaid by two text fields, one near the top and one near the bottom of the image. This view has a bottom toolbar with two buttons: one for the camera and one for the photo album. The top navigation bar has a share button on the left displaying Apple’s stock share icon and a “Cancel” button on the right.

![image](https://user-images.githubusercontent.com/46827335/70395933-9f22a900-1a0c-11ea-97f0-6bdb209d6e07.png)

![image](https://user-images.githubusercontent.com/46827335/70395938-af3a8880-1a0c-11ea-9775-ce7c91c120f9.png)


 Sent Memes View 

The sent memes view displays recently sent memes. It has a bottom toolbar with tabs that allow the user to toggle between viewing sent memes in a table and viewing them in a grid. The top navigation bar has a title that reads “Sent Memes” and an add button in the right corner displaying Apple’s stock “Add” icon.
If the user taps the “table” tab on the left of the bottom toolbar, sent memes are displayed in a table. If the user taps on the “collection” tab on the right of the bottom toolbar, sent memes are displayed in a grid. Selecting a meme from the table or collection presents the Meme Detail View. Pressing the “add” button brings up the Meme Editor View.  

![image](https://user-images.githubusercontent.com/46827335/70395942-b82b5a00-1a0c-11ea-95f9-24cb71a2c164.png)

![image](https://user-images.githubusercontent.com/46827335/70395944-bcf00e00-1a0c-11ea-95a6-bc3c76a5996b.png)


Meme Detail View

The Meme Detail View displays the selected meme in an image view in the center of the page with the meme’s original aspect ratio. The detail view has a back arrow in the top left corner. To the right of the arrow reads the title of the previous view, “Sent Memes.”
User Flow

When the user first launches the app the Sent Memes View will appear. It will be the root view of the navigation stack. When the user taps the + button in the top right corner the app should push the Meme Editor View on top of the Sent Memes View.
In the Meme Editor View, when the user clicks on the “Album” button, an Image Picker is presented, making it possible to choose an image from the Photo Album. If there is a camera available on the device, pressing the camera button launches the camera, and a newly snapped photo can be chosen for the meme. If a camera is not available on the device, the camera button is disabled.
After an image is chosen, the image picker is dismissed, allowing text to be entered into the top and bottom text fields of the editor. When a user clicks inside one of the text fields, the default text disappears and the keyboard slides up. When the user finishes entering text and presses return, the keyboard is dismissed and the new meme is displayed.
MemeDetailView.png
When the user presses the share button, Apple’s stock Activity View appears, displaying several options for sharing the meme. After an option is chosen, the Activity View is dismissed and the Sent Memes View appears. The Sent Memes View also appears upon pressing the “Cancel” button.
Selecting a meme from the table or collection presents the Meme Detail View. Clicking on the  back arrow of the Meme Detail View presents the previous Sent Memes View, either the table or collection.  

![image](https://user-images.githubusercontent.com/46827335/70395946-c24d5880-1a0c-11ea-884f-05e047399dae.png)

