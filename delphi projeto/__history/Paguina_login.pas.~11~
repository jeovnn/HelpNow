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
    email_login: TEdit;
    senha_login: TEdit;
    painel_email: TPanel;
    painel_senha: TPanel;
    bk_img_email: TImage;
    bk_img_senha: TImage;
    label_email: TLabel;
    labal_senha: TLabel;
    label_naoconta: TLabel;
    goto_cadastro: TLabel;
    retorna_ao_menu: TImage;
    Enviar: TImage;
    Image1: TImage;
    Votlar_txt: TLabel;
    LabelEnviar: TLabel;
    procedure goto_cadastroClick(Sender: TObject);
    procedure retorna_ao_menuClick(Sender: TObject);
    procedure retorna_ao_menuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure retorna_ao_menuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Votlar_txtMouseEnter(Sender: TObject);
    procedure Votlar_txtMouseLeave(Sender: TObject);
    procedure LabelEnviarClick(Sender: TObject);
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

procedure Tpag_login.FormCreate(Sender: TObject);
begin
  high_voltar := retorna_ao_menu.Top;
  high_voltar_txt:= Votlar_txt.Top;
end;

procedure Tpag_login.goto_cadastroClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(pag_cadastro);
end;

procedure Tpag_login.LabelEnviarClick(Sender: TObject);
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

procedure Tpag_login.Votlar_txtMouseEnter(Sender: TObject);
begin
Votlar_txt.Enabled:=false
end;

procedure Tpag_login.Votlar_txtMouseLeave(Sender: TObject);
begin
 Votlar_txt.Enabled:=true
end;

procedure Tpag_login.retorna_ao_menuClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(pag_inicial);
end;

procedure Tpag_login.retorna_ao_menuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  retorna_ao_menu.Top := high_voltar + 5;
end;

procedure Tpag_login.retorna_ao_menuMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  retorna_ao_menu.Top := high_voltar;
end;

end.
