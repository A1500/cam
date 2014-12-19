<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>冬春生活救助</title>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifFill = '<%=request.getParameter("ifFill")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var organcode = '<%=request.getParameter("organcode")%>';
     var disYear='<%=request.getParameter("disYear")%>';
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
<script type="text/javascript" src="dcQueryList.js"></script>
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
	<model:dataset id="infoDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" method="queryDetail"
		global="true" pageSize="20">
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


<next:GridPanel id="dcGrid" name="dcGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="infoDs" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="name" header="户主姓名" field="NAME" width="90"></next:Column>
		<next:Column id="idCard" header="身份证号码" field="ID_CARD" width="135"></next:Column>
		<next:Column id="acceptAreaName" header="行政村（社区）"
			field="ACCEPT_AREA_NAME" width="170"></next:Column>

		<next:Column id="familyNum" header="家庭人口(人)" field="FAMILY_NUM"
			width="90" align="right"></next:Column>
		<next:Column id="familyRegister" header="户口类型"
			field="FAMILY_REGISTER" width="80" dataset="DisFamilyRegister" align="center"></next:Column>
		<next:Column id="familyType" header="家庭类型"
			field="FAMILY_TYPE" width="80" dataset="DisFamilyType" align="center"></next:Column>
			
		<next:Column id="approvalTimes" header="核准救助时段(月)"
			field="APPROVAL_TIMES" width="120" align="center"></next:Column>
		<next:Column id="approvalFood" header="核准口粮救助(公斤)"
			field="APPROVAL_FOOD" width="130" align="right"></next:Column>
		<next:Column id="approvalClothes" header="核准衣被救助(件)"
			field="APPROVAL_CLOTHES" width="130" align="right"></next:Column>
		<next:Column id="approvalMoney" header="核准救助金额(元)"
			field="APPROVAL_MONEY" width="120" align="right"></next:Column>

		<next:Column id="acceptDate" header="填报日期" field="ACCEPT_DATE"
			width="90"></next:Column>
		<next:Column id="workflowStatus" header="提交状态"
			field="WORKFLOW_STATUS" width="90" dataset="ReliefinfoWorkflowState"></next:Column>
		<next:Column id="note" header="备注" field="NOTE" width="120"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>