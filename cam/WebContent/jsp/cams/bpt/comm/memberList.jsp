<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>家庭成员列表</title>
		<next:ScriptManager/>
		<script language="javascript">
			var familyId='<%=request.getParameter("familyId")%>';
			var fPeopleId='<%=request.getParameter("peopleId")%>';
		</script>
		<script type="text/javascript" src="memberList.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="queryTotalDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleNumInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
				<model:field name="CHILD" type="string" />
				<model:field name="ALLPEOPLE" type="string" />
				<model:field name="OLD" type="string" />
		</model:record>
	</model:dataset>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
				<model:field name="domicileName" type="string" />
				<model:field name="apanageName" type="string" />
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
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  height="10%" width="100%"  autoScroll="true" id="querytotal">
				<next:Html>
					<form id="queryTotalForm" method="post"
						 onsubmit="return false" dataset="queryTotalDataset"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
					     <tr>
							<td class="FieldLabel"  nowrap style="width:15%">家庭人口数：</td>
							<td class="FieldInput" style="width:15%" nowrap="nowrap"><label field="ALLPEOPLE" ></label></td>
						    <td class="FieldLabel" style="width:15%">18岁以下人数：</td>
							<td class="FieldInput" style="width:15%"><label field="CHILD"></label></td>
							<td class="FieldLabel" nowrap style="width:15%">60岁以上人数：</td>
							<td class="FieldInput"  style="width:15%"><label name="relationshipType" field="OLD"  ></label></td>
						</tr>
						</table>
				   </form>
			</next:Html>
		</next:Panel>
<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="BaseinfoPeopleDataSet" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    
	    <next:Column id="domicileCode" header="属地行政区划" field="domicileName" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="name" header="姓名" field="name" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="idCard" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sex" header="性别" field="sex" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="birthday" header="出生日期" field="birthday" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
				
		<next:Column id="nation" header="民族" field="nation" width="70" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
		    
		<next:Column id="relationshipType" header="与户主关系" field="relationshipType" width="120" dataset="RelationshipTypeDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="eduCode" header="文化程度" field="eduCode" width="120"  dataset="EducationDataset">
			<next:TextField  />
		</next:Column>
	

		<next:Column id="marriageCode" header="婚姻状况" field="marriageCode" width="90" hidden="true" dataset="MarriageDataset" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="careerCode" header="职业" field="careerCode" width="120" dataset="CareerDataset">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" dataset="DomicileDataset" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="telMobile" header="手机" field="telMobile" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
