object frm_Main: Tfrm_Main
  Left = 192
  Top = 125
  Width = 827
  Height = 589
  Caption = 'AllaKore Remote - Server'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 389
    Width = 819
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Logs_Memo: TMemo
    Left = 0
    Top = 392
    Width = 819
    Height = 163
    Align = alBottom
    Lines.Strings = (
      'Exceptions Log:'
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Connections_ListView: TListView
    Left = 0
    Top = 0
    Width = 819
    Height = 389
    Align = alClient
    Columns = <
      item
        Caption = 'HandleConnection'
        Width = 100
      end
      item
        Caption = 'IP'
        Width = 170
      end
      item
        Caption = 'ID'
        Width = 100
      end
      item
        Caption = 'Password'
        Width = 60
      end
      item
        Caption = 'Target ID'
        Width = 100
      end
      item
        Caption = 'Ping'
        Width = 80
      end
      item
        Caption = 'Group'
        Width = 100
      end
      item
        Caption = 'Machine'
        Width = 100
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 448
    Top = 80
  end
  object Main_IdTCPServer: TIdTCPServer
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = Main_IdTCPServerConnect
    OnExecute = Main_IdTCPServerExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 448
    Top = 120
  end
  object Ping_Timer: TTimer
    Interval = 5000
    OnTimer = Ping_TimerTimer
    Left = 360
    Top = 128
  end
  object pm1: TPopupMenu
    Left = 192
    Top = 96
    object Configurao1: TMenuItem
      Caption = 'Config'
      OnClick = Configurao1Click
    end
  end
end
