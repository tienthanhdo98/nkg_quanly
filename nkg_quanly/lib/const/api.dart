const apiGetDocument =
    "http://123.31.31.237:6002/api/documentin?Keyword&Level&DepartmentPublic&EndDate&DayInMonth&IsMonth&DateFrom&DateTo&PageIndex=1&PageSize=10";
const apiGetDocumentStatistic =
    "http://123.31.31.237:6002/api/documentin/statistic";
const apiGetDocumentDetail =
    "http://123.31.31.237:6002/api/documentin/get-by-id?";
//mission
const apiGetMissionStatistic =
    "http://123.31.31.237:6002/api/mission/statistic-status";
const apiGetMission =
    "http://123.31.31.237:6002/api/mission";

//calendar work
const apiPostCalendarWork =
    "http://123.31.31.237:6002/api/calendarwork?Keyword&DayInMonth=&IsMonth=&DateFrom=&DateTo=&PageIndex=1&PageSize=10";
//doc unprocess
const apitGetUnProcess0 =
    "http://123.31.31.237:6002/api/documentin/unprocess?filterUnProcess=0";
const apitGetUnProcess1 =
    "http://123.31.31.237:6002/api/documentin/unprocess?filterUnProcess=1";

//doc nonapprove
const apiGetDocumentNonApprove =
    "http://123.31.31.237:6002/api/documentin/non-approved";
//profile http://123.31.31.237:6002/api/profiles/statistic
const apiGetProfileStatistic =
    "http://123.31.31.237:6002/api/profiles/statistic";
const apiGetProfile =
    "http://123.31.31.237:6002/api/profiles/search";
const apiGetProfileFilter1 =
    "http://123.31.31.237:6002/api/profiles/get-statistic-chart?filterChart=1";
const apiGetProfileFilter0 =
    "http://123.31.31.237:6002/api/profiles/get-statistic-chart?filterChart=0";
//doc out
const apiGetDocumentOutFilter0 =
    "http://123.31.31.237:6002/api/documentout/wait-release?filterWaitRelease=0";
const apiGetDocumentOut=
    "http://123.31.31.237:6002/api/documentout";
//meeting room
const apiGetMeetingroomStatistic=
    "http://123.31.31.237:6002/api/meetingrooms/statistic";
const apiPostAllMeetingroom=
    "http://123.31.31.237:6002/api/meetingrooms/calendar";
const apiPostAllMeetingroomSearch=
    "http://123.31.31.237:6002/api/meetingrooms/search";

//report
const apiGetReportStatistic = "http://123.31.31.237:6002/api/reportapiclient/statistic";

//birthday
const apiPostBirthDay = "http://123.31.31.237:6002/api/birthday";
