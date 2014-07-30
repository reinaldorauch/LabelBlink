unit unLabelBlink;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, ExtCtrls, Graphics;

type
  TLabelBlink = class(TLabel)
  private
    { Private declarations }
    FInterval : Integer;
    FBlinking : Boolean;
    FTimer    : TTimer;
    FColors   : Array [1..5] of TColor;
    FColorPos : Byte;

    procedure FTimerOnTimer(Sender: TObject);
    procedure SetBlinking(const Value: Boolean);
    procedure SetInterval(const Value: Integer);

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Blinking: Boolean Read FBlinking Write SetBlinking;
    property Interval: Integer Read FInterval Write SetInterval;
    property FirstColor : TColor Read FColors[1] Write FColors[1];
    property SecondColor: TColor Read FColors[2] Write FColors[2];
    property ThridColor : TColor Read FColors[3] Write FColors[3];
    property FourthColor: TColor Read FColors[4] Write FColors[4];
    property FifthColor : TColor Read FColors[5] Write FColors[5];
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TLabelBlink]);
end;

{ TLabelBlink }

constructor TLabelBlink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FInterval := 300;
  FBlinking := False;
  Visible   := False;
  FColorPos := 1;

  FTimer := TTimer.Create(Self);

  FTimer.Interval := FInterval;
  FTimer.Enabled  := FBlinking;
  FTimer.OnTimer  := FTimerOnTimer;

end;

destructor TLabelBlink.Destroy;
begin
  FTimer.Free;
  inherited;
end;

procedure TLabelBlink.FTimerOnTimer(Sender: TObject);
begin
  Visible := NOT Visible;

  Font.Color := FColors[FColorPos];

  Inc(FColorPos);
  if(FColorPos > 5) then
    FColorPos := 1;
end;

procedure TLabelBlink.SetBlinking(const Value: Boolean);
begin
  FBlinking := Value;
  FTimer.Enabled := Value;
  Visible := True;
end;

procedure TLabelBlink.SetInterval(const Value: Integer);
begin
  if (FInterval <> Value) AND (value > 250) AND (value < 2000) then
  begin
    FTimer.Interval := Value;
    FInterval := Value;
  end;
end;

end.
