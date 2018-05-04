% Funktion von Least Median Square
function [RG,Plat_Gruppe,med_v,OR,Gesuchtpunkt] = ...
          LMS2_Funk(X,Y,Z,R,Referenzpunkte)

Referenzpunkte_Anzahl = size(R,1);
% C (n 4)
Referenzpunkte_Gruppe_Anzahl = nchoosek(Referenzpunkte_Anzahl,4);
% RG = Referenzpunkte_Gruppe(z.B.(P1,P2,P3,P4))
% Alle moegliche Kombinationen mit 4 Referenzpunkte
RG = nchoosek(1:Referenzpunkte_Anzahl,4);
% Anhand LLS-Verfahren werden alle Kombinationen(Subsets) gerechnet und
% auf Plat_Gruppe gespeichert.
Plat_Gruppe = [];
% Alle Medianwerte von alle mit LLS gerechnet Position Plat
med_v = [];
% OR = OpitimierungsReferenzpunkte
OR = [];
% Die gesuchte Position Plat(i)
Gesuchtpunkt = [];

% LLS-Verfahren
for i = 1 : Referenzpunkte_Gruppe_Anzahl
    % Lineares Gleichungssystem (3)
    A = [X(RG(i,2))-X(RG(i,1)) Y(RG(i,2))-Y(RG(i,1)) Z(RG(i,2))-Z(RG(i,1));...
         X(RG(i,3))-X(RG(i,1)) Y(RG(i,3))-Y(RG(i,1)) Z(RG(i,3))-Z(RG(i,1));...
         X(RG(i,4))-X(RG(i,1)) Y(RG(i,4))-Y(RG(i,1)) Z(RG(i,4))-Z(RG(i,1))];
    b = 0.5 * [...
        R(RG(i,1))^2-R(RG(i,2))^2-X(RG(i,1))^2-Y(RG(i,1))^2-Z(RG(i,1))^2+...
        X(RG(i,2))^2+Y(RG(i,2))^2+Z(RG(i,2))^2;  ...
        R(RG(i,1))^2-R(RG(i,3))^2-X(RG(i,1))^2-Y(RG(i,1))^2-Z(RG(i,1))^2+...
        X(RG(i,3))^2+Y(RG(i,3))^2+Z(RG(i,3))^2;  ...
        R(RG(i,1))^2-R(RG(i,4))^2-X(RG(i,1))^2-Y(RG(i,1))^2-Z(RG(i,1))^2+...
        X(RG(i,4))^2+Y(RG(i,4))^2+Z(RG(i,4))^2];   
    AT = A.'; 
    % Formel (5)
    Plat_Gruppe = [Plat_Gruppe;((AT * A)\(AT * b)).'];
end

% LMS-Verfahren
for i = 1:Referenzpunkte_Gruppe_Anzahl
    % Formel (6) und (7)
    Medianwerte = median(sort([...
          abs(sqrt((X(RG(i,1)) - Plat_Gruppe(i,1))^2 + (Y(RG(i,1)) - ...
          Plat_Gruppe(i,2))^2 + (Z(RG(i,1))-Plat_Gruppe(i,3))^2) - R(RG(i,1)))...
          abs(sqrt((X(RG(i,2)) - Plat_Gruppe(i,1))^2 + (Y(RG(i,2)) - ...
          Plat_Gruppe(i,2))^2 + (Z(RG(i,2))-Plat_Gruppe(i,3))^2) - R(RG(i,2)))...
          abs(sqrt((X(RG(i,3)) - Plat_Gruppe(i,1))^2 + (Y(RG(i,3)) - ...
          Plat_Gruppe(i,2))^2 + (Z(RG(i,3))-Plat_Gruppe(i,3))^2) - R(RG(i,3)))...
          abs(sqrt((X(RG(i,4)) - Plat_Gruppe(i,1))^2 + (Y(RG(i,4)) - ...
          Plat_Gruppe(i,2))^2 + (Z(RG(i,4))-Plat_Gruppe(i,3))^2) - R(RG(i,4)))].^2));
    med_v = [med_v; Medianwerte];
end

% Die gesuchte Position Plat(i) wird ermittelt, 
% die mit greingste Medianwert ist.
min_med_v = min(med_v);
min_med_v_position = find(med_v==min_med_v);
RealReferenzPunkt = RG(min_med_v_position,:);

for i = 1:4
    OR = [OR;Referenzpunkte(RealReferenzPunkt(i),:) R(RealReferenzPunkt(i))];
end

Gesuchtpunkt = Plat_Gruppe(min_med_v_position,:);
end