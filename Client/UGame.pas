unit UGame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.StdCtrls;

type
  TTUGame = class(TForm)
    ClientSocket1: TClientSocket;
    pnlPrincipal: TPanel;
    lbtitle: TLabel;
    lbVitoria: TLabel;
    lbDerrotas: TLabel;
    lbEmpates: TLabel;
    lbVitoriaValue: TLabel;
    lbDerrotasValue: TLabel;
    lbEmpatesValue: TLabel;
    imgPaper: TImage;
    imgRock: TImage;
    imgScizzors: TImage;
    procedure choice(i : integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgPaperDblClick(Sender: TObject);
    procedure imgScizzorsClick(Sender: TObject);
    procedure imgRockClick(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    function nameOption(i:integer) : string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TUGame: TTUGame;
  valorEscolhido: integer;

implementation

{$R *.dfm}
uses System.IniFiles;

procedure TTUGame.choice(i : integer);
begin
  if ClientSocket1.Active then
  begin
    valorEscolhido := i;
    ClientSocket1.Socket.SendText(inttostr(i));
  end
  else
    showmessage('Por algum motivo não indentificado o servidor não está funcionando')
end;

function TTUGame.nameOption(i:integer) : string;
begin
  case i of
    1: Result := 'Pedra';
    2: Result :='Papel';
    3: Result :='Tesoura';
  end;
end;

procedure TTUGame.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var retorno : integer;
var resultado,optionClient,optionServer : string;
begin
  retorno := StrToInt(Socket.ReceiveText);
  if(retorno = valorEscolhido) then
  begin
    lbEmpatesValue.Caption := inttostr(StrToInt(lbEmpatesValue.Caption) + 1);
    resultado := 'Empate';
  end
  else
  begin
    case valorEscolhido of
      1:
        if(retorno = 3) then
          resultado := 'Vitoria';
      2:
        if(retorno = 1) then
          resultado := 'Vitoria';
      3:
        if(retorno = 2) then
        resultado := 'Vitoria';
    end;
  end;

  if(resultado = '') then
  begin
    resultado := 'Derrota';
    lbDerrotasValue.Caption := inttostr(StrToInt(lbDerrotasValue.Caption) + 1);
  end
  else
  begin
    if(resultado = 'Vitoria')then
      lbVitoriaValue.Caption := inttostr(StrToInt(lbVitoriaValue.Caption) + 1);
  end;

  optionClient := nameOption(valorEscolhido);
  optionServer := nameOption(retorno);

  showmessage(
  'Jogador: ' + optionClient + sLineBreak +
  'Servidor: ' + optionServer + sLineBreak +
  'Resultado: ' + resultado
  );
end;

procedure TTUGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClientSocket1.Active := false;
end;

procedure TTUGame.FormCreate(Sender: TObject);
var
  ArquivoINI: TIniFile;
  ip : string;
  port : integer;
begin
  ip := '';
  port := 0;

  if FileExists('.\config.ini') then
  begin
    ArquivoINI := TIniFile.Create('.\config.ini');
    ip := ArquivoIni.ReadString('CONFIG','IP','');
    port := ArquivoINI.ReadInteger('CONFIG','PORT',0);
  end;
  ClientSocket1.Port :=  port;
  ClientSocket1.Host :=  ip;
  ClientSocket1.Active :=  true;

end;

procedure TTUGame.imgRockClick(Sender: TObject);
begin
  choice(1);
end;

procedure TTUGame.imgPaperDblClick(Sender: TObject);
begin
  choice(2);
end;

procedure TTUGame.imgScizzorsClick(Sender: TObject);
begin
  choice(3);
end;

end.
