<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>照片</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
 var rootUrl=<%=SkinUtils.getRootUrl(request) %>;
  var row_index=0;
  var deptId = '<%=request.getParameter("dept_code")%>';
</script>
<script type="text/javascript" src="photoList.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
 
</head>
<body>
<model:datasets>
	<model:dataset id="organDs" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo"></model:record>
	</model:dataset>
</model:datasets>
<next:TabPanel name="tabpanel-div" deferredRender="false" height="590" activeTab="0"  title="">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>

	</next:TopBar>
	<next:Tabs>
		<next:Panel title="场所照片" collapsible="false">
			<next:Html>
			<form id="form_content" method="post" onsubmit="return false" class="L5form">
				<table id="table1" border=1 width="100%">
					<tr><td class="FieldLabel">照片</td>
					<td>
					<input   type=button   value="添加"   onclick="add_row()" style="CURSOR: hand">
         		    &nbsp;<span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:Tabs>

</next:TabPanel>
</body>
</html>
