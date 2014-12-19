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
	<!-- 历史信息 -->
	<model:dataset id="hisDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" global="true" method="queryByCreateTime">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
	<!-- 年检结果枚举 0:未参检,1:合格,2:不合格,3:已检查,4:检查不合格,5:整改-->
	<model:dataset id="checkResultDs" enumName="FIS.BASE_OPINION" 
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
		<next:Column id="firstUnit" header="审批单位" field="FIRST_UNIT"
			width="135" align="center"></next:Column>
		<next:Column id="firstResult" header="审批结果" field="FIRST_RESULT"
			width="135" align="center" dataset="checkResultDs"></next:Column>
		<next:Column id="firstOpinion" header="审批意见" field="FIRST_OPINION"
			width="135" align="center"></next:Column>
		<next:Column id="firstTime" header="审批时间" field="FIRST_TIME"
			width="135" align="center"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="hisDs" />
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
</body>
</html>
