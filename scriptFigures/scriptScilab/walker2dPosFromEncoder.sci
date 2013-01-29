function [time, delta0, delta1] = synchronyseEncoders(time0,position0,time1, position1)
// time0 contains the time, position0 contains the relative positions between two times

// read the size of the vectors
size0 = (size(time0,1));
size1 = (size(time1,1));


flagFinish = 0;
iter0 = 1;
iter1 = 1;
time = [];
delta0 =[];
delta1 =[];


while(flagFinish == 0)
  //disp('--------------')
  //disp(iter0)
  //disp(iter1)


  // if there are still data in the vectors
  if (iter0<=size0 & iter1<=size1) then
    // disp('1 et 2 pas fini')
    
     if(time0(iter0)==time1(iter1)) then
      // disp('time are equal')
       time = [time time0(iter0)]
       
       //increment two values
       delta0 = [delta0 position0(iter0)];
       delta1 = [delta1 position1(iter1)];
       // increment two iterators
       iter0 = iter0+1;
       iter1 = iter1+1;
    
    elseif(time0(iter0)<time1(iter1)) then
        //disp('time0<time1')
        time = [time time0(iter0)]
        delta0 = [delta0 position0(iter0)];
        delta1 = [delta1 0];
        iter0 = iter0+1; 
        
        
        
    else
        //disp('time1<time0')
        time = [time time1(iter1)]
        delta0 = [delta0 0];
        delta1 = [delta1 position1(iter1)];
        iter1 = iter1+1; 
    end    
    
  elseif(iter1>size1 & iter0<=size0) then
      //disp(' 1 finish')
      time = [time time0(iter0)];
      delta0 = [delta0 position0(iter0)];
      delta1 = [delta1 0];
     
     iter0 = iter0+1;
      
  elseif(iter0>size0 & iter1<=size1) then
      //disp('0 finish')
      delta0 = [delta0 0];
      delta1 = [delta1 position1(iter1)];
      time = [time time1(iter1)];
      iter1 = iter1+1;
  else
      //disp('Finish !---------')    
      flagFinish = 1 ;    
      
  end
  
end
endfunction



function [x,y,theta] = computeWalkerPosition(time, delta0, delta1, L)
  
//domega
domega = (delta1-delta0) / (L) ;
//dS
dS = (delta1+delta0)/2;

x=[];
y=[];
theta=[];
xprec = 0;
yprec = 0;
thetaprec = 0;
for i=1:size(domega,2)
  
  xcourant = xprec + sinc(domega(i)/2)*(dS(i)*cos(thetaprec+domega(i)/2));
  ycourant = yprec + sinc(domega(i)/2)*(dS(i)*sin(thetaprec+domega(i)/2));
  thetacourant = thetaprec + domega(i);
  
  x = [x xcourant];
  y = [y ycourant];
  theta=[theta thetacourant];
  
  xprec = xcourant;
  yprec = ycourant;
  thetaprec=thetacourant;
  
end
  
endfunction  

function [M0, M1, time0, time1] = divideEncoderFile(Mencoder)
// columns encoder file
// #1 encoder number
// #2 absolute encoder pulse
// #3 relative encore pulse
// #4 absolute distance
// #5 relative distance
// #6 time elapsed since last motion
// #7 absolute machine time

  // devide the matrix into two encoder matrices
  M0 = [];
  M1 = [];

  for i=1:size(Mencoder,1)
    absPulse= Mencoder(i,2);
    relPulse= Mencoder(i,3);
    if(Mencoder(i,1)==1) then
      absPulse= -absPulse;
      relPulse= -relPulse;
    end

    absAngle= absPulse/4*%pi/180;
    relAngle= relPulse/4*%pi/180;
  
    // to compute the distance,
    // we have to take into account the reduction factor
    // and the diametre of the wheel.
    absDist = (absAngle/4)*0.1;
    relDist = (relAngle/4)*0.1;
    absTime = Mencoder(i,7) ;
    relTime = Mencoder(i,6) ;
    estVelocity = relDist/relTime;
  
    dataline = [ absAngle relAngle absDist relDist estVelocity absTime relTime];
  
    if(Mencoder(i,1)==0) then
      M0 = [M0; dataline];
    else
      M1 = [M1; dataline];
    end
end

// create timelines
time0 = M0(:,$-1);
time1 = M1(:,$-1);
timeStart=(min(min(time0), min(time1)));
time0 = time0-timeStart;
time1 = time1-timeStart;
  
  
endfunction  


function pt2D = createWalker(L)
  //
  //   P1====P3====P2
  //         ||
  //         ||
  //         ||
  //         P4
  
  
  P1 = [-L/2 0 1]';
  P2 = [L/2 0 1]';
  P3 = [0 0 1]';
  P4 = [0 0.2 1]';
  
  
  
  pt2D = [P1 P2 P3 P4];
 endfunction

function drawWalker(pt2D)

endfunction  
