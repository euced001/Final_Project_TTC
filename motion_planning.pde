//This is to find the sample PRM points
void findPRMpoints(){
          
          PRMpoints[numpoints-1] = goal;
          println("The goal is:");
          PRMpoints[numpoints-1].vectorPrint();

         
          for (int i = 0; i < numpoints-1; i++)
          {         
              //VECTOR samplePoint = new VECTOR(random(0,800), random(0, 800), 0);//this is so that points are not within the plane
              VECTOR samplePoint = new VECTOR(random(-planeLen+radius, planeLen-radius), planeYValue, random(-planeLen+radius, planeLen-radius));

              
              float dist;
              dist = distance(samplePoint, sphere);
              dist *= dist;
                   
              while(dist <= radius)
              {   
                  //samplePoint = new VECTOR(random(0, width), random(0, height), 0);//this is so that points are not within the plane
                  samplePoint = new VECTOR(random(-planeLen-radius, planeLen+radius), planeYValue, random(-planeLen+radius, planeLen-radius));

              }
              
              PRMpoints[i] = samplePoint;
              println(i);
              println("the sample point is:");
              PRMpoints[i].vectorPrint();
              println();

          }
          println("Done sampling points!");
}

float distance(VECTOR firstVector, VECTOR secondVector)
{  
          float xdiff;
          float ydiff;
          float zdiff;
          xdiff = firstVector.xp - secondVector.xp;
          ydiff = firstVector.yp - secondVector.yp;
          zdiff = firstVector.zp - secondVector.zp;
          
          return sqrt(xdiff*xdiff + ydiff*ydiff + zdiff*zdiff);  
} 
                    
