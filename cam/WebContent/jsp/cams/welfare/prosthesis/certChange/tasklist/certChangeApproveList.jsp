<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>受理任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script language="javascript">
	var procTypeId="prosthesisCertChange";
	//var act="现场勘查";
	var actId="<%=request.getParameter("actId")%>";
	var procDefUniqueId="8a898bf33f4080cd013f408cbf770006";	
	function setTaskState(value,a,rec)
	{
		var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
		var image="";
		//正常状态
		if(value=="0")
		{
			image="normal.png";
		}
		//预警状态
		else if(value=="1")
		{
			image="warn.png";
		}
		//超时状态
		else if(value=="2")
		{
			image="limit.png";
		}
	
		return '<img src="'+imagePath+image+'" />';
	}	
</script>
</head>
<body>
<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryDaiBan" autoLoad="false" global="true">
		<model:record>
			<model:field name="TASK_STATE" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="yiBanTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryYiBan" autoLoad="false" global="true">
		<model:record>
		</model:record>
	</model:dataset>
	<model:dataset id="endTaskDataset" cmd="com.inspur.cams.comm.workflow.taskinfo.cmd.TaskInfoQueryCmd" method="queryEnd" autoLoad="false" global="true">
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:TabPanel id="tab" activeTab="0" width="100%"  height="100%">
	<next:Tabs>
		<next:Panel title="待办任务" width="100%" height="100%">
			<next:Panel width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">
								<table border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">企业名称：</td>
						                <td class="FieldInput" style="width:40%"><input type="text" id="subjectDaiban" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="query()">查询</button></td>
									</tr>
								</table>
							</form>
						</div>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="daiBanTaskGridPanel" title="待办流程列表" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataset"  notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="办理" handler="forAccept"/>
					<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
		        	<next:Column header="状态" field="TASK_STATE" width="40" renderer="setTaskState" align="center">
							<next:TextField allowBlank="false"/>
						</next:Column>	
		        	<next:Column id="companyName" header="企业名称" field="COMPANY_NAME" width="150" ></next:Column>
		        	<next:Column id="legalPeople" header="法人代表" field="LEGAL_PEOPLE" width="150" ></next:Column>
		        	<next:Column id="economicNatureName" header="经济性质" field="ECONOMIC_NATURE_CODE" width="150" dataset="ecoDataSet"></next:Column>
		        	<next:Column id="licenseCode" header="营业执照编号" field="LICENSE_CODE" width="150" ></next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="150" ></next:Column>
					<next:Column id="actLimitTime" header="环节限时时间" field="ACT_LIMIT_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="actWarnTime" header="环节预警时间" field="ACT_WARN_TIME" width="150" renderer="renderDate" ></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="daiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
		<next:Panel title="已办任务" width="100%" height="100%">
			<next:Panel width="100%" border="0">
				<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">
								<table border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">企业名称：</td>
						                <td class="FieldInput" style="width:40%"><input type="text"  id="yibanSubject" style="width:40%"/></td>
										<td class="FieldButton" style="width:10%"><button onclick="queryyiban()">查询</button></td>
									</tr>
								</table>
							</form>
						</div>
					</fieldset>
				</next:Html>
			</next:Panel>
		
			<next:GridPanel id="yiBanTaskGridPanel" title="已办流程列表" name="yiBanTaskGridPanel" width="100%" height="100%" dataset="yiBanTaskDataset" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="select" text="查看" handler="handleyiban"/>
					<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showStateyiban"/>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>							
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
			        <next:Column id="companyName" header="企业名称" field="COMPANY_NAME" width="150" ></next:Column>
		        	<next:Column id="legalPeople" header="法人代表" field="LEGAL_PEOPLE" width="150" ></next:Column>
		        	<next:Column id="economicNatureName" header="经济性质" field="ECONOMIC_NATURE_CODE" width="150" dataset="ecoDataSet"></next:Column>
		        	<next:Column id="licenseCode" header="营业执照编号" field="LICENSE_CODE" width="150" ></next:Column>
		        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="150" ></next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="endTime" header="任务完成时间" field="END_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="150" ></next:Column>
					<next:Column id="activeOrganNames" header="当前环节处理人" field="ACTIVE_ORGAN_NAMES" width="150" ></next:Column>
					<next:Column id="activeActDefNames" header="当前活动环节" field="ACTIVE_ACT_DEF_NAMES" width="150" ></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="yiBanTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
			
		<next:Panel title="结束任务" width="100%" height="100%">
			<next:Panel width="100%" border="0">	
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form class="L5form">
							<table  border="1" width="100%">
								<tr>
								 	<td class="FieldLabel" style="width:10%">企业名称：</td>
					                <td class="FieldInput" style="width:40%"><input type="text" id="endSubject" style="width:40%"/></td>
									<td class="FieldButton" style="width:10%"><button onclick="queryEnd()">查询</button></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="endTaskGridPanel" title="结束流程列表" dataset="endTaskDataset" width="100%" height="100%"  stripeRows="true" notSelectFirstRow="true">
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="查看" handler="handleEnd"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showStateEnd"/>
				</next:TopBar>
				<next:Columns>
	   				<next:RowNumberColumn/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="processId" header="流程实例ID" field="PROCESS_ID" hidden="true" ></next:Column>					
					<next:Column id="assignmentId" header="内码" field="ID" hidden="true" ></next:Column>
		        	<next:Column id="companyName" header="企业名称" field="COMPANY_NAME" width="150" ></next:Column>
		        	<next:Column id="legalPeople" header="法人代表" field="LEGAL_PEOPLE" width="150" ></next:Column>
		        	<next:Column id="economicNatureName" header="经济性质" field="ECONOMIC_NATURE_CODE" width="150" dataset="ecoDataSet"></next:Column>
		        	<next:Column id="licenseCode" header="营业执照编号" field="LICENSE_CODE" width="150" ></next:Column>
		        	<next:Column id="procDefName" header="流程名称" field="PROC_DEF_NAME" width="150" ></next:Column>
					<next:Column id="endTime" header="办理时间" field="END_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="150"  renderer="renderDate" ></next:Column>
					<next:Column id="procEndTime" header="流程结束时间" field="PROC_END_TIME" width="150" renderer="renderDate" ></next:Column>
					<next:Column id="actDefName" header="已办环节" field="ACT_DEF_NAME" width="150" ></next:Column>		
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="endTaskDataset" />
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>			
	</next:Tabs>
