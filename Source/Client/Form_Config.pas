unit Form_Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, registry;

type
  Tfrm_Config = class(TForm)
    lblHost: TLabel;
    lblGroup: TLabel;
    lblMachine: TLabel;
    lblTimeOut: TLabel;
    edtMachineName: TEdit;
    edtGroup: TEdit;
    edtHost: TEdit;
    sbSave: TSpeedButton;
    seTimeOut: TSpinEdit;
    chkStarter: TCheckBox;
    TopBackground_Image: TImage;
    tmrCheck: TTimer;
    lblPort: TLabel;
    sePort: TSpinEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure tmrCheckTimer(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Config: Tfrm_Config;

implementation

{$R *.dfm}

uses Form_Main;

procedure Tfrm_Config.FormCreate(Sender: TObject);
var Reg: TRegistry; S: string;
begin
 edtHost.Text        := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cHost, True);
 sePort.Text         := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cPort, True);
 edtGroup.Text       := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cGroup, True);
 edtMachineName.Text := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cMachine, True);
 seTimeOut.Text      := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cConnectTimeOut, True);
 s                   := frm_Main.GetIni(ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral, cStarterWithWindows, True);
 if s = cYes then
    chkStarter.Checked := True
 else
     chkStarter.Checked := False;
end;

procedure Tfrm_Config.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Marcones Freitas - 16/10/2015 -> Disable Alt + F4
  if (Key = VK_F4) or (Key = VK_ESCAPE) then
      Key := 0;
end;

procedure Tfrm_Config.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //Marcones Freitas - 16/10/2015 -> Pula para o proximo campo com o ENTER
  IF Key = #13 THEN
    BEGIN
     Key := #0;
     Perform(Wm_NextDlgCtl,0,0);
    END;
end;

procedure Tfrm_Config.FormShow(Sender: TObject);
begin
 tmrCheck.Enabled := True;
end;

procedure Tfrm_Config.sbSaveClick(Sender: TObject);
var Reg: TRegistry; S: string;
begin
  Reg         := TRegistry.Create;
  S           :=ExtractFileDir(Application.ExeName)+'\'+ExtractFileName(Application.ExeName);
  Reg.rootkey :=HKEY_LOCAL_MACHINE;
  Reg.Openkey('SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN',false);
  if chkStarter.Checked then
      begin
       Reg.WriteString(Caption, S);
       frm_Main.SaveIni(cStarterWithWindows, cYes, ExtractFilePath(Application.ExeName) + Application.Title+'.ini', cGeneral,True);
      end
  else
      begin
       Reg.DeleteValue(Caption);
       frm_Main.SaveIni(cStarterWithWindows, cNO, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);
      end;

  frm_Main.SaveIni(cHost, edtHost.Text, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);
  frm_Main.SaveIni(cPort, sePort.Text, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);
  frm_Main.SaveIni(cMachine, edtMachineName.Text, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);
  frm_Main.SaveIni(cGroup, edtGroup.Text, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);
  frm_Main.SaveIni(cConnectTimeOut, seTimeOut.Text, ExtractFilePath(Application.ExeName) + Application.Title+'.ini',cGeneral,True);

  Host     := edtHost.Text;
  Port     := sePort.Value;
  vGroup   := edtGroup.Text;
  vMachine := edtMachineName.Text;
  ConnectionTimeout := seTimeOut.Value;
  frm_Main.SetHostPortGroupMach;
  Close;
end;

procedure Tfrm_Config.tmrCheckTimer(Sender: TObject);
begin
  //Marcones Freitas - 16/10/2015 -> Somente Libera o Botão Salvar se os campos estiverem preenchidos
  if (edtHost.Text = '') or
      (edtGroup.Text = '') or
        (edtMachineName.Text = '') or
          (seTimeOut.Value = 0) or
             (sePort.Value = 0)then
      sbSave.Enabled := False
  else
      sbSave.Enabled := True;
end;

end.
