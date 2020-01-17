/*START GetResponse
lissted.backend.net\SiteDLL\XiSiteLogic\App_Code\Services\Shared\ProfileContentLinkTopUrl\ProfileContentLinkTopUrlWorker.cs
*/
                            DECLARE @minHavingProfileCount int, @minProfileMentions int, @logFactorer float, @relevanceMultiplier int;
                            SET @minHavingProfileCount = dbo.SysConstant_Getint('MinimumProfileCount');
                            SET @minProfileMentions = dbo.SysConstant_Getint('MinimumProfileMentions');
                            SET @logFactorer = dbo.SysConstant_GetFloat('LogFactorer');
                            SET @relevanceMultiplier = dbo.SysConstant_Getint('RelevanceMultiplier');
 DECLARE @searchPhraseAsExpression nvarchar(4000);                    
                    SET @searchPhraseAsExpression = dbo.GetFullTextSearchExpressionFromPhrase(N'london'); 

SELECT TOP 100 [tblLinks].[link_id] AS tblProfileContentLinks_link_id , [tblLinks].[url] AS tblProfileContentLinks_url , [tblLinks].[title] AS tblProfileContentLinks_title , [tblLinks].[description] AS tblProfileContentLinks_description , [tblLinks].[media] AS tblProfileContentLinks_media , COUNT(DISTINCT tblProfileContents.profile_id) AS Count, tblLinks.cleanedUrl AS tblProfileContentLinks_cleanedUrl, tblLinks.createdDate AS tblProfileContentLinks_createdDate, tblLinks.profileMentions AS tblLinks_profileMentions
 FROM tblProfileContentLinkRels INNER JOIN 
                tblLinks ON tblProfileContentLinkRels.link_id = tblLinks.link_id INNER JOIN
                tblLinkDomains ON tblLinks.linkDomain_id = tblLinkDomains.linkDomain_id INNER JOIN
                tblProfileContents ON tblProfileContentLinkRels.profileContent_id = tblProfileContents.profileContent_id INNER JOIN 
                tblProfiles ON tblProfileContents.profile_id = tblProfiles.profile_id 
 WHERE 1=1  AND ([tblProfileContents].[authoredTime] >= '20190115 11:11:11.000') AND ([tblProfileContents].[authoredTime] <= '20190215 11:11:11.000') AND ( CONTAINS(tblProfileContents.[concat], @searchPhraseAsExpression) )  AND tblProfiles.active = 1 AND tblProfileContents.deleted = 0  AND tblLinks.[stoplist] = 0  AND tblLinkDomains.[stoplist] = 0  GROUP BY tblLinks.link_id, tblLinks.url, tblLinks.cleanedUrl, tblLinks.title, tblLinks.description, tblLinks.media, tblLinks.profileMentions, tblLinks.createdDate HAVING COUNT(DISTINCT tblProfileContents.profile_id) > @minHavingProfileCount AND tblLinks.profileMentions > @minProfileMentions
  ORDER BY  COUNT(DISTINCT tblProfileContents.profile_id) Asc, tblLinks.cleanedUrl ASC  
/* END GetResponse */