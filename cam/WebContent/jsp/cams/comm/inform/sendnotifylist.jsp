<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>发件箱</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="sendnotifylist.js"></script>
		<script language="javascript">
			var queryId = '<%=request.getParameter("id")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="notifyDataset" cmd="com.inspur.cams.comm.inform.InformQueryCommand" method="querySendBox" global="false">
		<model:record>
			<model:field name="ID" type="string"/>
			<model:field name="TITLE" type="string"/>
			<model:field name="SENDMANID" type="string"/>
			<model:field name="SENDTIME" type="date" dateFormat="Y-m-d H:i:s"/>
			<model:field name="INFORMTYPE" type="string"/>
			<model:field name="FLAG" type="string"/>
			<model:field name="RECEIVEMAN" type="string"/>
	</model:record>
	</model:dataset>
	<model:dataset id="organDS" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" global="true" autoLoad="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.informUtil.InformPubOrgan">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
	<model:dataset id="receiveOrganDS" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" method="queryNameByOrganType" global="true" autoLoad="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.informUtil.InformPubOrgan">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
	<model:dataset id="type" enumName="Inform.Type" autoLoad="true" global="false"></model:dataset>
	<model:dataset id="availableDate" enumName="Available.Date" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="gridPanel"   notSelectFirstRow="true"  title="发件箱列表" name="informGrid"  width="100%" height="400" dataset="notifyDataset" frame="true" >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="标题" field="TITLE"  renderer="titleRender" width="260" >
			<next:TextField />
		</next:Column>
		<next:Column header="时间" field="SENDTIME"  align="center" width="140" sortable="true">
			<next:DateField />
		</next:Column>
		<next:Column header="通知类型" field="INFORMTYPE"   width="100"  sortable="true">
			<next:ComboBox dataset="type" />
		</next:Column>
		<next:Column header="接收单位" field="RECEIVEMAN"  width="120" sortable="true" renderer="receiveRenderer">
		</next:Column>
		<next:Column header="发送单位" field="SENDMAN"  width="120" sortable="true">
			<next:ComboBox dataset="organDS" />
		</next:Column>
		<next:Column header="发送人" field="SENDMANID"   width="100" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="状态" field="FLAG" width="80" renderer="flagRender"   sortable="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="新建" handler="click_add"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="undo"  text="撤销" handler="click_undo"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="click_delete"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="common-query"  text="查看" handler="click_view"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="common-query"  text="查询" handler="click_query"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="notifyDataset"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 弹出添加窗口 -->
<next:Window id="organize" name="organizeWin" title="发件箱查询"
	resizable="false" width="300" lazyRender="false" height="150"
	closeAction="hide" autoScroll="false">
	<next:Buttons>
		<next:ToolButton text="查询" handler="query"></next:ToolButton>
		<next:ToolButton text="关闭" handler="undoit"></next:ToolButton>
	</next:Buttons>

	<next:Html>
		<form id="informcfg" method="post" onsubmit="return false">
		<table id="table0"  border="0">
			<tr>
				<td align="center" ><label>标题：</label></td>
				<td >
				    <input type="text" id="titlequery" name="titlequery"
					   title="标题" size="30"/>
				</td>
		    </tr>
		    <tr>
				<td align="center" ><label>发送人：</label></td>
				<td >
				    <input type="text" id="sendmanIdquery"
					   title="发送人" size="30"/>
				</td>
		    </tr>
		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>

<next:Window id="sendWin" width="850" height="550" collapsible="false"
	closable="close" resizable="false" modal="true" title="发件箱">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="发布" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="no" text="取消" handler="click_close"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Panel width="100%" height="100%">
		<next:Panel title="基本信息" collapsible="false">
			<next:Html>
			<form id="form_content" method="post" onsubmit="return false" class="L5form">
				<table id="table1" border=1 width="100%">
					<tr>
						<td class="FieldLabel">标题：</td>
						<td ><input type="text" id="title" size="1000" maxlength="10000" value="" width="100000" style="width: 300px">
							 <input id="informtype" name="informtype" value="bulletin" type="hidden">
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">接收单位：</td>
						<td>

						<textarea id="NAME" name="receivemanview"	rows="5" cols="92" readonly="readonly">
				  		 </textarea>

						<input type="button" name="selectdept" value="选择部门" onclick="selectUser()" style="CURSOR: hand">
						<input type="hidden"  id="CODE" class="TextEditor"/>

						</td>
					</tr>
					<tr>
						<td class="FieldLabel">内容:</td>
						<td class="FieldInput" colspan="3"><textarea id="content" style="width: 90%" rows="10" cols="100"></textarea>
						</td>
					</tr>
					<tr style="display:none">
						<td class="FieldLabel">有效时限：</td>
						<td><select name="validdaynum"  id="validdaynum" >
							<option dataset="availableDate" ></option>
						</select></td>
					</tr>
					<tr><td class="FieldLabel">附件</td>
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
	</next:Panel>
</next:Window>