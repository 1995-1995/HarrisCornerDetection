%% Harris corner of image Harris_1.jpg
A = imread('Harris_1.jpg');
I = rgb2gray(A);
C = corner(I,300);
D = harris(I,300);
figure('Numbertitle','off','Name','Figure1.4.1(a) Harris corner of image Harris_1.jpg');
imshow(A);
hold on;
plot(D(:,1),D(:,2),'g.');
%%Copare inbuild and own function of image Harris_1.jpg
figure('Numbertitle','off','Name','Figure1.5.1(a) Copare inbuild and own function of image Harris_1.jpg');
imshow(A);
hold on;
plot(D(:,1),D(:,2),'g*');
hold on;
plot(C(:,1),C(:,2),'r*')
legend("Own function harris corner","Inbuild function harris corner ")
%%  Harris corner of image Harris_1.pgm
E = imread('Harris_1.pgm');
E_=harris(E,300);
E_2=corner(E,300);
figure('Numbertitle','off','Name','Figure1.4.1(b) Harris corner of image Harris_1.pgm');
imshow(E);
hold on;
plot(E_(:,1),E_(:,2),'g.');
%%Copare inbuild and own function of image Harris_1.pgm
figure('Numbertitle','off','Name','Figure1.5.1(b) Copare inbuild and own function of image Harris_1.pgm');
imshow(E);
hold on;
plot(E_(:,1),E_(:,2),'g*');
hold on;
plot(E_2(:,1),E_2(:,2),'r*')
legend("Own function harris corner","Inbuild function harris corner ")
%%  Harris corner of image Harris_3.jpg
G = imread('Harris_3.jpg');
Ggray = rgb2gray(G);
G_2 = corner(Ggray,300);
G_ = harris(Ggray,300);
figure('Numbertitle','off','Name','Figure1.4.1(c) Harris corner of image Harris_3.jpg');
imshow(G);
hold on;
plot(G_(:,1),G_(:,2),'g.');
figure('Numbertitle','off','Name','Figure1.5.1(c) Copare inbuild and own function of image Harris_3.pgm');
imshow(G);
hold on;
plot(G_(:,1),G_(:,2),'g*');
hold on;
plot(G_2(:,1),G_2(:,2),'r*')
legend("Own function harris corner","Inbuild function harris corner ")
%%
H = imread('Harris_4.jpg');
Hgray = rgb2gray(H);
H_2 = corner(Hgray,300);
H_ = harris(Hgray,300);
figure('Numbertitle','off','Name','Figure1.4.1(d) Harris corner of image Harris_4.jpg');
imshow(H);
hold on;
plot(H_(:,1),H_(:,2),'g.');
figure('Numbertitle','off','Name','Figure1.5.1(d) Copare inbuild and own function of image Harris_3.pgm');
imshow(H);
hold on;
plot(H_(:,1),H_(:,2),'g*');
hold on;
plot(H_2(:,1),H_2(:,2),'r*')
legend("Own function harris corner","Inbuild function harris corner ")
%%


