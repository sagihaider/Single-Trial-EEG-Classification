function [e1,e2]=f_plot_ellipse(Xf_left,Xf_right)

%# substract mean
    Mu = mean(Xf_left);
    X0 = bsxfun(@minus, Xf_left, Mu);

    %# eigen decomposition [sorted by eigen values]
    [V D] = eig(cov(X0));     %#' cov(X0)
    [D order] = sort(diag(D), 'descend');
    D = diag(D);
    V = V(:, order);

    t = linspace(0,2*pi,200);
    e = [cos(t) ; sin(t)];        %# unit circle
    VV = V*sqrt(D)*2;               %# scale eigenvectors
    e1 = bsxfun(@plus, VV*e, Mu'); %#' project circle back to orig space

   
%   
%# substract mean
    Mu = mean(Xf_right);
    X0 = bsxfun(@minus, Xf_right, Mu);

    %# eigen decomposition [sorted by eigen values]
    [V D] = eig(cov(X0));     %#' cov(X0)
    [D order] = sort(diag(D), 'descend');
    D = diag(D);
    V = V(:, order);

    t = linspace(0,2*pi,200);
    e = [cos(t) ; sin(t)];        %# unit circle
    VV = V*sqrt(D)*2;               %# scale eigenvectors
    e2 = bsxfun(@plus, VV*e, Mu'); %#' project circle back to orig space   
end