// ------------------------------- //
// DISPLAY ENCODER and INERTIAL CENTER
//
//
// date : 01 2013
// author :  C. Dune
// brief : display the encoder values
//
// columns encoder file
// #1 encoder number
// #2 absolute encoder pulse
// #3 relative encore pulse
// #4 absolute distance
// #5 relative distance
// #6 time elapsed since last motion
// #7 absolute machine time
// -------------------------------- //

// load the data contained in the encoder file
Mencoder = fscanfMat('../../sbc/dataSaved/encoder');


// devide the encoder matrix into two encoder matrices
M0 = [];
M1 = [];
for i=1:size(Mencoder,1)
  
  absPulse= Mencoder(i,2);
  relPulse= Mencoder(i,3);
  absAngle= absPulse/4*%pi/180;
  relAngle= relPulse/4*%pi/180;
  
  // to compute the distance,
  // we have to take into account the reduction factor
  // and the diametre of the wheel.
  absDist = Mencoder(i,4) ;
  relDist = Mencoder(i,5);
  absTime = Mencoder(i,7) ;
  relTime = Mencoder(i,6) ;
  estVelocity = relDist/relTime;
  
  dataline = [ absAngle relAngle absDist relDist estVelocity absTime relTime];
  
  if(Mencoder(i,1)==0)
    M0 = [M0; dataline];
  else
    M1 = [M1; dataline];
  end
end

// create timelines
time0 = M0(:,$-1);
time1 = M1(:,$-1);
timeStart=min(min(time0), min(time1));
time0 = time0-timeStart;
time1 = time1-timeStart;

//create figures
xset('window', 1)
xtitle('ENCODERS')
subplot(221)
xtitle('Abs angle e0(b), e1(r)');
plot(time0,(M0(:,1)),'b');
plot(time1,(M1(:,1)),'r');
subplot(222)
xtitle('Abs dist. e0(b), e1(r)');
plot(time0,(M0(:,3)),'b');
plot(time1,(M1(:,3)),'r');
subplot(223)
xtitle('Rel time e0(b), e1(r)');
plot(time0,(M0(:,$)),'b');
plot(time1,(M1(:,$)),'r');
subplot(224)
xtitle('Velocity e0(b), e1(r)');
plot(time0,(M0(:,5)),'b');
plot(time1,(M1(:,5)),'r');