close all
clear
rawData1=textread('../data/julei1.txt');
[IDX, Color] = kmeans(rawData1, 2);
 figure(1),
 for i=1:2
    plot(rawData1(IDX==i,1),rawData1(IDX==i,2),'.');hold on
 end
 hold off
print(1,'../result/result1.bmp','-dbmp16m');
rawData2=textread('../data/julei2.txt');
minPoints=400;
min_cluster_size_ratio = 0.01;
min_clusters = 5;
min_maxima_ratio = 0.005;
min_neighborhood_size = 3;
% cost time 512.367924s
tic
[RD,CD,order]=optics(rawData2,minPoints);
toc
orderData=rawData2(order,:);
orderRD=RD(order);
min_cluster_size = round(min_cluster_size_ratio*size(orderRD,2));
min_cluster_size = max(min_cluster_size,min_clusters);
nghsize = round(min_maxima_ratio*size(orderRD,2));
nghsize = max(nghsize,min_neighborhood_size);
% [peaks,peaksLoc]=findpeaks(orderRD,'MinPeakProminence',25,'Annotate','extents');
[peaks,peaksLoc]=findpeaks(orderRD,'minpeakheight',165,'minpeakdistance',min_cluster_size,'MinPeakProminence',45);
% localMaximaPoints = findLocalMaxima(orderRD, orderData, nghsize);
% figure(2),
% plot(orderRD),hold on
% plot(localMaximaPoints,0,'*');hold on
% plot(peaksLoc,0,'*');
hold off
sstart=[1,peaksLoc];
eend=[peaksLoc,size(orderData,1)];
figure(2),
% color=rand(size(sstart,2),3);
Color=linspecer(size(sstart,2));
for i=1:size(sstart,2)
    plot(orderData(sstart(i):eend(i),1),orderData(sstart(i):eend(i),2),'.','Color',Color(i,:)),hold on
end
hold off
print(2,'../result/result2.bmp','-dbmp16m');
