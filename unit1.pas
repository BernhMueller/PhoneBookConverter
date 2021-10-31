unit unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Open: TMenuItem;
    Save: TMenuItem;
    TransformButton: TButton;
    InputFilename: TEdit;
    OutputFilename: TEdit;
    OpenButton: TButton;
    SaveButton: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PROCEDURE MenuItem1Click(Sender: TObject);
    PROCEDURE OutputFilenameChange(Sender: TObject);
    PROCEDURE TransformButtonClick(Sender: TObject);
    PROCEDURE InputFilenameChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure OpenButtonEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  fname, oname, parameters: String;
  f, o: TextFile;
  FirstTime: Boolean;
  textline: string;
  fullname: string;
  strpos, prefpos, voicepos: integer;
  (* cellpos: integer; *)
  mailhome: string;
  mailwork: string;
  telhome: string;
  (*	celnum: string;	*)

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.OpenButtonClick(Sender: TObject);

begin
  if OpenDialog1.Execute then
    begin
      fname := OPenDialog1.FileName;
      InputFilename.Text := fname;
    end
end;

procedure TForm1.SaveButtonClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    oname := SaveDialog1.FileName;
    OutputFilename.Text := oname;
  END;
end;

PROCEDURE TForm1.InputFilenameChange(Sender: TObject);
BEGIN
  fname := InputFilename.Text;
end;

PROCEDURE TForm1.TransformButtonClick(Sender: TObject);
BEGIN
  FirstTime := true;
  AssignFile(f, fname);
  reset(f);
  AssignFile(o, oname);
	rewrite(o);
	writeln(o, '<adARTISIPPhoneDirectory>');

	repeat
		readln(f, textline);

		(* Get Full Name *)
		if LeftStr(textline,3) = 'FN:' then
		begin
			fullname := RightStr(textline, length(textline)-3);
			writeln('Name = ', fullname);
			if not FirstTime then writeln(o,'</DirectoryEntry>');
                        writeln(o,'<DirectoryEntry>');
			writeln(o,'<Name>', fullname, '</Name>');
                        FirstTime := false;
		end;

		(* Get Home and Work Email *)
		if LeftStr(textline,5) = 'EMAIL' then
		begin
			strpos := pos('type=HOME',textline);
			prefpos := pos('type=pref', textline);

			if strpos > 0 then
			if prefpos > 0 then
			begin
				mailhome := Rightstr(textline, (length(textline) - prefpos - 9));
				writeln('Home Mail = ', mailhome);
			end
			else
			begin
				mailhome := Rightstr(textline, (length(textline) - strpos - 9));
				writeln('Home Mail = ', mailhome);
			end;
			strpos := pos('type=WORK',textline);

			if strpos > 0 then
			if prefpos > 0 then
			begin
				mailwork := Rightstr(textline, (length(textline) - prefpos - 9));
				writeln('Work Mail = ', mailwork);
			end
			else
			begin
				mailwork := Rightstr(textline, (length(textline) - strpos - 9));
				writeln('Work Mail = ', mailwork);
			end;
		end;
		(* Get Phone Numbers *)
		if LeftStr(textline,3) = 'TEL' then
		begin
			strpos := pos('type=HOME',textline);
			voicepos := pos('type=VOICE',textline);
			prefpos := pos('type=pref', textline);
			if voicepos > 0 then
			begin
				if prefpos > 0 then
					telhome := Rightstr(textline, (length(textline) - prefpos - 9))
				else
				telhome := Rightstr(textline, (length(textline) - voicepos - 10));
			writeln('Home Telefone = ', telhome);
			writeln(o,'<Telephone>', telhome, '</Telephone>');
			end;
		end;
	until eof(f);
	writeln(o,'</DirectoryEntry>');
	writeln(o, '</adARTISIPPhoneDirectory>');
	closefile(f);
	closefile(o);
        TransformButton.Caption := 'Done!';
end;

PROCEDURE TForm1.MenuItem1Click(Sender: TObject);
BEGIN

end;

PROCEDURE TForm1.OutputFilenameChange(Sender: TObject);
BEGIN
  oname := OutputFilename.Text;
end;


procedure TForm1.OpenButtonEnter(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;


end.

