object aCForm: TaCForm
  Left = 0
  Top = 0
  Caption = 'aCForm'
  ClientHeight = 370
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 122
    Caption = #220'bertragung'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 29
      Width = 51
      Height = 13
      Caption = 'COM-Port:'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 48
      Height = 13
      Caption = 'Baudrate:'
    end
    object comUpDown: TUpDown
      Left = 140
      Top = 26
      Width = 16
      Height = 21
      Associate = comEdit
      TabOrder = 0
    end
    object comEdit: TEdit
      Left = 88
      Top = 26
      Width = 52
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object baudEdit: TEdit
      Left = 88
      Top = 53
      Width = 73
      Height = 21
      TabOrder = 2
      Text = 'baudEdit'
    end
    object Button3: TButton
      Left = 183
      Top = 82
      Width = 75
      Height = 25
      Caption = 'Help'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 136
    Width = 305
    Height = 233
    Caption = 'Steuerung'
    TabOrder = 1
    object modeRadio: TRadioGroup
      Left = 3
      Top = 16
      Width = 153
      Height = 209
      Caption = 'Modus:'
      Items.Strings = (
        '0 - perm. off'
        '1 - perm. on'
        '2 - phase angle linear'
        '3 - phase angle voltage'
        '4 - phase angle power'
        '5 - burst fire slow'
        '6 - burst fire fast')
      TabOrder = 0
    end
    object adcRadio: TRadioGroup
      Left = 162
      Top = 16
      Width = 96
      Height = 73
      Caption = 'ADC:'
      Items.Strings = (
        '0 - off'
        '1 - on')
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 191
    Top = 28
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 191
    Top = 59
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
