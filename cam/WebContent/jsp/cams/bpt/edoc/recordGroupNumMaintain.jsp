<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
</script>

<html>
	<head>
		<title>档案柜信息维护</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="recordGroupNumMaintain.js"></script>
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
	<!-- 全宗号 -->
	<model:dataset id="ArchivalFondsDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptArchivalFondsNumberQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptArchivalFondsNumber"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel width="100%">
	<next:Html>
		<form id="editForm" dataset="ArchivalFondsDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="98%" >
	   		<tr>
				<td class="FieldLabel" style="width:20%">全宗号</td>
				<td class="FieldInput" style="width:20%"><input type="text" name="archivalFondsName" field="archivalFondsName" maxlength="3"/><font color="red">*</font> </td>
				<td class="FieldLabel" style="width:20%;padding-left:10"><button onclick="saveArchivalFonds()" type="button">保存</button></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
