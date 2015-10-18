unit uConfig;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 StdCtrls;

  //Marcones Freitas - 16/10/2015 -> Algumas Constantes Novas
 const
 cGeneral            = 'General';
 cPort               = 'Port';

type
  TfConfig = class(TForm)
    Label2: TLabel;
    edtPort: TEdit;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure sbCancelarPACClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConfig: TfConfig;

implementation

{$R *.dfm}

uses Form_Main;

procedure TfConfig.FormCreate(Sender: TObject);
begin
 edtPort.Text        := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', 'Geral', 'Port', True);
end;

procedure TfConfig.sbCancelarPACClick(Sender: TObject);
begin
 close;
end;

procedure TfConfig.btn1Click(Sender: TObject);
begin
 if (edtPort.Text = '') then
     Exit;

  frm_Main.SaveIni(cPort, edtPort.Text, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);
  Port := strtoint(edtPort.Text);
  Close;
end;

procedure TfConfig.FormShow(Sender: TObject);
begin
 edtPort.Text        := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cPort, True);
end;

end.
