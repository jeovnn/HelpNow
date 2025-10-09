unit Paguina_servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Conexao, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, paguina_perfil,
  pg_home;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    text_telaservicos: TLabel;
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private

  public
    { Public declarations }
    procedure CarregarServicos;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form3);
end;

procedure TForm2.CarregarServicos;
begin
  // garante que a conexão está ativa
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT titulo, preco FROM servico ORDER BY titulo';
    Open;
  end;

  // conecta o dataset ao DBGrid
  DataModule2.DataSource1.DataSet := DataModule2.FDQuery1;
  DBGrid1.DataSource := DataModule2.DataSource1;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  CarregarServicos;
end;

end.
