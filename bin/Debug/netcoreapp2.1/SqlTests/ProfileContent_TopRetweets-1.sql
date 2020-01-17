/* START GetResponse
\App_Code\Services\Shared\ProfileContentTopRetweet\ProfileContentTopRetweetWorker.cs
*/

 DECLARE @retweetMultiplier2 float, @profileMultiplier2 float, @relevanceMultiplier int; SELECT @retweetMultiplier2 = dbo.SysConstant_GetFloat('RetweetMultiplier2');  SELECT @profileMultiplier2 = dbo.SysConstant_GetFloat('ProfileMultiplier2');  SELECT @relevanceMultiplier = dbo.SysConstant_GetInt('RelevanceMultiplierB') 

SELECT TOP 1  vExttblProfileContents.retweetedProviderId AS vExttblProfileContents_retweetedProviderId , COUNT(DISTINCT vExttblProfileContents.profile_id) AS DistinctProfiles, SUM(vExttblProfileContents.retweetCount) AS GlobalRetweets, LOG((CAST(COUNT(DISTINCT vExttblProfileContents.profile_id) as float) / POWER(CAST(SUM(vExttblProfileContents.retweetCount) as float), @retweetMultiplier2) * POWER(CAST(COUNT(DISTINCT vExttblProfileContents.profile_id) as float), @profileMultiplier2))*@relevanceMultiplier)  AS vExttblProfileContents_relevanceScore
 FROM vExttblProfileContents INNER JOIN tblProfiles ON vExttblProfileContents.profile_id = tblProfiles.profile_id  INNER JOIN tblProfileTypes ON tblProfiles.profileType_id = tblProfileTypes.profileType_id 
 WHERE 1=1  AND ([vExttblProfileContents].[authoredTime] >= '20190306 00:00:00.000') AND ([vExttblProfileContents].[authoredTime] <= '20190704 23:59:59.000') AND ( tblProfiles.profile_id IN (SELECT profile_id FROM tblProfileListResults WHERE profileList_id = 310 ) )  AND (vExttblProfileContents.deleted=0)  AND (vExttblProfileContents.profile_active=1)  AND vExttblProfileContents.retweetedProviderId IS NOT NULL  GROUP BY vExttblProfileContents.retweetedProviderId 
  ORDER BY  LOG((CAST(COUNT(DISTINCT vExttblProfileContents.profile_id) as float) / POWER(CAST(SUM(vExttblProfileContents.retweetCount) as float), @retweetMultiplier2) * POWER(CAST(COUNT(DISTINCT vExttblProfileContents.profile_id) as float), @profileMultiplier2))*@relevanceMultiplier)  Desc, vExttblProfileContents.retweetedProviderId DESC 

/* END GetResponse */