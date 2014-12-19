<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>婚姻登记人员查询</title>
<script type="text/javascript">
	var regionCode ='<%= request.getParameter("regionCode") %>';
	var _dateTemp = (new Date()).valueOf();
</script>
<next:ScriptManager />
<script type="text/javascript" src="marry_person.js"></script>
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
	<!--	人员性质字典		-->
	<model:dataset id="ryxzDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	
	<!--	业务类别字典		-->
	<model:dataset id="ywlbDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	
	<!--	登记机关字典	-->
	<model:dataset id="djjgDs" cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true" pageSize="-1"
		sortField="deptCode" method="getCacheDept">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	登记机关-联动-父	-->
	<model:dataset id="djjgDs_Base" cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true" pageSize="-1"
		sortField="deptCode" method="getCacheDept">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	登记机关-联动-子	-->
	<model:dataset id="djjgDs_Sub" cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true" pageSize="-1"
		sortField="deptCode">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	登记机关-联动-子-子	-->
	<model:dataset id="djjgDs_Sub_Sub" cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true" pageSize="-1"
		sortField="deptCode">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>

	<!--	婚姻登记人员信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.person.cmd.MarrypersonCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.person.data.Marryperson"></model:record>
	</model:dataset>

</model:datasets>

<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
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
				<td class="FieldLabel">登记机关:</td>
				<td class="FieldInput" colspan="3">
					<select id="deptCode" title="登记机关" style="width: 180px;"><option dataset="djjgDs_Base" ></option></select>
					<select id="deptCodeSub" title="登记机关" style="width: 200px;"><option dataset="djjgDs_Sub" ></option></select>
					<select id="deptCodeSubSub" title="登记机关" style="width: 200px;"><option dataset="djjgDs_Sub_Sub" ></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">姓名:</td>
				<td class="FieldInput">
					<input type="text"  id="name" class="TextEditor" title="姓名"  style="width: 250px;"/>
				</td>
				<td class="FieldLabel">证件号码:</td>
				<td class="FieldInput">
					<input type="text"  id="cardNo" class="TextEditor" title="男方证件号码"  style="width: 250px;"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">人员性质:</td>
				<td class="FieldInput">
					<select id="kind" title="人员性质" style="width: 250px;"><option dataset="ryxzDs" ></option></select>
				</td>
				
				<td class="FieldLabel">人员状态:</td>
				<td class="FieldInput">
					<select id="validFlag" title="人员状态" style="width: 250px;"><option dataset="ryztDs"></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="4"><label
					style="text-align: left; width: 100%">&nbsp;</label>
				<button onclick="query()">查 询</button>
				&nbsp;&nbsp;
				<button type="reset" onclick="resetApply();">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%"
	stripeRows="true" height="100%" dataset="ds" title="查询婚姻登记人员列表"
	notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="查询结果:"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出为Excel" iconCls="detail" handler="exportExcel"/>
		<next:ToolBarItem text="详细信息" iconCls="add" handler="queryDetails" />
		<next:ToolBarItem symbol=""></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="code" header="登记员编号" field="code" width="90" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="name" header="姓名" field="name" width="75" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="birthDate" header="出生日期" field="birthDate" width="80" sortable="true">
			<next:DateField format="Y-m-d" />
		</next:Column>
		
		<next:Column id="cardNo" header="身份证号" field="cardNo" width="150" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="deptCode" header="所属部门" field="deptCode" width="220" renderer="djjgRenderer" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="kind" header="人员性质" field="kind" width="100" renderer="ryxzRenderer" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="validFlag" header="人员状态" field="validFlag" width="80" renderer="ryztRenderer">
			<next:TextField />
		</next:Column>
		
		<next:Column id="validFlag" header="在线状态" field="validFlag" width="80" renderer="zxztRenderer">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
