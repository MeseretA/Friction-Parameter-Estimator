clc;

%%
foldername_S = 'FrictionData';
AllFricData = dir(foldername_S);

AllFricData(1:2) = [];

foldernumber = length(AllFricData);

%% Go to the FrictionData\Static folder
StaticData = dir(fullfile(AllFricData(2).folder, AllFricData(2).name));
StaticData(1:2) = [];
staticFileNumebr = length(StaticData);

%% Go to the FrictionData\Static\Joints folder
% Joint-1
    StaticDataJoint_1 = dir(fullfile(StaticData(1).folder, StaticData(1).name));
    StaticDataJoint_1(1:2) = [];
    staticFileNumberJ1 = length(StaticDataJoint_1);
% Joint-2
    StaticDataJoint_2 = dir(fullfile(StaticData(2).folder, StaticData(2).name));
    StaticDataJoint_2(1:2) = [];
    staticFileNumberJ2 = length(StaticDataJoint_2);
% Joint-3
    StaticDataJoint_3 = dir(fullfile(StaticData(3).folder, StaticData(3).name));
    StaticDataJoint_3(1:2) = [];
    staticFileNumberJ3 = length(StaticDataJoint_3);
% Joint-4
    StaticDataJoint_4 = dir(fullfile(StaticData(4).folder, StaticData(4).name));
    StaticDataJoint_4(1:2) = [];
    staticFileNumberJ4 = length(StaticDataJoint_4);
% Joint-5
    StaticDataJoint_5 = dir(fullfile(StaticData(5).folder, StaticData(5).name));
    StaticDataJoint_5(1:2) = [];
    staticFileNumberJ5 = length(StaticDataJoint_5);    
% Joint-6
    StaticDataJoint_6 = dir(fullfile(StaticData(6).folder, StaticData(6).name));
    StaticDataJoint_6(1:2) = [];
    staticFileNumberJ6 = length(StaticDataJoint_6);     

%%
clear TorqueExtrem
if(staticFileNumberJ1)
    for(n = 1:staticFileNumberJ1)
        data_CJ1 = ReadCoulombData(fullfile(StaticDataJoint_1(n).folder, StaticDataJoint_1(n).name));
        StaticJoint1(:,n).Velocity = MovingAverageFilter(data_CJ1(:,15))*180/pi;
        StaticJoint1(:,n).Torque = MovingAverageFilter(data_CJ1(:,27));
        StaticJoint1(:,n).time = linspace(0,1,length(StaticJoint1(n).Torque));
        zerovel = find(StaticJoint1(:,n).Velocity==0);
        zerovelTor  = StaticJoint1(:,n).Torque(zerovel);
        zerovelTor_neg = zerovelTor(zerovelTor<0);
        if(isempty(zerovelTor_neg))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos= zerovelTor(zerovelTor>0);
        if(isempty(zerovelTor_pos))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos_max = max(abs(zerovelTor_pos));        
%         zerovelTor_pos_fs = zerovelTor_pos(zerovelTor_pos>zerovelTor_pos_max);
        
        zerovelTor_neg_abs = abs(zerovelTor_neg);
        zerovelTor_neg_max = max(zerovelTor_neg_abs);
%         zerovelTor_neg_fs = zerovelTor_neg_abs(zerovelTor_neg_abs>zerovelTor_neg_max);        
        TorqueExtrem(n).neg =  mean(abs(zerovelTor_pos_max));
        TorqueExtrem(n).pos =  mean(abs(zerovelTor_neg_max));
    end
    StaticFriction(1).neg = abs(mean([TorqueExtrem.neg]));
    StaticFriction(1).pos = mean([TorqueExtrem.pos]);
else
    StaticFriction(1).neg =0;
    StaticFriction(1).pos = 0;  
end

if(staticFileNumberJ2)
    for(n = 1:staticFileNumberJ2)
        data_CJ2 = ReadCoulombData(fullfile(StaticDataJoint_2(n).folder, StaticDataJoint_2(n).name));
        StaticJoint2(:,n).Velocity = MovingAverageFilter(data_CJ2(:,16))*180/pi;
        StaticJoint2(:,n).Torque = MovingAverageFilter(data_CJ2(:,28));
        StaticJoint2(:,n).time = linspace(0,1,length(StaticJoint2(n).Torque));
        zerovel = find(StaticJoint2(:,n).Velocity==0);
        zerovelTor  = StaticJoint2(:,n).Torque(zerovel);
        zerovelTor_neg = zerovelTor(zerovelTor<0);
        if(isempty(zerovelTor_neg))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos= zerovelTor(zerovelTor>0);
        if(isempty(zerovelTor_pos))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos_max = max(abs(zerovelTor_pos));
