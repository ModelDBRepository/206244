function [estimates, model, exitflag, sse] = exp_nooffset(xdata, ydata,weights)
% Call fminsearch with a random starting point.
% start_point = rand(1, 3);
if nargin<3
    weights = ones(size(ydata));
end
[~,s]=sort(ydata);
f=find(ydata(s)>0.5,1,'first');
start_point = [rand(1,1)];
model = @exp_Yoffs_fun;
options.MaxFunEvals = 10^12*length(start_point);
options.MaxIter = 10^12;
[estimates, sse, fval, exitflag] = fminsearch(model, start_point,options);
% expfun accepts curve parameters as inputs, and outputs sse,
% the sum of squares error for A + B*exp(-lambda*xdata)-ydata,
% and the FittedCurve. FMINSEARCH only needs sse, but we want
% to plot the FittedCurve at the end.
    function [sse, FittedCurve] = exp_Yoffs_fun(params)
        lambda = params(1);
        FittedCurve = exp(-lambda * xdata);
        ErrorVector = FittedCurve - ydata;
        sse = sum(ErrorVector .^ 2.*weights);
    end
end