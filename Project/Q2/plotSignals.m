function plotSignals(times,Signals,Titles,signalsPerFigure)
    if nargin < 3
        Titles = cell(1,length(Signals));
        signalsPerFigure = 1;
    elseif nargin < 4
        signalsPerFigure = 1;
    end
    if length(Signals) ~= length(Titles)
         error('Signals cell and tiltles cell are not in the same size.');
    end
    
    for i=1:length(Signals)
        if signalsPerFigure == 1
            figure;
        elseif mod(i,signalsPerFigure(1)*signalsPerFigure(2)) == 1
            figure
            subplot(signalsPerFigure(1),signalsPerFigure(2),1);
        else
            j = mod(i,signalsPerFigure(1)*signalsPerFigure(2));
            if j == 0
                j = signalsPerFigure(1)*signalsPerFigure(2);
            end
            subplot(signalsPerFigure(1),signalsPerFigure(2),j);
        end
        if length(times{i}) == length(Signals{i})
            plot(times{i},Signals{i});
            xlim([0,times{i}(end)]);
            title(Titles{i},'Interpreter','latex');
        else
            error(['Signal{', num2str(i) ,'} and time{', num2str(i) ,'} are not in the same size.']);
        end
        
    end
end