clc;
clear all;
close all;
%%
IsCoulombFriction = 1;
IsStaticFriction  = 1;
IsViscousFriction = 1;

if(IsCoulombFriction)
    % TODO: 
    % 1. Identify zero velocity correspoding torque
    % 2. identify the more clearly constant torque region and take the
    % average from both positive and negative side. That will be the
    % Coulomb Friction.
    LoadCoulombFrictionData();
    % retun -->> Joint(i).F_c_p and Joint(i).F_c_n
end
 
if(IsStaticFriction)
    % TODO: 
    % 1. Filter data
    % 2. find the Maximum and Minimum torque for more than 2 experimental
    % data. The average maximum and minimum torque will be the Static Friction
    % for positive and negative velocity respectively.
    LoadStaticFrictionData();
    % return -->> StaticFriction(i).neg and StaticFriction(i).pos
end

if(IsViscousFriction)
    %%
    % get data\
    % Return vel and tau
    LoadViscousData(); 
    % return -->>   Viscous(i).Torque_pos,  Viscous(i).Velocity_pos, Viscous(i).Torque_neg and Viscous(i).Velocity_neg,
   


    %% Optimization Arguments
    % Initializing Optimization Parameters
    mode = "one";
    [X0] = initializeOptParam(mode);
    viscousFileNumbersOfJoints = [viscousFileNumberJ1, viscousFileNumberJ2, viscousFileNumberJ3, viscousFileNumberJ4, viscousFileNumberJ5, viscousFileNumberJ6];
clc
for j = 1:6
    if(viscousFileNumbersOfJoints(j))
         [problem_pos, Function_PDexpr_pos,  Function_PDexpr_pos_full] = LSQcurveFitArg_pos(Viscous(j).Velocity_pos, Viscous(j).Torque_pos, Joint(j).F_c_n, StaticFriction(j).pos, X0(j),1);
        [X(j).pos] = lsqcurvefit(problem_pos);

        [problem_neg, Function_PDexpr_neg,  Function_PDexpr_neg_full] = LSQcurveFitArg_neg(Viscous(j).Velocity_neg, Viscous(j).Torque_neg, Joint(j).F_c_n, StaticFriction(j).neg, X0(j),1);
        [X(j).neg] = lsqcurvefit(problem_neg);    
    else
        X(j).neg = [0,0,0,0,0,0];
        X(j).pos = [0,0,0,0,0,0];
    end 
end

%% Plot
figure
for i = 1:6
    if(viscousFileNumbersOfJoints(i))
         [problem_pos, Function_PDexpr_pos,  Function_PDexpr_pos_full] = LSQcurveFitArg_pos(Viscous(i).Velocity_pos, Viscous(i).Torque_pos, Joint(i).F_c_p, StaticFriction(i).pos, X0(i),1);
         [problem_neg, Function_PDexpr_neg,  Function_PDexpr_neg_full] = LSQcurveFitArg_neg(Viscous(i).Velocity_neg, Viscous(i).Torque_neg, Joint(i).F_c_n, StaticFriction(i).neg, X0(i),1);
        
        subplot(3,2,double(i))
        set(gca,'FontSize', 10, 'FontName','Arial')
        hold on; box on; grid minor;
