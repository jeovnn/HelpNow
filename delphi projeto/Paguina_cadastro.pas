unit Paguina_cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, conexao;

type
  Tpag_cadastro = class(TForm)
    painel_principal: TPanel;
    text_login_pag: TLabel;
    descricao: TLabel;
    label_jaconta: TLabel;
    goto_cadastro: TLabel;
    painel_email: TPanel;
    label_email: TLabel;
    email_cad: TEdit;
    painel_senha_confirmação: TPanel;
    cpf: TEdit;
    painel_nome: TPanel;
    label_nome: TLabel;
    nome_cad: TEdit;
    painel_senha: TPanel;
    label_senha1: TLabel;
    senha_cad: TEdit;
    email_direção: TLabel;
    nome_direção: TLabel;
    senha_conf_direção: TLabel;
    senha_direção: TLabel;
    Label1: TLabel;
    Image2: TImage;
    ButtonVoltar: TButton;
    Button1: TButton;
    Image1: TImage;
    procedure goto_cadastroClick(Sender: TObject);
    procedure ButtonVoltarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pag_cadastro: Tpag_cadastro;
  high_voltar: Integer;
  high_volt_txt: Integer;

implementation

uses
  pg_home, Paguina_incial_login, Paguina_login, Paguina_servicos;

{$R *.dfm}

procedure Tpag_cadastro.Button1Click(Sender: TObject);
var
  NovoIDUsuario, NovoIDConta: Integer;
begin
  if Trim(email_cad.Text) = '' then
  begin
    ShowMessage('Digite seu e-mail.');
    Exit;
  end;

  if Trim(nome_cad.Text) = '' then
  begin
    ShowMessage('Digite seu nome.');
    Exit;
  end;

  if Trim(cpf.Text) = '' then
  begin
    ShowMessage('Digite seu CPF.');
    Exit;
  end;

  if Trim(senha_cad.Text) = '' then
  begin
    ShowMessage('Digite sua senha.');
    Exit;
  end;

  try
    // 1) Gerar o próximo id_usuario manualmente
    with DataModule2.FDQuery1 do
    begin
      SQL.Text := 'SELECT COALESCE(MAX(id_usuario), 0) + 1 AS prox FROM usuario';
      Open;
      NovoIDUsuario := FieldByName('prox').AsInteger;
      Close;
    end;

    // 2) Inserir na tabela usuario   //esse : é tipo pra deixar reservado um espaço pra colocar o dado durante a execução
    with DataModule2.FDQuery1 do
    begin
      SQL.Text :=
        'INSERT INTO usuario (id_usuario, email, nome, cpf, data_cadastro) ' +
        'VALUES (:id, :email, :nome, :cpf, :data_cadastro)';
      ParamByName('id').AsInteger         := NovoIDUsuario;
      ParamByName('email').AsString       := email_cad.Text;
      ParamByName('nome').AsString        := nome_cad.Text;
      ParamByName('cpf').AsString    := cpf.Text;
      ParamByName('data_cadastro').AsDate := Date;
      ExecSQL;
    end;

    // 3) Gerar o próximo id_conta manualmente
    with DataModule2.FDQuery1 do
    begin
      SQL.Text := 'SELECT COALESCE(MAX(id_conta), 0) + 1 AS prox FROM conta';
      Open;
      NovoIDConta := FieldByName('prox').AsInteger;
      Close;
      UsuarioLogadoID := NovoIDUsuario;
    end;

    // 4) Inserir na tabela conta
    with DataModule2.FDQuery1 do
    begin
      SQL.Text :=
        'INSERT INTO conta (id_conta, id_usuario, usuario, senha, tipo) ' +
        'VALUES (:id_conta, :id_usuario, :usuario, :senha, :tipo)';
      ParamByName('id_conta').AsInteger   := NovoIDConta;
      ParamByName('id_usuario').AsInteger := NovoIDUsuario;
      ParamByName('usuario').AsString     := email_cad.Text;
      ParamByName('senha').AsString       := senha_cad.Text;
      ParamByName('tipo').AsString        := 'cliente';
      ExecSQL;
    end;

    ShowMessage('Cadastro realizado com sucesso!');
    pag_home.MostrarFormularioEmbed(Form2);

  except
    on E: Exception do
      ShowMessage('Erro ao cadastrar: ' + E.Message);
  end;
end;

procedure Tpag_cadastro.ButtonVoltarClick(Sender: TObject);
begin
pag_home.MostrarFormularioEmbed(pag_inicial);
end;

procedure Tpag_cadastro.goto_cadastroClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(pag_login);
end;



end.
