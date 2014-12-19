<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>过渡性生活补助</title>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifFill = '<%=request.getParameter("ifFill")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     
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
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="gdList.js"></script>
</head>
<body>
<model:datasets>
	<!--批次明细-以乡镇为单位(单条)-->
	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		method="queryBatchDetailSums" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!-- 档案信息 -->
	<model:dataset id="infoDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd"
		global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害类型 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
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
				<td class="FieldLabel">村名称:</td>
				<td class="FieldInput"><input type="text"
					id="qAcceptAreaName" class="TextEditor" title="行政村（社区）"
					style="width: 200" /> <input type="hidden" id="qAcceptAreaCode"
					class="TextEditor" title="村名称" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>
				<td class="FieldLabel" colspan="2">
				<button onclick="query()" id="search">查 询</button>
				&nbsp;&nbsp;
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="gdGrid" name="gdGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="infoDs" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="添加" iconCls="add" handler="add" id="btnAdd" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="edit" id="btnEdit" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="deleteInfo"
			id="btnDelete" />
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"
			id="btnDetail" />
		<next:ToolBarItem text="汇总" iconCls="yes" handler="sums"
			id="btnSum" />
		<next:ToolBarItem text="导入Excel" iconCls="import" handler="forImport" id="btnImport"/>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="forExcel"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="infoId" header="id" field="infoId" width="90" hidden="true"></next:Column>
		<next:Column id="name" header="户主姓名" field="name" width="90"></next:Column>
		<next:Column id="idCard" header="身份证号码" field="idCard" width="135"></next:Column>
		<next:Column id="acceptAreaName" header="村名称" field="acceptAreaName" width="190">
			<next:TextField />
		</next:Column>
		
		<next:Column id="familyNum" header="家庭人口(人)" field="familyNum"
			width="90" align="right"></next:Column>
		<next:Column id="familyRegister" header="户口类型"
			field="familyRegister" width="80" dataset="DisFamilyRegister" align="center"></next:Column>
		<next:Column id="familyType" header="家庭类型"
			field="familyType" width="80" dataset="DisFamilyType" align="center"></next:Column>

		<next:Column id="approvalFood" header="核准救助口粮（公斤）"
			field="approvalFood" width="130">
			<next:TextField />
		</next:Column>

		<next:Column id="approvalClothes" header="核准救助衣被（件）"
			field="approvalClothes" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="approvalMoney" header="核准救助资金（元）"
			field="approvalMoney" width="120">
			<next:NumberField />
		</next:Column>

		<next:Column id="acceptPeopleName" header="村填报人姓名"
			field="acceptPeopleName" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="acceptDate" header="村填报日期" field="acceptDate"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="checkOrganName" header="乡镇（街道）名称"
			field="checkOrganName" width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="checkPeopleName" header="乡镇（街道）审核人名称"
			field="checkPeopleName" width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="checkDate" header="审核日期" field="checkDate" width="90"
			hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="organName" header="填报单位名称" field="organName"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="fillTime" header="填报时间" field="fillTime" width="90"
			hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="workflowStatus" header="审核状态" field="workflowStatus"
			dataset="ReliefinfoWorkflowState" width="90">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>

<!-- 汇总窗口 -->
<next:Window id="sumWin" closeAction="hide" title="汇总窗口" height="220"
	width="666" modal="true" resizable="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<fieldset>
		<form id="gdForm" method="post" dataset="batchDetailds"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭人口:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><label
					field="FAMILY_NUM" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_FOOD" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_FOOD_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_CLOTHES" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_CLOTHES_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准救助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_MONEY" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_MONEY_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Window>