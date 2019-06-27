function [problem, Function_PDexpr, Function_PDexpr_full] = LSQcurveFitArg_neg(Xdata, Ydata,F_c, F_s,X0,key)
%% Optimization Argument for LSQcurveFit
% OPTIONS -- create/ modify optimization options
% OPTIONS = optimoptions(SOLVER);
% SOLVER: 
%@fmincon--> (options:'Algorithm',  interior-point (default)
%                                            trust-region-reflective
%                                            sqp
%                                            sqp-legacy (optimoptions only)
%                                            active-set
%                     'MaxFunctionEvaluations' maximum number of
%                                              function evaluations allowed, a positive
%                                              integer. defaul except 'interior-point' is
%                                              100*numberOfVariables. 3000 for
%                                              'interior-point'
%                     'OpatimalityTolerance' Termination tolerance 
%                                            on the first-order optimality. 1e-06 default
%                     'PlotFcn'   'optimplotx' plots the current point
% 
%                                 'optimplotfunccount' plots the function count
% 
%                                 'optimplotfval' plots the function value
% 
%                                 'optimplotconstrviolation' plots the maximum constraint violation
% 
%                                 'optimplotstepsize' plots the step size
% 
%                                 'optimplotfirstorderopt' plots the first-order optimality measure
% @lsqcurvefit--> (options: 'Algorithm', 'trust-region-reflective' (default) and                                    %                               
%                                        'levenberg-marquardt'
%                           'FunctionTolerance', Termination tolerance on the function value, a                                               
%                                                positive scalar. the default is 1e-6.

OPTIONS_LSQCURVEFIT = optimoptions(@lsqcurvefit);
OPTIONS_LSQCURVEFIT.Algorithm = 'levenberg-marquardt';
OPTIONS_LSQCURVEFIT.Display = 'iter'; % displays output at each iteration, and gives the default exit message.
OPTIONS_LSQCURVEFIT.OptimalityTolerance = 1e-7; % default value. not used in the 'levenberg-marquardt' algorithm.
OPTIONS_LSQCURVEFIT.PlotFcn = {@optimplotx,@optimplotfval,@optimplotfirstorderopt};
OPTIONS_LSQCURVEFIT.ScaleProblem = 'Jacobian'; % default is 'none'
OPTIONS_LSQCURVEFIT.InitDamping = 1e-2; % default is 0.01.
OPTIONS_LSQCURVEFIT.StepTolerance = 1e-23;
OPTIONS_LSQCURVEFIT.FunctionTolerance  = 1e-23;
OPTIONS_LSQCURVEFIT.MaxFunctionEvaluations = 1e6;
OPTIONS_LSQCURVEFIT.MaxIterations = 1e6;

problem.options = OPTIONS_LSQCURVEFIT;
problem.solver = 'lsqcurvefit';
% Function_PDexpr = @(x,xdata) x(1)*sign(xdata) + (x(2) - x(1))*exp(-1*(xdata.^2/x(3)^2)).*sign(xdata) + ...
%     x(4)*xdata + x(5)*xdata.^2 + x(6)*xdata.^3;
Function_PDexpr_full = @(x,xdata) F_c*sign(xdata) + (F_s - F_c)*exp(-1*(xdata.^2/(1e-3)^2)).*sign(xdata) + ...
    x(1)*xdata + x(2)*xdata.^2 + x(3)*xdata.^3;
Function_PDexpr = @(x,xdata) F_c*sign(xdata)  + ... %+ (F_s - F_c)*exp(-1*(xdata.^2/x(1)^2)).*sign(xdata)
    x(1)*xdata + x(2)*xdata.^2 + x(3)*xdata.^3;
% Function_PDexpr_full = @(x,xdata)F_c*sign(xdata) + (F_s - F_c)*exp(-1*(xdata.^2/(1e-3)^2)).*sign(xdata) + ...
%     x(1)*xdata + x(2)*xdata.^2 + x(3)*xdata.^3+ x(4)*xdata.^4+ x(5)*xdata.^5 + x(6)*xdata.^6 ; % (F_s - F_c)*exp(-1*(xdata.^2/(1e-3)^2)).*sign(xdata) +
% Function_PDexpr = @(x,xdata)x(7)*sign(xdata) + ...
%     x(1)*xdata + x(2)*xdata.^2 + x(3)*xdata.^3+ x(4)*xdata.^4+ x(5)*xdata.^5 + x(6)*xdata.^6 ; % (F_s - F_c)*exp(-1*(xdata.^2/(1e-3)^2)).*sign(xdata) +
switch key
    case 1
        problem.objective = Function_PDexpr;
    case 2
        problem.objective = @Function_PD;
end
problem.lb =[];%[-Inf,-Inf,-Inf,-Inf,-Inf,-Inf,0, 0, 0];% [0.0, 1.0, 0.0, -Inf, -Inf, -Inf];%, -Inf, -Inf];
problem.ub =[];% [Inf,Inf,Inf,Inf,Inf,Inf,20,20,1];%[Inf, Inf, Inf, Inf, Inf, Inf];%, Inf, Inf];
% problem.x0 = [X0.Fc_n, X0.Fs_n, X0.vs_n, X0.Fv1_n, X0.Fv2_n, X0.Fv3_n];
problem.x0 = [X0.Fv1_n, X0.Fv2_n, X0.Fv3_n];
% problem.x0 = [X0.Fv1_n, X0.Fv2_n, X0.Fv3_n, X0.Fv4_n, X0.Fv5_n, X0.Fv6_n,X0.Fc_n];
% problem.x0 = [X0.vs_n, X0.Fv1_n, X0.Fv2_n, X0.Fv3_n];
problem.xdata = Xdata;
problem.ydata = Ydata;

end
