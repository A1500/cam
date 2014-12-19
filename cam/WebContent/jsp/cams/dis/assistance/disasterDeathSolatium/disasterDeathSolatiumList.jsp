<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	response.setHeader("Pragma", "no-cache");

	/*是否可以编辑：true 不能编辑； false 可以编辑*/
	String isupdate = request.getParameter("isupdate");
	if (isupdate == null) {
		isupdate = "true";
	}
%>
<html>
<head>
<title>因灾死亡人员家庭抚慰金发放</title>
<next:ScriptManager />
<script language="javascript">
   			var userOrganCode = '<%=BspUtil.getOrganCode()%>';
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			 var organCode = '<%=BspUtil.getOrganCode()%>';
			 var organName = '<%=BspUtil.getOrganName()%>';
			 var struId='<%=BspUtil.getStruId()%>';
             var organType='<%=BspUtil.getOrganType()%>';
             var batchDetailId='<%=request.getParameter("batchDetailId")%>';
             var fillState='<%=request.getParameter("fillState")%>';
		</script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="disasterDeathSolatiumList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.dis.base.cmd.AssistanceQueryCommand"
		method="queryAssistance" global="true" pageSize="15">
		<model:record>
			<model:field name="INFO_ID" type="string" />
			<model:field name="RECORD_ID" type="string" />
			<model:field name="CHECK_ORGAN_CODE" type="string" />
			<model:field name="CHECK_ORGAN_NAME" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="DEAD_NAME" type="string" />
			<model:field name="DEAD_SEX" type="string" />
			<model:field name="DEAD_AGE" type="string" />
			<model:field name="DISASTER_TYPE" type="string" />
			<model:field name="APPROVAL_MONRY" type="string" />
			<model:field name="ACCEPT_DATE" type="string" />
			<model:field name="NOTE" type="string" />
			<model:field name="WORKFLOW_STATUS" type="string" />
			<!-- 流程跳转状态 -->
			<model:field type="string" name="areaName" />
			<!-- 行政区划名字供显示用 -->
			<model:field name="ID_CARD" type="string" />
			<!-- 身份证号码 -->
		</model:record>
	</model:dataset>
	<!-- 打印 -->
	<model:dataset id="printDs"
		cmd="com.inspur.cams.dis.base.cmd.AssistanceQueryCommand"
		method="queryAssistance" global="true">
		<model:record>
			<model:field name="INFO_ID" type="string" />
			<model:field name="RECORD_ID" type="string" />
			<model:field name="CHECK_ORGAN_CODE" type="string" />
			<model:field name="CHECK_ORGAN_NAME" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="DEAD_NAME" type="string" />
			<model:field name="DEAD_SEX" type="string" />
			<model:field name="DEAD_AGE" type="string" />
			<model:field name="DISASTER_TYPE" type="string" />
			<model:field name="APPROVAL_MONRY" type="string" />
			<model:field name="ACCEPT_DATE" type="string" />
			<model:field name="NOTE" type="string" />
			<model:field name="WORKFLOW_STATUS" type="string" />
			<!-- 流程跳转状态 -->
			<model:field type="string" name="areaName" />
			<!-- 行政区划名字供显示用 -->
			<model:field name="ID_CARD" type="string" />
			<!-- 身份证号码 -->
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 死者性别 -->
	<model:dataset id="CommSex" enumName="COMM.SEX" autoLoad="true"
		global="true">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">死者（失踪）姓名：</td>
				<td class="FieldInput"><input type="text" id="cx_deadName"
					class="TextEditor" title="死者姓名" />
				<td class="FieldLabel" nowrap>行政村:</td>
				<td class="FieldInput"><input type="text" style="width: 200"
					id="areaName" field="areaName" title="行政村" readonly="readonly" /> <input
					type="hidden" id="cx_villiageCode" class="TextEditor" title="行政村" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>

				<td class="FieldLabel">
				<button onclick="query()" id="search">查 询</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="disasterDeathSolatiumGrid"
	name="disasterDeathSolatiumGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="ds" autoExpandColumn="NOTE" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if (Boolean.valueOf(isupdate)) {
		%>
		<next:ToolBarItem text="添加" iconCls="add" handler="add" id="add" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="deleteBatch"
			id="deleteBatch" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="edit" id="edit" />
		<next:ToolBarItem text="全部提交" iconCls="select" handler="selectBatch"
			id="selectBatch" />
		<%
			}
		%>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"
			id="detail" />
		<next:ToolBarItem text="导出Excel" iconCls="export"  />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="NAME" header="户主姓名" field="NAME" width="90"></next:Column>
		<next:Column id="ID_CARD" header="户主身份证号码" field="ID_CARD" width="135"></next:Column>
		<next:Column id="CHECK_ORGAN_CODE" header="乡镇（街道）"
			field="CHECK_ORGAN_CODE" hidden="true"></next:Column>
		<next:Column id="CHECK_ORGAN_NAME" header="乡镇（街道）"
			field="CHECK_ORGAN_NAME" width="200"></next:Column>
		<next:Column id="DEAD_NAME" header="死者（失踪）姓名" field="DEAD_NAME"
			width="120"></next:Column>
		<next:Column id="DEAD_SEX" header="死者（失踪）性别" field="DEAD_SEX"
			width="120" dataset="CommSex"></next:Column>
		<next:Column id="DEAD_AGE" header="死者（失踪）年龄" field="DEAD_AGE"
			width="120"></next:Column>
		<next:Column id="DISASTER_TYPE" header="灾害种类" field="DISASTER_TYPE"
			width="90" dataset="DisDisasterType"></next:Column>
		<next:Column id="APPROVAL_MONRY" header="抚慰金数额（元）"
			field="APPROVAL_MONRY" width="120"></next:Column>
		<next:Column id="ACCEPT_DATE" header="填报日期" field="ACCEPT_DATE"
			width="90"></next:Column>
		<next:Column id="WORKFLOW_STATUS" header="提交状态"
			field="WORKFLOW_STATUS" width="90" dataset="ReliefinfoWorkflowState"></next:Column>
		<next:Column id="NOTE" header="备注" field="NOTE" width="120"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>