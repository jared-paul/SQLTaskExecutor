                    DECLARE @searchPhrase nvarchar(1000), @searchPhraseAsExpression nvarchar(4000);
                    SET @searchPhrase = N'london or sqltest'
                    SET @searchPhraseAsExpression = dbo.GetFullTextSearchExpressionFromPhrase(@searchPhrase);
 SELECT Count(1) AS NoOfRows 
 FROM vExttblProfiles  
 WHERE 1=1  AND ( vExttblProfiles.profile_id IN ( SELECT [Key] FROM CONTAINSTABLE (viewFTProfiles, [concat], @searchPhraseAsExpression) ) )  
go