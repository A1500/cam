<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>审批流程</title>
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
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="swWorkFlow.js"></script>
</head>
<body>
<model:datasets>
	<!-- 历史信息 -->
	<model:dataset id="hisDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchCheckHistoryQueryCmd"
		global="true" pageSize="200">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchCheckHistory">
		</model:record>
	</model:dataset>
	<!-- 流程状态 -->
	<model:dataset id="receiveStatusDS"
		enumName="DIS.BATCHDETAIL_FILL_STATE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:GridPanel id="swGrid" name="swGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="hisDs" notSelectFirstRow="true" autoExpandColumn="checkOption">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:Column id="updateTime" header="时间" field="updateTime"
			width="135"></next:Column>
		<next:Column id="receiveStatus" header="流程状态" field="receiveStatus"
			width="100" renderer="receiveStatusRenderer"></next:Column>
		<next:Column id="sendOrganName" header="处理单位" field="sendOrganName"
			width="130"></next:Column>
		<next:Column id="sendPerson" header="处理人" field="sendPerson"
			width="140"></next:Column>
		<next:Column id="checkOption" header="审核意见" field="checkOption"
			align="left"></next:Column>
		<next:Column id="checkDate" header="审核时间" field="checkDate" width="80"
			align="center"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="hisDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
