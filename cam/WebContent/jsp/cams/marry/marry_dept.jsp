<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>婚姻登记机关查询</title>
<script type="text/javascript">
	var regionCode ='<%= request.getParameter("regionCode") %>';
	var _dateTemp = (new Date()).valueOf();
</script>
<next:ScriptManager />
<script type="text/javascript" src="marry_dept.js"></script>
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
	<!--	机构类型字典		-->
	<model:dataset id="jglxDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	
	<!--	机构性质字典		-->
	<model:dataset id="jgxzDs"
		cmd="com.inspur.cams.marry.base.cmd.MarrydicCommand" global="true"
		pageSize="-1" method="getCacheDic">
		<model:record fromBean="com.inspur.cams.marry.base.data.Marrydic">
			<model:field name="value" mapping="dicValue" type="string" />
			<model:field name="text" mapping="dicName" type="string" />
		</model:record>
	</model:dataset>
	
	<!--	行政区划-联动-父	-->
	<model:dataset id="xzqhDs_Base" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code" method="getCacheRegion">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	行政区划-联动-子	-->
	<model:dataset id="xzqhDs_Sub" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	行政区划-联动-子-子	-->
	<model:dataset id="xzqhDs_Sub_Sub" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	行政区划信息	-->
	<model:dataset id="xzqhDs"
		cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion"></model:record>
	</model:dataset>

	<!--	婚姻登记机关信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.dept.cmd.MarrydeptCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.dept.data.Marrydept"></model:record>
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
				<td class="FieldLabel">行政区划:</td>
				<td class="FieldInput" colspan="3">
					<select id="regionCode" title="行政区划" style="width: 180px;"><option dataset="xzqhDs_Base" ></option></select>
					<select id="regionCodeSub" title="行政区划" style="width: 200px;"><option dataset="xzqhDs_Sub" ></option></select>
					<select id="regionCodeSubSub" title="行政区划" style="width: 200px;"><option dataset="xzqhDs_Sub_Sub" ></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">机构名称:</td>
				<td class="FieldInput">
					<input type="text"  id="name" class="TextEditor" title="姓名"  style="width: 250px;"/>
				</td>
				<td class="FieldLabel">机构类型:</td>
				<td class="FieldInput">
					<select id="adminType" title="机构类型" style="width: 250px;"><option dataset="jglxDs" ></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">机构性质:</td>
				<td class="FieldInput">
					<select id="type" title="机构性质" style="width: 250px;"><option dataset="jgxzDs" ></option></select>
				</td>
				
				<td class="FieldLabel">机构状态:</td>
				<td class="FieldInput">
					<select id="validFlag" title="人员状态" style="width: 250px;"><option dataset="jgztDs" ></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="4"><label
					style="text-align: left; width: 100%">&nbsp;</label>
				<button onclick="query()">查 询</button>
				&nbsp;&nbsp;
				<button type="reset" onclick="resetApply()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%"
	stripeRows="true" height="100%" dataset="ds" title="查询婚姻登记机关列表"
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
		<next:Column id="deptCode" header="单位统一编号" field="deptCode" width="90" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="regionCode" header="所属行政区" field="regionCode" width="135" renderer="xzqhRenderer" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="name" header="机构名称" field="name" width="220" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="adminType" header="机构类型" field="adminType" width="100" renderer="jglxRenderer" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="type" header="机构性质" field="type" width="130" renderer="jgxzRenderer" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="creatDate" header="创建日期" field="creatDate" width="80" sortable="true">
			<next:DateField format="Y-m-d" />
		</next:Column>

		<next:Column id="validFlag" header="机构状态" field="validFlag" width="80" renderer="ryztRenderer">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
