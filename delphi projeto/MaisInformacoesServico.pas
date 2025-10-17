unit MaisInformacoesServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TForm9 = class(TForm)
    td: TImage;
    LabelMaisInformacoes: TLabel;
    LabelCategirua: TLabel;
    LabelCategoriaBanco: TLabel;
    LabelTitulo: TLabel;
    LabelTitulodobanco: TLabel;
    LabelDescricao: TLabel;
    LabelDescricaodobanco: TLabel;
    LabelPreco: TLabel;
    LabelValordobanco: TLabel;
    LabelPrestador: TLabel;
    LabelPrestadordobanco: TLabel;
    LabelTelefone: TLabel;
    LabelTelefonedobanco: TLabel;
    ImagePerfil: TImage;
    LabelEmail: TLabel;
    LabelEmaildobanco: TLabel;
    LabelRegiao: TLabel;
    LabelRegiaodobanco: TLabel;
    ButtonVoltar: TButton;
    GroupBox1: TGroupBox;
    Image1: TImage;
    procedure ButtonVoltarClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation
uses
Paguina_servicos,pg_home;
{$R *.dfm}

procedure TForm9.ButtonVoltarClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form2);
end;

procedure TForm9.FormHide(Sender: TObject);
begin
  // Limpa todas as labels
  LabelTitulodobanco.Caption      := '';
  LabelDescricaodobanco.Caption   := '';
  LabelValordobanco.Caption       := '';
  LabelCategoriaBanco.Caption     := '';
  LabelPrestadordobanco.Caption   := '';
  LabelTelefonedobanco.Caption    := '';
  LabelEmaildobanco.Caption       := '';
  LabelRegiaodobanco.Caption      := '';

  // Limpa a imagem
  td.Picture := nil;
end;

end.
