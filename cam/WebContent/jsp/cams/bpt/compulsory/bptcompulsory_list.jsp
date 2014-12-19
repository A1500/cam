<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var struId = '<%=BspUtil.getStruId()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<title>义务兵家庭基本信息</title>
<next:ScriptManager />
<script type="text/javascript" src="bptcompulsory_list.js"></script>
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryQueryCommand"
		global="true" method="queryCompulsory">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCompulsory">

		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO"
		global="true" autoLoad="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 开户银行 -->
	<model:dataset id="bank" enumName="BANK.CODE" global="true"
		autoLoad="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true"
	autoScroll="true">
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
				<td class="FieldLabel">家庭所属行政区划:</td>
				<td class="FieldInput"><input type="hidden" id="domicileCode" />
				<input type="text" id="domicileName" class="TextEditor" title="所属机构"
					onclick="forHelp()" /></td>

				<td class="FieldLabel">姓名:</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel">性别:</td>
				<td class="FieldInput"><select name="sex" field="sex">
					<option dataset="SexDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel">身份证号:</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证号" /></td>

				<td class="FieldLabel">民族:</td>
				<td class="FieldInput"><select id="nation">
					<option dataset="NationDataset"></option>
				</select></td>
				<td class="FieldInput" colspan="2">&nbsp;&nbsp;&nbsp;
				<button onclick="query()">查 询</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptcompulsoryGrid" width="100%"
	stripeRows="true" height="100%" dataset="ds" title="义务兵家庭基本信息列表"
	notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
		<next:ToolBarItem iconCls="detail" text="明细页"
			handler="Evt_butdetail_click" />

	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="35" header="编号" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="domicileCode" header="家庭所属行政区划" field="CITY_NAME"
			width="140">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="name" header="姓名" field="COMPULSORY_NAME" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" width="50">
			<next:ComboBox triggerAction="all" valueField="value"
				displayField="text" dataset="SexDataset" />
		</next:Column>

		<next:Column id="idCard" header="身份证号" field="ID_CARD" width="150">
			<next:TextField />
		</next:Column>

		<next:Column id="birthday" header="出生日期" field="BIRTHDAY" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="nation" header="民族" field="NATION" width="90">
			<next:TextField allowBlank="false" />
			<next:ComboBox triggerAction="all" valueField="value"
				displayField="text" dataset="NationDataset" />
		</next:Column>

		<next:Column id="specialSettingNo" header="优待安置证编号"
			field="SPECIAL_SETTING_NO" width="140">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="composedPortrait" header="进藏 进疆"
			field="COMPOSED_PORTRAIT" width="90">
			<next:TextField allowBlank="false" />
			<next:ComboBox triggerAction="all" valueField="value"
				displayField="text" dataset="composedPort" />
		</next:Column>

		<next:Column id="address" header="住址" field="ADDRESS" width="150">
			<next:TextField />
		</next:Column>

		<next:Column id="telContact" header="联系方式" field="TEL_CONTACT"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="postcode" header="邮编" field="postcode" width="90"
			hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="fatherName" header="父亲姓名" field="fatherName"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="fatherUnit" header="父亲单位" field="fatherUnit"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="fatherContact" header="父亲联系方式" field="fatherContact"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="motherName" header="母亲姓名" field="motherName"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="motherUnit" header="母亲单位" field="motherUnit"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="motherContact" header="母亲联系方式" field="motherContact"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="bank" header="开户银行" field="bank" width="90"
			hidden="true">
			<next:ComboBox triggerAction="all" valueField="value"
				displayField="text" dataset="bank" />
		</next:Column>

		<next:Column id="accountCode" header="开户账号" field="accountCode"
			width="90" hidden="true">
			<next:TextField />
		</next:Column>

		<next:Column id="note" header="备注" field="note" width="90"
			hidden="true">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
