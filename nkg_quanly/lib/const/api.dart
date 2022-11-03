const apiGetDocument = "http://123.31.31.237:6002/api/documentin";
const apiGetDocumentStatistic =
    "http://123.31.31.237:6002/api/documentin/statistic";
const apiGetDocumentDetail =
    "http://123.31.31.237:6002/api/documentin/get-by-id?";
//mission
const apiGetMissionStatistic =
    "http://123.31.31.237:6002/api/mission/statistic-state";
const apiGetMission = "http://123.31.31.237:6002/api/mission";
const apiGetMissionDetail = "http://123.31.31.237:6002/api/mission/get-by-id/";
const apiGetMissionChart =
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
const apiGetProfile = "http://123.31.31.237:6002/api/profiles/search";
const apiGetProfileFilter =
    "http://123.31.31.237:6002/api/profiles/get-statistic-chart?filterChart=";
//profile work
const apiPostProfile = "http://123.31.31.237:6002/api/workprofiles";
//profile procedure
const apiGetProfileProcedureStatistic =
    "http://123.31.31.237:6002/api/procedureprofiles/statistic";
const apiGetProfileProcedureChart0 =
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart?filterChart=0";
const apiGetProfileProcedureChart1 =
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart?filterChart=1";
const apiPostProfileProcedureModel =
    "http://123.31.31.237:6002/api/procedureprofiles/search";
const apiGetAgencies =
    "http://123.31.31.237:6002/api/procedureprofiles/get-agencies";
const apiGetBranch =
    "http://123.31.31.237:6002/api/procedureprofiles/get-branch";
const apiStatus = "http://123.31.31.237:6002/api/procedureprofiles/get-status";
const apiProcedure =
    "http://123.31.31.237:6002/api/procedureprofiles/get-procedure";
const apiGroupProcedure =
    "http://123.31.31.237:6002/api/procedureprofiles/get-group-procedure";
const apiPostProfileProcedureDetail =
    "http://123.31.31.237:6002/api/procedureprofiles/get-by-id?maSoBienNhan=";
const apiPostChartStatusResolve =
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart-status-resolve";
const apiPostChartByBranch=
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart-branch";
const apiPostChartByAgencies=
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart-agencies";
  const apiPostChartByReceptionform=
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart-receptionform";
  const apiPostChartByProceduce=
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart-procedure";
  const apiPostChartByDate =
    "http://123.31.31.237:6002/api/procedureprofiles/get-statistic-chart-bydate";

//doc out
const apiGetDocumentOutFilter0 =
    "http://123.31.31.237:6002/api/documentout/wait-release?filterWaitRelease=0";
const apiGetDocumentOut = "http://123.31.31.237:6002/api/documentout";
//meeting room
const apiGetMeetingroomStatistic =
    "http://123.31.31.237:6002/api/meetingrooms/statistic";
const apiPostAllMeetingroomCalendar =
    "http://123.31.31.237:6002/api/meetingrooms/calendar";
const apiPostAllMeetingroomSearch =
    "http://123.31.31.237:6002/api/meetingrooms/search";
const apiGetMeetingDetail =
    "http://123.31.31.237:6002/api/meetingrooms/get-by-id?";

//book car
const apiGetBookingCarListItems = "http://123.31.31.237:6002/api/cars/search";
//report
const apiGetReportStatistic =
    "http://123.31.31.237:6002/api/reportapiclient/statistic";
const apiGetReportChart0 =
    "http://123.31.31.237:6002/api/reportapiclient/get-statistic-chart?filterChart=0";
const apiGetReportChart1 =
    "http://123.31.31.237:6002/api/reportapiclient/get-statistic-chart?filterChart=1";
const apiGetReportModel =
    "http://123.31.31.237:6002/api/reportapiclient/search";
const apiGetReportDetail =
    "http://123.31.31.237:6002/api/reportapiclient/get-by-id?";
const apiGetDepartmentFilter =
    "http://123.31.31.237:6002/api/reportapiclient/department-handle";

//birthday
const apiPostBirthDay = "http://123.31.31.237:6002/api/birthday";
//workbook
const apiPostWorkBookSearch = "http://123.31.31.237:6002/api/workbook/search";
const apiGroupBookList = "http://123.31.31.237:6002/api/groupworkbook/search";
const apiAddWorkBook = "http://123.31.31.237:6002/api/workbook";
const apiWorkBookDetail = "http://123.31.31.237:6002/api/workbook/"; //id
const apiWorkBookDelete = "http://123.31.31.237:6002/api/workbook/";
const apiGroupWorkBookDetail = "http://123.31.31.237:6002/api/groupworkbook/"; //id
//contact organization
const apiPostSearchListContactOrganization = "http://123.31.31.237:6002/api/contact/organization/search";
const apiContactOrgan = "http://123.31.31.237:6002/api/contact/organization/";
const apiContactOrganDetail = "http://123.31.31.237:6002/api/contact/organization/"; //id
const apiOrganList= "http://123.31.31.237:6002/api/organizations/get-unpaging";

