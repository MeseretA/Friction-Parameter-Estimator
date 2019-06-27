function Indy7RTData20190508230258 = ReadCoulombData(filename, startRow, endRow)
%IMPORTFILE �ؽ�Ʈ ������ ������ �����͸� ��ķ� �����ɴϴ�.
%   INDY7RTDATA20190508230258 = IMPORTFILE(FILENAME) ����Ʈ ���� �׸��� �ؽ�Ʈ ����
%   FILENAME���� �����͸� �н��ϴ�.
%
%   INDY7RTDATA20190508230258 = IMPORTFILE(FILENAME, STARTROW, ENDROW) �ؽ�Ʈ
%   ���� FILENAME�� STARTROW �࿡�� ENDROW ����� �����͸� �н��ϴ�.
%
% Example:
%   Indy7RTData20190508230258 = importfile('Indy7RTData_20190508230258.csv', 1, 24273);
%
%    TEXTSCAN�� �����Ͻʽÿ�.

% MATLAB���� ���� ��¥�� �ڵ� ������: 2019/05/08 23:25:30

%% ������ �ʱ�ȭ�մϴ�.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% �� �ؽ�Ʈ ������ ����:
%   ��15: double (%f)
%	��27: double (%f)
% �ڼ��� ������ ���� �������� TEXTSCAN�� �����Ͻʽÿ�.
formatSpec = '%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%*s%[^\n\r]';

%% �ؽ�Ʈ ������ ���ϴ�.
fileID = fopen(filename,'r');

%% ���Ŀ� ���� ������ ���� �н��ϴ�.
% �� ȣ���� �� �ڵ带 �����ϴ� �� ���Ǵ� ������ ����ü�� ������� �մϴ�. �ٸ� ���Ͽ� ���� ������ �߻��ϴ� ��� �������� ������
% �ڵ带 �ٽ� �����Ͻʽÿ�.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% �ؽ�Ʈ ������ �ݽ��ϴ�.
fclose(fileID);

%% ������ �� ���� �����Ϳ� ���� ���� ó�� ���Դϴ�.
% �������� �������� ������ �� ���� �����Ϳ� ��Ģ�� ������� �ʾ����Ƿ� ���� ó�� �ڵ尡 ���Ե��� �ʾҽ��ϴ�. ������ �� ����
% �����Ϳ� ����� �ڵ带 �����Ϸ��� ���Ͽ��� ������ �� ���� ���� �����ϰ� ��ũ��Ʈ�� �ٽ� �����Ͻʽÿ�.

%% ��� ���� �����
Indy7RTData20190508230258 = [dataArray{1:end-1}];
