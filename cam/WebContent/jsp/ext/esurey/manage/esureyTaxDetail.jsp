<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>明细查询列表</title>
<next:ScriptManager />
<script>
			var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
			var checkOrg='<%=ExtBspInfo.getUserInfo(request).getOrganName()%>';
			var checkPeople='<%=ExtBspInfo.getUserInfo(request).getUserName()%>';
			var checkId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
		</script>
<script type="text/javascript" src="comm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
	<!--经济核对_外部单位填报信息的dataset-->
	<model:dataset id="FeedbackDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息的dataset-->
	<model:dataset id="CheckFlagDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>
	<!--国税信息dataset-->
	<model:dataset id="taxDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd"
		global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="checkFlgDataset1" enumName="CHECK.FLG.SUM"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkFlgDataset" enumName="CHECK.FLG"
		autoLoad="true" global="true"></model:dataset>
	<!-- 纳税类型 -->
	<model:dataset id="taxesTypeDataset" enumName="TAXES.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<!--业务查询-->
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true"
	title="->  您的位置 : 待核对人员列表">
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
				<td class="FieldLabel">姓名:</td>
				<td class="FieldInput"><input type="text" id="name" maxlength="15"
					class="TextEditor" /></td>
				<td class="FieldLabel">身份证号:</td>
				<td class="FieldInput"><input type="text" id="idCard" maxlength="18"  style="width: 80%"
					field="身份证号" class="TextEditor" /></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">核对日期:</td>
				<td class="FieldInput"><input type="text" id="checkTime"
					name="checkTime" readonly="readonly" format="Y-m-d"
					onclick="LoushangDate(this)"></td>
				<td class="FieldLabel">状态:</td>
				<td class="FieldInput"><select id="checkFlg" name="checkFlg">
					<option dataset="checkFlgDataset"></option>
				</select></td>
				<td class="FieldButton">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<!--业务查询明细-->
<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%"
	stripeRows="true" height="100%" dataset="FeedbackDataset"
	notSelectFirstRow="true" title="待核对人员列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="核对" handler="fillCheckMsg" />
		<next:ToolBarItem iconCls="edit" text="修改"
			handler="Evt_modify_onclick" />
		<next:ToolBarItem text="提交" iconCls="detail"
			handler="Evt_butcheckin_onclick"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="name" header="姓名" field="name" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="idCard" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="checkOrg" header="核对单位名称" field="checkOrg"
			width="28%">
			<next:TextField />
		</next:Column>

		<next:Column id="checkTime" header="核对日期" field="checkTime"
			width="15%">
			<next:TextField />
		</next:Column>
		<next:Column id="checkFlg" header="状态" field="checkFlg"
			dataset="checkFlgDataset1" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="FeedbackDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="socialWin" height="160" width="550" title="国税/地税信息录入" closeAction="hide">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="提交" iconCls="detail"
				handler="Evt_butcheckin_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="暂存" iconCls="save"
				handler="Evt_butsave_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="取消" iconCls="undo"
				handler="Evt_butreturn_onclick"></next:ToolBarItem>		
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="taxDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel">纳税人姓名：</td>
					<td class="FieldInput"><input id="taxesPeople" type="text" name="taxesPeople" maxlength="25" readonly="readonly"
						field="taxesPeople" /></td>
						
					<td class="FieldLabel">纳税类型</td>
					<td class="FieldInput"><select id="taxesType" name="taxesType" disabled="disabled"
						field="taxesType">
						<option dataset="taxesTypeDataset"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">纳税企业名称：</td>
					<td class="FieldInput"><input type="text" name="taxesOrg" maxlength="5"
						field="taxesOrg" /></td>

					<td class="FieldLabel">最近一年营业额（元）：</td>
					<td class="FieldInput"><input type="text" onblur="checkMoney(this.id)" align="right"
						name="turnoverLatestYear" field="turnoverLatestYear" maxlength="16"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">最近一年纳税额（元）：</td>
					<td class="FieldInput"><input type="text" onblur="checkMoney(this.id)" align="right"
						name="taxesLatestYear" field="taxesLatestYear" maxlength="16" /></td>

					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
			</table>
			</form>
		</next:Html>
</next:Window>
</body>
</html>
