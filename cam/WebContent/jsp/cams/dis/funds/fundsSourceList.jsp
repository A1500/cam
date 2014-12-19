<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>资金来源管理</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsSourceList.js"></script>
<script language="javascript">
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
	<!--社会捐赠资金-->
	<model:dataset id="contributeDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" sortField="DIS_YEAR DESC,ALLOCATION_TIME DESC,FILL_TIME">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>

	<!--单笔资金来源，增改使用-->
	<model:dataset id="singleSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource">
			<model:field name="disYear" type="string" rule="require"></model:field>
			<model:field name="amount" type="float" rule="require"></model:field>
			<model:field name="allocationTime" type="string" rule="require"></model:field>
			<model:field name="upAllocationType" type="string" rule="require"></model:field>
		</model:record>
	</model:dataset>

	<!-- 预算类型 -->
	<model:dataset id="disBudgetType" enumName="DIS.BUDGET_TYPE"
		global="true" autoLoad="true">
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true">
	</model:dataset>

</model:datasets>
<next:TabPanel id="tabpanel" name="tabpanel" height="100%" width="100%"
	activeTab="0" enableTabScroll="true">
	<next:Tabs>
		<!--	上级下拨-省/县/市		-->
		<next:Panel name="allocationPanel" width="100%" height="100%" title="上级下拨">
			<next:Html>
				<iframe id="frameUp" frameborder="no" marginwidth="0"
					marginheight="0" allowtransparency="yes" style="overflow: auto"
					height="100%" width="100%"></iframe>
			</next:Html>
		</next:Panel>
		
		<!--	本级投入		-->
		<next:Panel id="selfPanel" name="selfPanel" width="100%" height="100%" title="本级投入">
			<next:Html>
				<iframe id="frameSelf" frameborder="no" marginwidth="0"
					marginheight="0" allowtransparency="yes" style="overflow: auto"
					height="100%" width="100%" src="fundsSourceListOfSelf.jsp"></iframe>
			</next:Html>
		</next:Panel>
		
		<!--	社会捐赠		-->
		<next:Panel id="conPanel" name="conPanel" width="100%" height="100%" title="社会捐赠">
			<next:Html>
				<iframe id="frameCon" frameborder="no" marginwidth="0"
					marginheight="0" allowtransparency="yes" style="overflow: auto"
					height="100%" width="100%" src="fundsSourceListOfCon.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>