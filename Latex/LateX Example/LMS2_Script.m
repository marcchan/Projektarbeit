% Script von Least Median Square
% Referenzpunkt: Pi = {Xi,Yi,Zi}; 
% Gesuchte Position: Plat = {X,Y,Z}
% Distanzmessungen: Ri
% Alle Referenzpunkten und Distanzmessungen wird in Punkte.txt gespeichert.

% Textdatei 'Punkte.txt' wird gelesen und auf [X,Y,Z,R] gespeichert.
[X,Y,Z,R]=textread('Punkte.txt','%f%f%f%f','headerlines',1);
Referenzpunkte = [X,Y,Z];
% Funktion von Least Median Square aufrufen
[RG, Plat_Gruppe,med_v,OR,Gesuchtpunkt] = LMS2_Funk(X,Y,Z,R,Referenzpunkte)

% Bar Diagram wird erstellt, um Medianwerte zu anzeigen
figure(1);
b = bar(med_v);
grid on;
title('Least Median Square (6 Referenzpunkte)');
xlabel('Subset ');
ylabel('Medianwert (m^2)');

% Alle Medianwerte werden notiert.
min_med_position = find(med_v == min(med_v));
max_med = max(med_v);
for i = 1:length(med_v)
    if i == min_med_position
        text(i-0.45,med_v(i) + max_med/20, num2str(med_v(i)),'Color','red');
    else
        text(i-0.45,med_v(i) + max_med/20, num2str(med_v(i)));
    end
end

% In 3D werden die gesucht Plat(i) und optimierte Referenzpunkte angezeigt.
figure(2);
% Vier transparente Kugeln werden gemalt. 
for i = 1:4
    [x,y,z] = sphere(30);
    A = x*OR(i,4) + OR(i,1);
    B = y*OR(i,4) + OR(i,2);
    C = z*OR(i,4) + OR(i,3);
    surf(A,B,C);
    alpha(0.3)         %Transprenz von Kugeln
    shading flat       
    hold on
end

% Optimierte Referenzpunktt und gesuchte Punkt malen
plot3(OR(:,1), OR(:,2),OR(:,3), '*k');
plot3(Gesuchtpunkt(1), Gesuchtpunkt(2),Gesuchtpunkt(3), '*r');

% Informationen der Punkten werden dargestellt.
plot3(-20,-0,19, '*r');
text(-20,-0,19,['   Gesucht Punkt:',char(10),'(',num2str(Gesuchtpunkt(1)),...    
     ',',num2str(Gesuchtpunkt(2)),',',num2str(Gesuchtpunkt(3)),')']);
plot3(-20,-0,17, '*k');
text(-20,-0,17, '   Optimierte Referenzpunkte')
plot3(OR(:,1), OR(:,2),OR(:,3), '*k');
title('Gesucht Punkt und optimierte Referenzpunkte')
xlabel('X')
ylabel('Y')
zlabel('Z')

