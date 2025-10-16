unit Paguina_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  Tpag_login = class(TForm)
    painel_principal: TPanel;
    text_login_pag: TLabel;
    descricao: TLabel;
    senha_login: TEdit;
    painel_senha: TPanel;
    labal_senha: TLabel;
    label_naoconta: TLabel;
    goto_cadastro: TLabel;
    Image1: TImage;
    Image2: TImage;
    Button1: TButton;
    painel_email: TPanel;
    label_email: TLabel;
    email_login: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pag_login: Tpag_login;
  high_voltar: Integer;
  high_voltar_txt: Integer;

implementation

uses
  pg_home, Paguina_incial_login, Paguina_cadastro, Conexao, Paguina_servicos;

{$R *.dfm}



procedure Tpag_login.Button1Click(Sender: TObject);
begin
begin
  if Trim(email_login.Text) = '' then
  begin
    ShowMessage('Digite seu e-mail.');
    Exit;
  end;

  if Trim(senha_login.Text) = '' then
  begin
    ShowMessage('Digite sua senha.');
    Exit;
  end;

  try
    with DataModule2.FDQuery1 do
    begin
      Close;
      SQL.Text :=
        'SELECT u.id_usuario, u.nome, u.email ' +
        'FROM usuario u ' +
        'INNER JOIN conta c ON u.id_usuario = c.id_usuario ' +
        'WHERE u.email = :email AND c.senha = :senha';

      ParamByName('email').AsString := email_login.Text;
      ParamByName('senha').AsString := senha_login.Text;
      Open;

      if not EOF then
      begin
        UsuarioLogadoID := FieldByName('id_usuario').AsInteger;
        ShowMessage('Bem-vindo, ' + FieldByName('nome').AsString + '!');
        pag_home.MostrarFormularioEmbed(Form2); // vai para a tela de serviços
      end
      else
        ShowMessage('E-mail ou senha inválidos.');
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao efetuar login: ' + E.Message);
  end;
end;
end;
procedure Tpag_login.Button2Click(Sender: TObject);
begin
pag_home.MostrarFormularioEmbed(pag_inicial);
end;

end.
