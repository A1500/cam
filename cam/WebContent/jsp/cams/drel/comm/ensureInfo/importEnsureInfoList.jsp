<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>核查业务反馈列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="importEnsureInfoList.js"></script>
<script type="text/javascript">
function setTaskState(value,a,rec)
{
	var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
	var image="";
	var str="";
	if(value==""){
		value=0;
	}
	//正常状态
	if(rec.get("ENSURE_PROPERTY")<=value)
	{
		image="normal.png";
		str = '<img src="'+imagePath+image+'" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="green">标准以下</font>';
	}
	//预警状态
	else if(rec.get("ENSURE_PROPERTY")>value&&rec.get("ENSURE_PROPERTY")<value*1.1)
	{
		image="warn.png";
		str = '<img src="'+imagePath+image+'" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="yellow">标准警戒</font>';
	}
	//超时状态
	else if(rec.get("ENSURE_PROPERTY")>=value*1.1)
	{
		image="limit.png";
		str = '<img src="'+imagePath+image+'" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">标准以上</font>';
	}

	return str;
}

function getCheckFlg(value,a,rec)
{
		//var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
	//	var image="";
	var str="";
	if(value=="")
	{
		str="否";
	}
	else{
		//str='<a href="javascript:detail(\''+value+'\')">'+是+'</a>';
		str="是";
	}
	
		return str;
}
function detail(familyId){
	var data=new L5.Map();
	data.put("familyId",familyId);
	url="jsp/cams/drel/comm/ensureInfo/deadPeopleInfoList.jsp";
	L5.forward(url,'',data);
   
}

function showDead(){
	var grid = L5.getCmp('grid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records[0].get("IS_DEAD")==""){
		L5.Msg.alert("提示","该家庭，没有死亡人员！");
		return;
	}
	if(records.length==1){
		var familyId=records[0].get("IS_DEAD");
		var url = "deadPeopleInfoList.jsp?familyId="+familyId;
		var width = "1200";
	   var height = "500";
		   //var width = screen.availWidth;
		   //var height = screen.availHeight;
		var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
		if(true || returnValue) {
			//reQuery();
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ensureToClientDataSet" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" method="queryInfo" pageSize="200">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">反馈时间：</td>
					<td class="FieldInput" style="width:36%"><input id="feedBackTime"/></td>
					<td class="FieldButton" style="width:20%">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="ensureToClientDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export"  text="导入核对信息" handler="importEnsureInfo"/>
		<next:ToolBarItem iconCls="export"  text="查看死亡人员" hidden="true" handler="showDead"/>  
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="ensureId" header="业务主键" width="15%" hidden="true" sortable="false"/>
		<next:Column field="historyInfoId" header="历史信息主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="applyId" header="委托业务" hidden="true" width="15%" sortable="false"/>
		<next:Column field="commissionId" header="核查业务" hidden="true" width="15%" sortable="false"/>
		<next:Column field="acceptUnitId" header="接收单位主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="LOW_STANDARDS" header="核对参考标准" width="15%"  sortable="false" renderer="setTaskState"/>
		<next:Column field="ACCEPT_UNIT" header="接收单位" width="15%" sortable="false"/>
		<next:Column field="AREACODE" header="所属行政区划代码" hidden="true" width="15%" sortable="false"/>
		<next:Column field="AREA_NAME" header="所属行政区划名称" width="15%" sortable="false"/>
		<next:Column field="FAMILY_NAME" header="户主姓名" width="15%" sortable="false"/>
		<next:Column field="FAMILY_ID_CARD" header="户主身份证号" width="15%" sortable="false"/>
		<next:Column field="ENSURE_UNIT_ID" header="核查单位主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="ENSURE_UNIT" header="核查单位" width="15%" sortable="false"/>
		<next:Column field="ENSURE_INCOME" header="核查收入" width="15%" sortable="false"/>
		<next:Column field="ENSURE_EXPEND" header="核查支出" width="15%" sortable="false"/>
		<next:Column field="ENSURE_PROPERTY" header="核查财产" width="15%" sortable="false"/>
		<next:Column field="FEEDBACK_TIME" header="反馈时间" width="15%" sortable="false"/>
		<next:Column field="FEEDBACK_RESULT" header="反馈结果" width="15%" sortable="false"/>
		<next:Column field="IS_DEAD" header="是否存在死亡成员"  width="140" align="center" renderer="getCheckFlg"></next:Column>
		<next:Column field="readStatus" header="查看标示" hidden="true" width="15%" sortable="false"/>
		<next:Column field="inOutStatus" header="导入导出标识" hidden="true" width="15%" sortable="false"/>
		<next:Column field="currentStatus" header="当前标识" hidden="true" width="15%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ensureToClientDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>