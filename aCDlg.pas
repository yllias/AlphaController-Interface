unit aCDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TaCForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Mode: TLabel;
    comUpDown: TUpDown;
    comEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    baudEdit: TEdit;
    modeEdit: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  aCForm: TaCForm;

implementation

{$R *.dfm}

end.
