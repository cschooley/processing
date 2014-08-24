import java.util.Date; //Used to print date to console (for debugging & verification).

/* My stab at the video you showed me. I have a different image of the same subject, so the pixels
won't be exactly right, and the colors look dimmer, but you get the idea.
*/

/* Default url, about the same size as the other, but a differnt file, so who knew who scaled
   this and what scaling/interpolation method their software used (won't be a pixel perfect
   match for whatever that guy used).
   
   To "switch" to one of the other URLs uncomment (remove the '//' in front of the one you want
   to use. You need to then comment out the old one by adding '//'.
   
   The smaller image makes the sketch shorter at 15fps. You can play around google images
   to find a larger image. Be careful not to make it too big.
   
*/
//String url = "http://wfiles.brothersoft.com/a/a_s/andromeda-galaxy_88049-480x360.jpg";

/*Test URL. A checkered pattern helps to (maybe) visually determine that we did the nested loops right
 this should just look like yellow and red bars that trade placed (it's a checkerboard in reality) */

//String url = "http://fc05.deviantart.net/fs70/f/2011/331/a/1/checkered_flag_background_by_percyfan94-d4hhpf5.jpg";

/* This one's really big */

// String url = "http://i.imgur.com/Uwy8J.jpg";

//Chop your JPEG's on a mirror!!!!
String url = "http://www.metalmusicarchives.com/images/covers/metallica-master-of-puppets.jpg";

// Load image (from URL above) from a web server
PImage webImg = webImg = loadImage(url, "jpg");

/* Offset the time spent loading the image, running setup() so it doesn't count against time animating. 
 *We'll set it later, just need it scoped out here.
 */
int animationStartTime;
boolean isFirstLoop = true;

//Processing specific method to set stuff up (runs once)
void setup() {
  /*Set the processing sketch size to the same as the image.
    PROTIP: don't set the URL above to something larger 
    than your monitor.
  */
  size(webImg.width,webImg.height);
  
  //Processing way to set number of times draw() is called a second
  //frameRate(60);  
  
}


//Since we set frameRate draw() will loop forever
void draw() {
  
  PImage frame = createImage(webImg.width, webImg.height, RGB);
  //See: http://www.processing.org/reference/PImage.html, http://processing.org/reference/javadoc/core/
  frame.loadPixels();
  //frame.pixels = webImg.pixels;
 
 /* Here's where we loop through the image from 0,0 to 0, imageWidth...ending
    on imageWidth, imageHeight see note below on how processing stores the 
    pixels in a sucky 1D array.
 
     Note: "frameCount" is a magical variable that processing exposes
    to automatically track the number of times draw() was called */
 
   
   int now = millis(); //Save it to a variable because no two calls to millis() will be the same. //<>//

   
   if (isFirstLoop)
   {
     System.out.println(new Date());
     animationStartTime = now;
     isFirstLoop = false; //don't come in here again.
   }
 
   int animationTime = now - animationStartTime;
   int speed = 5; //Complete animation in 'speed' seconds
   int location = animationTime/(speed*2); //TODO JDN - why do I have to double speed here?
   
 
 
 
 //If we're not on the last column (so we don't blow the array bounds as that's bad)   
 if (location < webImg.width)
 {
   /*For each row starting at 0 while rowNumber is less than the
   image width loop and increnemt rowNumber.
   
   varName++ means increment.
   */ 
   

   
   for (int rowNumber=0; rowNumber< webImg.width; rowNumber++)
    {
      /*for each column starting at 0 until the last one, incrementing by 1 */
      for (int columnNumber=0; columnNumber< webImg.height; columnNumber++)
      {
        /*Processing is cool, but it stores all image arrays as single dimensional
          with 0,0 being the upper left corner, working to the right filling the image
          like a jar (you get to figure where the image should wrap with PImage.width).
          That complicates making a "column" so that we can smear it to the right.
        */
        System.arraycopy(webImg.pixels, (columnNumber*webImg.width)+location, frame.pixels, (columnNumber*webImg.width)+rowNumber, 1);
        //System.out.println("Milis: "+now+"Vanilis: "+new Date());
      }
    }
 }
else
{
  System.out.println(new Date());
  exit();
}
  
  frame.updatePixels();
  //don't need to set background color.
  //background(0);
  image(frame, 0, 0);
}
