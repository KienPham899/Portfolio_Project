USE [Portfolio_project]
GO

-- Drop if exist View [cleaned_offer]
Drop VIEW [cleaned_offer]
Go

-- Create view after filter channels to check list of each channel

CREATE VIEW [cleaned_offer] AS
SELECT [reward],
       [web],
	   [email],
	   [mobile],
	   [social],
       [difficulty],
       [duration],
       [offer_type],
       [id]
FROM (
	SELECT *,
	   CASE 
		  WHEN [channels] LIKE '%web%' THEN 1
		  ELSE 0
	   END AS [web],
	   CASE 
		  WHEN [channels] LIKE '%email%' THEN 1
		  ELSE 0
	   END AS [email],
	   CASE 
		  WHEN [channels] LIKE '%mobile%' THEN 1
		  ELSE 0
	   END AS [mobile],
	   CASE 
		  WHEN [channels] LIKE '%social%' THEN 1
		  ELSE 0
	   END AS [social]
	FROM [dbo].[portfolio]
) subquery;
GO 

SELECT *
  FROM [dbo].[cleaned_offer]
  ORDER BY reward ASC
GO
