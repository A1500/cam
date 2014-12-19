function init() {
	var layout = L5.getCmp("cards").getLayout();
	layout.setActiveItem(0);
	//L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
}

/**
 * 获取页面输入域值，并对空进行处理
 * @param ElementId
 * @returns
 */
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

/**
 * 事件处理：点击查询按钮
 */
function query(){
	var userId=getParam("userId");
	var startTime=getParam("pmStartTime_id");
	var endTime=getParam("pmEndTime_id");
	var moduleCode=getParam("moduleCode");
	var functionCode=getParam("functionCode");
	var operationCode=getParam("operationCode");
	if(userId==undefined&&startTime==undefined&&endTime==undefined&&moduleCode==undefined&&functionCode==undefined&&operationCode==undefined){
		L5.Msg.alert('提示',"请填写查询条件!");
		return false;
	}else if(startTime==undefined||endTime==undefined){
		L5.Msg.alert('提示',"请选择时间段!");
		return false;
	}
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("userId",userId);
	ds.setParameter("startTime",startTime);
	ds.setParameter("endTime",endTime);
	ds.setParameter("operationCode",operationCode);
	ds.setParameter("functionCode",functionCode);
	ds.setParameter("moduleCode",moduleCode);
	//重新加载ds
	ds.load();
}

function reset(){
	document.getElementById("userId").value="";
	document.getElementById("startTime").value="";
	document.getElementById("endTime").value="";
	document.getElementById("operationCode").value="";
	document.getElementById("functionCode").value="";
	document.getElementById("moduleCode").value="";
}


/**
 * 事件处理：点击批量删除按钮
 */
function del(){
	
	var url="jsp/bsp/audit/fordelete.jsp";
	var text='批量删除日志';
	L5.forward(url,text);
	
}

function detail(){
	 var grid=L5.getCmp('editGridPanel');
	 var selected = grid.getSelectionModel().getSelections();
	   if(selected.length!=1){
			L5.Msg.alert("提示","请选择一条记录!");
			return false;
		}else{
		  var record=selected[0];
		  var userId=record.get("USER_ID");
		  if(userId!=null&&userId!=undefined){
			  var command=new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserCmd");
			  command.setParameter("userId",userId);
			  command.execute("getDeptNameAndCorpNameByUserId");
			  record.set("deptName",command.getReturn("deptName"));
			  record.set("corpName",command.getReturn("corpName"));
		  }
		  var logId=record.get("logId");
		  var logDs=L5.DatasetMgr.lookup("logDs");
		  logDs.removeAll();
		  logDs.add(record);
		  var layout = L5.getCmp("cards").getLayout();
		   layout.setActiveItem(1);
		}
}

//返回按钮
function back2list(){
  var layout = L5.getCmp("cards").getLayout();
  layout.setActiveItem(0);
}

function selectModule(){
	var revalue=window.showModalDialog("../permit/pap/function/functionhelp.jsp?choiceType=module&isCheckBox=0","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list=revalue.split(";");
		var moduleCode=list[0];
		var moduleName=list[1];
		document.getElementById("moduleCode").value=list[0];
		L5.fly('moduleName').dom.value=list[1];
		L5.fireEvent("moduleName","blur");
	}
}
function selectFunction(){
	var revalue=window.showModalDialog("../permit/pap/function/functionhelp.jsp?choiceType=function&isCheckBox=0","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list=revalue.split(";");
		var functionCode=list[0];
		var functionName=list[1];
		document.getElementById("functionCode").value=list[0];
		L5.fly('functionName').dom.value=list[1];
		L5.fireEvent("functionName","blur");
	}
}

function selectOperation(){
	var revalue=window.showModalDialog("../permit/pap/function/functionhelp.jsp?choiceType=operation&isCheckBox=0","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list=revalue.split(";");
		var functionCode=list[0];
		var functionName=list[1];
		document.getElementById("operationCode").value=list[0];
		L5.fly('operationName').dom.value=list[1];
		L5.fireEvent("operationName","blur");
	}
}

