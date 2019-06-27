function Indy7RTData20190506224229 = READcsvDATA(filename, startRow, endRow)
%IMPORTFILE �ؽ�Ʈ ������ ������ �����͸� ��ķ� �����ɴϴ�.
%   INDY7RTDATA20190506224229 = IMPORTFILE(FILENAME) ����Ʈ ���� �׸��� �ؽ�Ʈ ����
%   FILENAME���� �����͸� �н��ϴ�.
%
%   INDY7RTDATA20190506224229 = IMPORTFILE(FILENAME, STARTROW, ENDROW) �ؽ�Ʈ
%   ���� FILENAME�� STARTROW �࿡�� ENDROW ����� �����͸� �н��ϴ�.
%
% Example:
%   Indy7RTData20190506224229 = importfile('Indy7RTData_20190506224229.csv', 1, 29130);
%
%    TEXTSCAN�� �����Ͻʽÿ�.

% MATLAB���� ���� ��¥�� �ڵ� ������: 2019/05/06 23:47:59

%% ������ �ʱ�ȭ�մϴ�.
delimiter = ',';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% �� �ؽ�Ʈ ������ ����:
%   ��1: double (%f)
%	��2: double (%f)
%   ��3: double (%f)
%	��4: double (%f)
%   ��5: double (%f)
%	��6: double (%f)
%   ��7: double (%f)
%	��8: double (%f)
%   ��9: double (%f)
%	��10: double (%f)
%   ��11: double (%f)
%	��12: double (%f)
%   ��13: double (%f)
%	��14: double (%f)
%   ��15: double (%f)
%	��16: double (%f)
%   ��17: double (%f)
%	��18: double (%f)
%   ��19: double (%f)
%	��20: double (%f)
%   ��21: double (%f)
%	��22: double (%f)
%   ��23: double (%f)
%	��24: double (%f)
%   ��25: double (%f)
%	��26: double (%f)
%   ��27: double (%f)
%	��28: double (%f)
%   ��29: double (%f)
%	��30: double (%f)
%   ��31: double (%f)
%	��32: double (%f)
% �ڼ��� ������ ���� �������� TEXTSCAN�� �����Ͻʽÿ�.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

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
Indy7RTData20190506224229 = [dataArray{1:end-1}];
