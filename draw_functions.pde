
//IDK what this function is anymore????
//void separate(){

//          if(distance(agent1[0].position, sphere) < 110){
             
//                separation(agent1[0]);
//                agent1[0].updateposit(1/frameRate);    
//          }
            
//          else{
               
//                agent1[0].updatevelocity(1/frameRate, agent1[0].nextNode);
//                agent1[0].updateposit(1/frameRate);
//          } 


//}        

//this function draws the path after running BFS
//void drawPaths(){
//          for (int i = 0; i < numAgents; i++){
//              for (int j = 0; j < agent1[i].path.size()-1; j++){ 
//                  int index = agent1[i].path.get(j); //get the  index for arrayOfPoints[]
//                  int nextInPath = agent1[i].path.get(j+1); 
//                  pushMatrix();
//                  stroke(0,255,0);        
//                  line(agent1[i].arrayOfPoints[index].xp, agent1[i].arrayOfPoints[index].yp, agent1[i].arrayOfPoints[nextInPath].xp, agent1[i].arrayOfPoints[nextInPath].yp );
//                  popMatrix();

              
//              }
//         }
//}
//void drawPaths(){
//          for (int i = 0; i < numpoints; i++){
//              for (int j = 0; j < agent1[0].neighbors[i].size(); j++){
             
//                  pushMatrix();
//                  fill(255,0,0);
//                  line(agent1[0].arrayOfPoints[i].xp, planeYValue, agent1[0].arrayOfPoints[i].zp, agent1[0].arrayOfPoints[agent1[0].neighbors[i].get(j)].xp, planeYValue, agent1[0].arrayOfPoints[agent1[0].neighbors[i].get(j)].zp);
//                  popMatrix();
              
//              }
//         }
//}

