object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Scrapper S'#233'ries RedeCanais'
  ClientHeight = 498
  ClientWidth = 893
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 80
    Width = 893
    Height = 418
    ActivePage = TabSheet3
    Align = alBottom
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'S'#233'ries'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 390
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'V'#237'deos'
      ImageIndex = 1
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 390
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Links'
      ImageIndex = 2
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 390
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Resultado'
      ImageIndex = 3
      object Memo4: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 390
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 321
    Height = 21
    TabOrder = 1
    Text = 'https://redecanais.bz/browse-letra-a-series-videos-1-date.html'
  end
  object Button1: TButton
    Left = 335
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Buscar S'#233'ries'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 35
    Width = 113
    Height = 39
    Caption = 'Buscar V'#237'deos'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 127
    Top = 35
    Width = 98
    Height = 39
    Caption = 'Frames'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 231
    Top = 35
    Width = 202
    Height = 39
    Caption = 'Gerar'
    TabOrder = 5
    OnClick = Button4Click
  end
end
