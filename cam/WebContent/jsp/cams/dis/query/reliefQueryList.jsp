<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救助档案查询</title>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifPrint = '<%=request.getParameter("ifPrint")%>';
     var ifDetail = '<%=request.getParameter("ifDetail")%>';
     var ifFill = '<%=request.getParameter("ifFill")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     var doleId = '<%=request.getParameter("doleId")%>';
     
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
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="reliefQueryList.js"></script>
</head>
<body>
<model:datasets>
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" global="true"
		pageSize="15">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<!--灾害类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="doleDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleDetailQueryCmd"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefDoleDetail">
		</model:record>
	</model:dataset>

	<!--拨付使用资金关系表-->
	<model:dataset id="disFundsBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd"
		method="queryFundsBatchSource" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs"
		enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
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
				<td class="FieldLabel">救助类型:</td>
				<td class="FieldInput"><select type="text" id="reliefType"
					class="TextEditor" title="RELIEF_TYPE" style="width: 160"/>
					<option dataset="ReliefTypeDataset"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel">户主姓名:</td>
				<td class="FieldInput"><input type="text" id="qName"
					class="TextEditor" title="户主姓名" /></td>
				<td class="FieldLabel">身份证号码:</td>
				<td class="FieldInput"><input type="text" id="qIdCard"
					class="TextEditor" title="身份证号码" style="width: 200" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">户口类型:</td>
				<td class="FieldInput"><select type="text" id="qFamilyRegister"
					class="TextEditor" />
					<option dataset="DisFamilyRegister"></option>
				</select></td>
				<td class="FieldLabel">家庭类型:</td>
				<td class="FieldInput"><select type="text" id="qFamilyType"
					class="TextEditor" />
					<option dataset="DisFamilyType"></option>
				</select></td>
				<td class="FieldLabel">家庭人口:</td>
				<td class="FieldInput"><input type="text" id="qFamilyNumStart"
					class="TextEditor" title="家庭人口最小人数"
					style="width: 30; text-align: right;" maxlength="2" value="1" />~
				<input type="text" id="qFamilyNumEnd" class="TextEditor"
					title="家庭人口最大人数" style="width: 30; text-align: right;"
					maxlength="2" />人</td>
				
			</tr>
			<tr>
				<td class="FieldLabel">核准救助时段:</td>
				<td class="FieldInput"><input type="text"
					id="qApprovalTimesStart" class="TextEditor" title="核准救助时段最少月数"
					style="width: 30; text-align: right;" maxlength="2" value="1" />~
				<input type="text" id="qApprovalTimesEnd" class="TextEditor"
					title="核准救助时段最大月数" style="width: 30; text-align: right;"
					maxlength="2" />月</td>
				<td class="FieldLabel">行政村（社区）:</td>
				<td class="FieldInput"><input type="text"
					id="qAcceptAreaName" class="TextEditor" title="行政村（社区）"
					style="width: 200" /> <input type="hidden" id="qAcceptAreaCode"
					class="TextEditor" title="行政村（社区）" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>
				<td class="FieldLabel" colspan="2">
				<button onclick="query()" id="search">查 询</button>
				&nbsp;&nbsp;
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="dcGrid" name="dcGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="infoDs" notSelectFirstRow="true" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="btnDetail" text="查看救助明细" iconCls="detail" handler="cardInfo" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="name" header="户主姓名" field="name" width="90"></next:Column>
		<next:Column id="idCard" header="身份证号码" field="idCard" width="135"></next:Column>
		<next:Column id="acceptAreaName" header="行政村（社区）"
			field="acceptAreaName" width="170"></next:Column>

		<next:Column id="familyNum" header="家庭人口(人)" field="familyNum"
			width="90" align="right"></next:Column>
		<next:Column id="familyRegister" header="户口类型"
			field="familyRegister" width="80" dataset="DisFamilyRegister" align="center"></next:Column>
		<next:Column id="familyType" header="家庭类型"
			field="familyType" width="80" dataset="DisFamilyType" align="center"></next:Column>
			
		<next:Column id="approvalTimes" header="核准救助时段(月)"
			field="approvalTimes" width="120" align="center"></next:Column>
		<next:Column id="approvalFood" header="核准口粮救助(公斤)"
			field="approvalFood" width="130" align="right"></next:Column>
		<next:Column id="approvalClothes" header="核准衣被救助(件)"
			field="approvalClothes" width="130" align="right"></next:Column>
		<next:Column id="approvalMoney" header="核准救助金额(元)"
			field="approvalMoney" width="120" align="right"></next:Column>

		<next:Column id="acceptDate" header="填报日期" field="acceptDate"
			width="90"></next:Column>
		<next:Column id="workflowStatus" header="提交状态"
			field="workflowStatus" width="90" dataset="ReliefinfoWorkflowState"></next:Column>
		<next:Column id="note" header="备注" field="note" width="120"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDs" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>