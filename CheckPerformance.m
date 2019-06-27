clc;
close all;
clear all;
%%
foldername_Performance = 'PerformanceCheck';
PerformanceData = dir(foldername_Performance);

PerformanceData(1:2) = [];

foldernumber_Performance = length(PerformanceData);

WithFricData = dir(fullfile(PerformanceData(2).folder, PerformanceData(2).name));
WithFricData(1:2) = [];
WithFricDataFileNumebr = length(WithFricData);
% To change Joints
JNoOffset1 = 0;
 for n = 1:WithFricDataFileNumebr
     data_WithFriction = ReadRDforPerformance(fullfile(WithFricData(n).folder, WithFricData(n).name));
     Joint(n).q_with = data_WithFriction(:,2+JNoOffset1);%*180/pi;
     Joint(n).qdes_with = data_WithFriction(:,8+JNoOffset1);%*180/pi;
     joint(n).time_with = data_WithFriction(:,1);
     joint(n).torque_with = data_WithFriction(:,50+JNoOffset1);
     joint(n).velocityerror_with = data_WithFriction(:,20+JNoOffset1)*180/pi - data_WithFriction(:,14+JNoOffset1)*180/pi;
     joint(n).error_with = Joint(n).qdes_with - Joint(n).q_with;
 end
 
 %%
 NoFricData = dir(fullfile(PerformanceData(1).folder, PerformanceData(1).name));
NoFricData(1:2) = [];
NoFricDataFileNumebr = length(NoFricData);
 for n = 1:NoFricDataFileNumebr
     data_NoFriction = ReadRDforPerformance(fullfile(NoFricData(n).folder, NoFricData(n).name));
     Jointt(n).q_without = data_NoFriction(:,2+JNoOffset1);%*180/pi;
     Jointt(n).qdes_without = data_NoFriction(:,8+JNoOffset1);%*180/pi;
     jointt(n).time_without = data_NoFriction(:,1);
     jointt(n).torque_without = data_NoFriction(:,50+JNoOffset1);
     jointt(n).velocityerror_without = data_NoFriction(:,20+JNoOffset1)*180/pi-data_NoFriction(:,14+JNoOffset1)*180/pi;
     jointt(n).error_without = Jointt(n).qdes_without - Jointt(n).q_without;
 end
 
 %%
%  figure(1)
%  hold on; box on; grid minor;
%  for  i = 1: WithFricDataFileNumebr
%      plot(joint(n).time, Joint(n).q, 'r', 'linewidth',2);
%      plot(joint(n).time, Joint(n).qdes, 'b', 'linewidth',2);   
%  end
time = linspace(0,1,length(jointt(1).error_without));
 figure(2)
 hold on; box on; grid minor;
  for  i = 1: WithFricDataFileNumebr
%     plot(joint(n).time_without, joint(n).error_without, 'k', 'linewidth',2); 
%     plot(joint(n).time_with, joint(n).error_with, 'b', 'linewidth',2);  
plot(time, joint(n).error_with, 'r', 'linewidth',2);     
plot(time, jointt(n).error_without, 'k', 'linewidth',2); 
    
%     plot(time,  joint(n).torque_with, 'k', 'linewidth',2); 
%     plot(time, joint(n).torque_without, 'b', 'linewidth',2); 
%      plot(time, joint(n).velocityerror_without*10, 'g', 'linewidth',2); 
%      plot(time,joint(n).velocityerror_with*10, 'y', 'linewidth',2); 
     
    
  end
 legend('With','Without')
 
 
