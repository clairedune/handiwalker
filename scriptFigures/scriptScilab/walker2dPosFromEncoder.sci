function [time, delta0, delta1] = synchronseEncoders(time0,position0,time1, position1)
// time0 contains the time, position0 contains the relative positions between two times

// read the size of the vectors
size0 = (size(time0,1));
size1 = (size(time1,1));

disp('TAILLE')
disp (size0);
disp (size1);

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

