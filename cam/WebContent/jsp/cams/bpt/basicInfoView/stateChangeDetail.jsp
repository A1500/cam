<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>状态变更查看</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var peopleId ='<%=request.getParameter("peopleId")%>';
			var username ='<%=request.getParameter("username")%>';
			var idCard ='<%=request.getParameter("idCard")%>';
			var changeStatePre ='<%=request.getParameter("objectState")%>';
			var objectType ='<%=request.getParameter("objectType")%>';
		</script>
		<script type="text/javascript" src="stateChangeDetail.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 状态变更 -->
	<model:dataset id="StateChangeDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptStateChangeQueryCommand" sortField="changeStateDate" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptStateChange"></model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset> 
</model:datasets>
<next:ViewPort>
<next:AnchorLayout >
<next:Panel  title="状态变更" autoHeight="true" width="100%" collapsible="true">
	<next:Html>
		<form id="editForm"   dataset="StateChangeDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="90%" >
	   		<tr>
				<td  class="FieldLabel" style="width: 20%">姓名：</td>
				<td class="FieldInput" style="width: 30%"><label id="name" name="name" field="name" ></label></td>
				<td  class="FieldLabel" style="width: 20%">身份证件号码：</td>
				<td class="FieldInput" style="width: 30%"><label id="idCard" name="idCard" field="idCard"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >变更前状态：</td>
				<td class="FieldInput"><label id="changeStatePre" name="changeStatePre" field="changeStatePre" dataset="ObjectStateDataset"></label></td>
				<td  class="FieldLabel" >变更后状态：</td>
				<td class="FieldInput"><label id="changeStateSuf" name="changeStateSuf" field="changeStateSuf" dataset="ObjectStateDataset"></label></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3">
					<label name="note" field="note" cols="122%" rows="3"></label>
			    </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>

<next:GridPanel id="GridPanel" name="bptstatechangeGrid" collapsible="true" height="100%" width="100%" stripeRows="true" title="状态变更历史查看" dataset="StateChangeDataset">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	
		<next:Column id="name" header="姓名" field="name" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="idCard" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="changeStatePre" header="变更前状态" field="changeStatePre" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="changeStateSuf" header="变更后状态" field="changeStateSuf" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="changeStateDate" header="变更时间" field="changeStateDate" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="note" header="备注" field="note" width="120" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="StateChangeDataset" />
	</next:BottomBar>
</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
