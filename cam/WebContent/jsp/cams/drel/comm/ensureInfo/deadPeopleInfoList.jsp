<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>核查业务反馈列表</title>
<next:ScriptManager></next:ScriptManager>

<script type="text/javascript">
var familyId = '<%=request.getParameter("familyId")%>';
function init(){
	peopleListDataSet.setParameter("familyId",familyId);
	peopleListDataSet.load();
}
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  method='queryCremationInfo'>
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">人员姓名：</td>
					<td class="FieldInput" style="width:36%"><input id="feedBackTime"/></td>
					<td class="FieldButton" style="width:20%">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="peopleListDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail"  text="明细" /> 
	</next:TopBar>
	<next:Columns>
				 <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column  id="name" field="NAME" header="姓名" width="150">
					<next:TextField editable="false"/>
				</next:Column>
				
				<next:Column field="SEX" header="性别" width="150">
					<next:ComboBox editable="false" dataset="sexDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="ID_CARD" header="身份证号" width="150" >
					<next:TextField editable="false"/>
				</next:Column>
				<next:Column   field="BIRTHDAY" header="出生日期" width="150">
					<next:TextField editable="false"/>
				</next:Column>
				<next:Column   field="AGE" header="年龄" width="150" >
					<next:TextField editable="false"/>
				</next:Column>
				<next:Column  field="FAMILY_ADD" header="家庭住址 " width="300" >
					<next:TextField editable="false"/>
				</next:Column>
				<next:Column   field="CREMATION_TIME" header="火化时间" width="150">
					<next:TextField editable="false"/>
				</next:Column>
				<next:Column   field="CREATE_ORGAN_NAME" header="火化单位" width="150" align='right'>
					<next:TextField editable="false"/>
				</next:Column>
				
			</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleListDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>