unit MeusServicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,conexao,pg_home,
  Vcl.Imaging.jpeg;

type
  TForm8 = class(TForm)
    Image1: TImage;
    text_telaservicos: TLabel;
    DBGridMeusservicos: TDBGrid;
    ButtonVoltar: TButton;
    Image2: TImage;
    procedure ButtonVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarServicosUsuario;

  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation
uses
paguina_servicos;

{$R *.dfm}

procedure TForm8.ButtonVoltarClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form2);
end;


procedure TForm8.CarregarServicosUsuario;
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQueryServicos do
  begin
    Close;
    SQL.Text :=
      'SELECT s.titulo, s.descricao, s.preco, c.nome AS categoria ' +
      'FROM servico s ' +
      'JOIN categoria c ON s.id_categoria = c.id_categoria ' +
      'JOIN prestador p ON s.id_prestador = p.id_prestador ' +
      'WHERE p.id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;
  end;

  // conecta o dataset à grid
  DBGridmeusservicos.DataSource := DataModule2.DataSourceServicos;
  DataModule2.DataSourceServicos.DataSet := DataModule2.FDQueryServicos;
end;

procedure TForm8.FormShow(Sender: TObject);
begin
  CarregarServicosUsuario;
end;

end.
