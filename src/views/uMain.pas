unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, dbConn, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Buttons, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TfrmMain = class(TForm)
    pnlCrud: TPanel;
    PnMenu: TPanel;
    btnAttListagem: TButton;
    tb1List: TTabSheet;
    pnlTelaInicial: TPanel;
    PanelUsuario: TPanel;
    lblUsuario: TLabel;
    edtUser: TEdit;
    PanelSenha: TPanel;
    lblSenha: TLabel;
    edtSenha: TEdit;
    pnlValidacao: TPanel;
    btnLogin: TButton;
    btnSair: TButton;
    tb2cadastrar: TTabSheet;
    tb3alterar: TTabSheet;
    pnlListagem: TPanel;
    dbgridList: TDBGrid;
    pnlCadastrar: TPanel;
    pnlLogin: TPanel;
    lblCrudPessoas: TLabel;
    lblNome: TLabel;
    dbEdtNome: TDBEdit;
    lblRg: TLabel;
    dbEdtRg: TDBEdit;
    lblCpf: TLabel;
    dbEdtCpf: TDBEdit;
    lblDataNascimento: TLabel;
    dbEdtDataNasc: TDBEdit;
    lblSistemaCrud: TLabel;
    btnCadastrar: TButton;
    btnLogout: TButton;
    dbrSexo: TDBRadioGroup;
    pnlTrazerCadastros: TPanel;
    pnlAlterarCad: TPanel;
    pnlInstruction2: TPanel;
    lblAlteracaoCadastro: TLabel;
    lbNome: TLabel;
    lbRg: TLabel;
    lbCpf: TLabel;
    lbDataNasc: TLabel;
    btnAlterar: TButton;
    pnlInsiraDados: TPanel;
    lblInsiraDados: TLabel;
    Image1: TImage;
    Image2: TImage;
    tb4Excluir: TTabSheet;
    pnlExcluir: TPanel;
    lbl1Nome: TLabel;
    lblSequencia: TLabel;
    dbexcNome: TDBEdit;
    dbexcSeq: TDBEdit;
    btnExcluir: TButton;
    pnlInstruction3: TPanel;
    lblVerifDados: TLabel;
    pnlListAll: TPanel;
    dbgridListAll: TDBGrid;
    pnlInstruction4: TPanel;
    lblSelectPessoa: TLabel;
    PageControl: TPageControl;
    pnlTotal: TPanel;
    lblQtdList: TLabel;
    dtpDataNasc: TDateTimePicker;
    dtpAltDataNasc: TDateTimePicker;
    pnlListagemPessoas: TPanel;
    lblListagemPessoas: TLabel;
    lblTotalPessoas: TLabel;
    imgFotoCadastro: TImage;
    btnCarregarImg: TButton;
    pnlFoto: TPanel;
    openDialogFoto: TOpenDialog;
    btnAltFoto: TButton;
    pnlAltFoto: TPanel;
    imgAltFoto: TImage;
    lblFoto: TLabel;
    lblCadFoto: TLabel;
    edtNome: TEdit;
    rdgSexo: TRadioGroup;
    edtRg: TEdit;
    edtCpf: TEdit;
    procedure btnLoginClick(Sender: TObject);
    function validarLogin: Boolean;
    function validarCadastro: Boolean;
    function validarAlteracao: Boolean;
    function modoEdicao: Boolean;
    function sairModoEdicao: Boolean;
    procedure btnSairClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnAttListagemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    // procedure dbgridListAlteracaoCellClick(Column: TColumn);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dtpDataNascChange(Sender: TObject);
    // procedure dtpAltDataNascChange(Sender: TObject);
    procedure btnCarregarImgClick(Sender: TObject);
    procedure btnAltFotoClick(Sender: TObject);
    // procedure dbgridListAlteracaoDblClick(Sender: TObject);
    procedure dbgridListDblClick(Sender: TObject);
    procedure rdgSexoClick(Sender: TObject);

  private
    FSeqAlteracao: Integer;
    FSeqExcluir: Integer;
  public
    conn: TdtmConn;
    // dataNasc : TDate;
  end;

