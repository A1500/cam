<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organCode = BspUtil.getOrganCode();
%>
<html>
<head>
<title>辅导员信息表</title>
<next:ScriptManager />

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
			var organ_Code = '<%=organCode%>';
			var organType = '<%=BspUtil.getOrganType()%>';
		</script>
		<script type="text/javascript" src="mrmfdy_list.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.base.cmd.MrmFdyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmFdy">
			<model:field name="workbegintime" />
			<model:field name="workendtime" />
			<model:field name="deptName"/>
		</model:record>
	</model:dataset>
	
	<model:dataset id="excelDs"
		cmd="com.inspur.cams.marry.base.cmd.MrmFdyQueryCommand" global="true"  pageSize="0">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmFdy">
			<model:field name="workbegintime" />
			<model:field name="workendtime" />
			<model:field name="deptName"/>
		</model:record>
	</model:dataset>
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 学历 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 人员来源 -->
	<model:dataset id="RylyDataset" enumName="MRM.RYCODE.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 专业 -->
	<model:dataset id="zyDataset" enumName="MRM.ZY.TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 专业资格证 -->
	<model:dataset id="zyzgzDataset" enumName="MRM.ZYZGZ.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 95%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">姓名:</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel">人员来源:</td>
				<td class="FieldInput"><select id="ryly" name=""
					ryly"" title="人员来源">
					<option dataset="RylyDataset" />
				</select></td>
				<td class="FieldLabel">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			
			<tr>
				<td class="FieldLabel" nowrap>婚姻登记机关:</td>
				<td class="FieldInput"><input type="text"  id="deptName" onclick="forHelp()" readonly="readonly"   title="婚姻登记机关"  />
				<input type="hidden" id="deptId" name="deptId" /></td>	
				<td class="FieldLabel">专业:</td>
				<td class="FieldInput"><select id="zhuanye" name="专业"
					ryly"" title="专业">
					<option dataset="zyDataset" />
				</select></td>
				<td class="FieldLabel">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="mrmfdyGrid" width="100%"
	stripeRows="true" height="100%" dataset="ds" title="辅导员信息列表">
	<%
		if (!"0000000000".equals(organCode.substring(2))
					&& !"00000000".equals(organCode.substring(4))
					&& "000000".equals(organCode.substring(6))) {
	%>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonExamapply" />
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
	</next:TopBar>
	<%
		}else{
	%>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonExamapply" />
		<next:ToolBarItem text="导出" iconCls="chart" handler="emportExcel" />
	</next:TopBar>
	<%
		}
	%>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		
		<next:Column id="name" header="服务机关" field="deptName" align="center"
			width="160">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="name" header="姓名" field="name" renderer="detailHref" align="center"
			width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="xb" header="性别" field="xb" width="90" align="center"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="nl" header="出生日期" field="nl" width="120" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="hyzk" header="学历" field="hyzk" width="90"
			align="center" dataset="EducationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="zy" header="专业" field="zy" align="center" width="90"
			dataset="zyDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="zc" header="职称" field="zc" align="center" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="zyzgz" header="专业资格证" field="zyzgz" align="center"
			width="90" dataset="zyzgzDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="ryly" header="人员来源" field="ryly" width="90"
			align="center" dataset="RylyDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="qtqk" header="其他情况" field="qtqk" width="150"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="bz" header="辅导安排" field="bz" width="150"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="workbegintime" header="工作开始时间" field="workbegintime"
			align="center" width="150">
			<next:TextField />
		</next:Column>
		<next:Column id="workendtime" header="工作结束时间" field="workendtime"
			align="center" width="150">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
<input type="hidden" id="docpath" value=""/>
<input type="hidden" id="fdyId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="mrmFdy/mrmFdyDao"/>
</html>
