// Created for CSCI 5611 by Liam Tyler and Stephen Guy

class Camera
{
  Camera()
  {
     //position      = new PVector( 0, 0, 0 ); // initial position
    // [ 13.694869, 286.78156, 36.44532 ]
    // position      = new PVector( 13.7, 287, 36 ); // initial position
    //BIRDS VIEW: [ 18.7939, 88.60211, 21.614113 ] //0.36630553 //-1.4835298
//    [ 46.35171, -1092.8021, 116.320625 ]
//-0.7802521
//-1.4835298
//[ 112.844124, -1310.436, 634.1309 ] -0.025441501 -1.1920395
//birds eyeview
    //*position = new PVector (217, 105, 533);
    //position = new PVector (agentStart.xp, agentStart.yp, agentStart.zp); //original ship view
    position = new PVector (-227, 145, 805); //keep this!!!!
    position = new PVector (112.844124,-1310.436, 634.1309);
    //**(46.3, -1092.8, 116);
    //position      = new PVector( 18.8, 88.6, 22 );  (77, 247, 534); //plane level view  //
    //position      = new PVector( 09.71E-6, 248, 222 ); // initial position
    //position      = new PVector( -0.75, 289.0603, 44.67 );    
    //position      = new PVector( 5.63, 1.5, 36 ); // initial position
    theta         = -0.025;//-0.13;//0.47;//0.37;//0; // rotation around Y axis. Starts with forward direction as ( 0, 0, -1 )
    phi           = -1.192;//-0.15;//-1.5;//0; // rotation around X axis. Starts with up direction as ( 0, 1, 0 )
    moveSpeed     = 150;//100;//50;
    turnSpeed     = 1.57; // radians/sec
    
    // dont need to change these
    negativeMovement = new PVector( 0, 0, 0 );
    positiveMovement = new PVector( 0, 0, 0 );
    negativeTurn     = new PVector( 0, 0 ); // .x for theta, .y for phi
    positiveTurn     = new PVector( 0, 0 );
    fovy             = PI / 4;
    aspectRatio      = width / (float) height;
    nearPlane        = 0.1;
    farPlane         = 10000;
  }
  
  void Update( float dt )
  {
    theta += turnSpeed * (negativeTurn.x + positiveTurn.x) * dt;
    
    // cap the rotation about the X axis to be less than 90 degrees to avoid gimble lock
    float maxAngleInRadians = 85 * PI / 180;
    phi = min( maxAngleInRadians, max( -maxAngleInRadians, phi + turnSpeed * ( negativeTurn.y + positiveTurn.y ) * dt ) );
    
    // re-orienting the angles to match the wikipedia formulas: https://en.wikipedia.org/wiki/Spherical_coordinate_system
    // except that their theta and phi are named opposite
    float t = theta + PI / 2;
    float p = phi + PI / 2;
    PVector forwardDir = new PVector( sin( p ) * cos( t ),   cos( p ),   -sin( p ) * sin ( t ) );
    PVector upDir      = new PVector( sin( phi ) * cos( t ), cos( phi ), -sin( t ) * sin( phi ) );
    PVector rightDir   = new PVector( cos( theta ), 0, -sin( theta ) );
    PVector velocity   = new PVector( negativeMovement.x + positiveMovement.x, negativeMovement.y + positiveMovement.y, negativeMovement.z + positiveMovement.z );
    position.add( PVector.mult( forwardDir, moveSpeed * velocity.z * dt ) );
    position.add( PVector.mult( upDir,      moveSpeed * velocity.y * dt ) );
    position.add( PVector.mult( rightDir,   moveSpeed * velocity.x * dt ) );
    
    aspectRatio = width / (float) height;
    perspective( fovy, aspectRatio, nearPlane, farPlane );
    camera( position.x, position.y, position.z,
            position.x + forwardDir.x, position.y + forwardDir.y, position.z + forwardDir.z,
            upDir.x, upDir.y, upDir.z );
  }
  
  // only need to change if you want difrent keys for the controls
  void HandleKeyPressed()
  {
    if ( key == 'w' ) positiveMovement.z = 1;
    if ( key == 's' ) negativeMovement.z = -1;
    if ( key == 'a' ) negativeMovement.x = -1;
    if ( key == 'd' ) positiveMovement.x = 1;
    if ( key == 'q' ) positiveMovement.y = 1;
    if ( key == 'e' ) negativeMovement.y = -1;
    
    if ( keyCode == LEFT )  negativeTurn.x = 1;
    if ( keyCode == RIGHT ) positiveTurn.x = -1;
    if ( keyCode == UP )    positiveTurn.y = 1;
    if ( keyCode == DOWN )  negativeTurn.y = -1;
  }
  
  // only need to change if you want difrent keys for the controls
  void HandleKeyReleased()
  {
    if ( key == 'w' ) positiveMovement.z = 0;
    if ( key == 'q' ) positiveMovement.y = 0;
    if ( key == 'd' ) positiveMovement.x = 0;
    if ( key == 'a' ) negativeMovement.x = 0;
    if ( key == 's' ) negativeMovement.z = 0;
    if ( key == 'e' ) negativeMovement.y = 0;
    
    if ( keyCode == LEFT  ) negativeTurn.x = 0;
    if ( keyCode == RIGHT ) positiveTurn.x = 0;
    if ( keyCode == UP    ) positiveTurn.y = 0;
    if ( keyCode == DOWN  ) negativeTurn.y = 0;
  }
  
  // only necessary to change if you want different start position, orientation, or speeds
  PVector position;
  float theta;
  float phi;
  float moveSpeed;
  float turnSpeed;
  
  // probably don't need / want to change any of the below variables
  float fovy;
  float aspectRatio;
  float nearPlane;
  float farPlane;  
  PVector negativeMovement;
  PVector positiveMovement;
  PVector negativeTurn;
  PVector positiveTurn;
};




//// ----------- Example using Camera class -------------------- //
//Camera camera;

//void setup()
//{
//  size( 600, 600, P3D );
//  camera = new Camera();
//}

//void keyPressed()
//{
//  camera.HandleKeyPressed();
//}

//void keyReleased()
//{
//  camera.HandleKeyReleased();
//}

//void draw() {
//  background(255);
//  noLights();

//  camera.Update( 1.0/frameRate );
  
//  // draw six cubes surrounding the origin (front, back, left, right, top, bottom)
//  fill( 0, 0, 255 );
//  pushMatrix();
//  translate( 0, 0, -50 );
//  box( 20 );
//  popMatrix();
  
//  pushMatrix();
//  translate( 0, 0, 50 );
//  box( 20 );
//  popMatrix();
  
//  fill( 255, 0, 0 );
//  pushMatrix();
//  translate( -50, 0, 0 );
//  box( 20 );
//  popMatrix();
  
//  pushMatrix();
//  translate( 50, 0, 0 );
//  box( 20 );
//  popMatrix();
  
//  fill( 0, 255, 0 );
//  pushMatrix();
//  translate( 0, 50, 0 );
//  box( 20 );
//  popMatrix();
  
//  pushMatrix();
//  translate( 0, -50, 0 );
//  box( 20 );
//  popMatrix();
//}
