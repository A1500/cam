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
	<model:dataset  id="ds" cmd="com.inspur.cams.sorg.dzjc.monitor.cmd.DzjcSomMonitorCmd" method="queryMonitorData"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.dzjc.monitor.data.DzjcSomMonitor">
			<model:field name="sorgName" type="string"/>
			<model:field name="acceptTime" type="string"/>
			<model:field name="toDate" type="string"/>
			<model:field name="GDBLSX" type="string"/>
			<model:field name="curActivity" type="string"/>
			<model:field name="curPerson" type="string"/>
			<model:field name="PROCESSTYPE" type="string"/>
			<model:field name="toDateDays" type="string"/>
			<model:field name="task_code" type="string"/>
			<model:field name="processType" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
			<next:Panel>
				<next:GridPanel id="daiBanTaskGridPanel" title="业务超时监控" dataset="ds" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="状态" field="toDateDays" width="40" renderer="setTaskState" align="center">
								<next:TextField allowBlank="false"/>
						</next:Column>	
						<next:Column id="sorgName" header="社会组织名称" field="sorgName" width="200"></next:Column>
						<next:Column id="processType" header="流程类型" field="processType" width="200" ></next:Column>
						<next:Column id="toDateDays" header="距离超时天数" field="toDateDays" width="100" ></next:Column>
			        	<next:Column id="acceptTime" header="受理时间" field="acceptTime" width="150" ></next:Column>
			        	<next:Column id="toDate" header="超时到期时间" field="toDate" width="150" ></next:Column>
						<next:Column id="GDBLSX" header="规定超时时限" field="GDBLSX" width="150" ></next:Column>
						<next:Column id="curActivity" header="当前环节" field="curActivity" width="150" ></next:Column>
						<next:Column id="curPerson" header="当前处理人" field="curPerson" width="150" ></next:Column>
						<next:Column id="task_code" header="业务编号" field="task_code" width="150" ></next:Column>
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
		else if(value<3&&value>=0)
		{
			image="warn.png";
		}
		//超时状态
		else if(value<0)
		{
			image="limit.png";
		}
		else if(value=="补齐补正清零")
		{
			image="normal.png";
		}
	
		return '<img src="'+imagePath+image+'" />';
	}
</script>

</html>