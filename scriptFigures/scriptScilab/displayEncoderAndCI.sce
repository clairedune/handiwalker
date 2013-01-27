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
// #4 time elapsed since last motion
// #5 absolute machine time
// columns spatial file
// #1 absolute time
// #2 translational acceleration in x
// #3 translational acceleration in y
// #4 translational acceleration in z
// #5 rotational velocity in x
// #6 rotational velocity in y
// #7 rotational velocity in z
// #8 magneto in x
// #9 magneto in y
// #10 magneto in z
// -------------------------------- //

// load the data contained in the encoder file
Mencoder = fscanfMat('../../sbc/dataSaved/encoder');
Mspacial = fscanfMat('../../sbc/dataSaved/spatial');


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
  absDist = (absAngle/4)*0.1 ;
  relDist = (absAngle/4)*0.1;
  absTime = Mencoder(i,5) ;
  relTime = Mencoder(i,4) ;
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
timeSpatial = Mspacial(:,1);
timeStart=min(min(min(time0), min(time1)),min(timeSpatial));
time0 = time0-timeStart;
time1 = time1-timeStart;
timeSpatial = timeSpatial-timeStart;

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

xset('window', 2)
xtitle('INERTIA DEVICE')
subplot(221)
xtitle('Acceleration x(b), y(r) z(g)');
plot(timeSpatial,(Mspacial (:,2)),'b');
plot(timeSpatial,(Mspacial (:,3)),'r');
plot(timeSpatial,(Mspacial (:,4)),'g');
subplot(222)
xtitle('Gyro x(b), y(r) z(g)');
plot(timeSpatial,(Mspacial (:,5)),'b');
plot(timeSpatial,(Mspacial (:,6)),'r');
plot(timeSpatial,(Mspacial (:,7)),'g');
subplot(223)
xtitle('Magneto x(b), y(r) z(g)');
plot(timeSpatial,(Mspacial (:,8)),'b');
plot(timeSpatial,(Mspacial (:,9)),'r');
plot(timeSpatial,(Mspacial (:,10)),'g');

xset('window', 3)
xtitle('Gyro and abs dist')
subplot(211)
plot(timeSpatial,(Mspacial (:,5)),'b-.');
plot(timeSpatial,(Mspacial (:,6)),'r-.');
plot(timeSpatial,(Mspacial (:,7)),'g-.');
plot(time1,(M1(:,3)),'r');
subplot(212)
plot(time0,(M0(:,3)),'b');
plot(time1,(M1(:,3)),'r');

