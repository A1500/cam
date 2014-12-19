
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>责令改正通知编辑</title>
			<%
				StringBuffer localStringBuffer = new StringBuffer();
			    localStringBuffer.append(request.getScheme());
			    localStringBuffer.append("://");
			    localStringBuffer.append(request.getServerName());
			    localStringBuffer.append(":");
			    localStringBuffer.append(request.getServerPort());
			    localStringBuffer.append(request.getContextPath());
			    String url= localStringBuffer.toString();
			%>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var url = '<%=url%>';
		</script>
		<script type="text/javascript" src="sompenaltycorrect_edit.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	</head>

<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyCorrectQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenaltyCorrect">
			<model:field name="sorgType" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="correctNo" type="string" rule="require" />
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
		<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  title="责令改正通知">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="出具《责令改正通知书》并保存" handler="printSave"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false" class="L5form">
		<table border="1"  width="100%" >
	   		<tr>
				<td class="FieldLabel" style='width:20%'>社会组织类型</td>
				<td class="FieldInput" style='width:30%'><select field="sorgType" id="sorgType" name='社会组织类型' title="社会组织类型" style='width:80%' onchange="fillBackSorgName()"><option  dataset="sorgTypeSelect"></option></select><span style="color:red">*</span></td>
				<td class="FieldLabel" style='width:20%'>登记证号</td>
				<td class="FieldInput" style='width:30%'><input type="text" id="sorgCode" name="sorgCode" field="sorgCode" title="登记证号" style='width:80%' onchange="fillBackSorgName()"/><span style="color:red">*</span></td>
			</tr>
			<tr>
				<td class="FieldLabel" >社会组织名称</td>
				<td class="FieldInput" colspan="3">
					<label type="text" field="sorgName" id="sorgName" name='社会组织名称'   />
				</td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >通知书编号</td>
				<td class="FieldInput"><input type="text" name="correctNo" field="correctNo" title="通知书编号" style='width:80%'/><span style="color:red">*</span></td>
				<td class="FieldLabel" >责改日期</td>
				<td class="FieldInput">
					<input type="text" name='责改日期' field="correctDate" format="Y-m-d"  onclick="WdatePicker()" style='width:80%'/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" >违规行为</td>
				<td class="FieldInput"  colspan="3">
					<textarea rows="5" name='违规行为' field="illegalBehavior" style="width:93%"></textarea>
				</td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >违反规定</td>
				<td class="FieldInput" colspan="3">
					<textarea rows="5" name='违反规定违规行为' field="deregulation" style="width:93%"></textarea>
				</td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >联系人</td>
				<td class="FieldInput"><input type="text" name="linkmanName" field="linkmanName"  style='width:80%'/> </td>
				<td class="FieldLabel" >联系电话</td>
				<td class="FieldInput"><input type="text" name="linkmanPhone" field="linkmanPhone"  style='width:80%'/> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>
