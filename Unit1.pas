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
identificador,link, temporada, episodeo,opcao, titleSerie:string;
begin
    retorno := TStringList.Create;
    lista   := TStringList.Create;
    temp    := TStringList.Create;

    identificador := '/musicvideo.php?';

    for I := 0 to memo1.Lines.Count -1 do begin
      retorno.Text := GetURL(memo1.Lines[i]);
      retorno.Text := Copy(retorno.Text, pos('<title>',retorno.Text)+7);
      titleSerie := Copy(retorno.Text, 1,pos('</title>',retorno.Text));
      while retorno.Text.Contains('/musicvideo.php?vid=') do begin

        if pos('Temporada</strong>',retorno.Text) < pos('/musicvideo.php?vid=',retorno.Text) then begin
          retorno.Text := copy(retorno.Text, pos('Temporada</strong>',retorno.Text)-20);
          retorno.Text := copy(retorno.Text, pos('<strong>',retorno.Text)+8);
          temporada := copy(retorno.Text,1,pos('&',retorno.Text)-1);
          retorno.text := copy(retorno.Text,pos('</strong>',retorno.Text));
        end else begin
          retorno.Text := copy(retorno.Text, pos('<strong>Epis&oacute;dio ', retorno.Text));
          retorno.Text := copy(retorno.Text, length('<strong>Epis&oacute;dio ')+1);
          episodeo := copy(retorno.Text, 1,pos(' ',retorno.Text)-1);
          retorno.Text := copy(retorno.Text, pos('/musicvideo.php?vid=',retorno.Text));
          if pos('dublado',retorno.Text) < pos('Legendado',retorno.Text) then begin
             opcao := 'Dublado';
          end else begin
            opcao := 'Legendado'
          end;
          link := copy(retorno.Text, 1,pos('"',retorno.Text)-1);
          link := 'https://redecanais.bz'+link;
          lista.Add(link+'@T'+temporada+'E'+episodeo+' '+opcao+'@'+titleSerie);
          retorno.Text := copy(retorno.Text, pos(opcao,retorno.Text));

        end;
      end;
    end;


    memo2.Lines.Text := lista.Text;
    temp.Destroy;
    lista.Destroy;
    retorno.Destroy;
end;

end.
