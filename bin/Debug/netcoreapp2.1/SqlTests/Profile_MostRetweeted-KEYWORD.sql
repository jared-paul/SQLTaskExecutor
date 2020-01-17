/* START GetResponse
\App_Code\Services\Shared\ProfileMostRetweeted\ProfileMostRetweetedWorker.cs
*/

                    DECLARE @searchPhraseAsExpression nvarchar(4000);                    
                    SET @searchPhraseAsExpression = dbo.GetFullTextSearchExpressionFromPhrase(N'iran');
SELECT TOP 100  tblProfileContents.retweetedProviderUserId AS vExttblProfileContents_retweetedProviderUserId , tblProfileContents.retweetedProviderUsername AS vExttblProfileContents_retweetedProviderUsername , COUNT(DISTINCT tblProfileContents.retweetedProviderid) AS Retweets, COUNT(DISTINCT tblProfileContents.profile_id) AS DistinctProfiles, SUM(tblProfileContents.retweetCount) AS GlobalRetweets
 FROM tblProfileContents INNER JOIN tblProfiles ON tblProfileContents.profile_id = tblProfiles.profile_id 
 WHERE 1=1  AND ([tblProfileContents].[authoredTime] >= '20181107 00:00:00.000') AND ([tblProfileContents].[authoredTime] <= '20190705 23:59:59.000') AND ( tblProfileContents.profileContent_id IN ( SELECT [Key] FROM CONTAINSTABLE(tblProfileContents, [concat], @searchPhraseAsExpression) ) )  AND (tblProfileContents.deleted=0)  AND tblProfiles.active = 1 AND tblProfileContents.retweetedProviderUserId IS NOT NULL AND tblProfileContents.retweetedProviderUsername IS NOT NULL  GROUP BY tblProfileContents.retweetedProviderUserId, tblProfileContents.retweetedProviderUsername 
  ORDER BY  COUNT(DISTINCT tblProfileContents.profile_id) DESC, SUM(tblProfileContents.retweetCount) DESC,  tblProfileContents.retweetedProviderUserId DESC 

/* END GetResponse */