unit Paguina_servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Conexao, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, paguina_perfil,
  pg_home, Vcl.Imaging.jpeg,CadastrarServico,meusservicos,MaisInformacoesServico;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    text_telaservicos: TLabel;
    ButtonPerfil: TButton;
    Image1: TImage;
    ButtonCadastrarServico: TButton;
    ButtonMeusServicos: TButton;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
    procedure ButtonPerfilClick(Sender: TObject);
    procedure ButtonCadastrarServicoClick(Sender: TObject);
    procedure ButtonMeusServicosClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private

  public
    { Public declarations }
    procedure CarregarServicos;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ButtonCadastrarServicoClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form7);
end;

procedure TForm2.ButtonMeusServicosClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form8);
end;

procedure TForm2.ButtonPerfilClick(Sender: TObject);
begin
  pag_home.MostrarFormularioEmbed(Form3);
end;

procedure TForm2.CarregarServicos;
begin
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT id_servico, titulo, preco FROM servico ORDER BY titulo';
    Open;
  end;

  DataModule2.DataSource1.DataSet := DataModule2.FDQuery1;
  DBGrid1.DataSource := DataModule2.DataSource1;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
var
  IDServico: Integer;
  Stream: TMemoryStream;
begin
  if DataModule2.FDQuery1.IsEmpty then
    Exit;

  IDServico := DataModule2.FDQuery1.FieldByName('id_servico').AsInteger;

  Form9 := TForm9.Create(Self);
  try
    with DataModule2.FDQueryServicos do
    begin
      Close;
      SQL.Text :=
        'SELECT s.titulo, s.descricao, s.preco, c.nome AS categoria, ' +
        'u.nome AS prestador, u.telefone, u.email, p.regiao, u.image ' +
        'FROM servico s ' +
        'LEFT JOIN categoria c ON c.id_categoria = s.id_categoria ' +
        'LEFT JOIN prestador p ON p.id_prestador = s.id_prestador ' +
        'LEFT JOIN usuario u ON u.id_usuario = p.id_usuario ' +
        'WHERE s.id_servico = :id';
      ParamByName('id').AsInteger := IDServico;
      Open;

      if not EOF then
      begin
        Form9.LabelTitulodobanco.Caption    := FieldByName('titulo').AsString;
        Form9.LabelDescricaodobanco.Caption := FieldByName('descricao').AsString;
        Form9.LabelValordobanco.Caption     := 'R$ ' + FormatFloat('0.00', FieldByName('preco').AsFloat);
        Form9.LabelCategoriaBanco.Caption   := FieldByName('categoria').AsString;
        Form9.LabelPrestadordobanco.Caption := FieldByName('prestador').AsString;
        Form9.LabelTelefonedobanco.Caption  := FieldByName('telefone').AsString;
        Form9.LabelEmaildobanco.Caption     := FieldByName('email').AsString;
        Form9.LabelRegiaodobanco.Caption    := FieldByName('regiao').AsString;

        // ?? Carrega a imagem do banco, se existir
        if not FieldByName('image').IsNull then
        begin
          Stream := TMemoryStream.Create;
          try
            TBlobField(FieldByName('image')).SaveToStream(Stream);
            Stream.Position := 0;
            Form9.Imageperfil.Picture.LoadFromStream(Stream);
          finally
            Stream.Free;
          end;
        end
        else
          Form9.Imageperfil.Picture := nil; // limpa se não tiver imagem
      end
      else
        ShowMessage('Serviço não encontrado.');
    end;

    pag_home.MostrarFormularioEmbed(Form9);
  except
    Form9.Free;
    raise;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  CarregarServicos;
   // Verifica o tipo de conta do usuário logado
  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQueryConta do
  begin
    Close;
    SQL.Text := 'SELECT tipo FROM conta WHERE id_usuario = :id';
    ParamByName('id').AsInteger := UsuarioLogadoID;
    Open;

    // Se o tipo for "prestador", mostra os botoes
    if not EOF and SameText(FieldByName('tipo').AsString, 'prestador') then
      ButtonCadastrarServico.Visible := True
    else
      ButtonCadastrarServico.Visible := False;

    if not EOF and SameText(FieldByName('tipo').AsString, 'prestador') then
      ButtonMeusServicos.Visible := True
    else
      ButtonMeusServicos.Visible := False;
    Close;
  end;
end;

end.
