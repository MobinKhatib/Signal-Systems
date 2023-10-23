function HalfBandFFT(X, Fs, b, my_title)
    if nargin < 3
        b = 1;
    end
    
    Y = fft(X);
    
    a = 1;
    L = length(X);
    P2 = abs(Y/L);
    P1 = P2(1:floor(L*a));
    P1(2:end-1) = 2*P1(2:end-1);
    
	f = Fs*(0:floor(L*a)-1)/L;
    w = 2 * pi * f / Fs;
    
    if b == 1
        plot(w,P1,'linewidth',1.5);

        if nargin == 4
            title(sprintf('%s',my_title),'Interpreter','latex');
        end

        xlabel('$w (rad/s)$','Interpreter','latex'); ylabel('$|H(f)|$','Interpreter','latex');
        xlim([0 2*pi/a]); grid minor;
        set(gca,'XTick',0:pi/4:2*pi/a);
        set(gca,'XTickLabel',{'0','\pi/4','\pi/2','3\pi/4','\pi','5\pi/4','3\pi/2','7\pi/4','2\pi'});
    else
        plot(f(1:floor(L/2)),P1(1:floor(L/2)),'linewidth',1.5);

        if nargin == 4
            title(sprintf('%s',my_title),'Interpreter','latex');
        end

        xlabel('$f (Hz)$','Interpreter','latex'); ylabel('$|H(f)|$','Interpreter','latex');
        xlim([0,f(floor(L/2))]); grid minor;
    end
end