%         zerovelTor_pos_fs = zerovelTor_pos(zerovelTor_pos>zerovelTor_pos_max);
        
        zerovelTor_neg_abs = abs(zerovelTor_neg);
        zerovelTor_neg_max = max(zerovelTor_neg_abs);
%         zerovelTor_neg_fs = zerovelTor_neg_abs(zerovelTor_neg_abs>zerovelTor_neg_max);        
        TorqueExtrem(n).neg =  mean(abs(zerovelTor_neg_max));
        TorqueExtrem(n).pos =  mean(abs(zerovelTor_pos_max));
    end
    StaticFriction(2).neg = abs(mean([TorqueExtrem.neg]));
    StaticFriction(2).pos = mean([TorqueExtrem.pos]);   
else
    StaticFriction(2).neg =0;
    StaticFriction(2).pos = 0;  
end
if(staticFileNumberJ3)
    for(n = 1:staticFileNumberJ3)
        data_CJ3 = ReadCoulombData(fullfile(StaticDataJoint_3(n).folder, StaticDataJoint_3(n).name));
        StaticJoint3(:,n).Velocity = MovingAverageFilter(data_CJ3(:,15+2))*180/pi;
        StaticJoint3(:,n).Torque = MovingAverageFilter(data_CJ3(:,27+2));
        StaticJoint3(:,n).time = linspace(0,1,length(StaticJoint3(n).Torque));
        zerovel = find(StaticJoint3(:,n).Velocity==0);
        zerovelTor  = StaticJoint3(:,n).Torque(zerovel);
        
        zerovelTor_neg = zerovelTor(zerovelTor<0);
        if(isempty(zerovelTor_neg))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos= zerovelTor(zerovelTor>0);
        if(isempty(zerovelTor_pos))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos_max = max(abs(zerovelTor_pos));
%         zerovelTor_pos_fs = zerovelTor_pos(zerovelTor_pos>zerovelTor_pos_max);
        
        zerovelTor_neg_abs = abs(zerovelTor_neg);
        zerovelTor_neg_max = max(zerovelTor_neg_abs);
%         zerovelTor_neg_fs = zerovelTor_neg_abs(zerovelTor_neg_abs>zerovelTor_neg_max);        
        TorqueExtrem(n).neg =  mean(abs(zerovelTor_neg_max));
        TorqueExtrem(n).pos =  mean(abs(zerovelTor_pos_max));
    end
    StaticFriction(3).neg = abs(mean([TorqueExtrem.neg]));
    StaticFriction(3).pos = mean([TorqueExtrem.pos]); 
 else
    StaticFriction(3).neg =0;
    StaticFriction(3).pos = 0;  
end
if(staticFileNumberJ4)
     for(n = 1:staticFileNumberJ4)
        data_CJ4 = ReadCoulombData(fullfile(StaticDataJoint_4(n).folder, StaticDataJoint_4(n).name));
        StaticJoint4(:,n).Velocity = MovingAverageFilter(data_CJ4(:,15+3))*180/pi;
        StaticJoint4(:,n).Torque = MovingAverageFilter(data_CJ4(:,27+3));
        StaticJoint4(:,n).time = linspace(0,1,length(StaticJoint4(n).Torque));
        zerovel = find(StaticJoint4(:,n).Velocity==0);
        zerovelTor  = StaticJoint4(:,n).Torque(zerovel);
        
        zerovelTor_neg = zerovelTor(zerovelTor<0);
        if(isempty(zerovelTor_neg))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos= zerovelTor(zerovelTor>0);
        if(isempty(zerovelTor_pos))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos_max = max(abs(zerovelTor_pos));
%         zerovelTor_pos_fs = zerovelTor_pos(zerovelTor_pos>zerovelTor_pos_max);
        
        zerovelTor_neg_abs = abs(zerovelTor_neg);
        zerovelTor_neg_max = max(zerovelTor_neg_abs);
