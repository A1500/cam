
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.DateUtil,org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>年检任务配置编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var year = '<%=DateUtil.getYear()%>';
		</script>
		<script type="text/javascript" src="somchecktask_edit.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.check.checktask.cmd.SomCheckTaskQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checktask.data.SomCheckTask">
				<model:field name="taskName" type="string" rule="require" />
				<model:field name="batchYear" type="string" rule="require" />
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
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="年检任务配置">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false"  class="L5form">
		<table border="1"  width="100%" >

	   		<tr>
				<td  class="FieldLabel" >任务名称</td>
				<td class="FieldInput" colspan="3"><input type="text" name="taskName" field="taskName" title="任务名称" style="width:80%" maxlength="100"/><span style="color:red">*</span> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >社会组织类型</td>
				<td class="FieldInput" >
				<select id="sorgType" field="sorgType" name='社会组织类型'><option dataset="sorgTypeSelect"></option></select><span style="color:red">*</span>
				</td>

				<td  class="FieldLabel" >年检年份</td>
				<td class="FieldInput"><input type="text" name="batchYear" title="年检年份" field="batchYear"  maxlength="4"/><span style="color:red">*</span></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >有效期至</td>
				<td class="FieldInput">
				<input type="text" id="validDate" field="validDate" format="Y-m-d" onclick="WdatePicker()" />
				</td>

				<td  class="FieldLabel" >是否有效</td>
				<td class="FieldInput">
				<select id="ifValid" field="ifValid" name='是否有效'><option dataset="comm_yesorno"></option></select>
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
