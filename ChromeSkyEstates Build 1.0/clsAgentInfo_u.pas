unit clsAgentInfo_u;

interface

type
  TAgentInfo = class(TObject)
  private
    fFirst_Name: string;
    fLast_Name: string;
    fCurrent_Level: integer;

  public
    constructor create(sFirst_Name, sLast_Name: string;
      iCurrent_Level: integer);

    function getFullName: string;
    function DetermineTier(iCurrentLevel: integer): string;
  end;

implementation

{ TAgentInfo }

constructor TAgentInfo.create(sFirst_Name, sLast_Name: string;
  iCurrent_Level: integer);
begin
  fFirst_Name := sFirst_Name;
  fLast_Name := sLast_Name;
  fCurrent_Level := iCurrent_Level;
end;

function TAgentInfo.DetermineTier(iCurrentLevel: integer): string;
begin
  if fCurrent_Level <= 5 then
  begin
    result := 'Neon Newbie';
  end
  else if (fCurrent_Level > 5) or (fCurrent_Level <= 20) then
  begin
    result := 'Circuit Slinger';
  end
  else if (fCurrent_Level > 20) or (fCurrent_Level <= 50) then
  begin
    result := 'Data Driver';
  end
  else if (fCurrent_Level > 50) or (fCurrent_Level <= 70) then
  begin
    result := 'Synth Samurai';
  end
  else if (fCurrent_Level > 70) or (fCurrent_Level <= 99) then
  begin
    result := 'Chrome Legend';
  end
  else if fCurrent_Level >= 99 then
  begin
        result:='Neon God';
  end;

end;

function TAgentInfo.getFullName: string;
begin
  result := fFirst_Name + ' ' + fLast_Name;
end;

end.
