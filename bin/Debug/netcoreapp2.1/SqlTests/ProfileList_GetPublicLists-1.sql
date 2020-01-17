/* START GetResponse
D:\lissted.backend.net\SiteDLL\XiSiteLogic\App_Code\Services\Shared\ProfileList\Get\ProfileListRetrieveWorker.cs
*/
SELECT   [tblProfileLists].[profileList_id] AS tblProfileLists_profileList_id , [tblProfileLists].[profileListType_id] AS tblProfileLists_profileListType_id , [tblProfileLists].[userProfile_id] AS tblProfileLists_userProfile_id , [tblProfileLists].[name] AS tblProfileLists_name , [tblProfileLists].[isSaved] AS tblProfileLists_isSaved , [tblProfileLists].[isDeleted] AS tblProfileLists_isDeleted , [tblProfileLists].[isPublic] AS tblProfileLists_isPublic , [tblProfileLists].[twitterUserIds] AS tblProfileLists_twitterUserIds , [tblProfileLists].[keywords] AS tblProfileLists_keywords , [tblProfileLists].[geo] AS tblProfileLists_geo , [tblProfileLists].[maxListLength] AS tblProfileLists_maxListLength , [tblProfileLists].[createdTime] AS tblProfileLists_createdTime , (SELECT COUNT(*) FROM tblProfileListResults WHERE profileList_id = tblProfileLists.profileList_id) AS tblProfileList_NumberOfResults
 FROM tblProfileLists 
 WHERE 1=1  AND isDeleted = 0  AND isPublic = 1  AND isSaved = 1 
  ORDER BY tblProfileLists.profilelist_id Asc
/* END GetResponse */