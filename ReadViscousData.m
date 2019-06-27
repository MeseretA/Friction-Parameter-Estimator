function Indy7FrictionDatajoint1 = ReadViscousData(filename, startRow, endRow)
%IMPORTFILE 텍스트 파일의 숫자형 데이터를 행렬로 가져옵니다.
%   INDY7FRICTIONDATAJOINT1 = IMPORTFILE(FILENAME) 디폴트 선택 항목의 텍스트 파일
%   FILENAME에서 데이터를 읽습니다.
%
%   INDY7FRICTIONDATAJOINT1 = IMPORTFILE(FILENAME, STARTROW, ENDROW) 텍스트 파일
%   FILENAME의 STARTROW 행에서 ENDROW 행까지 데이터를 읽습니다.
%
% Example:
%   Indy7FrictionDatajoint1 = importfile('Indy7FrictionData_joint1.csv', 4, 141);
%
%    TEXTSCAN도 참조하십시오.

% MATLAB에서 다음 날짜에 자동 생성됨: 2019/05/08 22:34:20

%% 변수를 초기화합니다.
delimiter = ',';
if nargin<=2
    startRow = 4;
    endRow = inf;
end

%% 각 텍스트 라인의 형식:
%   열1: double (%f)
%	열2: double (%f)
%   열3: double (%f)
% 자세한 내용은 도움말 문서에서 TEXTSCAN을 참조하십시오.
formatSpec = '%f%f%f%[^\n\r]';

%% 텍스트 파일을 엽니다.
fileID = fopen(filename,'r');

%% 형식에 따라 데이터 열을 읽습니다.
% 이 호출은 이 코드를 생성하는 데 사용되는 파일의 구조체를 기반으로 합니다. 다른 파일에 대한 오류가 발생하는 경우 가져오기 툴에서
% 코드를 다시 생성하십시오.
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'WhiteSpace', '', 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% 텍스트 파일을 닫습니다.
fclose(fileID);

%% 가져올 수 없는 데이터에 대한 사후 처리 중입니다.
% 가져오기 과정에서 가져올 수 없는 데이터에 규칙이 적용되지 않았으므로 사후 처리 코드가 포함되지 않았습니다. 가져올 수 없는
% 데이터에 사용할 코드를 생성하려면 파일에서 가져올 수 없는 셀을 선택하고 스크립트를 다시 생성하십시오.

%% 출력 변수 만들기
Indy7FrictionDatajoint1 = [dataArray{1:end-1}];
