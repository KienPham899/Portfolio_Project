USE [Portfolio_project]
GO
-- Drop if exist View [cleaned_offer]
Drop VIEW cleaned_transcript
Go

-- Create view for 
CREATE VIEW cleaned_transcript AS
SELECT 
	[person],
	[event],
	[time],
	SUBSTRING([value], CHARINDEX('{', [value])+2, CHARINDEX(':', [value]) - 4) AS offer_type,
	REPLACE(REPLACE(SUBSTRING([value], (CHARINDEX(':', [value]) + 2), (CHARINDEX('}', [value]))),'''',''),'}','')AS offer_value
FROM [dbo].transcript
GO


SELECT *
FROM cleaned_transcript;
GO