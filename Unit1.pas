unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  WinINet;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetURL(const AURL: string): string;
var
  HttpClient: THttpClient;
  HttpResponse: IHttpResponse;
begin

  HttpClient := THttpClient.Create;
  try
    HttpResponse := HttpClient.Get(AURL);
    Result := HttpResponse.ContentAsString();
  finally
    HttpClient.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
retorno, lista:tstringlist;
i,ii,g,j:integer;
identificador,link:string;
begin
  //
  retorno := TStringList.Create;
  lista   := TStringList.Create;
    retorno.Text := GetURL(edit1.Text);
    identificador := '<li><a href="/browse-a';

    while retorno.Text.Contains(identificador) do begin
      retorno.Text := copy(retorno.Text, pos(identificador,retorno.Text));
      link := copy(retorno.Text, pos('/',retorno.Text));
      link := copy(link,1,pos('"',link)-1);
      lista.Add('https://redecanais.bz'+link);
      retorno.Text := copy(retorno.Text,5);
    end;


  memo1.Lines.Text := lista.Text;
  lista.Destroy;
  retorno.Destroy;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
retorno,lista, temp:TStringList;
i,ii,g,j:integer;
identificador,link, temporada, episodeo,opcao,opcao2, titleSerie:string;
begin
    retorno := TStringList.Create;
    lista   := TStringList.Create;
    temp    := TStringList.Create;

    identificador := '/musicvideo.php?';

    for I := 0 to memo1.Lines.Count -1 do begin
      retorno.Text := GetURL(memo1.Lines[i]);
      retorno.Text := Copy(retorno.Text, pos('<title>',retorno.Text)+7);
      titleSerie := Copy(retorno.Text, 1,pos('</title>',retorno.Text)-1);
      while retorno.Text.Contains('<strong>Epis&oacute;dio ') do begin

        if (pos('Temporada</strong>',retorno.Text) < pos('<strong>Epis&oacute;dio ',retorno.Text))and (retorno.text.contains('Temporada</strong>')) then begin
          retorno.Text := copy(retorno.Text, pos('Temporada</strong>',retorno.Text)-20);
          retorno.Text := copy(retorno.Text, pos('<strong>',retorno.Text)+8);
          temporada := copy(retorno.Text,1,pos('&',retorno.Text)-1);
          retorno.text := copy(retorno.Text,pos('</strong>',retorno.Text));
        end else begin
          retorno.Text := copy(retorno.Text, pos('<strong>Epis&oacute;dio ', retorno.Text));
          retorno.Text := copy(retorno.Text, length('<strong>Epis&oacute;dio ')+1);
          episodeo := copy(retorno.Text, 1,pos(' ',retorno.Text)-1);

          retorno.Text := copy(retorno.Text, pos('<a href="',retorno.Text)+9);
          if pos('Dublado',retorno.Text) < pos('Legendado',retorno.Text) then begin
             opcao := 'Dublado';
             opcao2 := 'Legendado'
          end else begin
            opcao := 'Legendado';
            opcao2 := 'Dublado';
          end;
          link := copy(retorno.Text, 1,pos('"',retorno.Text)-1);
          link := 'https://redecanais.bz'+link;
          lista.Add(link+'@T'+temporada+'E'+episodeo+' '+opcao+'@'+titleSerie);

          if pos('<strong>Epis&oacute;dio ',retorno.Text) > pos(opcao2,retorno.Text)  then begin
             retorno.Text := copy(retorno.Text,5);
             retorno.Text := copy(retorno.Text, pos('<a href="',retorno.Text)+9);
             link := copy(retorno.Text, 1,pos('"',retorno.Text)-1);
             link := 'https://redecanais.bz'+link;
             lista.Add(link+'@T'+temporada+'E'+episodeo+' '+opcao2+'@'+titleSerie);
             retorno.Text := copy(retorno.Text, pos(opcao2,retorno.Text));
          end else begin
             retorno.Text := copy(retorno.Text, pos(opcao,retorno.Text));
          end;

        end;
      end;
    end;


    memo2.Lines.Text := lista.Text;
    temp.Destroy;
    lista.Destroy;
    retorno.Destroy;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
retorno, lista, memoPg:tstringlist;
i,ii,g,j:integer;
link,linkFrame,poster:string;
begin
    retorno := TStringList.Create;
    lista   := TStringList.Create;
    memoPg  := TStringList.Create;
    //link := memo2.Lines[1];
    //link := copy(link,1,)
    //memo4.Lines.Text := geturl(copy(memo2.Lines[1],1,pos('@',memo2.Lines[1])-1));
    memoPg.Text := memo2.Lines.Text;

    for I := 0 to memoPg.Count -1 do begin
      retorno.Text := GetURL(copy(memoPg[i],1,pos('@',memoPg[i])-1));

      retorno.Text := Copy(retorno.Text,pos('iframe',retorno.Text));
      retorno.Text := Copy(retorno.Text,pos('src="',retorno.Text)+5);
      linkFrame := Copy(retorno.Text, 1, pos('"',retorno.Text)-1);
      retorno.Text := GetURL('https://redecanais.bz'+linkFrame);
      retorno.Text := Copy(retorno.Text,pos('baixar="',retorno.Text)+8);
      link := Copy(retorno.Text, 1, Pos('.mp4',retorno.Text)+3);

      retorno.Text := Copy(retorno.Text,pos('poster=".',retorno.Text)+9);
      poster := Copy(retorno.Text,1,pos('"',retorno.Text)-1);
      lista.Add(link+'@'+'https://redecanais.bz/player3'+poster+copy(memoPg[i],pos('@',memoPg[i])));
    end;


    memo3.Lines.Text := lista.Text;
    retorno.Destroy;
    lista.Destroy;
    memoPg.Destroy;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
dados, linkvideos, lista: tstringlist;
i,ii,g,j:integer;
grupo, nome, capa,link: string;
begin
    dados := TStringList.Create;
    lista := TStringList.Create;

    dados.Text := memo3.Lines.Text;

    for I := 0 to dados.Count-1 do begin
      link := copy(dados[i],pos('@',dados[i])-1);

      lista.Add()

    end;


    memo4.Lines.Text := lista.Text;
    dados.Destroy;
    lista.Destroy;
end;

end.