//contact individual
const apiActionIndividualContact = "http://123.31.31.237:6002/api/contact/individual";
const apiSearhIndividualContact = "http://123.31.31.237:6002/api/contact/individual/search";
const apiGetDepartmentList = "http://123.31.31.237:6002/api/departments/get-unpaging";
const apiIndividualContactDetail = "http://123.31.31.237:6002/api/contact/individual/";

//helpdesk
const apiPostHelpDesk = "http://123.31.31.237:6002/api/helpdesks";
const apiGetChartRecentlyHelpDesk = "http://123.31.31.237:6002/api/helpdesks/get-recently";
const apiGetHelpdeskFilter= "http://123.31.31.237:6002/api/helpdesks";

//pmis
const apiPmisGetUnit = "http://123.31.31.237:6002/api/reportpmis/get-unit";
const apiStatisticTotal = "http://123.31.31.237:6002/api/reportpmis/get-statistic-total";
const apiPmisPieChart= "http://123.31.31.237:6002/api/reportpmis/get-statistic-chartpie";
const apiPmisPieChartByYear= "http://123.31.31.237:6002/api/reportpmis/get-statistic-by-year";
const apiPmisPieChartByUnit= "http://123.31.31.237:6002/api/reportpmis/get-statistic-by-unit";

//guideline
const getGuideline = "http://123.31.31.237:6002/api/guidelines/search?Keyword=%20";
const getGuidelineDownload = "http://123.31.31.237:6002/api/guidelines/download-file/";

//group work book
const apiSearchGroupWorkBook = "http://123.31.31.237:6002/api/groupworkbook/search";
const apiActionSearchGroupWorkBook = "http://123.31.31.237:6002/api/groupworkbook";

//analysis report
const  getAnalysisReportProvince = "http://123.31.31.237:6002/api/analysisreport/get-province";
const  getAnalysisReportRegion = "http://123.31.31.237:6002/api/analysisreport/get-region";
const  getAnalysisReportSemester = "http://123.31.31.237:6002/api/analysisreport/get-semester";
const  getAnalysisReportSchoolYear = "http://123.31.31.237:6002/api/analysisreport/get-schoolyear";
const  getAnalysisReportSchoolLevel = "http://123.31.31.237:6002/api/analysisreport/get-schoollevel";
const  getClass = "http://123.31.31.237:6002/api/analysisreport/get-class";
const  getSubject = "http://123.31.31.237:6002/api/analysisreport/get-subject";
const  getClassification = "http://123.31.31.237:6002/api/analysisreport/get-classification";
const  getPoint = "http://123.31.31.237:6002/api/analysisreport/get-point";

const  postEducationChart = "http://123.31.31.237:6002/api/statisticuniversaleducation/get-statistic-chart";
const postChartDsabilityEducation = "http://123.31.31.237:6002/api/analysisreportdisabilityeducation";
const postChartInfrastructure = "http://123.31.31.237:6002/api/analysisreportinfrastructure";
const postChartBeneficiary = "http://123.31.31.237:6002/api/analysisticbeneficiary/get-statistic-chart";
const postContinuingEducation = "http://123.31.31.237:6002/api/statisticcontinuingeducation/get-statistic-chart";
const postPreSchool = "http://123.31.31.237:6002/api/statisticpreschool/get-statistic-chart";
const postPrimarySchool = "http://123.31.31.237:6002/api/analysisreportprimaryschool";
const postSecondarySchool = "http://123.31.31.237:6002/api/statisticsecondaryschool/get-statistic-chart";
const postHighSchool = "http://123.31.31.237:6002/api/analysisreporthighschool";

//login
const apiGetAccessToken = "https://dangnhap.moet.gov.vn/oauth2/token";
const apiRevokeAccessToken = "https://dangnhap.moet.gov.vn/oauth2/revoke";
const apiRevokeAccessTokenIoc = "http://123.31.31.237:6002/api/authentications/access-tokens/revoke";
const apiGetUserInfo = "https://dangnhap.moet.gov.vn/oauth2/userinfo";
const apiGetSignup = "http://123.31.31.237:6002/api/authentications/sign-up";
const apiLoginConfig= "http://123.31.31.237:6002/api/configssos/8e3a49cd-5015-41fb-aace-d243cc591465";
const apiLogoutSSO = "https://dangnhap.moet.gov.vn/oidc/logout";