%         plot(Viscous(i).Velocity_pos, Viscous(i).Torque_pos,'ko', Viscous(i).Velocity_neg, Viscous(i).Torque_neg,'ko', 'linewidth', 2)
%         plot(Viscous(i).Velocity_pos,Function_PDexpr_pos(X(i).pos, Viscous(i).Velocity_pos), 'r', Viscous(i).Velocity_neg, Function_PDexpr_pos(X(i).neg, Viscous(i).Velocity_neg), 'r', 'linewidth', 2)        
        plot([0,0.2*pi/180,Viscous(i).Velocity_pos']', [StaticFriction(i).pos, Joint(i).F_c_p, Viscous(i).Torque_pos']','ko', [0,-0.2*pi/180,Viscous(i).Velocity_neg']', [StaticFriction(i).neg*-1,Joint(i).F_c_n*-1,Viscous(i).Torque_neg']','ko', 'linewidth', 2)
        plot([0,0.2*pi/180,Viscous(i).Velocity_pos']',[StaticFriction(i).pos, Joint(i).F_c_p, Function_PDexpr_pos_full(X(i).pos, Viscous(i).Velocity_pos)']', 'r', [0,-0.2*pi/180,Viscous(i).Velocity_neg']', [StaticFriction(i).neg*-1,Joint(i).F_c_n*-1,Function_PDexpr_neg_full(X(i).neg, Viscous(i).Velocity_neg)']', 'r', 'linewidth', 2)
        xlabel('Velocity (rad/sec)');
        ylabel('Friction Torque (Nm)');
        if i==1
            legend('Measured Friction','Measured Friction' ,'Estimated Friction');
        end
    end
        
end
  
end
%% creat xml file matlab
clc;
% 1. create the document node and root element, toc
docNode = com.mathworks.xml.XMLUtils.createDocument('FricParameter');
% 2. Identify the root element, and set the version attribute:
FricParameter = docNode.getDocumentElement;
% toc.setAttribute('version','2.0');
% 3. Add the tocitem element node for the product page. Each tocitem
% element in this file has a target attribute
% product = docNode.createElement('fricPar');
% product.setAttribute('target', 'upslope_product_page.html');
% product.appendChild(docNode.createTextNode('Upslope Area Toolbox'));
% FricParameter.appendChild(product)
% % 4. Add the comment:
% product.appendChild(docNode.createComment('Functions'));
% 5. Add a tocitem elemet node for each function, where the targets is of
% the form function_help.html:
JointIndex = {'0', '1', '2', '3', '4', '5'};
rate_fric = {'1', '1', '1', '1', '1', '1'};
rate_viscous = {'1', '1', '1', '1', '1', '1'};
rate_viscous_DT = {'1', '1', '1', '1', '1', '1'};
rate_fric_DT = {'1', '1', '1', '1', '1', '1'};
rate_grav_DT = {'1', '1', '1', '1', '1', '1'};
sigma_0 = {'1.6804e4', '1.6804e4', '1.6804e4', '1.6804e4', '1.6804e4', '1.6804e4'};
sigma_1 = {'259.2605', '259.2605', '259.2605', '259.2605', '259.2605', '259.2605'};
for idx = 1:numel(JointIndex)
    curr_node = docNode.createElement('fricPar');
    
%     curr_file = [functions{idx}];

    curr_node.setAttribute('F_c_p', num2str(Joint(idx).F_c_p));    
    curr_node.setAttribute('F_c_n', num2str(Joint(idx).F_c_n));
    curr_node.setAttribute('F_s_p', num2str(StaticFriction(idx).pos));
    curr_node.setAttribute('F_s_n', num2str(StaticFriction(idx).neg));    
    curr_node.setAttribute('v_s_p', num2str(X0(idx).vs_p));
    curr_node.setAttribute('v_s_n', num2str(X0(idx).vs_n)); 
    if(mode == "one")
        curr_node.setAttribute('F_v1_p', num2str(X(idx).pos(1)));     
        curr_node.setAttribute('F_v2_p', num2str(X(idx).pos(2)));
        curr_node.setAttribute('F_v3_p', num2str(X(idx).pos(3)));
    else
        curr_node.setAttribute('F_v1_p', num2str(X(idx).pos(1)));     
        curr_node.setAttribute('F_v2_p', num2str(X(idx).pos(2)));
        curr_node.setAttribute('F_v3_p', num2str(X(idx).pos(3)));
        curr_node.setAttribute('F_v4_p', num2str(X(idx).pos(4)));
        curr_node.setAttribute('F_v5_p', num2str(X(idx).pos(5)));
        curr_node.setAttribute('F_v6_p', num2str(X(idx).pos(6)));        
    end
    
     if(mode == "one")
        curr_node.setAttribute('F_v1_n', num2str(X(idx).neg(1)));
        curr_node.setAttribute('F_v2_n', num2str(X(idx).neg(2)));
        curr_node.setAttribute('F_v3_n', num2str(X(idx).neg(3)));         
     else
        curr_node.setAttribute('F_v1_n', num2str(X(idx).neg(1)));
        curr_node.setAttribute('F_v2_n', num2str(X(idx).neg(2)));
        curr_node.setAttribute('F_v3_n', num2str(X(idx).neg(3)));
        curr_node.setAttribute('F_v4_n', num2str(X(idx).neg(4)));
        curr_node.setAttribute('F_v5_n', num2str(X(idx).neg(5)));
        curr_node.setAttribute('F_v6_n', num2str(X(idx).neg(6)));            
     end
 
    curr_node.setAttribute('index', JointIndex{idx});  
    curr_node.setAttribute('rate_fric', rate_fric{idx}); 
    curr_node.setAttribute('rate_viscous', rate_viscous{idx}); 
    curr_node.setAttribute('rate_viscous_DT', rate_viscous_DT{idx}); 
    curr_node.setAttribute('rate_fric_DT', rate_fric_DT{idx}); 
    curr_node.setAttribute('rate_grav_DT', rate_grav_DT{idx}); 
    curr_node.setAttribute('sigma_0', sigma_0{idx}); 
    curr_node.setAttribute('sigma_1', sigma_1{idx}); 
    FricParameter.appendChild(curr_node);    
    % Child text is the function name.
%     curr_node.appendChild(docNode.createTextNode(functions{idx}));
    
end
% 6. Export the DOM node to info.xml, and view the file with the type
% function
xmlwrite('FricParameterIndy7.xml', docNode);
% type('info.xml');
%%
% clc
% docNode = com.mathworks.xml.XMLUtils.createDocument('toc');
% toc = docNode.getDocumentElement;
% % toc.setAttribute('version','2.0');
% product = docNode.createElement('tocitem');
% product.setAttribute('target','upslope_product_page.html');
% % product.appendChild(docNode.createTextNode('Upslope Area Toolbox'));
% toc.appendChild(product)
% % product.appendChild(docNode.createComment(' Functions '));
% % JointIndex = {'demFlow','facetFlow','flowMatrix','pixelFlow'};
% % for idx = 1:numel(JointIndex)
% %     curr_node = docNode.createElement('tocitem');
% %     
% %     curr_file = [JointIndex{idx} '_help.html']; 
% %     curr_node.setAttribute('target',curr_file);
% %     
% %     % Child text is the function name.
% %     curr_node.appendChild(docNode.createTextNode(JointIndex{idx}));
% %     product.appendChild(curr_node);
% % end
% % 
% xmlwrite('info.xml',docNode);
% % type('info.xml');