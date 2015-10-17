program AllaKore_Remote_Server;

uses
  Forms,
  Form_Main in 'Form_Main.pas' {frm_Main},
  uConfig in 'uConfig.pas' {fConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AllaKore Remote - Server';
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.CreateForm(TfConfig, fConfig);
  Application.Run;
end.
