<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>轮养休养名单列表</title>
<next:ScriptManager />
<script type="text/javascript" src="bptrecuperatedetal_list.js"></script>
<script type="text/javascript">
		var idField='<%=request.getParameter("dataBean")%>';
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateDetalQueryCommand" global="true" pageSize="600">
		<model:record fromBean="com.inspur.cams.bpt.bptrecuperate.data.BptRecuperateDetail">
			<model:field name="age" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectType" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:EditGridPanel id="editGridPanel" name="bptrecuperatedetalGrid"
	width="100%" notSelectFirstRow="true" stripeRows="true" height="100%" clickToSelectedForChkSM="true"
	dataset="ds" title="名单详细">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
		if("UPDATE".equals(request.getParameter("method"))){
		%>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="add"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"/>
		<%
		}
		%>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="undo" handler="back"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="name" header="姓名" field="name" width="90" editable="false" renderer="peopleDetail">
			<next:TextField/>
		</next:Column>
		<next:Column id="idCard" header="身份证号" field="idCard" width="150" editable="false">
			<next:TextField/>
		</next:Column>
		<next:Column id="age" header="年龄" field="age" width="150" editable="false" align="right">
			<next:TextField/>
		</next:Column>
		<next:Column id="objectType" header="优抚类别" field="objectType" width="150" dataset="ObjectType" editable="false">
			<next:TextField/>
		</next:Column>
		<%
		if("UPDATE".equals(request.getParameter("method"))){
		%>
		<next:Column id="place" header="轮养休养地点" field="place" width="230" editable="true">
			<next:TextField/>
		</next:Column>
		<%
		}else{
		%>
		<next:Column id="place" header="轮养休养地点" field="place" width="230" editable="false">
			<next:TextField/>
		</next:Column>
		<%
		}
		%>
	</next:Columns>
</next:EditGridPanel>
</body>
</html>
