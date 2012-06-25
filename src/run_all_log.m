time = clock;
fname = num2str(time(1));
for timeNo = 2:length(time)
   fname = [fname '_' num2str(time(timeNo))];
end
fname = [fname '.log'];
diary('test.log');
run_all
disp(['Log file name: ' fname]);
diary('off');
