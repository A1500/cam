<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>用户映射列表</title>
<script type="text/javascript">
			//ORGANTYPE.messType=确定
			var messType="确定";
			var messTypePrompt="提示";
			//ORGANTYPE.Save.NoDataMess=没有需要保存的数据!
			var saveNoDataMess="没有需要保存的数据!";
			var saveValidateMess='<%=res.get("ORGAN.Save.ValidateMess")%>';
			var saveValidateMessInputBigen='<%=res.get("ORGAN.Save.ValidateMessInputBigen")%>';
			var saveValidateMessInputEnd='<%=res.get("ORGAN.Save.ValidateMessInputEnd")%>';
			//ORGANTYPE.Save.SuccessMess="数据保存成功!"
			var saveSuccessMess="数据保存成功!";
			//ORGANTYPE.Delete.PleaseSelectData=请选择要删除的记录！
			var deletePleaseSelectData="请选择要删除的记录！";
			//ORGANTYPE.Delete.SelectDataMess=你确定要删除吗？
			var deleteSelectDataMess="你确定要删除吗？";
			var msg_has_unlegal_char = '<%=res.get("MSG_HAS_UNLEGAL_CHAR")%>';
			var struTypeId='<%=request.getParameter("struTypeId")%>';
			if(struTypeId == null) struTypeId = '00';
		</script>
<next:ScriptManager/>
<script type="text/javascript" src="user_map_listform.js"></script>
		 <script language="javascript">
	 	 //查询条件打开合并函数
		 function collapse(element){
			var fieldsetParent=L5.get(element).findParent("fieldset");
			if(element.expand==null||element.expand==true){
				fieldsetParent.getElementsByTagName("div")[0].style.display="none";
				element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
				element.expand=false;
			}else{
				fieldsetParent.getElementsByTagName("div")[0].style.display="";
				element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
				element.expand =true;
			}
		}
	</script>
</head>
<body>
<model:datasets>
	<model:dataset id="userMapTypeDst" enumName="BSP.USERMAP_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="ds"
		cmd="org.loushang.bsp.permit.pap.user.cmd.UserMapQueryCmd"
		method="execute" global="true" pageSize="10">
		<model:record
			fromBean="org.loushang.bsp.permit.pap.user.data.UserMap">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel height="100%" autoScroll="true">
<next:Panel  name="form"  border="false" anchor="100% 15%" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox" >
		<legend class="GroupBoxTitle">查询条件
		<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)"/>	</legend>
		<div>
		<form class="L5form">
				<table width="80%">
					<tr>
						<td class="FieldLabel"><%=res.get("LABEL_MAP_VALUE") %></td>
						<td class="FieldInput"><input type="text" id="querymapValue"
							class="TextEditor" title="用户映射值" maxlength="250"/></td>
						<td class="FieldLabel"><%=res.get("LABEL_USER_ID") %></td>
						<td class="FieldInput"><input type="text" id="queryuserId"
							class="TextEditor" title="用户"/></td>
						<td class="FieldLabel"><%=res.get("LABEL_TYPE_ID") %></td>
						<td class="FieldInput">
							<select name="typeId" id="querytypeId" field="typeId" >
								<option dataset="userMapTypeDst"></option>
							</select>
						</td>
						<td class="FieldLabel">
						<button  type="button" onclick="query()"><%=res.get("PUB_USER_MAP.QUERY") %></button>&nbsp;
						<button  type="button" onclick="resetSearch()">重置</button>
						</td>
					</tr>
				</table>
			</form></div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel  id="editGridPanel" name="editGridPanel"  dataset="ds" border="false" stripeRows="true" anchor="100% 80%" autoScroll="false"
		dataset="ds"  collapsible="true" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol='<%=res.get("USER_MAP_LIST") %>'></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD") %>'
			handler="insert" />
		<next:ToolBarItem iconCls="delete" text='<%=res.get("BUT.REMOVE") %>'
			handler="del" />
		<next:ToolBarItem iconCls="save" text='<%=res.get("BUT.SAVE") %>'
			handler="save" />
		<next:ToolBarItem iconCls="undo" text='<%=res.get("BUT.UNDO") %>'
			handler="reset" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="mapValue" header="用户映射值"
			field="mapValue" width="160">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  id="userId" header="用户" field="userId" width="120" editable="setEditable" >
			<next:TriggerField id="grid_itemId" hideTrigger="false" enableKeyEvents="true" onTriggerClick="showUserTree" readOnly="true">
			</next:TriggerField>
		</next:Column>
		<next:Column id="typeId" header="类型"
			field="typeId" width="160" editable="setEditable">
			<next:ComboBox dataset="userMapTypeDst" triggerAction="all" valueField="value" displayField="text" typeAble="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar  dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>

</body>
</html>
