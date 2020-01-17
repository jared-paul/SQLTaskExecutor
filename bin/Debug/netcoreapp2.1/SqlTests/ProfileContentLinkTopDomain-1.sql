/* START GetResponse
D:\Projects\lissted.backend.net\SiteDLL\XiSiteLogic\App_Code\Services\Shared\ProfileContentLinkTopUrl\ProfileContentLinkTopUrlWorker.cs
*/
                            DECLARE @minHavingProfileCount int, @minProfileMentions int, @logFactorer float, @relevanceMultiplier int;
                            SET @minHavingProfileCount = dbo.SysConstant_Getint('MinimumProfileCount');
                            SET @minProfileMentions = dbo.SysConstant_Getint('MinimumProfileMentions');
                            SET @logFactorer = dbo.SysConstant_GetFloat('LogFactorer');
                            SET @relevanceMultiplier = dbo.SysConstant_Getint('RelevanceMultiplier');
 DECLARE @PLMembership int, @profileMentionsFactorer float; SELECT @profileMentionsFactorer = dbo.SysConstant_GetFloat('ProfileMentionsFactorer'); SELECT @PLMembership = COUNT(DISTINCT tblProfileContents.profile_id) FROM tblProfileListResults INNER JOIN tblProfiles ON tblProfileListResults.profile_id = tblProfiles.profile_id INNER JOIN tblProfileContents ON tblProfiles.profile_id = tblProfileContents.profile_id WHERE profileList_id = 420   AND [tblProfileContents].authoredTime >= '20190115 11:11:11.000' AND [tblProfileContents].authoredTime <= '20190215 11:11:11.000'
DECLARE @DomainDistinctMentions int, @DomainInsiderMultiplier float, @DomainCountMultiplier float; 
                SET @DomainDistinctMentions = dbo.SysConstant_GetInt('DomainDistinctMentions');
                SET @DomainInsiderMultiplier = dbo.SysConstant_GetFloat('DomainInsiderMultiplier');
                SET @DomainCountMultiplier = dbo.SysConstant_GetFloat('DomainCountMultiplier');

SELECT TOP 100 [tblLinkDomains].[linkDomain_id] AS tblProfileContentLinks_linkDomain_id , [tblLinkDomains].[name] AS tblProfileContentLinks_domain , COUNT(DISTINCT tblProfileContents.profile_id) AS Count, tblLinkDomains.profileMentions AS tblLinkDomains_profileMentions, CASE WHEN tblLinkDomains.profileMentions < COUNT(DISTINCT tblProfileContents.profile_id) THEN LOG((((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @PLMembership) / (CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @profileMentionsFactorer)) * LOG(COUNT(DISTINCT tblProfileContents.profile_id)/@logFactorer))*@relevanceMultiplier) ELSE LOG((((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @PLMembership) / (CAST(tblLinkDomains.profileMentions as float) / @profileMentionsFactorer)) * LOG(COUNT(DISTINCT tblProfileContents.profile_id)/@logFactorer))*@relevanceMultiplier) END AS tblProfileContentLinkRels_relevanceScore, CASE WHEN tblLinkDomains.profileMentions < COUNT(DISTINCT tblProfileContents.profile_id) 
                    THEN LOG(POWER((LOG((((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @PLMembership) / (CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @profileMentionsFactorer)) * LOG(COUNT(DISTINCT tblProfileContents.profile_id) / @logFactorer)) * @relevanceMultiplier)), @DomainInsiderMultiplier) * POWER(CAST(COUNT(DISTINCT tblProfileContents.profile_id) AS float), @DomainCountMultiplier)) 
                    ELSE LOG(POWER((LOG((((CAST(COUNT(DISTINCT tblProfileContents.profile_id) as float) / @PLMembership) / (CAST(tblLinkDomains.profileMentions as float) / @profileMentionsFactorer)) * LOG(COUNT(DISTINCT tblProfileContents.profile_id) / @logFactorer)) * @relevanceMultiplier)), @DomainInsiderMultiplier) * POWER(CAST(COUNT(DISTINCT tblProfileContents.profile_id) AS float), @DomainCountMultiplier)) 
                    END AS PopularityScore
 FROM tblProfileContentLinkRels INNER JOIN 
                tblLinks ON tblProfileContentLinkRels.link_id = tblLinks.link_id INNER JOIN
                tblLinkDomains ON tblLinks.linkDomain_id = tblLinkDomains.linkDomain_id INNER JOIN
                tblProfileContents ON tblProfileContentLinkRels.profileContent_id = tblProfileContents.profileContent_id INNER JOIN 
                tblProfiles ON tblProfileContents.profile_id = tblProfiles.profile_id 
 WHERE 1=1  AND ([tblProfileContents].[authoredTime] >= '20190115 11:11:11.000') AND ([tblProfileContents].[authoredTime] <= '20190215 11:11:11.000') AND ( tblProfiles.profile_id IN (SELECT profile_id FROM tblProfileListResults WHERE profileList_id = 420 ))  AND tblProfiles.active = 1 AND tblProfileContents.deleted = 0  AND tblLinkDomains.[stoplist] = 0  GROUP BY tblLinkDomains.linkDomain_id , tblLinkDomains.name, tblLinkDomains.profileMentions HAVING COUNT(DISTINCT tblProfileContents.profile_id) > @DomainDistinctMentions AND tblLinkDomains.profileMentions > @minProfileMentions
  ORDER BY  COUNT(DISTINCT tblProfileContents.profile_id) Asc, tblLinkDomains.name ASC  
/* END GetResponse */