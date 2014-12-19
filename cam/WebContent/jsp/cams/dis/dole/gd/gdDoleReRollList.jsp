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
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="gdDoleReRollList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="doleDetailDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleDetailQueryCmd"
		global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDoleDetail">
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
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="gdGrid" name="gdGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="infoDs" notSelectFirstRow="true" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="add" handler="save" id="btnAdd" />
		<next:ToolBarItem text="确认" iconCls="edit" handler="confirm" id="btnEdit" />
		<next:ToolBarItem text="导出Excel" iconCls="export" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:Column id="acceptAreaName" header="村名称" field="acceptAreaName" width="190">
			<next:TextField />
		</next:Column>
		
		<next:Column id="familyNum" header="家庭人口(人)" field="familyNum"
			width="90" align="right"></next:Column>
		<next:Column id="familyRegister" header="户口类型"
			field="familyRegister" width="80" dataset="DisFamilyRegister" align="center"></next:Column>
		<next:Column id="familyType" header="家庭类型"
			field="familyType" width="80" dataset="DisFamilyType" align="center"></next:Column>
		<next:Column id="yhTr" header="开户银行"
			field="bank" width="120" align="right"></next:Column>
		<next:Column id="yhTr2" header="开户银行帐号"
			field="accountCode" width="120" align="right"></next:Column>
		<next:Column id="approvalFood" header="核准救助粮食（公斤）"
			field="approvalFood" width="130">
			<next:TextField />
		</next:Column>

		<next:Column id="approvalClothes" header="核准救助衣被（件）"
			field="approvalClothes" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="approvalMoney" header="核准救助资金（元）"
			field="approvalMoney" width="120" summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : countNum1
           	</next:ExtendConfig>
			<next:NumberField />
		</next:Column>
		<next:Column id="account" header="实际发放金额（元）"
			field="account" width="120" align="right" summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : countNum2
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDs" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>