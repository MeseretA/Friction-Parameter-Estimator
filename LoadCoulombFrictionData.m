clc;

%%
foldername_C = 'FrictionData';
AllFricData = dir(foldername_C);

AllFricData(1:2) = [];

foldernumber = length(AllFricData);

%% Go to the FrictionData\Coulomb folder
folderPath = fullfile(AllFricData(1).folder, AllFricData(1).name);
CoulombData = dir(folderPath);
CoulombData(1:2) = [];
coulombFileNumebr = length(CoulombData);
%% Go to the FrictionData\Coulomb\Joints folder
% Joint-1
    CoulombDataJoint_1 = dir(fullfile(CoulombData(1).folder, CoulombData(1).name));
    CoulombDataJoint_1(1:2) = [];
    coulombFileNumberJ1 = length(CoulombDataJoint_1);
% Joint-2
    CoulombDataJoint_2 = dir(fullfile(CoulombData(2).folder, CoulombData(2).name));
    CoulombDataJoint_2(1:2) = [];
    coulombFileNumberJ2 = length(CoulombDataJoint_2);
% Joint-3
    CoulombDataJoint_3 = dir(fullfile(CoulombData(3).folder, CoulombData(3).name));
    CoulombDataJoint_3(1:2) = [];
    coulombFileNumberJ3 = length(CoulombDataJoint_3);
% Joint-4
    CoulombDataJoint_4 = dir(fullfile(CoulombData(4).folder, CoulombData(4).name));
    CoulombDataJoint_4(1:2) = [];
    coulombFileNumberJ4 = length(CoulombDataJoint_4);
% Joint-5
    CoulombDataJoint_5 = dir(fullfile(CoulombData(5).folder, CoulombData(5).name));
    CoulombDataJoint_5(1:2) = [];
    coulombFileNumberJ5 = length(CoulombDataJoint_5);    
% Joint-6
    CoulombDataJoint_6 = dir(fullfile(CoulombData(6).folder, CoulombData(6).name));
    CoulombDataJoint_6(1:2) = [];
    coulombFileNumberJ6 = length(CoulombDataJoint_6);     