var
  frmMain: TfrmMain;
  sexo: string;
  LStream: TFileStream;
  LBlobStream: TStream;

implementation

{$R *.dfm}

procedure TfrmMain.btnAlterarClick(Sender: TObject);
// var
// dataNasc: TDate;
// sexo: string;
begin
  if validarAlteracao then
  begin
    if dtmConn.qryAlteracao.State in [dsInsert, dsEdit] then
      dtmConn.qryAlteracao.Cancel;

    // dtmConn.qryAlteracao.Cancel;
    // dtmConn.qryAlteracao.Close;
    // dtmConn.qryAlteracao.Open;
    dtmConn.qryAlteracao.Edit;

    if dtmConn.qryAlteracao.State in [dsEdit] then
    begin
      dtmConn.qryAlteracaoNOME.AsString := edtNome.Text;
      dtmConn.qryAlteracaoRG.AsInteger := StrToInt(edtRg.Text);
      dtmConn.qryAlteracaoCPF.AsLargeInt := StrToInt64(edtCpf.Text);
      dtmConn.qryAlteracaoDATA_NASCIMENTO.AsDateTime := dtpAltDataNasc.Date;
      dtmConn.qryAlteracaoSEXO.AsString := sexo;

      // Verifica se LBlobStream foi carregado
      if Assigned(LBlobStream) then
      begin
        LBlobStream.Position := 0; // Garante que a posição está no início.
        (dtmConn.qryAlteracao.FieldByName('FOTO') as TBlobField).LoadFromStream(LBlobStream);
      end;

      try
        dtmConn.qryAlteracao.Post;
        ShowMessage('Alteração salva com sucesso.');
        dtmConn.qryListagem.Refresh;
        LBlobStream := nil;
        // PageControl.ActivePage := PageControl.Pages[0];
      finally
        // Libere o LBlobStream aqui, após a operação ser concluída com sucesso.
        if Assigned(LBlobStream) then
          LBlobStream.Free;
        //LBlobStream := nil; // Define a variável como nil para evitar acessos inválidos.
      end;

    end
    else
    begin
      ShowMessage('Atenção: A query não pôde entrar em modo de edição.');
    end;

    // Finalização das rotinas
    dtmConn.qryListagem.Refresh;
    pnlAlterarCad.Enabled := False;
    PageControl.ActivePage := PageControl.Pages[0];

  end;
end;

procedure TfrmMain.btnAttListagemClick(Sender: TObject);
begin
  PageControl.ActivePage := tb1List;
  dtmConn.qryListagem.Refresh;
end;

procedure TfrmMain.btnExcluirClick(Sender: TObject);
begin
  if (MessageDlg('Deseja realmente Excluir?', TMsgDlgType.mtWarning,
    [TMsgDlgBtn.mbYes, mbNo], 0) = mrYes) then
  begin
    FSeqExcluir := dtmConn.qryListagem.FieldByName('SEQUENCIA').AsInteger;
    dtmConn.Excluir(FSeqExcluir);
    ShowMessage('Removido com sucesso.');
    PageControl.ActivePage := PageControl.Pages[0];
    Exit;
  end
  else
    dbgridListAll.SetFocus;
end;

procedure TfrmMain.btnLoginClick(Sender: TObject);
begin
  if validarLogin then
  begin
    pnlTelaInicial.Visible := False;
    pnlCrud.Visible := true;
    PageControl.ActivePage := tb1List;
    // uServicePessoa.ServicePessoa.qryCadastro.Append;
    // dbConn.dtmConn.dsCadastro.
  end
  else
    ShowMessage('Login/Senha inválido.');
end;

