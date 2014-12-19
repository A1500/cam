<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>婚姻登记查询</title>
<script type="text/javascript">
	var regionCode ='<%= request.getParameter("regionCode") %>';
	var _dateTemp = (new Date()).valueOf();
</script>
<next:ScriptManager />
<script type="text/javascript" src="common.js"></script>
<script type="text/javascript" src="marry_list.js"></script>
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
	
	<!--	男方行政区划-联动-父	-->
	<model:dataset id="xzqhDs_Base" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code" method="getCacheRegion">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	男方行政区划-联动-子	-->
	<model:dataset id="xzqhDs_Sub" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	男方行政区划-联动-子-子	-->
	<model:dataset id="xzqhDs_Sub_Sub" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	女方行政区划-联动-父	-->
	<model:dataset id="xzqhDs_BaseW" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code" method="getCacheRegion">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	女方行政区划-联动-子	-->
	<model:dataset id="xzqhDs_SubW" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
		</model:record>
	</model:dataset>
	
	<!--	女方行政区划-联动-子-子	-->
	<model:dataset id="xzqhDs_Sub_SubW" cmd="com.inspur.cams.marry.region.cmd.MarryregionCommand" global="true" pageSize="-1"
		sortField="code">
		<model:record fromBean="com.inspur.cams.marry.region.data.Marryregion">
			<model:field name="value" mapping="id" type="string"/>
			<model:field name="text" mapping="name" type="string"/>
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

	<!--	婚姻登记信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.reg.cmd.MarryregQueryCommand" global="true"
		pageSize="10">
		<model:record fromBean="com.inspur.cams.marry.reg.data.Marryreg"></model:record>
	</model:dataset>

</model:datasets>

<%
Calendar c = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
%>
<next:Panel name="form" width="100%" border="0" autoHeight="true">
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
				<td class="FieldInput" colspan="7">
					<select id="deptCode" title="登记机关" style="width: 180px;"><option dataset="djjgDs_Base" ></option></select>
					<select id="deptCodeSub" title="登记机关" style="width: 200px;"><option dataset="djjgDs_Sub" ></option></select>
					<select id="deptCodeSubSub" title="登记机关" style="width: 200px;"><option dataset="djjgDs_Sub_Sub" ></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">业务类别:</td>
				<td class="FieldInput" colspan="3"><select id="opType" title="业务类别">
					<option dataset="ywlbDs"></option>
				</select></td>
				<td class="FieldLabel">登记日期:</td>
				<td class="FieldInput" colspan="3">
				<input type="text"  id="opDate" name="opDate" class="TextEditor" maxlength="10"  onpropertychange="changeDateStyle(this)" value='<%=c.get(Calendar.YEAR)%>-01-01'  format="Y-m-d"/>
				<img  src="<%=SkinUtils.getImage(request,"default/rl.gif")%>" align="middle" onclick="getTimes('opDate');" /> 
				&nbsp;&nbsp;至
				<input type="text"  id="opDateTo" name="opDateTo" class="TextEditor" maxlength="10"  onpropertychange="changeDateStyle(this)" value='<%=sdf.format(c.getTime())%>' format="Y-m-d"/>
				<img  src="<%=SkinUtils.getImage(request,"default/rl.gif")%>" align="middle" onclick="getTimes('opDateTo');" /> 
				</td>
			</tr> 
			<tr>
				<td class="FieldLabel">男方姓名:</td>
				<td class="FieldInput">
					<input type="text"  id="nameMan" class="TextEditor" title="男方姓名"  style="width: 70px;"/>
				</td>
				<td class="FieldLabel">男方证件号码:</td>
				<td class="FieldInput">
					<input type="text"  id="certNumMan" class="TextEditor" title="男方证件号码"  style="width: 140px;"/>
				</td>
				<td class="FieldLabel">女方姓名:</td>
				<td class="FieldInput">
					<input type="text"  id="nameWoman" class="TextEditor" title="女方姓名"  style="width: 70px;"/>
				</td>
				<td class="FieldLabel">女方证件号码:</td>
				<td class="FieldInput">
					<input type="text"  id="certNumWoman" class="TextEditor" title="女方证件号码" style="width: 140px;"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">男方行政区划:</td>
				<td class="FieldInput" colspan="3">
					<select id="regionCode" title="男方行政区划" style="width: 80px;"><option dataset="xzqhDs_Base" ></option></select>
					<select id="regionCodeSub" title="男方行政区划" style="width: 80px;"><option dataset="xzqhDs_Sub" ></option></select>
					<select id="regionCodeSubSub" title="男方行政区划" style="width: 80px;"><option dataset="xzqhDs_Sub_Sub" ></option></select>
				</td>
				<td class="FieldLabel">女方行政区划:</td>
				<td class="FieldInput" colspan="3">
					<select id="regionCodeW" title="女方行政区划" style="width: 80px;"><option dataset="xzqhDs_BaseW" ></option></select>
					<select id="regionCodeSubW" title="女方行政区划" style="width: 80px;"><option dataset="xzqhDs_SubW" ></option></select>
					<select id="regionCodeSubSubW" title="女方行政区划" style="width: 80px;"><option dataset="xzqhDs_Sub_SubW" ></option></select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="8">
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
	stripeRows="true" height="100%" dataset="ds" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="查询结果"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出为Excel" iconCls="detail" handler="exportExcel"/>
		<next:ToolBarItem text="详细信息" iconCls="add" handler="queryDetails" />
		<next:ToolBarItem symbol=""></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="certNo2" header="登记字号" field="certNo" width="220" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="nameMan2" header="男方姓名" field="nameMan" width="75" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="certNumMan2" header="男方身份证号" field="certNumMan" width="150" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="nameWoman2" header="女方姓名" field="nameWoman" width="75" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="certNumWoman2" header="女方身份证号" field="certNumWoman" width="150" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="opDate2" header="登记日期" field="opDate" width="80" sortable="true">
			<next:DateField format="Y-m-d" />
		</next:Column>

		<next:Column id="opType2" header="业务类型" field="opType" width="120" renderer="ywlbRenderer" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="deptName2" header="登记机关" field="deptName" width="190">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
