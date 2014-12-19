<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>退役士兵列表</title>
<next:ScriptManager />
<script>
	var Type='<%=request.getParameter("Type")%>';
	var struId = '<%=BspUtil.getStruId()%>';
</script>
<script type="text/javascript" src="prsretiredsoldiers_list.js"></script>
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
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset" pageSize="15"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldiers">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers">
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
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
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否退档 -->
		<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>	
		
</model:datasets>

<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">安置机构：</td>
				<td class="FieldInput"><input type="text" id="domicileName"
					class="TextEditor" title="属地行政区划" onclick="func_ForDomicileSelect()" /> <input
					type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" /></td>

				<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>

				<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" /></td>
				<td class="FieldInput"></td>
			</tr>
			<tr>
				<td class="FieldLabel">户籍类别：</td>
				<td class="FieldInput"><select id="domicileType">
					<option dataset="DomicileDataset"></option>
				</select></td>

				<td class="FieldLabel" nowrap="nowrap">退伍证号：</td>
				<td class="FieldInput"><input type="text"
					id="veteransCertificateNo" class="TextEditor" title="退伍证号" /></td>
				<td class="FieldLabel" nowrap="nowrap">部队单位：</td>
				<td class="FieldInput"><input type="text" id="servedArmy"
					class="TextEditor" title="部队单位" /></td>
				<td class="FieldInput">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">入伍类型：</td>
				<td class="FieldInput"><select id="enlistType">
					<option dataset="EnlistTypeDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">服役年限：</td>
				<td class="FieldInput"><input type="text" id="servicedTime"
					class="TextEditor" title="服役年限" /></td>
				<td class="FieldLabel" nowrap="nowrap">备注：</td>
				<td class="FieldInput"><input type="text" id="note"
					class="TextEditor" title="备注" /></td>
				<td class="FieldInput">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="prsretiredsoldiersGrid"
	width="99%" stripeRows="true" height="320" style="padding: 5px;"
	dataset="retiredSoldierDataset" autoExpandColumn="address"
	notSelectFirstRow="true" title="退役士兵信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" id="detail"
			handler="detail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="name" header="姓名" field="name" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="sex" header="性别" field="sex" width="35"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="naton" header="民族" field="naton"
			dataset="NationDataset" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="enlistTime" header="入伍时间" field="enlistTime"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="enlistPlace" header="入伍地" field="enlistPlaceName"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="veteransCertificateNo" header="退伍证号"
			field="veteransCertificateNo" width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="enlistPlace" header="退伍时间" field="retiredTime"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="filesSource" header="档案来源" field="filesSource" dataset="FileResourcesDataset"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="flag" header="审核状态" field="flag"
			dataset="ApprovalDataset" width="90">
			<next:TextField />
		</next:Column>
		
		<next:Column id="tel" header="联系方式" field="tel" width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="家庭住址" field="address" width="130">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
