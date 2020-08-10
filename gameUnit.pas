unit gameUnit;

interface

uses Dialogs, SysUtils;

type
  TArray = array [0..3, 0..3] of string[2];
  TEmptyButton = array[0..1] of integer;
  TGame = class
  private
    FArray: TArray;
    FTargetArray: TArray;
    FEmptyButton: TEmptyButton;
    function GetArray: TArray;
    function GetTargetArray: TArray;
    procedure SetEmptyButton(emptyButton: TEmptyButton);
    procedure WriteButtonIfEmpty(i, j: integer);
    function IsArraySolvability: boolean;
    function NumberOfSmallerSquaresFurther(x, y: integer): integer;
    procedure SwapSomeNeighbor;
  public
    Property Arr: TArray read GetArray;
    Property TargetArr: TArray read GetTargetArray;
    Property EmptyButton: TEmptyButton read FEmptyButton write SetEmptyButton;
    Constructor Create;
end;

implementation

var
  targetArray: TArray = (
    ('1', '2', '3', '4'),
    ('5', '6', '7', '8'),
    ('9', '10', '11', '12'),
    ('13', '14', '15', '')
  );
  gameArray: TArray = (
    ('1', '2', '3', '4'),
    ('5', '6', '7', '8'),
    ('9', '10', '11', '12'),
    ('13', '14', '15', '')
  );

procedure TGame.WriteButtonIfEmpty(i, j: integer);
begin
if FArray[i, j] = '' then
    begin
    FEmptyButton[0] := i;
    FEmptyButton[1] := j;
    end;
end;

function TGame.NumberOfSmallerSquaresFurther(x, y: integer): integer;
var i, j, currentSquare, furtherSquare, sum: integer;
begin
sum := 0;
if FArray[x,y] = '' then currentSquare := 16
else currentSquare := StrToInt(FArray[x,y]);
for i:=x to 3 do
  begin
  if x=i then j:=y+1 else j:=1;
  for j:=j to 3 do
    begin
    if FArray[i,j] = '' then furtherSquare := 16
    else furtherSquare := StrToInt(FArray[i,j]);
    if furtherSquare < currentSquare then Inc(sum);
    end;
  end;
  Result := sum;
end;

function TGame.IsArraySolvability: boolean;
var i, j, sum: integer;
begin
sum := 0;
for i:=0 to 3 do
  for j:=0 to 3 do
    begin
    sum := sum + NumberOfSmallerSquaresFurther(i, j);
    end;
sum := sum + FEmptyButton[1] + 1;
Result := sum mod 2 = 0;
end;

procedure TGame.SwapSomeNeighbor;
var cash: string[2];
x: integer;
begin
if (FArray[0,0] = '') or (FArray[0,1] = '') then x:=1 else x:=0;
cash := FArray[x,0];
FArray[x,0] := FArray[x,1];
FArray[x,1] := cash;
end;

Constructor TGame.Create;
var i, j: integer;
rdmi, rdmj: integer; //random index
cash: string[2];
begin
FArray := gameArray;
FTargetArray := targetArray;
for i:=0 to 3 do
  for j:=0 to 3 do
    begin
    randomize;
    rdmi := Random(3);
    rdmj := Random(3);
    cash := self.FArray[i, j];
    FArray[i, j] := self.Farray[rdmi, rdmj];
    Farray[rdmi, rdmj] := cash;
    WriteButtonIfEmpty(i, j);
    WriteButtonIfEmpty(rdmi, rdmj);
    end;
if not IsArraySolvability then SwapSomeNeighbor;
end;

function TGame.GetArray: TArray;
begin
result := FArray;
end;

function TGame.GetTargetArray: TArray;
begin
result := FTargetArray;
end;

procedure TGame.SetEmptyButton(emptyButton: TEmptyButton);
begin
FEmptyButton[0] := emptyButton[0];
FEmptyButton[1] := emptyButton[1];
end;

end.
