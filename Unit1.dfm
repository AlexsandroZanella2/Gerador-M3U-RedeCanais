object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Scrapper S'#233'ries RedeCanais'
  ClientHeight = 510
  ClientWidth = 893
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 497
    Width = 893
    Height = 13
    Align = alBottom
    Caption = 'Alexsandro Zanella - +5554991245573'
    ExplicitWidth = 187
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 96
    Width = 893
    Height = 401
    ActivePage = TabSheet2
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'S'#233'ries'
      ExplicitHeight = 390
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 373
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 390
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'V'#237'deos'
      ImageIndex = 1
      ExplicitHeight = 390
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 373
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 390
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Links'
      ImageIndex = 2
      ExplicitHeight = 390
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 373
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 390
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Resultado'
      ImageIndex = 3
      ExplicitHeight = 390
      object Memo4: TMemo
        Left = 0
        Top = 0
        Width = 885
        Height = 373
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 390
      end
    end
  end
  object Button1: TButton
    Left = 335
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Buscar S'#233'ries'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 35
    Width = 113
    Height = 39
    Caption = 'Buscar V'#237'deos'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 127
    Top = 35
    Width = 98
    Height = 39
    Caption = 'Frames'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 231
    Top = 35
    Width = 202
    Height = 39
    Caption = 'Gerar'
    TabOrder = 4
    OnClick = Button4Click
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 321
    Height = 21
    ItemIndex = 0
    TabOrder = 5
    Text = 
      'https://redecanais.bz/browse-numerosesimbolos-series-videos-1-da' +
      'te.html'
    Items.Strings = (
      
        'https://redecanais.bz/browse-numerosesimbolos-series-videos-1-da' +
        'te.html'
      'https://redecanais.bz/browse-letra-a-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-b-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-c-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-d-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-e-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-f-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-g-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-h-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-i-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-j-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-k-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-l-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-m-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-n-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-o-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-p-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-q-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-r-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-s-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-t-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-u-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-v-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-w-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-x-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-y-series-videos-1-date.html'
      'https://redecanais.bz/browse-letra-z-series-videos-1-date.html')
  end
  object Button5: TButton
    Left = 439
    Top = 35
    Width = 138
    Height = 38
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Edit1: TEdit
    Left = 439
    Top = 8
    Width = 138
    Height = 21
    Alignment = taCenter
    TabOrder = 7
    TextHint = 'Sleep Frames'
    Visible = False
  end
  object Button6: TButton
    Left = 583
    Top = 35
    Width = 90
    Height = 38
    Caption = 'Teste'
    TabOrder = 8
    Visible = False
    OnClick = Button6Click
  end
  object TestMode: TCheckBox
    Left = 583
    Top = 12
    Width = 97
    Height = 17
    Caption = 'Modo Teste'
    TabOrder = 9
    Visible = False
  end
  object Button7: TButton
    Left = 679
    Top = 35
    Width = 98
    Height = 38
    Caption = 'Atualizar Links'
    TabOrder = 10
    Visible = False
    OnClick = Button7Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 79
    Width = 893
    Height = 17
    Align = alBottom
    TabOrder = 11
    ExplicitLeft = 808
    ExplicitTop = 48
    ExplicitWidth = 150
  end
end
