<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>物资来源管理</title>
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
<script type="text/javascript" src="fundsGoodSourceList.js"></script>
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

<next:TabPanel id="tabpanel" name="tabpanel" height="100%" width="100%"
	activeTab="0" enableTabScroll="true">
	<next:Tabs>
		<!--	上级调拨-省/县/市		-->
		<next:Panel name="allocationPanel" width="100%" height="100%" title="上级调拨物资">
			<next:Html>
				<iframe id="frameUp" frameborder="no" marginwidth="0"
					marginheight="0" allowtransparency="yes" style="overflow: auto"
					height="100%" width="100%" src="fundsGoodSourceListOfUp.jsp"></iframe>
			</next:Html>
		</next:Panel>
		
		<!--	本级采购		-->
		<next:Panel id="selfPanel" name="selfPanel" width="100%" height="100%" title="救灾物资采购">
			<next:Html>
				<iframe id="frameSelf" frameborder="no" marginwidth="0"
					marginheight="0" allowtransparency="yes" style="overflow: auto"
					height="100%" width="100%" src="fundsGoodSwapList.jsp"></iframe>
			</next:Html>
		</next:Panel>
		
		<!--	社会捐赠		-->
		<next:Panel id="conPanel" name="conPanel" width="100%" height="100%" title="捐赠物资接收">
			<next:Html>
				<iframe id="frameCon" frameborder="no" marginwidth="0"
					marginheight="0" allowtransparency="yes" style="overflow: auto"
					height="100%" width="100%" src="fundsGoodReceivedList.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>