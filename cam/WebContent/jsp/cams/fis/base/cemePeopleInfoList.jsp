<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>工作人员信息</title>
<next:ScriptManager />
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="cemePeopleInfoList.js">
		</script>
<script type="text/javascript">
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisPeopleInfoQueryCmd" global="true"
		sortField="CREATE_ORGAN ASC,PEOPLE_ID">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisPeopleInfo"></model:record>
	</model:dataset>

	<!-- 政治面貌-->
	<model:dataset id="sorgPoliticsDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="fisEducation" enumName="FIS.EDUCATION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 男女-->
	<model:dataset id="fisSex" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 编制性质 -->
	<model:dataset id="fisPeopleTypeDS" enumName="FIS.PEOPLE.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 行政级别 -->
	<model:dataset id="fisProfessionDS" enumName="FIS.PROFESSION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 职务 -->
	<model:dataset id="fisPostionDS" enumName="FIS.POSITION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工种 -->
	<model:dataset id="fisWorkTypeDS" enumName="FIS.WORK.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="fisYesOrNo" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 专业技术等级 -->
	<model:dataset id="fisProfessionLevelDS"
		enumName="FIS.PROFESSION.LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="queryPanel" width="100%">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this);" /> </legend>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel"><label>姓名:</label></td>
				<td class="FieldInput"><input type="text" id="qName" /></td>
				<td class="FieldLabel"><label>是否离岗:</label></td>
				<td class="FieldInput"><select id="qIfCancel">
					<option dataset="fisYesOrNo"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="4">
				<button onclick="query();">查 询</button>
				&nbsp;
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" dataset="ds" name="ds" width="100%"
	notSelectFirstRow="true" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text=""></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出" iconCls="export" handler="print"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:Column id="PEOPLE_ID" header="人员编号" field="peopleId" width="90"
			hidden="true" />
		<next:Column id="ORGAN_ID" header="人员内码" field="organId" width="90"
			hidden="true" />
		<next:Column id="NAME" header="姓名" field="name" width="100"
			align="center" renderer="detailHref">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="SEX" header="性别" field="sex" width="50"
			align="center" dataset="fisSex">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="ID_CARD" header="身份证件号" field="idCard" width="140"
			align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="PEOPLE_TYPE" header="编制性质" field="peopleType"
			width="70" align="center" dataset="fisPeopleTypeDS">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="POLITICAL" header="政治面貌" field="political" width="70"
			align="center" dataset="sorgPoliticsDS" hidden="true">
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
		<next:Column id="POSITION" header="职务" field="position" width="70"
			align="center" dataset="fisPostionDS">
			<next:TextField />
		</next:Column>
		<next:Column id="PHONE" header="联系电话" field="phone" width="100"
			align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="WORK_DATE" header="从业日期" field="workDate" width="80"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="IF_CANCEL" header="是否离岗" field="ifCancel"
			dataset="fisYesOrNo" width="80" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="CREATE_ORGAN_NAME" header="所属殡仪馆"
			field="createOrganName" width="130" align="left">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>