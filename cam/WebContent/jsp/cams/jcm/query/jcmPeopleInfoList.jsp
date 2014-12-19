<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>人员基本信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleInfoDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
	</model:dataset>
	<!-- 是否-->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 有无-->
	<model:dataset id="comm_haveorno" enumName="COMM.HAVEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
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
</model:datasets>
<next:Panel width="100%" border="0" >
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%">姓名：</td>
					<td class="FieldInput" style="width:18%"><input type="text"  id="qName" /></td>
					<td class="FieldLabel" style="width:15%">性别：</td>
					<td class="FieldInput" style="width:18%"><select id="qSex" >
						<option dataset="sex"></option></select>
					</td>
					<td class="FieldLabel" style="width:15%">身份证号：</td>
					<td class="FieldInput" style="width:18%"><input type="text"  id="qIdCard" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">民族：</td>
					<td class="FieldInput" style="width:18%"><select  id="qNation" >
					<option dataset="NationDataset"></option></select>
					</td>
					<td class="FieldLabel" style="width:15%">出生年月：</td>
					<td class="FieldInput" style="width:18%"><input onclick="LoushangDate(this)" readonly="readonly" format="Y-m-d" type="text"  id="qBirthday" /></td>
					<td class="FieldLabel" style="width:15%">政治面貌：</td>
					<td class="FieldInput" style="width:18%"><select   id="qPolitical" >
						<option dataset="sorgPoliticsDS"></option>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">学历：</td>
					<td class="FieldInput" style="width:18%"><select id="qEdu" >
						<option dataset="eduDataSet"></option>
					</td>
					<td class="FieldLabel" style="width:15%">家庭住址：</td>
					<td class="FieldInput" style="width:18%" colspan="2"><input type="text" style="width:300"  id="qAdd" /></td>
					<td class="FieldButton" style="width:20%">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重置</button>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="jcmPeopleInfoDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert" hidden="true"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export" text="导出Excel" handler="exportExcel()" hidden="true"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleId" hidden="true" header="主键" width="15%" sortable="false"/>
		<next:Column field="companyId" hidden="true"  header="单位主键" width="15%" sortable="false"/>
		<next:Column field="photoId" hidden="true" header="人员照片ＩＤ" width="15%" sortable="false"/>
		<next:Column renderer="DetailsRendener" field="peopleName" header="姓名" width="15%" sortable="false"/>
		<next:Column field="peopleSex" header="性别" dataset="sex" width="15%" sortable="false"/>
		<next:Column field="peopleCard" header="身份证号" width="15%" sortable="false"/>
		<next:Column field="peopleBirthday" header="出生年月" width="15%" sortable="false"/>
		<next:Column field="peoplePolitics" header="政治面貌" dataset="sorgPoliticsDS" width="15%" sortable="false"/>
		<next:Column field="peopleNation" header="民族" width="15%" dataset="NationDataset" sortable="false"/>
		<next:Column field="peopleEdu" header="学历" dataset="eduDataSet" width="15%" sortable="false"/>
		<next:Column field="peopleSchool" header="毕业院校" width="15%" sortable="false"/>
		<next:Column field="peopleAdress" header="家庭住址" width="15%" sortable="false"/>
		<next:Column field="jobStartTime" header="参加工作时间" width="15%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>