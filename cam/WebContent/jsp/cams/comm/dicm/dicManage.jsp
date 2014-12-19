<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>字典信息维护</title>
<next:ScriptManager />
<script type="text/javascript" src="dicManage.js"></script>
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
	<!-- 字典信息维护 -->
	<model:dataset id="dicManageDS" cmd="com.inspur.cams.comm.dicm.cmd.DicManageQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.data.DicManage"></model:record>
	</model:dataset>
	<!-- 字典信息维护 -->
	<model:dataset id="dicManageAddDS" cmd="com.inspur.cams.comm.dicm.cmd.DicManageQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.data.DicManage"></model:record>
	</model:dataset>
	<!-- 字典信息校验 -->
	<model:dataset id="dicManageCheckDS" cmd="com.inspur.cams.comm.dicm.cmd.DicManageQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.data.DicManage"></model:record>
	</model:dataset>
	<!-- 字典详细信息 -->
	<model:dataset id="dicDetailsDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.data.DicDetails"></model:record>
	</model:dataset>
	<!-- 字典详细信息校验 -->
	<model:dataset id="dicDetailsCheckDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.data.DicDetails"></model:record>
	</model:dataset>
	<!-- 是否有效 -->
	<model:dataset id="yesOrNoDS"  enumName="COMM.YESORNO" global="true" autoLoad="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="99.9%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel"width="15%">字典类型：</td>
				<td class="FieldInput"><input type="text" 
					id="qDicType" /></td>
				<td class="FieldLabel"width="15%">字典描述：</td>
				<td class="FieldInput"><input type="text" 
					id="qDicName" /></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
				<td class="FieldButton">
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:Panel width="100%" height="100%">
	<next:EditGridPanel id="dicManageGrid" dataset="dicManageDS" width="99.9%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="增加" iconCls="add" handler="add_Button_Click"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save" handler="save_Modify_Click"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn></next:RowNumberColumn>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column field="dicType" header="字典类型" width="15%"  renderer="editDicDetails" >
				<next:TextField editable="false"></next:TextField>
			</next:Column>
			<next:Column field="dicName" header="字典描述" width="15%">
				<next:TextField></next:TextField>
			</next:Column>
			<next:Column field="note" header="备注" width="50%">
				<next:TextField></next:TextField>
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="dicManageDS" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
<!-- 字典信息添加/修改 -->
<next:Window id="addWin" closeAction="hide" title="字典信息添加" width="520">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save_Button_Click"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="return_Button_Click"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="dicManageAddDS">
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="15%">字典类型：</td>
				<td class="FieldInput"><input type="text" maxlength="50" id="dicType" onblur="changeCapsLock(this.id)"
					field="dicType" name="字典类型" /></td>
				<td class="FieldLabel">字典描述：</td>
				<td class="FieldInput"><input type="text" maxlength="16" id="dicName" field="dicName"
					name="字典描述" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注：</td>
				<td class="FieldInput" colspan="3"><textarea type="text" cols="12" id="note" field="note" style="width: 90%"
					name="备注" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>

<!-- 字典详细信息管理 -->
<next:Window id="dicDetailWin" closeAction="hide" title="字典详细信息管理" width="630" height="450">
	<next:EditGridPanel id="dicDetailsGrid" dataset="dicDetailsDS" width="620" height="400">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="增加" iconCls="add" handler="add_Details_Click"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save" handler="save_Details_Click"></next:ToolBarItem>
			<next:ToolBarItem text="返回" iconCls="return" handler="closeDicDetailWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn></next:RowNumberColumn>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column field="dicType" header="字典类型" width="15%">
				<next:TextField editable="false"></next:TextField>
			</next:Column>
			<next:Column field="code" header="代码" width="5%">
				<next:TextField></next:TextField>
			</next:Column>
			<next:Column field="name" header="名称" width="10%">
				<next:TextField></next:TextField>
			</next:Column>
			<next:Column field="flag" header="是否有效" width="5%">
				<next:ComboBox dataset="yesOrNoDS" displayField="text"
					valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column field="orderNum" header="排序字段" width="5%">
				<next:TextField></next:TextField>
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="dicDetailsDS" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>