program MeuProjeto;

uses
  Vcl.Forms,
  uMain in 'src\views\uMain.pas' {frmMain},
  dbConn in 'src\services\dbConn.pas' {dtmConn: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdtmConn, dtmConn);
  Application.Run;
end.
