
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<html>
	<head>
		<title>下辖村情况基本信息编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var userName='<%=request.getParameter("userName")%>';
			userName=decodeURIComponent(userName);
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="cdcundergovemnsinfo_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.cdc.base.cmd.CdcUnderGovemnsInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="下辖村情况基本信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td class="FieldLabel" >下辖村名称：</td>
				<td class="FieldInput" colspan="3"><label name="下辖村名称" field="villageName"  />  </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >总人口数：</td>
				<td class="FieldInput"><input type="text" name="总人口数" onblur="forcheck(this)" field="headCount"  /> 人 </td>
			
				<td class="FieldLabel" >总户数：</td>
				<td class="FieldInput"><input type="text" name="总户数" field="householdsNum" onblur="forcheck(this)"  /> 户 </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >耕地面积：</td>
				<td class="FieldInput"><input type="text" name="耕地面积" field="agriculturalArea" onblur="fordecimalcheck(this)" /> 亩 </td>
			
				<td class="FieldLabel" >宅基地面积：</td>
				<td class="FieldInput"><input type="text" name="宅基地面积" field="houseArea" onblur="fordecimalcheck(this)"/> 亩</td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
