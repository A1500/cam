
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
	<head>
		<title>社会组织评估</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var assessType='<%=request.getParameter("assessType")%>';
			var sorgCode='<%=request.getParameter("sorgCode")%>';
			var sorgType='<%=request.getParameter("sorgType")%>';
			var sorgName='<%=request.getParameter("sorgName")%>';
			var loginName = '<%= BspUtil.getEmpOrgan().getOrganName()%>';
			var loginOrganId = '<%= BspUtil.getEmpOrganId()%>';
			var areaCode = '<%= BspUtil.getOrganCode()%>';
			var assessDate = '<%= DateUtil.getDay()%>';
		</script>
		<script type="text/javascript" src="somassess_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assess.cmd.SomAssessQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assess.data.SomAssess">
			<model:field name="assessPersonName" type="string" rule="require|length{72}" />
			<model:field name="note" type="string" rule="length{250}" />
		</model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assessTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='som_assess_type'></model:param>
			<model:param name="value" value='TYPE'></model:param>
			<model:param name="text" value='TYPE_DESC'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="社会组织评估信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<%if(request.getParameter("method").equals("INSERT")) {%>
			<next:ToolBarItem iconCls="save"  text="开始评估打分" handler="save"/>
		<%}else{ %>
			<next:ToolBarItem iconCls="save"  text="修改评估打分" handler="save"/>
		<%} %>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" style='width:20%'>评估类型</td>
				<td class="FieldInput"style='width:30%'>
					<label field="assessType"  dataSet="assessTypeSelect"/> 
				</td>
				<td  class="FieldLabel" style='width:20%'>评估社会组织类型</td>
				<td class="FieldInput"style='width:30%'>
					<label field="sorgType"  dataSet="sorgTypeSelect"/> 
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >评估社会组织登记证号</td>
				<td class="FieldInput"><label field="sorgCode" /></td>
			
				<td  class="FieldLabel" >社会组织名称</td>
				<td class="FieldInput"><label field="sorgName" /></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">评估人姓名</td>
				<td class="FieldInput">
				<%if(request.getParameter("method").equals("INSERT")) {%>
					<input type="text" name="评估人姓名" field="assessPersonName"/><span style="color:red">*</span>
				<%}else{ %>
					<label field="assessPersonName" />
				<%} %>
				</td>
				<%if(request.getParameter("method").equals("INSERT")) {%>
					<td  class="FieldLabel"></td>
					<td  class="FieldInput"></td>
				<%}else{ %>
					<td  class="FieldLabel">评估总分</td>
					<td  class="FieldInput"><label field="score" /></td>
				<%} %>
				
			</tr>
	   		<tr>
				<td  class="FieldLabel" >登陆人姓名</td>
				<td class="FieldInput"><label field="loginName" /></td>
				<td  class="FieldLabel" >评估时间</td>
				<td class="FieldInput"><label field="assessDate" /></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注</td>
				<td class="FieldInput" colspan="3"><textarea rows="5" name='备注' field="note" style="width:98%"></textarea>
				</td>
			</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
