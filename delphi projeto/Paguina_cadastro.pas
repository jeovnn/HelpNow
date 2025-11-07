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
    function EmailValido(const Email: string): Boolean;
    function CPFValido(cpf: string): Boolean;

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

  // Validar email
  if not EmailValido(email_cad.Text) then
  begin
    ShowMessage('E-mail inválido! Digite um e-mail válido.');
    Exit;
  end;

  // Validar CPF
  if not CPFValido(cpf.Text) then
  begin
    ShowMessage('CPF inválido! Verifique e tente novamente.');
    Exit;
  end;
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

  // 🔹 VALIDAR SE EMAIL JÁ EXISTE
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT COUNT(*) AS total FROM usuario WHERE email = :email';
    ParamByName('email').AsString := email_cad.Text;
    Open;

    if FieldByName('total').AsInteger > 0 then
    begin
      ShowMessage('Este e-mail já está cadastrado! Tente outro.');
      Exit;
    end;
  end;

  // 🔹 VALIDAR SE CPF JÁ EXISTE
  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT COUNT(*) AS total FROM usuario WHERE cpf = :cpf';
    ParamByName('cpf').AsString := cpf.Text;
    Open;

    if FieldByName('total').AsInteger > 0 then
    begin
      ShowMessage('Este CPF já está cadastrado! Verifique e tente novamente.');
      Exit;
    end;
  end;

  // ✅ Se passou em todas validações → Continua cadastro
  try
    // 1) Gerar o próximo id_usuario manualmente
    with DataModule2.FDQuery1 do
    begin
      SQL.Text :=
        'SELECT COALESCE(MAX(id_usuario), 0) + 1 AS prox FROM usuario';
      Open;
      NovoIDUsuario := FieldByName('prox').AsInteger;
      Close;
    end;

    // 2) Inserir na tabela usuario
    with DataModule2.FDQuery1 do
    begin
      SQL.Text :=
        'INSERT INTO usuario (id_usuario, email, nome, cpf, data_cadastro) ' +
        'VALUES (:id, :email, :nome, :cpf, :data_cadastro)';
      ParamByName('id').AsInteger := NovoIDUsuario;
      ParamByName('email').AsString := email_cad.Text;
      ParamByName('nome').AsString := nome_cad.Text;
      ParamByName('cpf').AsString := cpf.Text;
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
      ParamByName('id_conta').AsInteger := NovoIDConta;
      ParamByName('id_usuario').AsInteger := NovoIDUsuario;
      ParamByName('usuario').AsString := email_cad.Text;
      ParamByName('senha').AsString := senha_cad.Text;
      ParamByName('tipo').AsString := 'cliente';
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

function Tpag_cadastro.CPFValido(cpf: string): Boolean;
var
  I, Digito1, Digito2, Soma, Resto: Integer;
begin
  cpf := StringReplace(cpf, '.', '', [rfReplaceAll]);
  cpf := StringReplace(cpf, '-', '', [rfReplaceAll]);

  // precisa ter 11 números
  if Length(cpf) <> 11 then
    Exit(False);

  // rejeita CPFs repetidos: 11111111111, 22222222222...
  if cpf = StringOfChar(cpf[1], 11) then
    Exit(False);

  // Calcula primeiro dígito
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + (StrToInt(cpf[I]) * (11 - I));
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) or (Resto = 11) then
    Resto := 0;
  Digito1 := Resto;

  // Calcula segundo dígito
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + (StrToInt(cpf[I]) * (12 - I));
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) or (Resto = 11) then
    Resto := 0;
  Digito2 := Resto;

  Result := (Digito1 = StrToInt(cpf[10])) and (Digito2 = StrToInt(cpf[11]));
end;

function Tpag_cadastro.EmailValido(const Email: string): Boolean;
begin
  Result := (Pos('@', Email) > 1) and (Pos('.', Email) > Pos('@', Email) + 1)
    and (Email[Length(Email)] <> '.');
end;

procedure Tpag_cadastro.goto_cadastroClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(pag_login);
end;

end.
