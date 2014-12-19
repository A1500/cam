
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>医前救助列表</title>
<next:ScriptManager />
<script type="text/javascript">
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var userId='<%=BspUtil.getEmpOrgan().getOrganId()%>'
	var userName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
</script>
<script type="text/javascript" src="samMBeforeList.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
	<!-- 医前救助 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeQueryCmd"
		global="true" sortField="auditDate" sortDirection="desc">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalBefore"></model:record>
	</model:dataset>
	<!-- 病种 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医前救助使用状态 -->
	<model:dataset id="assBeforeStatusDataset"
		enumName="ASSISTANCE_BEFORE_STATUS" autoLoad="true">
	</model:dataset>
	<model:dataset id="beforDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalBefore"></model:record>
	</model:dataset>
	<!-- 医前救助校验 -->
	<model:dataset id="beforeCheckDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalBefore"></model:record>
	</model:dataset>
	<!-- 个人信息 -->
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
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
				<td class="FieldLabel">姓名:</td>
				<td class="FieldInput"><input type="text" maxlength="25"
					id="name" class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel">病种:</td>
				<td class="FieldInput"><select id="disease" name="disease"
					field="disease">
					<option dataset="diseaseDataset"></option>
				</select></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">使用状态:</td>
				<td class="FieldInput"><select id="status" name="status"
					field="status">
					<option dataset="assBeforeStatusDataset"></option>
				</select></td>
				<td class="FieldLabel">审批日期:</td>
				<td class="FieldInput"><input type="text" name="auditDate"
					id="auditDate" format="Y-m-d" title="审批日期" readonly="readonly"
					onclick="LoushangDate(this)"></td>
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

<next:GridPanel id="editGridPanel" name="sammedicalbeforeGrid"
	width="99.9%" stripeRows="true" height="100%" dataset="ds" title="医前救助">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="医前救助" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="name" header="姓名" field="name" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证号" field="idCard" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="disease" header="病种" field="disease"
			dataset="diseaseDataset" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column id="assitanceMon" header="救助金额（元）" field="assitanceMon"
			align="right" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="auditDate" header="审批日期" field="auditDate" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="status" header="使用状态" field="status"
			dataset="assBeforeStatusDataset" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="assitanceOrg" header="救助单位" field="assitanceOrg"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="manager" header="经办人" field="manager" width="90">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<!-- 医前救助设定 -->
<next:Window id="updateWin" closeAction="hide" title="医前救助管理"
	width="700">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="beforDS" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="100%">

			<tr>
				<td class="FieldLabel" width="15%">身份证件号码</td>
				<td class="FieldInput" width="35%"><input id="addidCard"
					type="text" style="width: 60%" name="身份证件号码" field="idCard"
					onblur="loadBeforeAssMsg()" /><font color="red">*</font></td>

				<td class="FieldLabel" width="15%">姓名</td>
				<td class="FieldInput" width="35%"><label id="addname"
					maxlength="25" type="text" name="姓名" style="width: 45%"
					field="name" /></td>
			<tr>
				<td class="FieldLabel">病种</td>
				<td class="FieldInput"><select name="病种" field="disease"
					style="width: 60%">
					<option dataset="diseaseDataset"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel">救助金额（元）</td>
				<td class="FieldInput"><input type="text" maxlength="16"
					name="救助金额" id="assitanceMony" onblur="checkAssMon(this.id)"
					style="width: 45%" field="assitanceMon" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">审批日期</td>
				<td class="FieldInput"><input type="text" name="auditDate"
					style="width: 60%" id="auditDate" format="Y-m-d" field="auditDate"
					title="审批日期" readonly="readonly" onclick="LoushangDate(this)"></td>
				<td class="FieldLabel">使用状态</td>
				<td class="FieldInput"><select id="status" name="使用状态"
					field="status" style="width: 45%">
					<option dataset="assBeforeStatusDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel">经办人</td>
				<td class="FieldInput"><input type="text" maxlength="15"
					name="经办人" style="width: 60%" field="manager" /></td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>