//this function draws an edge b/w neighbors
//you must run connect() from the connect tab to use this function
void prmNeighbors(){
          for (int i = 0; i < numpoints; i++){
              for (int j = 0; j < prmneighbors[i].size(); j++){
             
                  pushMatrix();
                  stroke(0,0,255);
                  line(PRMpoints[i].xp,PRMpoints[i].yp, PRMpoints[i].zp, PRMpoints[prmneighbors[i].get(j)].xp, PRMpoints[prmneighbors[i].get(j)].yp, PRMpoints[i].zp);
                  popMatrix();
              
              }
         }
}
//This FUNCTION DRAWS ALL THE PRM points. The value of i and numpoints determines if we will draw the start and the goal as well.
//Keep in mind that this is agent dependent.
void drawPRMPoints(){
        for (int i = 1; i < numpoints+1; i++) {   //i = 0 includes the agent start position // numpoints+1 includes the goal    
            //pushMatrix();
            //fill(color(#E242E3)); //this is a purple color
            //translate(0,0, agent1[0].arrayOfPoints[i].zp);
            //circle(agent1[0].arrayOfPoints[i].xp, agent1[0].arrayOfPoints[i].yp, agentAndTargetRadius*.5);
            //popMatrix();
            
            //sphere
            pushMatrix();
            fill(color(#E242E3)); //this is a purple color
            translate(agent1[0].arrayOfPoints[i].xp, agent1[0].arrayOfPoints[i].yp, agent1[0].arrayOfPoints[i].zp);
            sphere(agentAndTargetRadius*.5);
            popMatrix();
        }  
}
//this function draws the sphere/circle in the middle
void drawCenterObstacle(){
  
    pushMatrix();
    fill(0, 0, 255);
    //translate(0, 300, 0);
    translate(sphere.xp, sphere.yp, sphere.zp);
    sphere(radius);
    popMatrix();
}

//this function draws the agents.
void drawAgents(){
  
  for(int i = 0; i < numAgents; i ++){
  
          //pushMatrix();
          //fill(agent1[i].colors);
          //translate(agent1[i].position.xp, agent1[i].position.yp, agent1[i].position.zp);
          //circle(0,0, agentAndTargetRadius*.5);
          //popMatrix();
          //sphere
          pushMatrix();
        
          fill(agent1[i].colors);
          translate(agent1[i].position.xp, agent1[i].position.yp - (agentAndTargetRadius*.5), agent1[i].position.zp);    
         //translate(agent1[i].position.xp, 0, agent1[i].position.zp);    

          sphere(agentAndTargetRadius*.5);
          popMatrix();   
          
         
   }        

}
//his colors the prm points green or red if the points are in the openSet or closedSet respectively. It updates with everyframe, so we always know what path aStar is looking at.
//Also, this function draws the path aStar is considerring. 
void aStarDraw(AGENT agent){

   for(int i = 0; i< agent.closedSet.size(); i++){
      pushMatrix();
      fill(255, 0, 0);
      translate(agent.arrayOfPoints[agent.openSet.get(i)].xp, agent.arrayOfPoints[agent.openSet.get(i)].yp, agent.arrayOfPoints[agent.openSet.get(i)].zp);
      circle(0,0,agentAndTargetRadius*.5);
      popMatrix();

   }    
   for(int i = 0; i < agent.openSet.size(); i++){
      pushMatrix();
      fill(0, 255, 0);
      translate(agent.arrayOfPoints[agent.openSet.get(i)].xp, agent.arrayOfPoints[agent.openSet.get(i)].yp, agent.arrayOfPoints[agent.openSet.get(i)].zp);
      circle(0,0,agentAndTargetRadius*.5);
      popMatrix();
   }

  delay(500);
  for(int i = 0; i < agent.AStarPath.size()-1; i++){
   
      pushMatrix();
      //circle( arrayOfPoints[AStarPath.get(i)].xp,  arrayOfPoints[AStarPath.get(i)].yp, agentAndTargetRadius*.75);
      line( agent.arrayOfPoints[agent.AStarPath.get(i)].xp, planeYValue, agent.arrayOfPoints[agent.AStarPath.get(i)].zp, agent.arrayOfPoints[agent.AStarPath.get(i+1)].xp,  planeYValue, agent.arrayOfPoints[agent.AStarPath.get(i+1)].zp);
      popMatrix();      
      
   }
}

void drawShips(){
  
  
          //first agent is RED
          //for(int i = 0; i < numAgents; i ++){
          //    if(i == 0){
          //        pushMatrix();
          //        fill(agent1[i].colors);
          //        //translate(agent1[i].position.xp, agent1[i].position.yp, agent1[i].position.zp);
          //        //circle(0,0, agentAndTargetRadius*.5)
          //        translate(0,0, agent1[i].position.zp);
          //        shape(horse, agent1[i].position.xp, agent1[i].position.yp);
          //        popMatrix();
          //    } 
          //    else{  
          //        pushMatrix();
          //        fill(agent1[i].colors);
          //        //translate(agent1[i].position.xp, agent1[i].position.yp, agent1[i].position.zp);
          //        //circle(0,0, agentAndTargetRadius*.5);
          //        translate(0,0, agent1[i].position.zp);
          //        shape(horse, agent1[i].position.xp, agent1[i].position.yp);
          //        popMatrix();
          //    }
           
          //}
          
          
          for(int i = 0; i < numAgents; i ++){
              if(i == 0){
                  pushMatrix();
                  fill(agent1[i].colors);
                  //spaceShip.translate(0, 0, agent1[i].position.zp);
                  spaceShip.translate(0, 0, agentStart.zp);                  
                  shape(spaceShip, agentStart.xp,agentStart.yp);
                  popMatrix();
              } 
              else{  
                  pushMatrix();
                  fill(agent1[i].colors);
                  spaceShip.translate(agent1[i].position.xp, 0, agent1[i].position.zp);
                  shape(spaceShip,0,planeYValue);
                  popMatrix();
              }
           
          }           

}

void rotateShip(){
    float velAngle = atan(agent1[0].velocity.zp/agent1[0].velocity.xp);//Calculates the angle in the x-z plane of the velocity vector
    float deg = degrees(velAngle);
    float currentDeg = degrees(currentAngle);
    //println("velAngle is", deg, currentDeg);
    float diffDeg = (deg - currentDeg);
    //println("diffDeg:", diffDeg);
   if((diffDeg) > 5){ //only rotate the ship of the velocity angle and the ship's angle differ by 5 degrees
       
      spaceShip.rotateY(velAngle); //rotate the ship by the velcotiy vector angle with respcect to the orgin
      currentAngle = velAngle; //now the ships angle in the x-z plane is the same as the velocity angle
   }


}


void setUpStars(){
  for(int i = 0; i < stars.length; i++){   
        stars[i]  = new VECTOR(random(-1000, 1000), random(-1000, 1000), random(-1000, 1000));        
  }
}

void drawStars(){
  
  for(int i = 0; i < stars.length; i++){   
        pushMatrix();
        lights();
        fill(255, 255, 255, 200);
        translate(stars[i].xp, stars[i].yp, stars[i].zp);
        sphere(random(0.5, 1.5));
        popMatrix();
  }
}