%         zerovelTor_neg_fs = zerovelTor_neg_abs(zerovelTor_neg_abs>zerovelTor_neg_max);        
        TorqueExtrem(n).neg =  mean(abs(zerovelTor_neg_max));
        TorqueExtrem(n).pos =  mean(abs(zerovelTor_pos_max));
    end
    StaticFriction(4).neg = abs(mean([TorqueExtrem.neg]));
    StaticFriction(4).pos = mean([TorqueExtrem.pos]);  
else
    StaticFriction(4).neg =0;
    StaticFriction(4).pos = 0;  
end
if(staticFileNumberJ5)
    for(n = 1:staticFileNumberJ5)
        data_CJ5 = ReadCoulombData(fullfile(StaticDataJoint_5(n).folder, StaticDataJoint_5(n).name));
        StaticJoint5(:,n).Velocity = MovingAverageFilter(data_CJ5(:,15+4))*180/pi;
        StaticJoint5(:,n).Torque = MovingAverageFilter(data_CJ5(:,27+4));
        StaticJoint5(:,n).time = linspace(0,1,length(StaticJoint5(n).Torque));
        zerovel = find(StaticJoint5(:,n).Velocity==0);
        zerovelTor  = StaticJoint5(:,n).Torque(zerovel);
        
        zerovelTor_neg = zerovelTor(zerovelTor<0);
        if(isempty(zerovelTor_neg))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos= zerovelTor(zerovelTor>0);
        if(isempty(zerovelTor_pos))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos_max = max(abs(zerovelTor_pos));
%         zerovelTor_pos_fs = zerovelTor_pos(zerovelTor_pos>zerovelTor_pos_max);
        
        zerovelTor_neg_abs = abs(zerovelTor_neg);
        zerovelTor_neg_max = max(zerovelTor_neg_abs);
%         zerovelTor_neg_fs = zerovelTor_neg_abs(zerovelTor_neg_abs>zerovelTor_neg_max);        
        TorqueExtrem(n).neg =  mean(abs(zerovelTor_neg_max));
        TorqueExtrem(n).pos =  mean(abs(zerovelTor_pos_max));
    end
    StaticFriction(5).neg = abs(mean([TorqueExtrem.neg]));
    StaticFriction(5).pos = mean([TorqueExtrem.pos]);  
else
    StaticFriction(5).neg =0;
    StaticFriction(5).pos = 0;  
end
if(staticFileNumberJ6)
    for(n = 1:staticFileNumberJ6)
        data_CJ6 = ReadCoulombData(fullfile(StaticDataJoint_6(n).folder, StaticDataJoint_6(n).name));
        StaticJoint6(:,n).Velocity = MovingAverageFilter(data_CJ6(:,15+5))*180/pi;
        StaticJoint6(:,n).Torque = MovingAverageFilter(data_CJ6(:,27+5));
        StaticJoint6(:,n).time = linspace(0,1,length(StaticJoint6(n).Torque));
        zerovel = find(StaticJoint6(:,n).Velocity==0);
        zerovelTor  = StaticJoint6(:,n).Torque(zerovel);
        
        zerovelTor_neg = zerovelTor(zerovelTor<0);
        if(isempty(zerovelTor_neg))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos= zerovelTor(zerovelTor>0);
        if(isempty(zerovelTor_pos))
            display("Defective data detected")
            continue
        end
        zerovelTor_pos_max = max(abs(zerovelTor_pos));
%         zerovelTor_pos_fs = zerovelTor_pos(zerovelTor_pos>zerovelTor_pos_max);
        
        zerovelTor_neg_abs = abs(zerovelTor_neg);
        zerovelTor_neg_max = max(zerovelTor_neg_abs);
%         zerovelTor_neg_fs = zerovelTor_neg_abs(zerovelTor_neg_abs>zerovelTor_neg_max);        
        TorqueExtrem(n).neg =  mean(abs(zerovelTor_neg_max));
        TorqueExtrem(n).pos =  mean(abs(zerovelTor_pos_max));
    end
    StaticFriction(6).neg =abs(mean([TorqueExtrem.neg]));
    StaticFriction(6).pos = mean([TorqueExtrem.pos]);
else
    StaticFriction(6).neg =0;
    StaticFriction(6).pos = 0;  
end
