/* START ValidateRequest
D:\lissted.backend.net\SiteDLL\XiSiteLogic\App_Code\Services\Shared\ProfileList\Result\ProfileListResultWorker.cs
*/
SELECT   [tblProfileLists].[profileList_id] AS tblProfileLists_profileList_id , [tblProfileLists].[profileListType_id] AS tblProfileLists_profileListType_id , [tblProfileLists].[userProfile_id] AS tblProfileLists_userProfile_id , [tblProfileLists].[name] AS tblProfileLists_name , [tblProfileLists].[isSaved] AS tblProfileLists_isSaved , [tblProfileLists].[isDeleted] AS tblProfileLists_isDeleted , [tblProfileLists].[isPublic] AS tblProfileLists_isPublic , [tblProfileLists].[twitterUserIds] AS tblProfileLists_twitterUserIds , [tblProfileLists].[keywords] AS tblProfileLists_keywords , [tblProfileLists].[geo] AS tblProfileLists_geo , [tblProfileLists].[maxListLength] AS tblProfileLists_maxListLength , [tblProfileLists].[createdTime] AS tblProfileLists_createdTime 
 FROM tblProfileLists 
 WHERE 1=1  AND [tblProfileLists].[profileList_id] = 225
go
/* END ValidateRequest */