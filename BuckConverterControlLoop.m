clear
clc
pkg load control;
s=tf('s');
#######################
Fv=9.91E-6;
Fm=6.67;
Hv=0.08;
Hi=2E-2;
Fi=9.87E-1;

######################
Cs=30E-9;
Rs=1000;
Cp=50E-12;
gm=0.001;
G0=(Cs*Rs)/(Cs+Cp);

Gcomp=gm*G0*((1+(1/(s*Cs*Rs)))/(1+s*(Cp*Cs*Rs/(Cs+Cp))));

[mg, ph, w]=bode(-Hi*Gcomp);

bfreq=w/(2*pi());
mdb=20*log10(mg);

subplot(2,1,1);                    % Subplot 1 of (2,1)
semilogx(bfreq, mdb);              % Plot the magnitude
zoom on;
grid on;
title('Bode');
ylabel('Magnitude[dB]');

title('Compensation Transfer Function');

subplot(2,1,2);                   % Subplot 2 of (2,1)
semilogx(bfreq, ph);              % Plot the phase
grid on;
zoom on;
ylabel('Phase[deg]');
xlabel('Frequency[Hz]');

################################

################################
###Inductor Current to Duty Cycle
Gid=34.61236194*(1+s*2.19E-5)/(1.019166667+s*2.47E-6+s^2*4.48E-11);
###Vout to Duty Cycle
Gvd=36.11724724*(1)/(1.019166667+s*2.47E-6+s^2*4.48E-11);
###Vout to Vinput
Gvg=0.415314044*(1)/(1.019166667+s*2.47E-6+s^2*4.48E-11);
###Inductor Current to Vinput
Gig=0.398009292*(1+s*2.19E-5)/(1.019166667+s*2.47E-6+s^2*4.48E-11);
######################
######################

############Gvd#############
##figure;
##hold;
##[mg, ph, w]=bode(Gvd);
##
##bfreq=w/(2*pi());
##mdb=20*log10(mg);
##
##subplot(2,1,1);                    % Subplot 1 of (2,1)
##semilogx(bfreq, mdb);              % Plot the magnitude
##zoom on;
##grid on;
##title('Bode');
##ylabel('Magnitude[dB]');
##
##title('G_v_d');
##
##subplot(2,1,2);                   % Subplot 2 of (2,1)
##semilogx(bfreq, ph);              % Plot the phase
##grid on;
##zoom on;
##ylabel('Phase[deg]');
##xlabel('Frequency[Hz]');
############Gid#############
##figure;
##hold;
##[mg, ph, w]=bode(Gid);
##
##bfreq=w/(2*pi());
##mdb=20*log10(mg);
##
##subplot(2,1,1);                    % Subplot 1 of (2,1)
##semilogx(bfreq, mdb);              % Plot the magnitude
##zoom on;
##grid on;
##title('Bode');
##ylabel('Magnitude[dB]');
##
##title('G_i_d');
##hold;
##subplot(2,1,2);                   % Subplot 2 of (2,1)
##semilogx(bfreq, ph);              % Plot the phase
##grid on;
##zoom on;
##ylabel('Phase[deg]');
##xlabel('Frequency[Hz]');
############Gig#############
##figure;
##hold;
##[mg, ph, w]=bode(Gig);
##
##bfreq=w/(2*pi());
##mdb=20*log10(mg);
##
##subplot(2,1,1);                    % Subplot 1 of (2,1)
##semilogx(bfreq, mdb);              % Plot the magnitude
##zoom on;
##grid on;
##title('Bode');
##ylabel('Magnitude[dB]');
##
##title('G_i_g');
##hold;
##subplot(2,1,2);                   % Subplot 2 of (2,1)
##semilogx(bfreq, ph);              % Plot the phase
##grid on;
##zoom on;
##ylabel('Phase[deg]');
##xlabel('Frequency[Hz]');
############Gvg#############
##figure;
##hold;
##[mg, ph, w]=bode(Gvg);
##
##bfreq=w/(2*pi());
##mdb=20*log10(mg);
##
##subplot(2,1,1);                    % Subplot 1 of (2,1)
##semilogx(bfreq, mdb);              % Plot the magnitude
##zoom on;
##grid on;
##title('Bode');
##ylabel('Magnitude[dB]');
##
##title('G_v_g');
##hold;
##subplot(2,1,2);                   % Subplot 2 of (2,1)
##semilogx(bfreq, ph);              % Plot the phase
##grid on;
##zoom on;
##ylabel('Phase[deg]');
##xlabel('Frequency[Hz]');

#################################
###Open Loop Without Gcomp
Topen_loop_no_comp=Fm*(Fi*Hi*Gid+Gvd*Hv*Fv);
Topen_loop_comp=Fm*(Fi*Hi*Gid+Gcomp*Gvd*Hv*Fv);
###################
figure;
hold;
[mg, ph, w]=bode(Topen_loop_no_comp);

bfreq=w/(2*pi());
mdb=20*log10(mg);

subplot(2,1,1);                    % Subplot 1 of (2,1)
semilogx(bfreq, mdb);              % Plot the magnitude
zoom on;
grid on;
title('Bode');
ylabel('Magnitude[dB]');

title('Uncompensated Open Loop Gain');

subplot(2,1,2);                   % Subplot 2 of (2,1)
semilogx(bfreq, ph);              % Plot the phase
grid on;
zoom on;
ylabel('Phase[deg]');
xlabel('Frequency[Hz]');
###################
figure;
hold;
[mg, ph, w]=bode(Topen_loop_comp);

bfreq=w/(2*pi());
mdb=20*log10(mg);

subplot(2,1,1);                    % Subplot 1 of (2,1)
semilogx(bfreq, mdb);              % Plot the magnitude
zoom on;
grid on;
title('Bode');
ylabel('Magnitude[dB]');

title('Compensated Open Loop Gain');

subplot(2,1,2);                   % Subplot 2 of (2,1)
semilogx(bfreq, ph);              % Plot the phase
grid on;
zoom on;
ylabel('Phase[deg]');
xlabel('Frequency[Hz]');


############################
#####Closed Loop############
############################
figure;
hold;
[mg, ph, w]=bode(Gvd*(Fm/(1+Topen_loop_no_comp)));

bfreq=w/(2*pi());
mdb=20*log10(mg);

subplot(2,1,1);                    % Subplot 1 of (2,1)
semilogx(bfreq, mdb);              % Plot the magnitude
zoom on;
grid on;
title('Bode');
ylabel('Magnitude[dB]');

title('Uncompensated G_i_c');

subplot(2,1,2);                   % Subplot 2 of (2,1)
semilogx(bfreq, ph);              % Plot the phase
grid on;
zoom on;
ylabel('Phase[deg]');
xlabel('Frequency[Hz]');
####################
figure;
hold;
[mg, ph, w]=bode(Gvd*(Fm/(1+Topen_loop_comp)));

bfreq=w/(2*pi());
mdb=20*log10(mg);

subplot(2,1,1);                    % Subplot 1 of (2,1)
semilogx(bfreq, mdb);              % Plot the magnitude
zoom on;
grid on;
title('Bode');
ylabel('Magnitude[dB]');

title('Compensated G_i_c');

subplot(2,1,2);                   % Subplot 2 of (2,1)
semilogx(bfreq, ph);              % Plot the phase
grid on;
zoom on;
ylabel('Phase[deg]');
xlabel('Frequency[Hz]');
