<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 业务主管单位主页面-->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somBorgList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript">
	var organType = "<%=BspUtil.getOrganType()%>";
	
</script>
</head>
<body>
<model:datasets>
	<!-- 列表dataset -->
	<model:dataset id="somBorgList" autoLoad="true" cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd" pageSize="8"  sortField="orderNumber">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg">
			<model:field name="borgLevel" type="string" rule="require|length{1}"/>
			<model:field name="borgType" type="string" rule="length{2}"/>
			<model:field name="borgName" type="string" rule="require|length{100}|custom{fn:checkQuotein,min:2}"/>
			<model:field name="borgPeople" type="string" rule="length{72}|custom{fn:checkQuotefor,min:2}"/>
			<model:field name="borgPhone" type="string" rule="length{30}"/>
			<model:field name="orderNumber" type="string" rule="require"/>
		</model:record>
		<model:params>
			<model:param name="MORG_CODE" value='<%=BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 明细 -->
	<model:dataset id="somBorgView"  cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
	</model:dataset>
	<!-- 添加dataset -->
	<model:dataset id="somBorgAdd"  cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
	</model:dataset>
	<!-- 修改dataset -->
	<model:dataset id="somBorgUpdate" autoLoad="true" cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
	</model:dataset>
	
	<!-- 主管单位级别 -->
	<model:dataset id="borgLevel" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BORG_LEVEL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" border="0">
	<next:Html>
		<form class="L5form">
		<fieldset><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel"><label>主管单位名称：</label></td>
				<td class="FieldInput"><input type="text" id="borgName" style="width:350"/></td>
				<td class="FieldButton">
				<button onclick="forQuery();">查询</button>
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="hlistPanel" dataset="somBorgList" height="99.9%"  width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="业务主管单位管理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="showWin"></next:ToolBarItem>
		<next:ToolBarItem text="增加单位" iconCls="add" handler="newBorg"></next:ToolBarItem>
		<next:ToolBarItem text="保存修改" iconCls="detail" handler="saveBorg" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="delete" handler="del" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="主管单位级别" field="borgLevel" width="15%" ><next:ComboBox valueField="value" displayField="text" triggerAction="all" dataset="borgLevel" editable="false"></next:ComboBox></next:Column>
		<next:Column header="顺序号" field="orderNumber"   width="20%"><next:TextField/></next:Column>
		<next:Column header="是否是历史业务主管单位"  field="ifHis" width="15%"><next:TextField/><next:ComboBox dataset="comm_yesorno"/></next:Column>
		<next:Column header="主管单位名称" field="borgName"  width="20%"><next:TextField/></next:Column>
		<next:Column header="主管单位联系人" field="borgPeople"   width="20%"><next:TextField/></next:Column>
		<next:Column header="主管单位联系电话" field="borgPhone" width="15%" ><next:TextField/></next:Column>
		<next:Column header="主管单位编码" field="borgCode" hidden="true" ><next:TextField/></next:Column>
		<next:Column header="是否成立社会组织党委" field="ifSorgParty" width="15%"><next:ComboBox dataset='comm_yesorno'/></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somBorgList" />
	</next:BottomBar>
</next:EditGridPanel>


<!-- 业务主管单位明细 -->
<next:Window id="showwindow" closeAction="hide" title="业务主管单位明细" width="550">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somBorgView">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%"><label>主管单位级别：</label></td>
					<td class="FieldInput" style="width:10%"><label  field="borgLevel" dataset="borgLevel"></label></td>
					<td class="FieldLabel" style="width:10%"><label>主管单位类型：</label></td>
					<td class="FieldInput" style="width:10%"><label field="borgType" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>主管单位名称：</label></td>
					<td class="FieldInput" colspan="3"><label field="borgName" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>主管单位联系人：</label></td>
					<td class="FieldInput"><label field="borgPeople" ></label></td>
					<td class="FieldLabel"><label>主管单位联系电话：</label></td>
					<td class="FieldInput"><label field="borgPhone" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>管理机关名称：</label></td>
					<td class="FieldInput"><label field="morgName" /></td>
					<td class="FieldLabel"><label>管理机关区划：</label></td>
					<td class="FieldInput"><label field="morgCode" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>录入人：</label></td>
					<td class="FieldInput"><label field="createPeople" /></td>
					<td class="FieldLabel"><label>录入时间：</label></td>
					<td class="FieldInput"><label field="createTime" /></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>