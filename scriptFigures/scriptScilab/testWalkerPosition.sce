// unit testing function walker 2D Pos

time0 = [0 0.1 0.2 0.25 1 2 2.1];
time1 = [0 1 1.1 1.3 1.4 1.5 1.6 1.8 2];
position0 = [0 0.1 0.2 0.25 1 2 2.1];
position1 = [0 1 1.1 1.3 1.4 1.5 1.6 1.8 2];


[time, delta0, delta1] = synchronyseEncoders(time0,position0,time1, position1);

// entraxe
L = 0.513;
[x,y,theta] = computeWalkerPosition(time, delta0, delta1, L);


//create figures
xset('window', 1)
subplot(311)
xtitle('Enc 0 ');
plot(time,delta0);
subplot(312)
xtitle('Enc 1');
plot(time,delta1);
subplot(313)
xtitle('Walker position');
plot(x,y);