procedure TfrmMain.btnLogoutClick(Sender: TObject);
begin
  if (MessageDlg('Deseja realmente sair?', TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, mbNo], 0) = mrYes) then
  begin
    pnlCrud.Visible := False;
    pnlTelaInicial.Visible := true;
    Exit;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if not dtmConn.qryCadastro.Active then
    dtmConn.qryCadastro.Open;
  dtmConn.qryListagem.Refresh;

  lblTotalPessoas.caption := IntToStr(dtmConn.qryListagem.RecordCount);
  // Resultado Listagem Pessoas

  // dtpAltDataNasc.DateTime := StrToDateTime(dbaltDataNasc.Text);

  // no momento que inicio a tela de cadastro, modo insert;
  // imgAltFoto.Picture :=
  // dtmConn.qryCadastro.Insert;
  // com isso os dados não vem preenchidos
end;

function TfrmMain.modoEdicao: Boolean;
begin
  PageControl.Pages[0].TabVisible := False;
  PageControl.Pages[1].TabVisible := False;
  PageControl.Pages[3].TabVisible := False;
  btnAttListagem.Enabled := False;
  btnLogout.Enabled := False;
  pnlAlterarCad.Visible := true;
end;

procedure TfrmMain.PageControlChange(Sender: TObject);
begin
  // dtmConn.qryListagem.Refresh;
  // dtpAltDataNasc.DateTime := StrToDateTime(dbaltDataNasc.Text);
  // Quando o usuário muda para a aba de cadastro, inicie a inserção.
  pnlAlterarCad.Enabled := false;
  if PageControl.ActivePage = tb2cadastrar then
  begin
    dtmConn.qryCadastro.Close;
    dtmConn.qryCadastro.Open;
    dtmConn.qryCadastro.Insert;
  end
  // Quando o usuário sai da aba de cadastro, finalize a operação se ela estiver pendente.
  else
  begin
    if dtmConn.qryCadastro.State in [dsInsert, dsEdit] then
      dtmConn.qryCadastro.Cancel;
  end;

  if PageControl.ActivePage = tb3alterar then
    ShowMessage('Para alteração de cadastros em LISTAGEM DE PESSOAS é necessário selecionar com duplo clique a pessoa desejada.');

  lblTotalPessoas.caption := IntToStr(dtmConn.qryListagem.RecordCount);
end;

procedure TfrmMain.rdgSexoClick(Sender: TObject);
begin
  with dtmConn do
  begin
    if rdgSexo.ItemIndex = 0 then
      sexo := 'M'
    else
      sexo := 'F';
  end;
end;

function TfrmMain.sairModoEdicao: Boolean;
begin
  PageControl.Pages[0].TabVisible := true;
  PageControl.Pages[1].TabVisible := true;
  PageControl.Pages[3].TabVisible := true;
  btnAttListagem.Enabled := true;
  btnLogout.Enabled := true;
end;

procedure TfrmMain.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnAltFotoClick(Sender: TObject);
var
  LStream: TFileStream;
begin
  if openDialogFoto.Execute then
  begin
    // Libera o stream anterior se ele existir para evitar vazamento de memória.
    if Assigned(LBlobStream) then
      LBlobStream.Free;

    // Cria um TFileStream para ler o arquivo
    LStream := TFileStream.Create(openDialogFoto.FileName,
      fmOpenRead or fmShareDenyWrite);
    try
      // Carrega a imagem no TImage para visualização.
      imgAltFoto.Picture.LoadFromStream(LStream);
      LStream.Position := 0;

      // Cria um TMemoryStream para a variável global e copia os dados.
      // Isso armazena a foto na memória, pronta para ser usada.
      LBlobStream := TMemoryStream.Create;
      LBlobStream.CopyFrom(LStream, LStream.Size);
      LBlobStream.Position := 0; // Volta para o início do stream.
    finally
      LStream.Free; // O LStream local pode ser liberado com segurança.
    end;
  end;
end;

procedure TfrmMain.btnCadastrarClick(Sender: TObject);
begin
  if validarCadastro then
  begin
    dtmConn.Cadastrar;
    dtmConn.qryCadastro.Cancel; // INSERI PRA SAIR DO MODO INSERT
    dtmConn.qryListagem.Refresh;
    ShowMessage('Cadastrado com sucesso.');
    PageControl.ActivePage := PageControl.Pages[0];

  end;
