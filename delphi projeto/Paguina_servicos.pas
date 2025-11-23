unit Paguina_servicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Conexao, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, paguina_perfil,
  pg_home, Vcl.Imaging.jpeg, CadastrarServico, meusservicos,
  MaisInformacoesServico;

type
  TForm2 = class(TForm)
    DBGrid1: TDBGrid;
    text_telaservicos: TLabel;
    ButtonPerfil: TButton;
    Image1: TImage;
    ButtonCadastrarServico: TButton;
    ButtonMeusServicos: TButton;
    Image2: TImage;
    EditPesquisa: TEdit;
    LabelPesquisar: TLabel;
    ComboCategoria: TComboBox;
    LabelFiltroCategoria: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ButtonPerfilClick(Sender: TObject);
    procedure ButtonCadastrarServicoClick(Sender: TObject);
    procedure ButtonMeusServicosClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditPesquisaChange(Sender: TObject);
    procedure ComboCategoriaChange(Sender: TObject);
  private

  public
    { Public declarations }
    procedure CarregarServicos;
    procedure CarregarCategorias;
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

procedure TForm2.CarregarCategorias;
begin
  ComboCategoria.Items.Clear;

  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQueryConta do
  begin
    Close;
    SQL.Text := 'SELECT id_categoria, nome FROM categoria ORDER BY nome';
    Open;

    while not EOF do
    begin
      ComboCategoria.Items.AddObject(FieldByName('nome').AsString,
        TObject(FieldByName('id_categoria').AsInteger));
      Next;
    end;

    Close;
  end;

  // Adiciona uma opção padrão "todas"
  ComboCategoria.Items.Insert(0, 'Todas as categorias');
  ComboCategoria.ItemIndex := 0;
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

  // 🔹 Oculta a coluna do ID após abrir e carregar no grid
  if DBGrid1.Columns.Count > 0 then
    DBGrid1.Columns[0].Visible := False;
end;

procedure TForm2.ComboCategoriaChange(Sender: TObject);
var
  CategoriaID: Integer;
begin
  if ComboCategoria.ItemIndex <= 0 then
  begin
    // Mostra todos os serviços
    CarregarServicos;
    Exit;
  end;

  CategoriaID := Integer(ComboCategoria.Items.Objects
    [ComboCategoria.ItemIndex]);

  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT id_servico, titulo, preco ' + 'FROM servico ' +
      'WHERE id_categoria = :cat ' + 'ORDER BY titulo';
    ParamByName('cat').AsInteger := CategoriaID;
    Open;
  end;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
// 🔹 função local
  function QuebrarTexto(const Texto: string; Max: Integer): string;
  var
    i, Count: Integer;
    Linha: string;
  begin
    Result := '';
    Linha := '';
    Count := 0;
    for i := 1 to Length(Texto) do
    begin
      Linha := Linha + Texto[i];
      Inc(Count);
      if (Count >= Max) and (Texto[i] = ' ') then
      begin
        Result := Result + Trim(Linha) + sLineBreak;
        Linha := '';
        Count := 0;
      end;
    end;
    Result := Result + Trim(Linha);
  end;

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
      SQL.Text := 'SELECT s.titulo, s.descricao, s.preco, c.nome AS categoria, '
        + 'u.nome AS prestador, u.telefone, u.email, p.regiao, u.image ' +
        'FROM servico s ' +
        'LEFT JOIN categoria c ON c.id_categoria = s.id_categoria ' +
        'LEFT JOIN prestador p ON p.id_prestador = s.id_prestador ' +
        'LEFT JOIN usuario u ON u.id_usuario = p.id_usuario ' +
        'WHERE s.id_servico = :id';
      ParamByName('id').AsInteger := IDServico;
      Open;

      if not EOF then
      begin
        Form9.LabelTitulodobanco.Caption := FieldByName('titulo').AsString;
        Form9.LabelDescricaodobanco.Caption :=
          QuebrarTexto(FieldByName('descricao').AsString, 40);
        Form9.LabelDescricaodobanco.WordWrap := True;
        Form9.LabelValordobanco.Caption := 'R$ ' + FormatFloat('0.00',
          FieldByName('preco').AsFloat);
        Form9.LabelCategoriaBanco.Caption := FieldByName('categoria').AsString;
        Form9.LabelPrestadordobanco.Caption := FieldByName('prestador')
          .AsString;
        Form9.LabelTelefonedobanco.Caption := FieldByName('telefone').AsString;
        Form9.LabelEmaildobanco.Caption := FieldByName('email').AsString;
        Form9.LabelRegiaodobanco.Caption := FieldByName('regiao').AsString;

        // imagem
        if not FieldByName('image').IsNull then
        begin
          Stream := TMemoryStream.Create;
          try
            TBlobField(FieldByName('image')).SaveToStream(Stream);
            Stream.Position := 0;
            Form9.ImagePerfil.Picture.LoadFromStream(Stream);
          finally
            Stream.Free;
          end;
        end
        else
        begin
          // NÃO limpa a imagem para manter a default do Form
          // Apenas garante ajustes visuais caso queira
          Form9.ImagePerfil.Stretch := True;
          Form9.ImagePerfil.Proportional := True;
        end;
      end;
    end;
    Form9.IDServico := IDServico;
    pag_home.MostrarFormularioEmbed(Form9);
  except
    Form9.Free;
    raise;
  end;
end;

procedure TForm2.EditPesquisaChange(Sender: TObject);
var
  TextoPesquisa: string;
begin
  TextoPesquisa := Trim(EditPesquisa.Text);

  if not DataModule2.FDConnection1.Connected then
    DataModule2.FDConnection1.Connected := True;

  with DataModule2.FDQuery1 do
  begin
    Close;

    if TextoPesquisa = '' then
      SQL.Text :=
        'SELECT id_servico, titulo, preco FROM servico ORDER BY titulo'
    else
    begin
      SQL.Text := 'SELECT id_servico, titulo, preco FROM servico ' +
        'WHERE UPPER(titulo) LIKE :titulo ' + 'ORDER BY titulo';
      ParamByName('titulo').AsString := '%' + UpperCase(TextoPesquisa) + '%';
    end;

    Open;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
DBGrid1.OnCellClick := DBGrid1CellClick;
  CarregarServicos;
  CarregarCategorias;

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