%%
if(coulombFileNumberJ1)
    for n = 1:coulombFileNumberJ1%    
        data_CJ1 = ReadCoulombData(fullfile(CoulombDataJoint_1(n).folder, CoulombDataJoint_1(n).name));
        CoulombJoint1(:,n).Velocity = MovingAverageFilter(data_CJ1(:,15))*180/pi;
        CoulombJoint1(:,n).Torque = MovingAverageFilter(data_CJ1(:,27));
        CoulombJoint1(:,n).time = linspace(0,1,length(CoulombJoint1(n).Torque));
        zeroVelLocationJoint1 = find(CoulombJoint1(n).Velocity==0);
        zeroVelLocationChangeJoint1 = find(diff(zeroVelLocationJoint1)>100);
        NoOfzeroVelLocationChangeJoint1 = length(zeroVelLocationChangeJoint1);
        ZeroVelocityedge2 = zeroVelLocationChangeJoint1(2)+1;
        ZeroVelocityedge3 = zeroVelLocationChangeJoint1(3);
        ZeroVelocityedgeLast = zeroVelLocationChangeJoint1(end) + 1;
         if(length(zeroVelLocationChangeJoint1)<=2)
            
            zeroVelStart = zeroVelLocationChangeJoint1(1)+1;
            zeroVel1stEdgeEnds = zeroVelLocationChangeJoint1(2)-1;
            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint1( (zeroVelStart + ceil(length((zeroVelStart):(zeroVel1stEdgeEnds))/8)  ):(zeroVel1stEdgeEnds - ceil(length(zeroVelStart:zeroVel1stEdgeEnds)/8) ) );
            TorqueOffSetJoint1_pos =   CoulombJoint1(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
            
         else
        

            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint1((ZeroVelocityedge2 + ceil(length(ZeroVelocityedge2:ZeroVelocityedge3)/8)  ):(zeroVelLocationChangeJoint1(3)-ceil(length((zeroVelLocationChangeJoint1(2)+1):zeroVelLocationChangeJoint1(3))/8)));
            TorqueOffSetJoint1_pos =   CoulombJoint1(:,n).Torque(TorqueOffSetlocationJoint1_pos);
         end
        
        removeThisPart = ceil(length(ZeroVelocityedgeLast : length(zeroVelLocationJoint1(:)))/8);
        startforTorneg = ZeroVelocityedgeLast + removeThisPart;
        
        TorqueOffSetlocationJoint1_neg = zeroVelLocationJoint1(startforTorneg:end - removeThisPart);
        TorqueOffSetJoint1_neg =   CoulombJoint1(:,n).Torque(TorqueOffSetlocationJoint1_neg); 
      
        averageCoulombTorque(n).neg =  mean(abs(TorqueOffSetJoint1_neg));
        averageCoulombTorque(n).pos =  mean(TorqueOffSetJoint1_pos);
        
    end
    Joint(1).F_c_p = mean([averageCoulombTorque.pos]);
    Joint(1).F_c_n = mean([averageCoulombTorque.neg]);
    if(abs(Joint(1).F_c_p - Joint(1).F_c_n) >1.5)
        Joint(1).F_c_p = max([mean([averageCoulombTorque.pos]),mean([averageCoulombTorque.neg])]) ;
        Joint(1).F_c_n = max([mean([averageCoulombTorque.pos]),mean([averageCoulombTorque.neg])]) ;       
    end
else 
    Joint(1).F_c_p = 0;
    Joint(1).F_c_n = 0;   
end
if(coulombFileNumberJ2)
    for n = 1:coulombFileNumberJ2    
        data_CJ2 = ReadCoulombData(fullfile(CoulombDataJoint_2(n).folder, CoulombDataJoint_2(n).name));
        CoulombJoint2(:,n).Velocity = MovingAverageFilter(data_CJ2(:,16))*180/pi;
        CoulombJoint2(:,n).Torque = MovingAverageFilter(data_CJ2(:,28));
        CoulombJoint2(:,n).time = linspace(0,1,length(CoulombJoint2(n).Torque));
        zeroVelLocationJoint2 = find(CoulombJoint2(n).Velocity==0);
        zeroVelLocationChangeJoint2 = find(diff(zeroVelLocationJoint2)>300);
        NoOfzeroVelLocationChangeJoint2 = length(zeroVelLocationChangeJoint2);   
        %  because of gravity effect, the positive velocity torque is
        %  omitted
        ZeroVelocityedgeLast = zeroVelLocationChangeJoint2(end) + 1;
        removeThisPart = ceil(length(ZeroVelocityedgeLast : length(zeroVelLocationJoint2(:)))/8);
        startforTorneg = ZeroVelocityedgeLast + removeThisPart;
        
        TorqueOffSetlocationJoint1_neg = zeroVelLocationJoint2(startforTorneg:end - removeThisPart);
        TorqueOffSetJoint1_neg =   CoulombJoint2(:,n).Torque(TorqueOffSetlocationJoint1_neg);       
        
        
        averageCoulombTorque(n).neg =  mean(abs(TorqueOffSetJoint1_neg));
        averageCoulombTorque(n).pos =  mean(abs(TorqueOffSetJoint1_neg));
        
    end
    Joint(2).F_c_p = mean([averageCoulombTorque.pos]);
    Joint(2).F_c_n = mean([averageCoulombTorque.neg]);
else 
    Joint(2).F_c_p = 0;
    Joint(2).F_c_n = 0;   
end
if(coulombFileNumberJ3)
    for n = 1:coulombFileNumberJ3%    
        data_CJ3 = ReadCoulombData(fullfile(CoulombDataJoint_3(n).folder, CoulombDataJoint_3(n).name));
        CoulombJoint3(:,n).Velocity = MovingAverageFilter(data_CJ3(:,17))*180/pi;
        CoulombJoint3(:,n).Torque = MovingAverageFilter(data_CJ3(:,29));
        CoulombJoint3(:,n).time = linspace(0,1,length(CoulombJoint3(n).Torque));
          zeroVelLocationJoint3 = find(CoulombJoint3(n).Velocity==0);
          
        zeroVelLocationChangeJoint3 = find(diff(zeroVelLocationJoint3)>300);
        NoOfzeroVelLocationChangeJoint3 = length(zeroVelLocationChangeJoint3);

        % This is because of gravity effect
%         TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint3(((zeroVelLocationChangeJoint3(2)+1)+ceil(length((zeroVelLocationChangeJoint3(2)+1):zeroVelLocationChangeJoint3(3))/8)  ):(zeroVelLocationChangeJoint3(3)-ceil(length((zeroVelLocationChangeJoint3(2)+1):zeroVelLocationChangeJoint3(3))/8)));
%         TorqueOffSetJoint1_pos =   CoulombJoint3(:,n).Torque(TorqueOffSetlocationJoint1); 
        
        ZeroVelocityedgeLast = zeroVelLocationChangeJoint3(end) + 1;
        removeThisPart = ceil(length(ZeroVelocityedgeLast : length(zeroVelLocationJoint3(:)))/8);
        startforTorneg = ZeroVelocityedgeLast + removeThisPart;
        
        TorqueOffSetlocationJoint1_neg = zeroVelLocationJoint3(startforTorneg:end - removeThisPart);
        TorqueOffSetJoint1_neg =   CoulombJoint3(:,n).Torque(TorqueOffSetlocationJoint1_neg);       
          
        averageCoulombTorque(n).neg =  mean(abs(TorqueOffSetJoint1_neg));
        averageCoulombTorque(n).pos =  mean(abs(TorqueOffSetJoint1_neg));
        
    end
    Joint(3).F_c_p = mean([averageCoulombTorque.pos]);
    Joint(3).F_c_n = mean([averageCoulombTorque.neg]);
else 
    Joint(3).F_c_p = 0;
    Joint(3).F_c_n = 0;   
end
if(coulombFileNumberJ4)
    for n = 1:coulombFileNumberJ4%    
        data_CJ4 = ReadCoulombData(fullfile(CoulombDataJoint_4(n).folder, CoulombDataJoint_4(n).name));
        CoulombJoint4(:,n).Velocity = MovingAverageFilter(data_CJ4(:,18))*180/pi;
        CoulombJoint4(:,n).Torque = MovingAverageFilter(data_CJ4(:,30));
        CoulombJoint4(:,n).time = linspace(0,1,length(CoulombJoint4(n).Torque));
        zeroVelLocationJoint4 = find(CoulombJoint4(n).Velocity==0);
        
        zeroVelLocationChangeJoint4 = find(diff(zeroVelLocationJoint4)>300);
        NoOfzeroVelLocationChangeJoint4 = length(zeroVelLocationChangeJoint4);
        
         if(length(zeroVelLocationChangeJoint4)<=2)
            
            zeroVelStart = zeroVelLocationChangeJoint4(1)+1;
            zeroVel1stEdgeEnds = zeroVelLocationChangeJoint4(2)-1;
            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint4( (zeroVelStart + ceil(length((zeroVelStart):(zeroVel1stEdgeEnds))/8)  ):(zeroVel1stEdgeEnds - ceil(length(zeroVelStart:zeroVel1stEdgeEnds)/8) ) );
            TorqueOffSetJoint1_pos =   CoulombJoint4(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
            
         else

            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint4(((zeroVelLocationChangeJoint4(2)+1)+ceil(length((zeroVelLocationChangeJoint4(2)+1):zeroVelLocationChangeJoint4(3))/8)  ):(zeroVelLocationChangeJoint4(3)-ceil(length((zeroVelLocationChangeJoint4(2)+1):zeroVelLocationChangeJoint4(3))/8)));
            TorqueOffSetJoint1_pos =   CoulombJoint4(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
         end
        
        ZeroVelocityedgeLast = zeroVelLocationChangeJoint4(end) + 1;
        removeThisPart = ceil(length(ZeroVelocityedgeLast : length(zeroVelLocationJoint4(:)))/8);
        startforTorneg = ZeroVelocityedgeLast + removeThisPart;
        
        TorqueOffSetlocationJoint1_neg = zeroVelLocationJoint4(startforTorneg:end - removeThisPart);
        TorqueOffSetJoint1_neg =   CoulombJoint4(:,n).Torque(TorqueOffSetlocationJoint1_neg);      

        averageCoulombTorque(n).neg =  mean(abs(TorqueOffSetJoint1_neg));
        averageCoulombTorque(n).pos =  mean(TorqueOffSetJoint1_pos);      
        
    end
    Joint(4).F_c_p = mean([averageCoulombTorque.pos]);
    Joint(4).F_c_n = mean([averageCoulombTorque.neg]);
else 
    Joint(4).F_c_p = 0;
    Joint(4).F_c_n = 0;   
end
if(coulombFileNumberJ5)
    for n = 1:coulombFileNumberJ5%    
        data_CJ5 = ReadCoulombData(fullfile(CoulombDataJoint_5(n).folder, CoulombDataJoint_5(n).name));
        CoulombJoint5(:,n).Velocity = MovingAverageFilter(data_CJ5(:,19))*180/pi;
        CoulombJoint5(:,n).Torque = MovingAverageFilter(data_CJ5(:,31));
        CoulombJoint5(:,n).time = linspace(0,1,length(CoulombJoint5(n).Torque));
            zeroVelLocationJoint5 = find(CoulombJoint5(n).Velocity==0);
            
            
        zeroVelLocationChangeJoint5 = find(diff(zeroVelLocationJoint5)>300);
        NoOfzeroVelLocationChangeJoint5 = length(zeroVelLocationChangeJoint5);

        if(length(zeroVelLocationChangeJoint5)<=2)
            
            zeroVelStart = zeroVelLocationChangeJoint5(1)+1;
            zeroVel1stEdgeEnds = zeroVelLocationChangeJoint5(2)-1;
            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint5( (zeroVelStart + ceil(length((zeroVelStart):(zeroVel1stEdgeEnds))/8)  ):(zeroVel1stEdgeEnds - ceil(length(zeroVelStart:zeroVel1stEdgeEnds)/8) ) );
            TorqueOffSetJoint1_pos =   CoulombJoint5(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
            
        else

            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint5(((zeroVelLocationChangeJoint5(2)+1)+ceil(length((zeroVelLocationChangeJoint5(2)+1):zeroVelLocationChangeJoint5(3))/8)  ):(zeroVelLocationChangeJoint5(3)-ceil(length((zeroVelLocationChangeJoint5(2)+1):zeroVelLocationChangeJoint5(3))/8)));
            TorqueOffSetJoint1_pos =   CoulombJoint5(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
        end
        
        ZeroVelocityedgeLast = zeroVelLocationChangeJoint5(end) + 1;
        removeThisPart = ceil(length(ZeroVelocityedgeLast : length(zeroVelLocationJoint5(:)))/8);
        startforTorneg = ZeroVelocityedgeLast + removeThisPart;
        
        TorqueOffSetlocationJoint1_neg = zeroVelLocationJoint5(startforTorneg:end - removeThisPart);
        TorqueOffSetJoint1_neg =   CoulombJoint5(:,n).Torque(TorqueOffSetlocationJoint1_neg);      

        averageCoulombTorque(n).neg =  mean(abs(TorqueOffSetJoint1_neg));
        averageCoulombTorque(n).pos =  mean(TorqueOffSetJoint1_pos);
        
    end
    Joint(5).F_c_p = mean([averageCoulombTorque.pos]);
    Joint(5).F_c_n = mean([averageCoulombTorque.neg]);
else 
    Joint(5).F_c_p = 0;
    Joint(5).F_c_n = 0;   
end
if(coulombFileNumberJ6)
    for n = 1:coulombFileNumberJ6%    
        data_CJ6 = ReadCoulombData(fullfile(CoulombDataJoint_6(n).folder, CoulombDataJoint_6(n).name));
        CoulombJoint6(:,n).Velocity = MovingAverageFilter(data_CJ6(:,20))*180/pi;
        CoulombJoint6(:,n).Torque = MovingAverageFilter(data_CJ6(:,32));
        CoulombJoint6(:,n).time = linspace(0,1,length(CoulombJoint6(n).Torque));
            zeroVelLocationJoint6 = find(CoulombJoint6(n).Velocity==0);
            
        zeroVelLocationChangeJoint6 = find(abs(diff(zeroVelLocationJoint6))>1000);
        NoOfzeroVelLocationChangeJoint6 = length(zeroVelLocationChangeJoint6);
        if(length(zeroVelLocationChangeJoint6)<=2)
            
            zeroVelStart = zeroVelLocationChangeJoint6(1)+1;
            zeroVel1stEdgeEnds = zeroVelLocationChangeJoint6(2)-1;
            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint6( (zeroVelStart + ceil(length((zeroVelStart):(zeroVel1stEdgeEnds))/8)  ):(zeroVel1stEdgeEnds - ceil(length(zeroVelStart:zeroVel1stEdgeEnds)/8) ) );
            TorqueOffSetJoint1_pos =   CoulombJoint6(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
            
        else

            TorqueOffSetlocationJoint1_pos = zeroVelLocationJoint6(((zeroVelLocationChangeJoint6(2)+1)+ceil(length((zeroVelLocationChangeJoint6(2)+1):zeroVelLocationChangeJoint6(3))/8)  ):(zeroVelLocationChangeJoint6(3)-ceil(length((zeroVelLocationChangeJoint6(2)+1):zeroVelLocationChangeJoint6(3))/8)));
            TorqueOffSetJoint1_pos =   CoulombJoint6(:,n).Torque(TorqueOffSetlocationJoint1_pos); 
        end
        
        ZeroVelocityedgeLast = zeroVelLocationChangeJoint6(end) + 1;
        removeThisPart = ceil(length(ZeroVelocityedgeLast : length(zeroVelLocationJoint6(:)))/8);
        startforTorneg = ZeroVelocityedgeLast + removeThisPart;
        
        TorqueOffSetlocationJoint1_neg = zeroVelLocationJoint6(startforTorneg:end - removeThisPart);
        TorqueOffSetJoint1_neg =   CoulombJoint6(:,n).Torque(TorqueOffSetlocationJoint1_neg);     

        averageCoulombTorque(n).neg =  mean(abs(TorqueOffSetJoint1_neg));
        averageCoulombTorque(n).pos =  mean(TorqueOffSetJoint1_pos);          
          
        
    end
    Joint(6).F_c_p = mean([averageCoulombTorque.pos]);
    Joint(6).F_c_n = mean([averageCoulombTorque.neg]);
else 
    Joint(6).F_c_p = 0;
    Joint(6).F_c_n = 0;    
end











