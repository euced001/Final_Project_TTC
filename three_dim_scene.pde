  
PShape s;
PShape plane;
PShape butterfly;
PShape spaceShip;

PShape[] shapes = new PShape[3];
PShape[] spaceships = new PShape[numAgents-1]; //this array stores all the ships except the main ship

void setUpPlane(){
      plane  = createShape();
      plane.beginShape();
      plane.fill(0, 255, 0);
      plane.stroke(0,255,0);
      plane.vertex(planeLen, planeYValue, planeLen);
      plane.vertex(planeLen, planeYValue, -planeLen);
      plane.vertex(-planeLen, planeYValue, -planeLen);
      plane.vertex(-planeLen, planeYValue, planeLen);
      plane.endShape();
}

void setUpShips(){
  
   shapes[0] = loadShape("Spaceship.obj");
   shapes[1] = loadShape("Spaceship3.obj");
   shapes[2] = loadShape("Spaceship5.obj");
   //main ship
   spaceShip = loadShape("Spaceship4.obj"); 
   currentAngle = atan(agentStart.zp/agentStart.xp);
   print(degrees(currentAngle));
   pushMatrix();
   spaceShip.rotateX(PI);
   spaceShip.scale(10);  //10 is the ideal 
   popMatrix();
 
  for(int i=0; i < spaceships.length; i++){
    int rs = int(random(0,2));
    
    spaceships[i] = shapes[rs]; //randomly assing the ship object
    spaceships[i].rotateX(PI);
    float scale = random(1, 2);
    pushMatrix();
    spaceships[i].scale(scale);   
    popMatrix();
  }
  
  //spaceShip = loadShape("Spaceship4.obj");
}

void showMainShip(){
    pushMatrix();
    translate(0, 0, agent1[0].position.zp);
    shape(spaceShip, agent1[0].position.xp, planeYValue-10);
    popMatrix(); 
}  

void showShips(){
  for(int i=1; i < spaceships.length; i++){
    pushMatrix();
    translate(0, 0, agent1[i].position.zp);
    shape(spaceships[i], agent1[i].position.xp, planeYValue-10);
    popMatrix(); 
    
  }  

}
  
