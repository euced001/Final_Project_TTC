//SOURCES: 
//https://youtu.be/aKYlikFAV4k for A* Algorithm
//SOURCES: The Coding Train Coding Challenge: https://youtu.be/aKYlikFAV4k //This was for Astar.
//SOURCES: Part 2: https://youtu.be/EaZxUCWAjb0
//SOURCES: My OWN implementing_ASTAR_draft2
//SOURCES: Guide to Anticipatory Collision Avoidance Chapter 19 by Stephen Guy and Ioannis Karamouzas //This is for TTC
//SOURCES: // Liam's Camera was Created for CSCI 5611 by Liam Tyler and Stephen Guy
//SOURCES: For the angle b/w two vectors: https://www.youtube.com/watch?v=dYPRYO8QhxUs
//SOURCES: TO create the solar system: https://www.youtube.com/watch?v=l8SiJ-RmeHU&t=472s
//https://www.youtube.com/watch?v=dncudkelNxw
//SOURCE: For planet images: http://planetpixelemporium.com/
//SOURCE: for alien and ships https://drive.google.com/drive/folders/1rPLtJJCmqcKKU-YBiqaDVZxHBBo1t3-5
//SOURCES: debris picture https://phys.org/news/2018-11-space-debris-cleanup-national-threat.html


//NOTES:
//Boids appears to be working.
//need to add boids to work with the debris
//UPDATE: BFS works and adding the obstacles works. Was not able to get the user to click on the location to add the obstacle but we can add obstacles 
//by a mouseclick and the debris obstacle shows up and BFS reruns with every obtacle added.
//UPDATE: rev1_solar_system is for the solar system
//PURPOSE: The purpose of final_project_rev1 is to put together all the components of the project in this file and clean up the code.
//UPDATE: Changed all the drawing functions to work with the 3d plane. Compared them to the draw functions in loading_obj_file_examples_draft4. 
//Old draw functions are in final_project_draft4_aStar
//UPDATE: Also update the findPRMpoints() function to work within the plane Dimensions
//UPDATE: As of 8/19/20 all the code is in this file. And BFS works
//OLD NOTES:
//the paths are draw for each agent using the agent.arrayOfPoints

/*Astar appears to be working, but sometimes it breaks and goes directly through the obstacle.
 *this may be due to how the goal is placed in the the arrayOfPoints b/c we can see that the goal is drawn three times;
 *as of 8/19/20 this is also true for BFS
*/



//^Still need to move the agent along the path and this requires call update position and updating the nextNode part correctly-for AStar
//Q:why is goal a part of the closedSEt???A:This makes sense based on how AStar works. Also, if we look at the coding challenge example and take out the path drawing code, the path will be all red
//^Sometimes the code breaks
//^//not sure what to do with the the draw functions
//^also did not change anything about the user added obstacel functions

//TODO: update stuff to work in the xz-plane
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//for camera
Camera camera;

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;


//PeasyCam cam;

//Alien

PShape person;


//for 3d scenes
float planeLen = 600; //planeLen is actually 2x this value 
float planeYValue = 300;

int numAgents = 10;//10; //1;
int numpoints = 10;//25;//10; //numpoints is the number of sample points for PRM
int radiusOfPercep = 50;//500; //50;
int radius = 50; //10; //sphere radius //50 is the radius of the sun
//int agentAndTargetRadius = 25;
int agentAndTargetRadius = 15;

VECTOR ZERO = new VECTOR (0,0,0); //the zero vector
VECTOR SUN = new VECTOR (0, planeYValue, 0);

//VECTOR sphere = new VECTOR(400,400,0);
VECTOR sphere = new VECTOR(0,planeYValue,0);
VECTOR steering = new VECTOR(0,0,0);
VECTOR goal = new VECTOR(planeLen, planeYValue, -planeLen); 
VECTOR agentStart = new VECTOR(-375, planeYValue, 375); //to be on the one corner of the plane
VECTOR point; //???
AGENT[] agent1; //the agents contain the horse position, velocity, acceleration, starting posotion, goal, and path
VECTOR[] PRMpoints = new VECTOR[numpoints]; //this stores the PRM points
VECTOR[] stars = new VECTOR[100]; 

//this is for the user to draw obstacles //keep in mind that bfs has to be called again if we add new obstacles
int debrisTotal = 0;
int numSatellites = 1000;
CIRCLE[] debris;
//for solar system
float currentAngle = 0;
PLANET sun; //I know the sun is not a planet.

PImage sunTexture;
PImage[] textures = new PImage[5];

//we can only have one earth
boolean earth = false;