end;

procedure TfrmMain.btnCarregarImgClick(Sender: TObject);
var
  LStream: TFileStream;
  LBlobStream: TStream;
begin
  if openDialogFoto.Execute then
  begin
    dtmConn.qryCadastro.Edit;
    LStream := TFileStream.Create(openDialogFoto.FileName,
      fmOpenRead or fmShareDenyWrite);
    try
      imgFotoCadastro.Picture.LoadFromStream(LStream);
      LStream.Position := 0;
      LBlobStream := dtmConn.qryCadastro.CreateBlobStream
        (dtmConn.qryCadastro.FieldByName('FOTO'), bmWrite);
      LBlobStream.CopyFrom(LStream, LStream.Size);
      // SalvarImagemNoBanco(LStream)
    finally
      LStream.Free;
      LBlobStream.Free;
    end;
  end;
end;

// NA TELA DE ALTERAR
// QND SELECIONAR CELULAR TRAZER OS DADOS

// procedure TfrmMain.dbgridListAlteracaoDblClick(Sender: TObject);
// begin
// var
// LBlobStream: TStream;
// begin
// modoEdicao;
// // Campo Sexo:
//
// // Foto:
// imgAltFoto.Picture.Assign(nil);
// if not dtmConn.qryListagem.FieldByName('FOTO').IsNull then
// begin
// LBlobStream := dtmConn.qryListagem.CreateBlobStream
// (dtmConn.qryListagem.FieldByName('FOTO'), bmRead);
// try
// LBlobStream.Position := 0;
// imgAltFoto.Picture.LoadFromStream(LBlobStream);
// finally
// LBlobStream.Free;
// end;
// end;
//
// // dtpicker recebe = trata a data do dbEdit:
// dtpAltDataNasc.DateTime := StrToDateTime(dbaltDataNasc.Text);
//
// // guardo a sequencia selecionada da lista:
// FSeqAlteracao := dtmConn.qryListagem.FieldByName('SEQUENCIA').AsInteger;
//
// // dtmConn.qryAlteracao.Close;
// // dtmConn.qryAlteracao.ParamByName('SEQUENCIA').AsInteger := FSeqAlteracao;
// // dtmConn.qryAlteracao.Open;
// end;
// end;

procedure TfrmMain.dbgridListDblClick(Sender: TObject);
begin
  PageControl.ActivePage := tb3alterar;
  pnlAlterarCad.Enabled := true;
  with dtmConn do
  begin

    qryAlteracao.ParamByName('SEQUENCIA').AsInteger :=
      qryListagem.FieldByName('SEQUENCIA').AsInteger;

    qryAlteracao.Close;
    qryAlteracao.Open;

    edtNome.Text := qryListagemNOME.AsString;
    edtRg.Text := qryListagemRG.AsString;
    edtCpf.Text := qryListagemCPF.AsString;
    if qryListagemSEXO.AsString = 'M' then
      rdgSexo.ItemIndex := 0
    else
      rdgSexo.ItemIndex := 1;
    dtpAltDataNasc.Date := qryListagemDATA_NASCIMENTO.AsDateTime;

    imgAltFoto.Picture.Assign(nil);
    if not dtmConn.qryListagem.FieldByName('FOTO').IsNull then
    begin
      LBlobStream := dtmConn.qryListagem.CreateBlobStream
        (dtmConn.qryListagem.FieldByName('FOTO'), bmRead);
      try
        LBlobStream.Position := 0;
        imgAltFoto.Picture.LoadFromStream(LBlobStream);
      finally
        LBlobStream.Free;
      end;
    end;

  end;
end;

// QND SELECIONAR A DATA ENVIAR PARA DbEdit
// procedure TfrmMain.dtpAltDataNascChange(Sender: TObject);
// begin
// dbaltDataNasc.Text := DateToStr(dtpAltDataNasc.DateTime);
// end;

