program Server;

uses
  Vcl.Forms,
  UServer in 'UServer.pas' {UHistorico};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUHistorico, UHistorico);
  Application.Run;
end.
