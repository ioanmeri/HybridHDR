% gseData = getgeodata('GSE5847', 'ToFile', 'GSE5847.txt')
% 
% GEOData = getgeodata(AccessionNumber)
% 
% getgeodata(AccessionNumber, 'ToFile', ToFileValue)

% dm = bioma.data.DataMatrix(rand(5,4), 'RowNames','Feature', 'ColNames', 'Sample')
% 
% dm({'Feature2', 'Feature3'}, {'Sample1', 'Sample4'}) = [2, 3; 4, 5]
% 
% exprsData = bioma.data.DataMatrix('file', 'mouseExprsData.txt');
% 
% class(exprsData)

%------------- NEW TUTORIAL --------------- %
% Accessing Web Map Service (WMS)
% available from: NASA, ESA, usgs, NOAA, esri, microsoft
% search function, data layers we want to
% natural recourses canada
 a = wmsfind('nrcan','searchfield','serverurl');
 aa = wmsfind('nga','searchfield','serverurl');
 
 b = wmsupdate(aa(1))
 
[c, r] = wmsread(b);
 
 