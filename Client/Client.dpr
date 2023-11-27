program Client;

uses
  Vcl.Forms,
  UGame in 'UGame.pas' {TUGame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTUGame, TUGame);
  Application.Run;
end.
