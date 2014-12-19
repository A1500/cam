<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>状态变更编辑</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var peopleId = '<%=request.getParameter("peopleId")%>';
			var changeStatePre = '<%=request.getParameter("objectState")%>';
			var objectType = '<%=request.getParameter("objectType")%>';
		</script>
		<script type="text/javascript" src="stateChangeInsert.js"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 状态变更 -->
	<model:dataset id="StateChangeDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptStateChangeQueryCommand" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptStateChange"></model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout >
<next:Panel  title="状态变更" autoHeight="true" autoWidth="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="新增" handler="insert" />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save" />
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="StateChangeDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="90%" >
			
		
	   		<tr>
				<td  class="FieldLabel" style="width:20%">姓名：</td>
				<td class="FieldInput"  style="width:30%"><label id="name" name="name" field="name" ></label></td>
				<td  class="FieldLabel" style="width:20%">身份证件号码：</td>
				<td class="FieldInput"  style="width:30%"><label id="idCard" name="idCard" field="idCard"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap="nowrap">变更前状态：</td>
				<td class="FieldInput"><label id="changeStatePre" name="changeStatePre" field="changeStatePre" dataset="ObjectStateDataset"></label></td>
				<td  class="FieldLabel" >变更后状态：</td>
				<td class="FieldInput" >
						<select id="changeStateSuf" name="changeStateSuf" field="changeStateSuf"  onclick="ondisplay()" onchange="onChangeState()"> 
								<option  dataset="ObjectStateDataset" ></option>
						</select>
					<font color="red">*</font> </td>
			</tr>
			<tr id="deathAlllowance">
				<td  class="FieldLabel" style="width:20%">死亡日期：</td>
				<td class="FieldInput"  style="width:30%"><input type="text" id="deathDate" name="deathDate" field="deathDate" format="Y-m-d"
								style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td  class="FieldLabel" style="width:20%">抚恤金发放日期：</td>
				<td class="FieldInput"  style="width:30%"><input type="text" id="allowanceMonth" name="allowanceMonth" field="allowanceMonth" format="Y-m"
								style="width: 100px;" maxlength="10" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3">
					<textarea name="note" field="note" cols="122%" rows="3"></textarea>
			    </td>
			</tr>
			<!-- 状态变更ID -->
			<input type="hidden" name="stateChangeId" field="stateChangeId" id="stateChangeId"/>
			<!-- 变更时间 -->
			<input type="hidden" name="changeStateDate" field="changeStateDate" id="changeStateDate" />
		</table>
		</form>
   </next:Html>
</next:Panel>

<next:GridPanel id="GridPanel" name="bptstatechangeGrid" disableSelection="true" height="290" autoWidth="true" stripeRows="true" title="状态变更历史查看" dataset="StateChangeDataset">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="name" header="姓名" field="name" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="idCard" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="changeStatePre" header="变更前状态" field="changeStatePre" width="115" renderer="statePreRender" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="changeStateSuf" header="变更后状态" field="changeStateSuf" width="115" renderer="stateSufRender">
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
