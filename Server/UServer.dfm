object UHistorico: TUHistorico
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rico'
  ClientHeight = 268
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    643
    268)
  TextHeight = 15
  object lbHistorico: TLabel
    Left = 8
    Top = 8
    Width = 101
    Height = 15
    Caption = 'Hist'#243'rico de Envios'
  end
  object reHistorico: TRichEdit
    Left = 8
    Top = 29
    Width = 627
    Height = 230
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    ExplicitWidth = 623
    ExplicitHeight = 229
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientRead = ServerSocket1ClientRead
    OnClientError = ServerSocket1ClientError
    Left = 600
    Top = 8
  end
end
