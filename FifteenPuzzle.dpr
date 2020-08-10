program FifteenPuzzle;

uses
  Forms,
  mainUnit in 'mainUnit.pas' {main},
  gameUnit in 'gameUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Пятнашки';
  Application.CreateForm(Tmain, main);
  Application.Run;
end.
