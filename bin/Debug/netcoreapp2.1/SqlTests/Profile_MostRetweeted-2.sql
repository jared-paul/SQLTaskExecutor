/* START GetResponse
\App_Code\Services\Shared\ProfileMostRetweeted\ProfileMostRetweetedWorker.cs
*/

 DECLARE @retweetMultiplier float, @profileMultiplier float, @providerMultiplier float, @relevanceMultiplier int; SELECT @retweetMultiplier = dbo.SysConstant_GetFloat('RetweetMultiplier');  SELECT @profileMultiplier = dbo.SysConstant_GetFloat('ProfileMultiplier'); SELECT @providerMultiplier = dbo.SysConstant_GetFloat('ProviderMultiplier'); SELECT @relevanceMultiplier = dbo.SysConstant_GetInt('RelevanceMultiplierB') 

SELECT TOP 100  tblProfileContents.retweetedProviderUserId AS vExttblProfileContents_retweetedProviderUserId , tblProfileContents.retweetedProviderUsername AS vExttblProfileContents_retweetedProviderUsername , COUNT(DISTINCT tblProfileContents.retweetedProviderid) AS Retweets, COUNT(DISTINCT tblProfileContents.profile_id) AS DistinctProfiles, SUM(tblProfileContents.retweetCount) AS GlobalRetweets, LOG((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / POWER(CAST(SUM(tblProfileContents.retweetCount) as float), @retweetMultiplier) * POWER(CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float), @profileMultiplier) * POWER(CAST(COUNT(DISTINCT tblProfileContents.retweetedProviderId) as float), @providerMultiplier))*@relevanceMultiplier)  AS tblProfileContents_relevanceScore
 FROM tblProfileContents INNER JOIN tblProfiles ON tblProfileContents.profile_id = tblProfiles.profile_id 
 WHERE 1=1  AND ([tblProfileContents].[authoredTime] >= '20190306 00:00:00.000') AND ([tblProfileContents].[authoredTime] <= '20190704 23:59:59.000') AND ( tblProfiles.profile_id IN (SELECT profile_id FROM tblProfileListResults WHERE profileList_id = 268 ) )  AND (tblProfileContents.deleted=0)  AND tblProfiles.active = 1 AND tblProfileContents.retweetedProviderUserId IS NOT NULL AND tblProfileContents.retweetedProviderUsername IS NOT NULL  GROUP BY tblProfileContents.retweetedProviderUserId, tblProfileContents.retweetedProviderUsername 
  ORDER BY  COUNT(DISTINCT tblProfileContents.profile_id) DESC, SUM(tblProfileContents.retweetCount) DESC,  tblProfileContents.retweetedProviderUserId DESC 

/* END GetResponse */