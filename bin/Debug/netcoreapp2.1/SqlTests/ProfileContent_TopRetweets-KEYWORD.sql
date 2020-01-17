/* START GetResponse
\App_Code\Services\Shared\ProfileMostRetweeted\ProfileMostRetweetedWorker.cs
*/

                    DECLARE @searchPhraseAsExpression nvarchar(4000);                    
                    SET @searchPhraseAsExpression = dbo.GetFullTextSearchExpressionFromPhrase(N'ireland');
SELECT TOP 100  vExttblProfileContents.retweetedProviderId AS vExttblProfileContents_retweetedProviderId , COUNT(DISTINCT vExttblProfileContents.profile_id) AS DistinctProfiles, SUM(vExttblProfileContents.retweetCount) AS GlobalRetweets
 FROM vExttblProfileContents INNER JOIN tblProfiles ON vExttblProfileContents.profile_id = tblProfiles.profile_id  INNER JOIN tblProfileTypes ON tblProfiles.profileType_id = tblProfileTypes.profileType_id 
 WHERE 1=1  AND ([vExttblProfileContents].[authoredTime] >= '20181107 00:00:00.000') AND ([vExttblProfileContents].[authoredTime] <= '20190705 23:59:59.000') AND ( vExttblProfileContents.profileContent_id IN ( SELECT [Key] FROM CONTAINSTABLE(tblProfileContents, [concat], @searchPhraseAsExpression) ) )  AND (vExttblProfileContents.deleted=0)  AND (vExttblProfileContents.profile_active=1)  AND vExttblProfileContents.retweetedProviderId IS NOT NULL  GROUP BY vExttblProfileContents.retweetedProviderId 
  ORDER BY  COUNT(DISTINCT vExttblProfileContents.profile_id) DESC, SUM(vExttblProfileContents.retweetCount) DESC,  vExttblProfileContents.retweetedProviderId DESC 

/* END GetResponse*/