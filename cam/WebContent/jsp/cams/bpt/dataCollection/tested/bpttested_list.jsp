
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
<title>参试人员信息</title>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="bpttested_list.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
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
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand"
		global="true" method="queryPeople" pageSize="20">
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
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset> 
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0" autoScroll="true"
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
				<td class="FieldLabel" nowrap>属地行政区划：</td>
				<input type="hidden" name="struid" value="<%=struId %>" />
				<td class="FieldInput"><input type="hidden" id="domicileCode"/>
				<input type="text" id="domicileName" class="TextEditor"
					title="属地行政区划" onclick="query_selectDomicile()" /></td>
				<td class="FieldLabel" nowrap>姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap>身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" /></td>
				
				<td class="FieldLabel" nowrap>户籍类别：</td>
				<td class="FieldInput"><select name="domicileType"
					field="domicileType" title="户籍类别">
					<option dataset="DomicileDataset"></option>
				</select></td>
			</tr>
			<tr>
				
				
				<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
				<td class="FieldInput"><select id="warStateCode"
					 field="warStateCode" title="优抚对象状态">
					<option dataset="ObjectStateDataset"></option>
				</select></td>

				<td class="FieldLabel" nowrap>残疾等级：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="disabilityLevelCode" field="disabilityLevelCode" title="残疾等级">
					<option dataset="DisabilityLevelDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap>备注：</td>
				<td class="FieldInput"><input type="text" id="note"
					class="TextEditor" title="备注" /></td>
				
				<td colspan="2" align="center"><button id="queryButton" onclick="query()">查 询</button>&nbsp;
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid"
	width="100%" stripeRows="true" height="98%"
	dataset="BaseinfoPeopleDataSet" title="参试人员信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="查看" iconCls="detail" handler="detailTested"></next:ToolBarItem>
		<%-- <next:ToolBarItem text="Excel导入" iconCls="detail" handler="ett"/> --%>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="50" header="编号" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="domicileCode" header="属地行政区划" field="DICNAME"
			width="220">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="name" header="姓名" field="NAME" width="70">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="160">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" width="40"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="NATION" header="民族" field="NATION" width="70"
			dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="warStateCode" header="优抚对象状态"
			field="WAR_STATE_CODE" width="90" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>


		<next:Column id="forcesNo" header="原部队代号" field="FORCES_NO"
			width="150">
			<next:TextField />
		</next:Column>

		<next:Column id="testedType" header="参试类别" field="TESTED_TYPE" width="150" dataset="dsTest">
			<next:TextField />
		</next:Column>


		<next:Column id="disabilityLevelCode" header="残疾等级" field="DISABILITY_LEVEL_CODE"
			width="90" dataset="DisabilityLevelDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="NOTE" header="备注" field="NOTE" width="90">
						<next:TextField  />
					</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
