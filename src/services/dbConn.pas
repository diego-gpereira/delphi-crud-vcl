unit dbConn;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TdtmConn = class(TDataModule)
    FDConn: TFDConnection;
    qryListagem: TFDQuery;
    qryListagemSEQUENCIA: TIntegerField;
    qryListagemNOME: TStringField;
    qryListagemRG: TStringField;
    qryListagemCPF: TStringField;
    qryListagemSEXO: TStringField;
    qryListagemDATA_NASCIMENTO: TSQLTimeStampField;
    qryListagemFOTO: TBlobField;
    qryCadastro: TFDQuery;
    dsCadastro: TDataSource;
    qryCadastroSEQUENCIA: TIntegerField;
    qryCadastroNOME: TStringField;
    qryCadastroRG: TStringField;
    qryCadastroCPF: TStringField;
    qryCadastroSEXO: TStringField;
    qryCadastroDATA_NASCIMENTO: TSQLTimeStampField;
    qryCadastroFOTO: TBlobField;
    dsListagem: TDataSource;
    qryAlteracao: TFDQuery;
    dsAlteracao: TDataSource;
    qryAlteracaoSEQUENCIA: TIntegerField;
    qryAlteracaoNOME: TStringField;
    qryAlteracaoRG: TStringField;
    qryAlteracaoCPF: TStringField;
    qryAlteracaoSEXO: TStringField;
    qryAlteracaoDATA_NASCIMENTO: TSQLTimeStampField;
    qryAlteracaoFOTO: TBlobField;
  private
    { Private declarations }
  public
//    procedure AbrirListagem;
//    procedure Novo;
//    procedure Editar(AId: Integer);
    procedure Cadastrar;
//    procedure Cancelar;
    procedure Excluir(AId: Integer);
  end;

var
  dtmConn: TdtmConn;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

//procedure TdtmConn.AbrirListagem;
//begin
//  qryListagem.Close;
//  qryListagem.SQL.Text := 'SELECT * FROM PESSOAS';
//  qryListagem.Open;
//end;

//procedure TdtmConn.Novo;
//begin
//  qryCadastro.Close;
//  qryCadastro.SQL.Text := 'SELECT * FROM PESSOAS WHERE 1=0';
//  qryCadastro.Open;
//  qryCadastro.Append;
//end;

//procedure TdtmConn.Editar(AId: Integer);
//begin
//  qryAlteracao.Close;
//  qryAlteracao.SQL.Text :=
//    'UPDATE PESSOAS SET ' +
//    'NOME = :NOME, ' +
//    'RG = :RG, ' +
//    'CPF = :CPF, ' +
//    'SEXO = :SEXO, ' +
//    'DATA_NASCIMENTO = :DATA_NASCIMENTO, ' +
//    'FOTO = :FOTO ' +
//    'WHERE SEQUENCIA = :SEQUENCIA';
//  qryAlteracao.ParamByName('SEQUENCIA').AsInteger := AId;
//  qryAlteracao.Open;
//  qryAlteracao.Edit;
//  qryAlteracao.Post;
//end;

procedure TdtmConn.Cadastrar;
begin
  if qryCadastro.State in [dsInsert, dsEdit] then
    qryCadastro.Post;
//  if qryCadastro.State in [dsInsert, dsEdit] then
//    qryCadastro.Post;
//  if not qryCadastro.Active then
//    qryCadastro.Open;
//
//
//  // no momento que inicio a tela de cadastro, modo insert;
//  qryCadastro.Insert; // com isso os dados não vem preenchidos
    qryListagem.Refresh;
end;

//procedure TdtmConn.Cancelar;
//begin
//  if qryCadastro.State in [dsInsert, dsEdit] then
//    qryCadastro.Cancel;
//end;

procedure TdtmConn.Excluir(AId: Integer);
begin
  qryCadastro.Close;
  qryCadastro.SQL.Text := 'DELETE FROM PESSOAS WHERE SEQUENCIA = :SEQUENCIA';
  qryCadastro.ParamByName('SEQUENCIA').AsInteger := AId;
  qryCadastro.ExecSQL;
  qryListagem.Refresh;
end;


end.
