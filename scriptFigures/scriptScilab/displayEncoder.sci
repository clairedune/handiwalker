// ------------------------------- //
// DISPLAY ENCODER
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
function displayEncoder(path)

filename = path+'/encoder';

// read encoder file
Mencoder = fscanfMat(filename);

//split the encoder matrix into two matrices
[M0, M1, time0, time1] = divideEncoderFile(Mencoder);

//synchronise the motion data
[time, delta0, delta1] = synchronyseEncoders(time0,M0(:,4),time1, M1(:,4));

// compute the walker position
L = 0.513;
[x,y,theta] = computeWalkerPosition(time, delta0, delta1, L);

//create figures
xset('window', 1)
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

//create figures
// ligne de commande pour creation du gif anime
// convert -delay 10 -loop 0 image_*gif animation.gif
xset('window', 2)
xtitle('Walker position');
winnum=winsid();
xbasc() 
xset("pixmap",1)
driver("Rec");
pt2D = createWalker(L);
plot2d(x,y, 3,frameflag=4);
xset("wshow")  ;
//pause
k=0;
for i = 1:200:size(x,2)
  k=k+1 // numero image
  
  pt2Dnew = changeFrameWalker(pt2D,x(i),y(i),theta(i));
  xbasc();
  clear_pixmap();
  plot2d(x,y, 3,frameflag=4);
  drawWalker(pt2Dnew);
  show_pixmap();
  
//  if pmodulo(k,10)==0 then 
  nom_image=path+'images/image_'+string(1000+k)+'.gif'; 
  xs2gif(winnum($),nom_image);
  
end
xset("pixmap",0)

endfunction
