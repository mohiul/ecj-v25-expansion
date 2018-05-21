clear;

k = {'keijzer1', 'keijzer2', 'keijzer3', 'keijzer4', 'keijzer5', 'keijzer6', ...
  'keijzer7', 'keijzer8', 'keijzer9', 'keijzer10', 'keijzer11', 'keijzer12', 'keijzer13', ...
  'keijzer14', 'keijzer15', 'vladislavleva1', 'vladislavleva2', 'vladislavleva3', 'vladislavleva4', ...
  'vladislavleva5', 'vladislavleva6', 'vladislavleva7'};
v = {'$$ 0.3xsin(2\pi x) $$', '$$ 0.3xsin(2\pi x) $$', 'keijzer3', '$$x^3e^{-x}cos(x)sin(x)(sin^2(x)cos(x)-1)$$', ...
    '$$ 30xz \over (x-10)y^2 $$', '$$ \sum_{i}^{x} 1/i $$', ...
  'keijzer7', 'keijzer8', 'keijzer9', '$$ x^y $$', '$$ xy + sin((x-1)(y-1)) $$', '$$ x^4-x^3+y^2/2 - y $$', '$$ 6sin(x)cos(y) $$', ...
  '$$ 8 \over (2+x^2+y^2) $$', '$$ x^3/5 + y^3/5 -y -x $$', '$$ e^{-(x-1)^2}/(1.2 + (y-2.5)^2) $$',...
  '$$ e^{-x}x^3 cos(x) sin(x)(cos(x) sin^2(x)-1) $$', '$$ e^{-x}x^3 cos(x) sin(x)(cos(x) sin^2(x)-1)(y-5) $$',...
  '$$ 10 \over (5+(x-3)^2+(y-3)^2+(z-3)^2+(v-3)^2+(w-3)^2) $$', ...
  '$$ 30 (x-1)(z-1) \over y^2(x-10) $$', 'vladislavleva6', '$$ (x-3)(y-3)+2sin((x-4)(y-4)) $$'};
problemList = containers.Map(k, v);

%prob = 'pagie1';
prob = 'keijzer11';
%prob = 'vladislavleva4';


%expSim1 = dlmread(strcat(['ex-param-diff/ecj-', 'pagie1', '-ex5xo95dist10sim1']), '\t');
expSim1 = dlmread(strcat(['expansionAll/test4sim1dist10/ecj-', prob, '-addInd-noFv']), '\t');
original = dlmread(strcat(['expansionAll/original/1200p1000g/ecj-', prob]), '\t');
mu_xo_all = dlmread(strcat(['mu_xo_all/ecj-', prob]), '\t');
ex_mu_xo_all = dlmread(strcat(['ex_mu_xo/ecj-', prob, '-addInd-noFv']), '\t');

generation = 1002;
expSim1 = expSim1(:, 1:generation);
original = original(:, 1:generation);
mu_xo_all = mu_xo_all(:, 1:generation);
ex_mu_xo_all = ex_mu_xo_all(:, 1:generation);

m_expSim1 = mean(expSim1,1);
m_original = mean(original,1);
m_mu_xo_all = mean(mu_xo_all,1);
m_ex_mu_xo_all = mean(ex_mu_xo_all,1);

indices = 1:generation;
b_indices = 1:generation;

plot(b_indices, m_expSim1,'-', ...
    indices, m_original,'--', ...
    indices, m_mu_xo_all,'--', ...
    indices, m_ex_mu_xo_all,'-.');
title(problemList(prob),'Interpreter','latex');
xlabel('Number of Generations');
ylabel('Average of 50 executions');
legend('Expansion:5% Crossover:85%','Crossover:90%', 'Mutation:10% Crossover:80%', 'Expansion:5% Mutation:10% Crossover:75%');

%ylim([0 1.2]);

% figure;
% [mx_expSim1, I_expSim1] = max(expSim1, [], 1);
% [mx_original, I_original] = max(original, [], 1);
% [mx_mu_xo_all, I_mu_xo_all] = max(mu_xo_all, [], 1);
% 
% plot(b_indices, expSim1(I_expSim1(end), :), '-', ...
%     indices, original(I_original(end), :), '--', ...
%     indices, mu_xo_all(I_mu_xo_all(end), :), '--');
% title(prob);
% xlabel('Number of Generations');
% ylabel('Best Fitness');
% legend('Expansion','ecj default', '10% Mutation');

%ylim([0 1.2]);