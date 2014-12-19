
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
<title>年满60周岁农村籍退役士兵</title>
<next:ScriptManager />
<script type="text/javascript" src="idCardSelect.js"></script>
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
<%
	String struId = BspUtil.getStruId();
	
%>
</head>
<body>
<model:datasets>
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BptApplyCountrySoldierQueryCommand"
		global="true" method="queryCountrysoldier">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		</model:record>
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
		
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
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
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="98%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears"></next:ToolBarItem>
		</next:TopBar>
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
				<td class="FieldLabel" nowrap>所属机构：</td>
				<input type="hidden" name="struid" value="<%=struId %>" />
				<td class="FieldInput"><input type="hidden" id="domicileCode"/>
				<input type="text" id="domicileName" class="TextEditor"
					title="属地行政区划" onclick="forHelp()" /></td>
				<td class="FieldLabel" nowrap>姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap>身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" /></td>
				
				<td align="center"><button onclick="query()">查 询</button></td>
			</tr>
			<tr>
				
					<td class="FieldLabel" nowrap>服役部队名称(番号)：</td>
				<td class="FieldInput">
				<input type="text" id="forcesName"  title="服役部队名称(番号)" />
				</td>

				<td class="FieldLabel" nowrap>服义务兵开始时间：</td>
				<td class="FieldInput">
				<input type="text" id="soldierStartDate"  title="服义务兵开始时间" format="Y-m-d" style="width: 100px;" maxlength="10" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);">
				</td>
				<td class="FieldLabel" nowrap>服义务兵结束时间：</td>
				<td class="FieldInput">
				<input type="text" id="soldierEndDate" style="width: 100px;" format="Y-m-d" title="服义务兵结束时间"/><img src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);">
				</td>
				<td align="center"><button onclick="reset()">重 置</button></td>
				
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid"
	width="98%" stripeRows="true" height="98%"
	dataset="BaseinfoPeopleDataSet" title="年满60周岁农村籍退役士兵" notSelectFirstRow="true">
		<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn header="序号" width="45"/>
	     <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column  header="属地行政区划" field="FULL_NAME" width="180">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="姓名" field="NAME" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="性别" field="SEX" width="60" dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="民族" field="NATION" width="60"  dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column  header="年龄" field="AGE" width="90" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="soldierStartDate" header="服义务兵开始时间" field="SOLDIER_START_DATE" width="120" align="center">
			<next:TextField/>
		</next:Column>
		<next:Column id="soldierEndDate" header="服义务兵结束时间" field="SOLDIER_END_DATE" width="120" align="center">
			<next:TextField/>
		</next:Column>
		<next:Column id="soldierYears" header="服役折算年限" field="SOLDIER_YEARS" width="90" align="right">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
