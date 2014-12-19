/////////////////////////////////////////////////////
//                                                 //
//             js helper for bpm5                  //
//                                                 //
/////////////////////////////////////////////////////
putProcessInfoIntoContext();
function putProcessInfoIntoContext()
{
	var parameters=document.URL.split("?");
	if(parameters.length>0)
	{
		var keyValues=parameters[1].split("&");
		for ( var i = 0; i < keyValues.length; i++) {
			var keyValue = keyValues[i].split("=");
			if (keyValue.length == 2) {
				var key = keyValue[0];
				var value = keyValue[1];
				if (key == "procDefUniqueId" || key == "startActDefUniqueId"
						|| key == "assignmentId" || key == "selectedOrganId"
						|| key =="selectedOrganName") {
					L5.setCP(key, value);
				}
			}
		}
	}
}

function getProcessInfoFromContext(key){
	return L5.Command.context.get(key);
}
// [start activity] select and send
function selectNextActivitiesAndPartiesFromStartAct() {
	var url =L5.webPath+"/jsp/workflow/help/selectnextactivitiesandpartiesfromstartact.jsp?procDefUniqueId="
		+getProcessInfoFromContext("procDefUniqueId")+"&startActDefUniqueId="+getProcessInfoFromContext("startActDefUniqueId");
	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToNextActivity(returnValue);
}

// [start activity] select and send(display employees)
function selectNextActivitiesAndEmployeesFromStartAct() {
	var url =L5.webPath+"/jsp/workflow/help/selectnextactivitiesandemployeesfromstartact.jsp?procDefUniqueId="
		+getProcessInfoFromContext("procDefUniqueId")+"&startActDefUniqueId="+getProcessInfoFromContext("startActDefUniqueId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToNextActivity(returnValue);
}
// [middle activity] select and send
function selectNextActivitiesAndParties() {
    var url =L5.webPath+"/jsp/workflow/help/selectnextactivitiesandparties.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");
	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToNextActivity(returnValue);
}
// [middle activity] select and send(display employees)
function selectNextActivitiesAndEmployees() {
    var url =  L5.webPath+"/jsp/workflow/help/selectnextactivitiesandemployees.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");
	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToNextActivity(returnValue);
}
//[middle activity] select and send(display employees)
function selectNextActivitiesAndEmployeesIncludeCurrentActivity() {
    var url =  L5.webPath+"/jsp/workflow/help/selectnextactivitiesandemployeesincludecurrentactivity.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");
	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToNextActivity(returnValue);
}
// [middle activity] select and jump
function selectJumpActivitiesAndParties() {
	var url = L5.webPath+"/jsp/workflow/help/selectjumpactivitiesandparties.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToNextActivity(returnValue);
}
// [middle activity] select and jump(display employees)
function selectJumpActivitiesAndEmployees() {
    var url = L5.webPath+"/jsp/workflow/help/selectjumpactivitiesandemployees.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	// assign values to the hidden fields
	assignValueToNextActivity(returnValue);
}
// [middle activity] select and rollback 
function selectHistoryActivitiesAndParties() {
   var url = L5.webPath+"/jsp/workflow/help/selecthistoryactivitiesandparties.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToBackActivity(returnValue);
}
// [middle activity] select and rollback (display employees)
function selectHistoryActivitiesAndEmployees() {
   var url = L5.webPath+"/jsp/workflow/help/selecthistoryactivitiesandemployees.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToBackActivity(returnValue);
}
//[middle activity] select and rollback (display actualhandler)
function selectHistoryActivitiesAndActualHandler() {
   var url = L5.webPath+"/jsp/workflow/help/selecthistoryactivitiesandactualhandler.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToBackActivity(returnValue);
}
//[middle activity] select and rollback (display actualhandler)
function selectHistoryActivitiesAndActualHandlerIncludeCurrentActivity() {
   var url = L5.webPath+"/jsp/workflow/help/selecthistoryactivitiesandactualhandlerincludecurrentactivity.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");

	var returnValue = showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToBackActivity(returnValue);
}
//[middle activity] in activity freesend (display stru)
function selectCurrentActivityEmployees() {
	var url=L5.webPath+"/jsp/workflow/help/selectcurrentactivityemployees.jsp?assignmentId="
				+ getProcessInfoFromContext("assignmentId");
	
	var returnValue = showModalDialog(url, window,
	"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToCurrentActivity(returnValue);
}

//[middle activity] in activity freesend (display stru)
function selectLoopSend() {
	var url=L5.webPath+"/jsp/workflow/help/selectloopsend.jsp"

	var returnValue = showModalDialog(url, window,
	"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToCurrentActivity(returnValue);
}
//[middle activity] in activity freesend (display stru)
function selectLoopSendDisplayByGrid() {
	var url=L5.webPath+"/jsp/public/help/help.jsp?helpCode=bsp_employeelistquery"

	var returnValue = showModalDialog(url, window,
	"scroll:no;status:no;dialogWidth:500px;dialogHeight:400px");
	assignValueToCurrentActivity(returnValue);
}
//assign value to the current activity
function assignValueToCurrentActivity(returnValue) {
	if (!returnValue){
		return;
	}
	L5.setCP("selectedOrganId", returnValue[0]);
	L5.setCP("selectedOrganName", returnValue[1]);
}

// assign value to the next activity
function assignValueToNextActivity(returnValue) {
	if (!returnValue){
		return;
	}
	L5.setCP("nextActDefUniqueId", returnValue[0]);
	L5.setCP("nextActOrganIds", returnValue[1]);
	L5.setCP("nextActOrganNames", returnValue[2]);
	L5.setCP("nextActDefId", returnValue[3]);
}

//assign value to the rollback activity
function assignValueToBackActivity(returnValue) {
	if (!returnValue){
		return;
	}
	L5.setCP("backActDefUniqueId", returnValue[0]);
	L5.setCP("backActOrganIds", returnValue[1]);
	L5.setCP("backActOrganNames", returnValue[2]);
	L5.setCP("backActDefId", returnValue[3]);
}