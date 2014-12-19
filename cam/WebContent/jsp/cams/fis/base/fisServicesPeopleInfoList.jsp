<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>服务机构人员信息</title>
<next:ScriptManager />

<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="fisServicesPeopleInfoList.js"></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
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
	<!-- 服务机构人员信息 -->
	<model:dataset id="fisPeoInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesPeopleInfoQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisServicesPeopleInfo"></model:record>
	</model:dataset>
	<!-- 服务机构信息 -->
	<model:dataset id="fisServicesOrganManageDs"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesOrganManageQueryCmd"
		global="true" pageSize="-1" sortField="unitId">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisServicesOrganManage">
			<model:field name="value" mapping="unitId" type="string"/>
			<model:field name="text" mapping="unitName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 职务 -->
	<model:dataset id="fisPostionDS" enumName="FIS.POSITION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 行政级别 -->
	<model:dataset id="fisProfessionDS" enumName="FIS.PROFESSION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 男女 -->
	<model:dataset id="commSexDS" enumName="COMM.SEX" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="fisEducation" enumName="FIS.EDUCATION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工种 -->
	<model:dataset id="fisWorkType" enumName="FIS.WORK.TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 编制性质 -->
	<model:dataset id="fisPeopleTypeDS" enumName="FIS.PEOPLE.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this)" /> </legend>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel">姓名</td>
				<td class="FieldInput"><input type="text" name="qName"
					id="qName" /></td>
				<td class="FieldLabel">编制性质</td>
				<td class="FieldInput"><select name="qSex" id="qPeopleType">
					<option dataset="fisPeopleTypeDS"></option>
				</select></td>
	<%-- 			<td class="FieldLabel">工种</td>
				<td class="FieldInput"><select name="qWorkType" id="qWorkType">
					<option dataset="fisWorkType"></option>
				</select></td>--%>
			</tr>
			<tr>
				<td nowrap="nowrap" class="FieldLabel" colspan="6">
				<button onclick="query()">查 询</button>
				&nbsp;
				<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="serviceUsePeoGrid" name="funeralServiceUseResource"
	stripeRows="true" height="100%" width="100%" dataset="fisPeoInfoDS"
	notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="查询结果"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="addFuneral" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="updateFuneral" />
		<next:ToolBarItem text="导出" iconCls="export" handler="print"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column id="peopleId" header="人员编号" field="peopleId" width="90"
			hidden="true" />

		<next:Column id="name" header="人员姓名" field="name" width="80"
			renderer="detailHref" align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="sex" header="性别" field="sex" dataset="commSexDS"
			width="50" align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="idCard" header="身份证件号" field="idCard" width="140"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="PEOPLE_TYPE" header="编制性质" field="peopleType"
			width="70" align="center" dataset="fisPeopleTypeDS">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="EDUCATION" header="文化程度" field="education" width="70"
			align="center" dataset="fisEducation">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="PROFESSION" header="行政级别" field="profession"
			width="70" align="center" dataset="fisProfessionDS">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="POSITION" header="职务" field="position" width="80"
			align="center" dataset="fisPostionDS">
			<next:TextField />
		</next:Column>

		<next:Column id="phone" header="联系电话" field="phone" width="100"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="workDate" header="从业日期" field="workDate" width="90"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="createOrgan" header="所属单位" field="createOrgan" 
			width="120" align="left" renderer="rendererCreateOrgan" >
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisPeoInfoDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>