procedure TfrmMain.dtpDataNascChange(Sender: TObject);
begin
  dbEdtDataNasc.Text := DateToStr(dtpDataNasc.DateTime);
end;


// VALIDAÇÕES ABAIXO ---------------------

function TfrmMain.validarCadastro: Boolean;
begin
  result := False;
  var
    dataNasc: TDate;

  if trim(dbEdtNome.Text) = '' then
  begin
    ShowMessage('O campo "Nome" é obrigatório.');
    dbEdtNome.SetFocus;
    Exit;
  end;

  if Length(trim(dbEdtRg.Text)) <> 9 then
  begin
    ShowMessage('O campo "RG" deve conter 9 dígitos');
    dbEdtRg.SetFocus;
    result := False;
    Exit;
  end;

  if Length(trim(dbEdtCpf.Text)) <> 11 then
  begin
    ShowMessage('O campo "CPF" deve conter 11 dígitos');
    dbEdtCpf.SetFocus;
    result := False;
    Exit;
  end;

  if dbrSexo.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o "SEXO" ');
    result := False;
    Exit;
  end;

  if trim(dbEdtDataNasc.Text) = '' then
  begin
    ShowMessage('O campo "Data de Nascimento" é obrigatório ');
    dbEdtDataNasc.SetFocus;
    result := False;
    Exit;
  end;

  if dbrSexo.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o "SEXO');
    dbrSexo.SetFocus;
    result := False;
    Exit;
  end;

  // try
  // //dataNasc := StrToDate(dbEdtDataNasc.Text);
  // dbEdtDataNasc.Text := dtpDataNasc.ToString;
  // except
  // on E: EConvertError do
  // begin
  // ShowMessage('Data de nascimento inválida. Use o formato dd/mm/aaaa.');
  // dbaltDataNasc.SetFocus;
  // Exit;
  // end
  // end;

  result := true;
end;

function TfrmMain.validarLogin: Boolean;
begin
  result := False;
  if (edtUser.Text <> '') or (edtSenha.Text <> '') then
    if (edtUser.Text = 'ADMIN') and (edtSenha.Text = 'ADMIN') then
      result := true
end;

function TfrmMain.validarAlteracao: Boolean;
begin
  result := False;
  var
    dataNasc: TDate;

  if trim(edtNome.Text) = '' then
  begin
    ShowMessage('O campo "Nome" é obrigatório.');
    edtNome.SetFocus;
    result := False;
    Exit;
  end;

  if Length(trim(edtRg.Text)) <> 9 then
  begin
    ShowMessage('O campo "RG" deve conter 9 dígitos');
    edtRg.SetFocus;
    result := False;
    Exit;
  end;

  if Length(trim(edtCpf.Text)) <> 11 then
  begin
    ShowMessage('O campo "CPF" deve conter 11 dígitos');
    edtCpf.SetFocus;
    result := False;
    Exit;
  end;

  if rdgSexo.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o "SEXO" ');
    result := False;
    Exit;
  end;

  // if trim(dbaltDataNasc.Text) <> '' then
  // dbaltDataNasc.Text := DateToStr(dtpAltDataNasc.DateTime);

  // else
  // dtmConn.qryAlteracao.Edit;
  // dtmConn.qryAlteracao.ParamByName('DATA_NASCIMENTO').AsDate :=
  // StrToDate(dbaltDataNasc.Text);

  // try
  // // Tenta converter a string para uma data. Isso também valida o formato.
  // dataNasc := StrToDate(dbEdtDataNasc.Text);
  // except
  // on E: EConvertError do
  // begin
  // // Se a conversão falhar, a data é inválida
  // ShowMessage('Data de nascimento inválida. Use o formato dd/mm/aaaa.');
  // dbaltDataNasc.SetFocus;
  // result := false;
  // Exit;
  // end;

  result := true;
end;

end.
