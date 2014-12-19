<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>电子监察超时监控</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script type="text/javascript">

</script>
<body>

<model:datasets>
	<!-- 待办任务 -->
	<model:dataset  id="ds" cmd="com.inspur.cams.welfare.dzjc.monitor.cmd.DzjcWealMonitorCmd" method="queryMonitorUnitData"  global="true">
	</model:dataset>
	<!-- 基本意见 -->
	<model:dataset id="wealBaseOpinionDs" enumName="WEAL.BASE_OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
			<next:Panel>
				<next:GridPanel id="daiBanTaskGridPanel" title="业务超时监控" dataset="ds" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="状态" field="LIMIT_DAYS" width="40" renderer="setTaskState" align="center">
								<next:TextField allowBlank="false"/>
						</next:Column>	
						<next:Column id="companyName" header="企业名称" field="COMPANY_NAME" width="200"></next:Column>
						<next:Column id="applyType" header="流程类型" field="APPLY_TYPE" width="120" renderer="setProcType"></next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="PROC_CREATE_TIME" width="120" renderer="renderDate" ></next:Column>
						<next:Column id="actDefName" header="当前环节" field="ACT_DEF_NAME" width="100" ></next:Column>
						<next:Column id="limitDays" header="距离超时天数" field="LIMIT_DAYS" width="100" ></next:Column>
						<next:Column id="actLimitTime" header="环节限时时间" field="ACT_LIMIT_TIME" width="120" renderer="renderDate" ></next:Column>
						<next:Column id="actWarnTime" header="环节预警时间" field="ACT_WARN_TIME" width="120" renderer="renderDate" ></next:Column>
						<next:Column id="curActivity" header="上一环节" field="CUR_ACTIVITY" width="120" ></next:Column>
						<next:Column id="curOpinionId" header="上一环节意见" field="CUR_OPINION_ID" width="120" dataset="wealBaseOpinionDs"></next:Column>
						<next:Column id="curPeopleName" header="上一环节处理人" field="CUR_PEOPLE_NAME" width="120" ></next:Column>
						<%--
						<next:Column id="processType" header="流程类型" field="processType" width="200" ></next:Column>
						<next:Column id="toDateDays" header="距离超时天数" field="toDateDays" width="100" ></next:Column>
			        	<next:Column id="acceptTime" header="受理时间" field="acceptTime" width="150" ></next:Column>
			        	<next:Column id="toDate" header="超时到期时间" field="toDate" width="150" ></next:Column>
						<next:Column id="GDBLSX" header="规定超时时限" field="GDBLSX" width="150" ></next:Column>
						<next:Column id="curActivity" header="当前环节" field="curActivity" width="150" ></next:Column>
						<next:Column id="curPerson" header="当前处理人" field="curPerson" width="150" ></next:Column>
						<next:Column id="task_code" header="业务编号" field="task_code" width="150" ></next:Column>
						
						<next:Column id="curActivity" header="上一环节" field="curActivity" width="150" ></next:Column>
						<next:Column id="curOpinionId" header="上一环节意见" field="curOpinionId" width="150" ></next:Column>
						<next:Column id="curPeopleName" header="上一环节处理人" field="curPeopleName" width="150" ></next:Column>
						<next:Column id="task_code" header="业务编号" field="TASK_CODE" width="180" ></next:Column>
						--%>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="ds" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
</next:ViewPort>

</body>
<script language="javascript"  type="text/javascript" >
function init(){
	ds.load();
	ds.on("load",function(d){
		d.getCount();
	});
}
function setTaskState(value,a,rec)
	{
		var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
		var image="";
		//正常状态，不到两天
		if(value>3)
		{
			image="normal.png";
		}
		//预警状态,两天预警
		else if(value<=3&&value>=0)
		{
			image="warn.png";
		}
		//超时状态
		else if(value<0)
		{
			image="limit.png";
		}
	
		return '<img src="'+imagePath+image+'" />';
	}
function setProcType(value,a,rec){
	var procType="";
	if(value==1)
	{
		procType="资格认定";
	}
	//预警状态,两天预警
	else if(value==2)
	{
		procType="年检";
	}
	//超时状态
	return procType;
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