void setup(){
        //size(600,600);
        size(600,600, P3D);
        //cam = new PeasyCam(this, 100); //look at the center of the world from 100 units away
        setUpStars();
        camera = new Camera();
        setUpPlane();
        setUpShips();
        //findPRMpoints();      
        //prmConnect();
       agent1 = new AGENT[numAgents];
       // debris = new CIRCLE[numSatellites]; //max size of circles is 1000 
       //agent1[0] = new AGENT(PRMpoints, agentStart);// all agents start at the same position
       //agent1[0].colors = #3FD61E;
       ////agent1[i].AStartSetup();                
       ////println("Astar SETUP is complete for agent", i);   
       //agent1[0].bfs();
       //println("BFS is complete for agent", 0);
       //            agent1[0].nextNode = agent1[0].path.size()-2;          
        //for(int i = 1; i < numAgents; i++){ 
        //           VECTOR random = new VECTOR(random(-planeLen, planeLen), planeYValue, random(-planeLen, planeLen)); 
        //           agent1[i] = new AGENT(random); 

                   
        //           //agent1[i] = new AGENT(PRMpoints, agentStart);// all agents start at the same position
        //           //agent1[i].colors = #3FD61E;
        //           ////agent1[i].AStartSetup();                
        //           ////println("Astar SETUP is complete for agent", i);   
        //           //agent1[i].bfs();
        //           //println("BFS is complete for agent", i);
        //           //agent1[i].nextNode = agent1[i].path.size()-2;                   
        //}  
        
        //for ttc
        //for(int i = 1; i < numAgents; i++){        
        for(int i = 0; i < numAgents; i++){
             //*VECTOR random = new VECTOR(random(50, 150),random(550,700),0); 
             VECTOR random = new VECTOR(random(-100,100),planeYValue,random(-100,100));
             //VECTOR random = new VECTOR(random(-planeLen, planeLen), planeYValue, random(-planeLen, planeLen));              
             
             float randomRadius = random(0, 150);
             //goal = new VECTOR(random(0, width), random(0, height), 0);
            

             agent1[i] = new AGENT(random, randomRadius, goal); //this is for the ttc radius
           
        }
       // println("Set up is complete!");
       /*add to set up setupShips()
       // currentAngle = atan(agentStart.zp/agentStart.xp);
       // print(degrees(currentAngle));
       //// spaceShip.rotateY(currentAngle);       
       // spaceShip.rotateX(PI);
       // spaceShip.scale(10);  //10 is the ideal 
       */
       
       //for solar system
       sunTexture = loadImage("sun.jpg");  
       textures[0] = loadImage("earth.jpg");
       textures[1] = loadImage("mars.jpg");
       textures[2] = loadImage("pluto.jpg");
       textures[3] = loadImage("neptune.jpg");
       textures[4] = loadImage("jupiter.jpg");
       sun = new PLANET(100, 0, 0, sunTexture);   
       sun.spawnMoons(8, 1); // We are at level zero
       //person
       person = loadShape("astronaut.obj");
       pushMatrix();
       person.rotateX(PI/2);
       person.scale(5);
       popMatrix();

       
       
       
}
//Start: For Camera////////////////////////For Camera//////////////////////////////For Camera/////////////////////////////////
void keyPressed()
{
  camera.HandleKeyPressed();
}

void keyReleased()
{
  camera.HandleKeyReleased();  
}
//End: For Camera////////////////////////For Camera//////////////////////////////For Camera/////////////////////////////////


///START//////////////////DRAW////////////////////////////////////////////////////DRAW///////////////////////////////////////////
void draw(){ 
  background(0);
  lights();
  camera.Update( 1.0/frameRate);
  drawStars();
  sun.show();
  shape(plane);
  //for one agent
    //agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
    //agent1[0].updateposit(1/frameRate);
  //}
  
  //drawPRMPoints(); 
  showMainShip();
  showShips();
  rotateShip();
 // //if mouse is pressed add debris in random spot  on the plane
 // if(mousePressed){
 //   delay(100);//ensure we only create one circle per click
 //   pushMatrix();
 //   VECTOR mousePosit = new VECTOR(random(-planeLen, planeLen), planeYValue, random(-planeLen, planeLen));
 //   popMatrix();
 //   debris[debrisTotal] = new CIRCLE(mousePosit);    
 //   debrisTotal++;
 //   debris[debrisTotal-1].showDebris(); 
 //   agent1[0].arrayOfPoints[0] = agent1[0].position;
 //   agent1[0].path = new ArrayList(); //now the path is empty  
 //   agent1[0].bfs();
 //   agent1[0].nextNode = agent1[0].path.size()-2;
 //   //separation(agent1[0]);   
 //  }   
 //for(int i=0; i < debrisTotal; i++){   
 // //for(int i=0; i < satellites.length; i++){
 //     debris[i].showDebris();   
 // }
 // agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
 // agent1[0].updateposit(1/frameRate);
  
  //runBoids();
  runTTC();
   
          //Draw the Goal
        pushMatrix();
        fill(0, 255, 0);
        translate(planeLen, planeYValue, -planeLen);
        sphere( agentAndTargetRadius);
        popMatrix(); 
        //agent1[0].edges();
        //separate();
        //for(int k = 0; k<circlesTotal; k++){
           
        //       if(distance(agent1[0].position, circles[k].position) < circles[k].radius + 5){
              
        //            separation(agent1[0]);
        //            agent1[0].updateposit(1/frameRate);       
        //       }       
        //}

       //agent1[0].aStar();
       //aStarDraw(agent1[0]);
       //delay(1000);  
       //agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
       //agent1[0].updateposit(1/frameRate);    

 
 //camera   
 //if(agent1[0].atEnd == false){
 //  pushMatrix();
 //  translate(goal.xp, goal.yp, goal.zp);
 //  shape(person);
 //  popMatrix();
 //}
  if(key == 'g')
        camera.position = new PVector(18.8, 88.6, 22);
  if(key == 'p'){      
    println(camera.position);
    println(camera.theta);
    println(camera.phi);
  } 

}
////END/////////////////DRAW////////////////////////////////////////////////////DRAW///////////////////////////////////////////























  
