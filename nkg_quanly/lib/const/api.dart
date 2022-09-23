const apiGetDocument =
    "http://123.31.31.237:6002/api/documentin?Keyword&Level&DepartmentPublic&EndDate&DayInMonth&IsMonth&DateFrom&DateTo&PageIndex=1&PageSize=10";
const apiGetDocumentStatistic =
    "http://123.31.31.237:6002/api/documentin/statistic";
const apiGetDocumentDetail =
    "http://123.31.31.237:6002/api/documentin/get-by-id?";
//mission
const apiGetMissionStatistic =
    "http://123.31.31.237:6002/api/mission/statistic-state";
const apiGetMission =
    "http://123.31.31.237:6002/api/mission";
const apiGetMissionDetail =
   "http://123.31.31.237:6002/api/mission/get-by-id/";
const apiGetMissionChart=
   "http://123.31.31.237:6002/api/mission/statistic?missionFilter=";

//calendar work
const apiPostCalendarWork =
    "http://123.31.31.237:6002/api/calendarwork?Keyword&DayInMonth=&IsMonth=&DateFrom=&DateTo=&PageIndex=1&PageSize=10";
//doc unprocess
const apitGetUnProcess0 =
    "http://123.31.31.237:6002/api/documentin/unprocess?filterUnProcess=0";
const apitGetUnProcess1 =
    "http://123.31.31.237:6002/api/documentin/unprocess?filterUnProcess=1";
const apiGetDocumentUnprocessFilterChart =
    "http://123.31.31.237:6002/api/documentin/unprocess?filterUnProcess=";

//doc nonapprove
const apiGetDocumentNonApprove =
    "http://123.31.31.237:6002/api/documentin/non-approved";
const apiGetDocumentApproveFilterChart =
    "http://123.31.31.237:6002/api/documentin/non-approved?filterNonApproved=";

//profile
const apiGetProfileStatistic =
    "http://123.31.31.237:6002/api/profiles/statistic";
const apiGetProfile =
    "http://123.31.31.237:6002/api/profiles/search";
const apiGetProfileFilter =
    "http://123.31.31.237:6002/api/profiles/get-statistic-chart?filterChart=";

//profile procedure
const apiGetProfileProcedureStatistic =
    "http://123.31.31.237:6002/api/procedureprofiles/statistic-status";
const apiGetProfileProcedureChart0 =
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart?filterChart=0";
const apiGetProfileProcedureChart1=
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart?filterChart=1";
const apiPostProfileProcedureModel=
    "http://123.31.31.237:6002/api/procedureprofiles/search";
const apiPostProfileProcedureDetail=
    "http://123.31.31.237:6002/api/procedureprofiles/get-by-id?";


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
const apiGetMeetingDetail=
    "http://123.31.31.237:6002/api/meetingrooms/get-by-id?";

//report
const apiGetReportStatistic = "http://123.31.31.237:6002/api/reportapiclient/statistic";
const apiGetReportChart0 = "http://123.31.31.237:6002/api/reportapiclient/get-statistic-chart?filterChart=0";
const apiGetReportChart1 = "http://123.31.31.237:6002/api/reportapiclient/get-statistic-chart?filterChart=1";
const apiGetReportModel = "http://123.31.31.237:6002/api/reportapiclient/search";
const apiGetReportDetail = "http://123.31.31.237:6002/api/reportapiclient/get-by-id?";

//birthday
const apiPostBirthDay = "http://123.31.31.237:6002/api/birthday";
//workbook
const apiPostWorkBookSearch = "http://123.31.31.237:6002/api/workbook/search";
const apiAddWorkBook = "http://123.31.31.237:6002/api/workbook";
const apiWorkBookDetail = "http://123.31.31.237:6002/api/workbook/";//id
const apiWorkBookDelete = "http://123.31.31.237:6002/api/workbook/deletes";