function VARfevdplot(FEVD,VARopt,INF,SUP)
% =======================================================================
% Plot the FEVDs computed with VARfevd
% =======================================================================
% VARfevdplot(FEVD,VARopt,vnames,INF,SUP)
% -----------------------------------------------------------------------
% INPUT
%   - FEVD(:,:,:): matrix with 't' steps, the FEVD due to 'j' shock for 
%       'k' variable
%	- VARopt: options of the FEVDs (see VARoption)
% -----------------------------------------------------------------------
% OPTIONAL INPUT
%   - INF: lower error band
%   - SUP: upper error band
% =======================================================================
% Ambrogio Cesa Bianchi, March 2015
% ambrogio.cesabianchi@gmail.com


%% Check inputs
%================================================
if ~exist('VARopt','var')
    error('You need to provide VAR options (VARopt from VARmodel)');
end
% If there is VARopt check that vnames is not empty
vnames = VARopt.vnames;
if isempty(vnames)
    error('You need to add label for endogenous variables in VARopt');
end


%% Retrieve and initialize variables 
%================================================
filename = [VARopt.figname 'FEVD_'];
quality = VARopt.quality;
savefigs = VARopt.savefigs;
suptitle = VARopt.suptitle;
pick = VARopt.pick;

% Initialize FEVD matrix
[nsteps, nvars, nshocks] = size(FEVD);

% If one variable is chosen, set the right value for nvars
if pick<0 || pick>nvars
    error('The selected variable is non valid')
else
    if pick==0
        pick=1;
    else
        nvars = pick;
    end
end

% Define the rows and columns for the subplots
row = 1;        % round(sqrt(nvars));
col = nvars;    % ceil(sqrt(nvars));

% Define a timeline
steps = 1:1:nsteps;
x_axis = zeros(1,nsteps);



%% Plot
%================================================

for ii=pick:nvars
    disp(['Variance decomposition of ' vnames{ii}])
    figure; FigSize(40,10)
    for jj=1:nshocks
        subplot(row,col,jj);
        plot(steps,FEVD(:,jj,ii),'LineStyle','-','Color',[0.01 0.09 0.44],'LineWidth',2);
        hold on
        plot(x_axis,'k','LineWidth',0.5)
        if exist('INF','var') && exist('SUP','var')
            plot(steps,INF(:,jj,ii),'LineStyle',':','Color',[0.39 0.58 0.93],'LineWidth',1.5);
            hold on
            plot(steps,SUP(:,jj,ii),'LineStyle',':','Color',[0.39 0.58 0.93],'LineWidth',1.5);
        end
        xlim([1 nsteps]); ylim([0 1]);
        title(['Contrib. of ' vnames{jj} ' shock to ' vnames{ii} ' variance'], 'FontWeight','bold','FontSize',10); 
    end
    
    if savefigs
        % Save
        FigName = [filename num2str(ii)];
        if quality
            if suptitle==1
                Alphabet = char('a'+(1:nvars)-1);
                SupTitle([Alphabet(ii) ') FEVD of '  vnames{ii}])
            end
            set(gcf, 'Color', 'w');
            export_fig(FigName,'-pdf','-png','-painters')
        else
            print('-dpng','-r100',FigName);
            orient landscape
            print('-dpdf','-bestfit','-r100',FigName);
        end
    end
end
