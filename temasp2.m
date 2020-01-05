P=40; % perioada 
N=50; % numarul de coeficienti                                             
w0=2*pi/P; % pulsatie
D=3; % durata de crestere           
t_initial=0:0.02:D; % esantionarea semnalului initial

% semnalul dreptunghiular initial
x_initial= square(2*pi*t_initial*w0); 
t=0:0.02:P; % esantionarea semnalului reconstruit
x = zeros(1,length(t)); % initializarea lui x cu zerouri
x(t<=D)=x_initial; % inlocuim valorile nule cu cele din semnalul initial, cu conditia t<=D

figure(1);
plot(t,x);% afisarea semnalului x(t)
title('x(t)(linie solida) si reconstructia (linie punctata)');
hold on;

% k = variabilia dupa care se face suma
for k = -N:N
    x_t = x_initial; %x_t  semnalul realizat cu formula SF
    x_t = x_t .* exp(-j*k*w0*t_initial); % vectorul ce trebuie integrat
    X(k+N+1)=0;% initializarea 

    for i = 1: length(t_initial)-1
        X(k+N+1) = X(k+N+1) + (t_initial(i+1)-t_initial(i))* (x_t(i)+x_t(i+1))/2; % integrare folosind metoda dreptunghiurilor
    end
end

for i = 1: length(t)
    x_reconstruit(i) = 0;%  elementelor vectorului reconstruit
    for k=-N:N
        x_reconstruit(i) = x_reconstruit(i) + (1/P)*X(k+N+1)*exp(j*k*w0*t(i));% calcularea sumei
    end
end

plot(t,x_reconstruit,'--');% afisarea semnalului reconstruit 
figure(2);

w=-50*w0:w0:50*w0;% generarea vectorului de pulsatii corespunzatoare coeficientilor Xk
stem(w/(2*pi),abs(X));% afisarea spectrului de amplitudini
title('Spectrul de amplitudini ')

%Deoarece exista un numar finit de coeficienti, in cazul nostru 50, exista o
%marja de eroare, insa semnalul reconstruit se apropie de forma semnalului
%initial. Cu cat folosim mai multi coeficienti, cu atat semnalul
%reconstruit se apropie de cel initial.
