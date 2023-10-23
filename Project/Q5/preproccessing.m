function new_Subject = preproccessing(subjectName,fpass,Fs_new)
    Subject = load(subjectName);
    Subject = bandpassStruct(Subject,fpass);            % bandpass-filtering
    Subject = reduceSampleRateStruct(Subject,Fs_new);	% down-sampling
    Subject = IndexExtraction(Subject);                 % index-extractioning
    new_Subject = epochStruct(Subject);                 % epoching
end