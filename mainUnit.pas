unit mainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gameUnit;

type
  TneighborButtons = array[0..3, 0..1] of integer;
  TButtons = array[0..3, 0..3] of TButton;
  Tmain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    ButtonStart: TButton;
    procedure ButtonStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Swap(Sender: TObject);
    procedure DoNothing(Sender: TObject);
    function GetButtons: TButtons;
  private
    FButtons: TButtons;
    procedure FillButtons;
    procedure SwtichMovableButtons(activate: boolean);
    procedure CheckForWin;
  public
    Property Buttons: TButtons read GetButtons;
  published
  end;

var
  main: Tmain;
  gameArray: TGame;

implementation

{$R *.dfm}

procedure TMain.FillButtons;
begin
  FButtons[0,0]:=Button1;
  FButtons[0,1]:=Button2;
  FButtons[0,2]:=Button3;
  FButtons[0,3]:=Button4;
  FButtons[1,0]:=Button5;
  FButtons[1,1]:=Button6;
  FButtons[1,2]:=Button7;
  FButtons[1,3]:=Button8;
  FButtons[2,0]:=Button9;
  FButtons[2,1]:=Button10;
  FButtons[2,2]:=Button11;
  FButtons[2,3]:=Button12;
  FButtons[3,0]:=Button13;
  FButtons[3,1]:=Button14;
  FButtons[3,2]:=Button15;
  FButtons[3,3]:=Button16;
end;

function TMain.GetButtons: TButtons;
begin
Result := FButtons;
end;

procedure TMain.DoNothing(Sender: TObject);
begin
//
end;

function ReturnNeighborButtons: TneighborButtons;
var
neighborButtons: TneighborButtons;
emptyButtonX, emptyButtonY: integer;
begin
emptyButtonX := gameArray.EmptyButton[0];
emptyButtonY := gameArray.EmptyButton[1];
neighborButtons[0,0] := emptyButtonX;
neighborButtons[0,1] := emptyButtonY + 1;
neighborButtons[1,0] := emptyButtonX;
neighborButtons[1,1] := emptyButtonY - 1;
neighborButtons[2,0] := emptyButtonX + 1;
neighborButtons[2,1] := emptyButtonY;
neighborButtons[3,0] := emptyButtonX - 1;
neighborButtons[3,1] := emptyButtonY;
Result := neighborButtons;
end;

procedure TMain.SwtichMovableButtons(activate: boolean);
var neighborButtons: TneighborButtons;
i, neighborButtonX, neighborButtonY: integer;
button: TButton;
begin
  neighborButtons := ReturnNeighborButtons;
  for i:=0 to length(neighborButtons) do
    begin
    neighborButtonX := neighborButtons[i,0];
    neighborButtonY := neighborButtons[i,1];
    if (neighborButtonX < 0) or (neighborButtonX > 3) then continue;
    if (neighborButtonY < 0) or (neighborButtonY > 3) then continue;
    button := Buttons[neighborButtonX, neighborButtonY];
    if activate then button.OnClick := main.Swap
    else button.OnClick := main.DoNothing;
    end;
end;

procedure TMain.CheckForWin;
var i,j: integer;
begin
for i:=0 to 3 do
  for j:=0 to 3 do
    begin
    if Buttons[i, j].Caption <> gameArray.TargetArr[i, j] then exit;
    end;
ShowMessage('������!');
SwtichMovableButtons(False);
end;

procedure TMain.Swap(Sender: TObject);
var emptyButton: TButton;
newEmptyButton: TEmptyButton;
emptyButtonX, emptyButtonY, i: integer;
begin
emptyButtonX := gameArray.EmptyButton[0];
emptyButtonY := gameArray.EmptyButton[1];
emptyButton := buttons[emptyButtonX, emptyButtonY];
emptyButton.Caption := (Sender as TButton).Caption;
(Sender as TButton).Caption := '';
SwtichMovableButtons(False);
for i:=0 to 15 do
  if (Sender as TButton).Name = buttons[i div 4, i mod 4].Name then
    begin
    newEmptyButton[0] := i div 4;
    newEmptyButton[1] := i mod 4;
    gameArray.EmptyButton := newEmptyButton;
    end;
SwtichMovableButtons(True);
CheckForWin;
end;

procedure Tmain.ButtonStartClick(Sender: TObject);
var
i, j: integer;
begin
gameArray := TGame.Create;
for i:= 0 to 3 do
  for j:=0 to 3 do
    begin
    buttons[i,j].Caption := gameArray.Arr[i,j];
    end;
SwtichMovableButtons(True);
end;

procedure Tmain.FormCreate(Sender: TObject);
begin
FillButtons;
end;

end.

