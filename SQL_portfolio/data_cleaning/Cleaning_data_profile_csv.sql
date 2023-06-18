USE [Portfolio_project]
GO
-- Drop if exist View [cleaned_offer]
Drop VIEW cleaned_customer
Go

-- Create view for filter all null value exist in table 
CREATE VIEW cleaned_customer AS
  SELECT *
  FROM [dbo].[profile]
  WHERE NOT ([gender] IS NULL OR [income] IS NULL)
GO

SELECT *
FROM cleaned_customer
ORDER BY [became_member_on] DESC