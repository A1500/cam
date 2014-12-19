<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公墓年检审批流程</title>
<next:ScriptManager />
<script type="text/javascript" src="workFlowDetail.js"></script>
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var cemeApplyId = '<%=request.getParameter("cemeApplyId")%>';
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

</head>
<body>
<model:datasets>
	<!-- 初检结果 检查通过   检查未通过-->
	<model:dataset id="cJDs" enumName="FIS.CEME.RESULT1" 
		autoLoad="true" global="true"></model:dataset>
	<!-- 历史信息 -->
	<model:dataset id="hisDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
	<!-- 年检结果枚举 0:未参检,1:合格,2:不合格,3:已检查,4:检查不合格,5:整改-->
	<model:dataset id="checkResultDs" enumName="FIS.CEME.INSPECTION.STATUS" 
		autoLoad="true" global="true"></model:dataset>
	<!-- 上报状态 4:县级未上报,0:县级已上报,1:市级已审核,2:市级已驳回,3:省级已审批-->
	<model:dataset id="isReportState" enumName="FIS.CEME.REPORT.STATUS"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:GridPanel id="Grid" name="Grid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="hisDs" notSelectFirstRow="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:Column id="hisId" header="历史记录编码" field="hisId"
			width="135" hidden="true"></next:Column>		<next:Column id="createTime" header="创建纪录时间" field="createTime"
			width="135" hidden="true" ></next:Column>
		<next:Column id="cemeApplyId" header="业务编码" field="cemeApplyId"
			width="135" hidden="true"></next:Column>
		<next:Column id="firstUnit" header="县级检查单位" field="firstUnit"
			width="135" align="center"></next:Column>
		<next:Column id="firstTime" header="县级检查时间" field="firstTime"
			width="135" align="center"></next:Column>
		<next:Column id="firstResult" header="县级检查结果" field="firstResult"
			width="135" align="center" dataset="cJDs"></next:Column>
		<next:Column id="secondUnit" header="市级审批单位" field="secondUnit"
			width="135" align="center"></next:Column>
		<next:Column id="secondTime" header="市级审批时间" field="secondTime"
			width="135" align="center"></next:Column>
		<next:Column id="secondResult" header="市级审批结果" field="secondResult"
			width="135" dataset="checkResultDs" align="center"></next:Column>
		<next:Column id="isReport" header="流程状态" field="isReport"
			width="135" dataset="isReportState" align="center" hidden="true"></next:Column>
		<next:Column id="checkResult" header="年检结果" field="checkResult"
			width="135" dataset="checkResultDs" align="center"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="hisDs" />
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
</body>
</html>
