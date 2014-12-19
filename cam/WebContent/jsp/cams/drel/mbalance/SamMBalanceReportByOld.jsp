<%@page import="com.inspur.cams.comm.util.CamsProperties"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();

%>
<html>
	<head>
		<title>低保五保中各类别统计</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
		<script type="text/javascript" src="SamMBalanceReportByOld.js"></script>
		<script language="javascript">
		 var organArea='<%= organArea%>';
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
	<model:dataset id="ds" 
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd" 
		method="queryBptDisOld" global="true" pageSize="100">
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
		<div>
			<form style="width: 100%; height: 100%;" class="L5form">
				<table  border="0" width="100%" style="border:none">
					<tr>
						<td align="center">
						    <br/>
							<input type="hidden" id="age" value='<%=CamsProperties.getString("old_age") %>'><button onclick="query()">开始统计</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</next:Html>
</next:Panel>
<next:Panel name="tabpanel-div" height="100%">
	<next:Defaults>
		{bodyStyle:'padding:15px;'}
	</next:Defaults>
	<next:Html>
		<div id = "svgDiv"></div>
	</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>