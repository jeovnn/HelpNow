unit Paguina_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
    Image1: TImage;
    procedure goto_cadastroClick(Sender: TObject);
    procedure retorna_ao_menuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pag_login: Tpag_login;

implementation

uses
  pg_home, Paguina_incial_login, Paguina_cadastro;

{$R *.dfm}

procedure Tpag_login.goto_cadastroClick(Sender: TObject);
begin
 pag_home.MostrarFormularioEmbed(pag_cadastro);
end;

procedure Tpag_login.retorna_ao_menuClick(Sender: TObject);
begin
 pag_home.MostrarFormularioEmbed(pag_inicial);
end;

end.
