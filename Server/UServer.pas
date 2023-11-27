unit UServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Datasnap.Win.MConnect, Datasnap.Win.SConnect, Vcl.StdCtrls, Vcl.ComCtrls,
  System.Win.ScktComp;

type
  TUHistorico = class(TForm)
    ServerSocket1: TServerSocket;
    reHistorico: TRichEdit;
    lbHistorico: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
      function getNameOption(i : integer) : string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UHistorico: TUHistorico;
implementation

uses System.IniFiles;
{$R *.dfm}

procedure TUHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ServerSocket1.Active := false;
end;

procedure TUHistorico.FormCreate(Sender: TObject);
var
  ArquivoINI: TIniFile;
  port: integer;
begin
  port := 8005;
  if FileExists('.\config.ini') then
  begin
    ArquivoINI := TIniFile.Create('.\config.ini');
    port := ArquivoINI.ReadInteger('CONFIG','PORT',8005);
  end;
  ServerSocket1.Port := port;
  ServerSocket1.Active := True;
end;

function TUHistorico.getNameOption(i : integer) : string;
begin
  case i of
  1: Result := 'Rock';
  2: Result  := 'Paper';
  3: Result  := 'Scissors';
  else
    Result := 'Rock';
 end;
end;


procedure TUHistorico.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var dateTime : string;
const response : AnsiString = 'error';
begin
 dateTime := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
 reHistorico.Lines.Add(
  '['+dateTime+']' +'['+ Socket.RemoteAddress+
    ':'+inttostr(Socket.RemotePort)+ ']'+
  Socket.ReceiveText
 );
 reHistorico.Lines.Add('['+'Response'+'] Error'
 );
 Socket.SendText(response);
end;

procedure TUHistorico.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var dateTime,nameOption : string;
var clientOption,serverOption : integer;
begin
 dateTime := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
 clientOption := StrToInt(Socket.ReceiveText);
 nameOption := getNameOption(clientOption);

 reHistorico.Lines.Add(
  '['+dateTime+']' +'['+ Socket.RemoteAddress+
    ':'+inttostr(Socket.RemotePort)+ ']'+
  nameOption
 );
 serverOption := (Random(3) + 1);
 nameOption := getNameOption(serverOption);

 reHistorico.Lines.Add(
  '[Response] ' + nameOption
 );
 reHistorico.Lines.Add('');
 Socket.SendText(IntToStr(serverOption));
end;

end.
