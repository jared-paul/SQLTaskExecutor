/*START GetResponse
lissted.backend.net\SiteDLL\XiSiteLogic\App_Code\Services\Shared\ProfileContentLinkTopUrl\ProfileContentLinkTopUrlWorker.cs
*/
                            DECLARE @minHavingProfileCount int, @minProfileMentions int, @logFactorer float, @relevanceMultiplier int;
                            SET @minHavingProfileCount = dbo.SysConstant_Getint('MinimumProfileCount');
                            SET @minProfileMentions = dbo.SysConstant_Getint('MinimumProfileMentions');
                            SET @logFactorer = dbo.SysConstant_GetFloat('LogFactorer');
                            SET @relevanceMultiplier = dbo.SysConstant_Getint('RelevanceMultiplier');
 DECLARE @PLMembership int, @profileMentionsFactorer float, @relevanceScorePowerFactor1 float, @relevanceScorePowerFactor2 float; SELECT @profileMentionsFactorer = dbo.SysConstant_GetFloat('ProfileMentionsFactorer'); SELECT @relevanceScorePowerFactor1 = dbo.SysConstant_GetFloat('RelevanceScorePowerFactor1'); SELECT @relevanceScorePowerFactor2 = dbo.SysConstant_GetFloat('RelevanceScorePowerFactor2'); SELECT @PLMembership = COUNT(DISTINCT tblProfileContents.profile_id) FROM tblProfileListResults INNER JOIN tblProfiles ON tblProfileListResults.profile_id = tblProfiles.profile_id INNER JOIN tblProfileContents ON tblProfiles.profile_id = tblProfileContents.profile_id WHERE profileList_id = 420   AND [tblProfileContents].authoredTime >= '20190115 11:11:11.000' AND [tblProfileContents].authoredTime <= '20190215 11:11:11.000'

SELECT TOP 100 [tblLinks].[link_id] AS tblProfileContentLinks_link_id , [tblLinks].[url] AS tblProfileContentLinks_url , [tblLinks].[title] AS tblProfileContentLinks_title , [tblLinks].[description] AS tblProfileContentLinks_description , [tblLinks].[media] AS tblProfileContentLinks_media , COUNT(DISTINCT tblProfileContents.profile_id) AS Count, tblLinks.cleanedUrl AS tblProfileContentLinks_cleanedUrl, tblLinks.createdDate AS tblProfileContentLinks_createdDate, tblLinks.profileMentions AS tblLinks_profileMentions, CASE WHEN tblLinks.profileMentions < COUNT(DISTINCT tblProfileContents.profile_id) THEN LOG(POWER(((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @PLMembership) / (CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @profileMentionsFactorer)), @relevanceScorePowerFactor1)* POWER(CAST(COUNT(DISTINCT tblProfileContents.profile_id)/@logFactorer as float), @relevanceScorePowerFactor2) * @relevanceMultiplier) ELSE LOG(POWER(((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @PLMembership) / (CAST(tblLinks.profileMentions as float) / @profileMentionsFactorer)), @relevanceScorePowerFactor1) * POWER(CAST(COUNT(DISTINCT tblProfileContents.profile_id)/@logFactorer as float), @relevanceScorePowerFactor2) * @relevanceMultiplier) END AS tblProfileContentLinkRels_relevanceScore
 FROM tblProfileContentLinkRels INNER JOIN 
                tblLinks ON tblProfileContentLinkRels.link_id = tblLinks.link_id INNER JOIN
                tblLinkDomains ON tblLinks.linkDomain_id = tblLinkDomains.linkDomain_id INNER JOIN
                tblProfileContents ON tblProfileContentLinkRels.profileContent_id = tblProfileContents.profileContent_id INNER JOIN 
                tblProfiles ON tblProfileContents.profile_id = tblProfiles.profile_id 
 WHERE 1=1  AND ([tblProfileContents].[authoredTime] >= '20190115 11:11:11.000') AND ([tblProfileContents].[authoredTime] <= '20190215 11:11:11.000') AND ( tblProfiles.profile_id IN (SELECT profile_id FROM tblProfileListResults WHERE profileList_id = 420 ))  AND tblProfiles.active = 1 AND tblProfileContents.deleted = 0  AND tblLinks.[stoplist] = 0  AND tblLinkDomains.[stoplist] = 0  GROUP BY tblLinks.link_id, tblLinks.url, tblLinks.cleanedUrl, tblLinks.title, tblLinks.description, tblLinks.media, tblLinks.profileMentions, tblLinks.createdDate HAVING COUNT(DISTINCT tblProfileContents.profile_id) > @minHavingProfileCount AND tblLinks.profileMentions > @minProfileMentions
  ORDER BY  COUNT(DISTINCT tblProfileContents.profile_id) Asc, tblLinks.cleanedUrl ASC  
/* END GetResponse */