</next:TabPanel>

</body>
<script language="javascript" type="text/javascript">
//查询条件面板打开合并函数
function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
var act="";
function init(){
	
	if(actId=="1"){
		act="现场勘查";
	}else if(actId=="2"){
		act="主管审核";
	}else if(actId=="3"){
		act="处长审核";
	}else if(actId=="4"){
		act="主管厅长审批";
	}else if(actId=="5"){
		act="补齐补正";
	}
	daiBanDataset.setParameter("processType",procTypeId);	
	daiBanDataset.setParameter("actDefName",act);
	daiBanDataset.setParameter("tableName","WEAL_FIT_INFO");
	daiBanDataset.setParameter("tableKey","TASK_CODE");
	daiBanDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
	daiBanDataset.load();
	yiBanTaskDataset.setParameter("processType",procTypeId);	
	yiBanTaskDataset.setParameter("actDefName",act);
	yiBanTaskDataset.setParameter("tableName","WEAL_FIT_INFO");
	yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
	yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
	yiBanTaskDataset.load();
	endTaskDataset.setParameter("processType",procTypeId);	
	endTaskDataset.setParameter("actDefName",act);
	endTaskDataset.setParameter("tableName","WEAL_FIT_INFO");
	endTaskDataset.setParameter("tableKey","TASK_CODE");
	endTaskDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
	endTaskDataset.load();
	L5.QuickTips.init();			
}
//待办任务查询
function query(){
	var subjectDaiban=document.getElementById('subjectDaiban').value;
	if(subjectDaiban==''){
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.setParameter("tableName","WEAL_FIT_INFO");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
		daiBanDataset.load();
	}else{
		daiBanDataset.setParameter("processType",procTypeId);	
		daiBanDataset.setParameter("actDefName",act);
		daiBanDataset.setParameter("tableName","WEAL_FIT_INFO");
		daiBanDataset.setParameter("tableKey","TASK_CODE");
		daiBanDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
		daiBanDataset.setParameter("mysetwhere","COMPANY_NAME@LIKE:%"+subjectDaiban+"%");
		daiBanDataset.load();
	}
	
}
//查看待办流程图
function showState(){
	var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
	var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//已办任务查询
function queryyiban(){
	var yibanSubject=document.getElementById('yibanSubject').value;
	if(yibanSubject==''){
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",act);
		yiBanTaskDataset.setParameter("tableName","WEAL_FIT_INFO");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
		yiBanTaskDataset.load();
	}else {
		yiBanTaskDataset.setParameter("processType",procTypeId);	
		yiBanTaskDataset.setParameter("actDefName",act);
		yiBanTaskDataset.setParameter("tableName","WEAL_FIT_INFO");
		yiBanTaskDataset.setParameter("tableKey","TASK_CODE");
		yiBanTaskDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
		yiBanTaskDataset.setParameter("mysetwhere","COMPANY_NAME@LIKE:%"+yibanSubject+"%");
		yiBanTaskDataset.load();	
	}
}
//查看已办任务
function handleyiban(){
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var taskCode = rec.get("TASK_CODE");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/yiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&taskCode="+taskCode;
	L5.forward(url+query);
}
//查看已办流程图
function showStateyiban(){
	var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
	var selecteds=yiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var assignmentId=selecteds[0].get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
//查询结束任务
function queryEnd(){
	var endSubject=document.getElementById("endSubject").value;
	if(endSubject==''){
		endTaskDataset.setParameter("processType",procTypeId);	
		endTaskDataset.setParameter("actDefName",act);
		endTaskDataset.setParameter("tableName","WEAL_FIT_INFO");
		endTaskDataset.setParameter("tableKey","TASK_CODE");
		endTaskDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
		endTaskDataset.load();	
	}else {
		endTaskDataset.setParameter("processType",procTypeId);	
		endTaskDataset.setParameter("actDefName",act);
		endTaskDataset.setParameter("tableName","WEAL_FIT_INFO");
		endTaskDataset.setParameter("tableKey","TASK_CODE");
		endTaskDataset.setParameter("applyShowColum","TASK_CODE,COMPANY_NAME,LEGAL_PEOPLE,ECONOMIC_NATURE_CODE,LICENSE_CODE");
		endTaskDataset.setParameter("mysetwhere","COMPANY_NAME@LIKE:%"+endSubject+"%");
		endTaskDataset.load();	
	}
}
//查看结束任务
function handleEnd(){
	var userGrid=L5.getCmp("endTaskGridPanel");
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var processId=rec.get("PROCESS_ID");
	var actDefUniqueId=rec.get("ACT_DEF_UNIQUE_ID");
	var assignmentId=rec.get("ID");
	var taskCode = rec.get("TASK_CODE");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&taskCode="+taskCode;
	L5.forward(url+query);
}
//查看流程状态图
function showStateEnd(){
   var endTaskGridPanel=L5.getCmp("endTaskGridPanel");
   var selecteds=endTaskGridPanel.getSelectionModel().getSelections();
   if(selecteds.length!=1){
      L5.Msg.alert("提示","请选择一条您要查看的记录");
	  return false;
	}
   var assignmentId=selecteds[0].get("ID");
   var url="jsp/workflow/monitor/flowview.jsp?assignmentId="+assignmentId;
   var text = "流程状态";
   L5.forward(url,text);
}
// 受理页面
function forAccept(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	var assignmentId = rec.get("ID");
	var processId = rec.get("PROCESS_ID");
	var taskCode = rec.get("TASK_CODE");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&taskCode="+taskCode;
	//var url='jsp/cams/welfare/prosthesis/apply/prosthesisQualification/applytask/qualificationApprove.jsp?taskCode='+selected[0].get("TASK_CODE");
	L5.forward(url+query);
}
// 修改页面
function forUpdate(){
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selecteds=userGrid.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	var rec=selecteds[0];
	var assignmentId = rec.get("ID");
	var processId = rec.get("PROCESS_ID");
	var taskCode = rec.get("TASK_CODE");
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/newTaskForward";
	var query="?assignmentId="+assignmentId+"&processId="+processId+"&taskCode="+taskCode;
	L5.forward(url);
}

Date.prototype.pattern=function(fmt) {        
    var o = {        
    "M+" : this.getMonth()+1, //月份        
    "d+" : this.getDate(), //日        
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时        
    "H+" : this.getHours(), //小时        
    "m+" : this.getMinutes(), //分        
    "s+" : this.getSeconds(), //秒        
    "q+" : Math.floor((this.getMonth()+3)/3), //季度        
    "S" : this.getMilliseconds() //毫秒        
    };        
    var week = {        
    "0" : "/u65e5",        
    "1" : "/u4e00",        
    "2" : "/u4e8c",        
    "3" : "/u4e09",        
    "4" : "/u56db",        
    "5" : "/u4e94",        
    "6" : "/u516d"       
    };        
    if(/(y+)/.test(fmt)){        
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));        
    }        
    if(/(E+)/.test(fmt)){        
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);        
    }        
    for(var k in o){        
        if(new RegExp("("+ k +")").test(fmt)){        
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));        
        }        
    }        
    return fmt;        
}      
    
function renderDate(value,cellmeta,record) {
	var revalue="";
	revalue+= value.substr(0,4)+"-";
	revalue+= value.substr(4,2)+"-";
	revalue+= value.substr(6,2);
	revalue+= value.substr(8,6);
	return revalue;
			
}

</script>
</html>