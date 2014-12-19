<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<% 
	String organType = BspUtil.getOrganType();
%>
<html>
<head>
<title>人员基本信息表列表</title>
<next:ScriptManager />
<script type="text/javascript">
			var organCode='<%=BspUtil.getOrganCode()%>';
			var organType = '<%=BspUtil.getOrganType()%>';
			var xzqu = '<%=request.getParameter("xzqu")%>';
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="mrmbasepersonbzydetail.js"></script>
<script type="text/javascript" src="../../bpt/comm/bptComm.js"></script>
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmBasePerson">
			<model:field name="status" />
		</model:record>
	</model:dataset>

	<model:dataset id="excelDs"
		cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmBasePerson">
			<model:field name="status" />
		</model:record>
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
	<!-- 岗位状态 -->
	<model:dataset id="workstateDataset" enumName="MRM.WORK.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 计算机管理类型 -->
	<model:dataset id="computerTypeDataset" enumName="MRM.COMPUTERTYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 职务 -->
	<model:dataset id="zwDataset" enumName="MRM.ZW.TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 是否颁证员 -->
	<model:dataset id="bzycodeDataset" enumName="MRM.BZYCODE.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" autoScroll="true" autoHeight="true"
	border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
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
				<td class="FieldLabel" nowrap="nowrap">姓名:</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap="nowrap">民族:</td>
				<td class="FieldInput"><select id="nation" name="nation"
					title="民族">
					<option dataset="NationDataset" />
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">性别:</td>
				<td class="FieldInput"><select id="sex" name="sex" title="性别">
					<option dataset="SexDataset" />
				</select></td>
				<td class="FieldLabel" align="center">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">出生日期:</td>
				<td class="FieldInput"><input type="text" id="birthDate"
					name="birthDate" title="出生日期" format="Y-m-d" /><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this)" /></td>

				<td class="FieldLabel" nowrap="nowrap">身份证件号:</td>
				<td class="FieldInput"><input type="text" id="cardNo"
					class="TextEditor" title="身份证件号" /></td>
				<td class="FieldLabel" nowrap>婚姻登记机关:</td>
				<td class="FieldInput"><input type="text" id="deptName"
					onclick="forHelp()" readonly="readonly" title="婚姻登记机关" /> <input
					type="hidden" id="deptId" name="deptId" /></td>
				<td class="FieldLabel" align="center">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="mrmbasepersonGrid" width="100%"
	stripeRows="true" height="98%" dataset="ds" notSelectFirstRow="true"
	title="人员基本信息表">
	<next:TopBar>
	<next:ToolBarItem id="qrToolbar" text=""></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印资格证书" iconCls="dy" handler="dyzgzs" />
		<next:ToolBarItem text="撤销颁证员" iconCls="add" handler="bzySet" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonQuery" />
		<next:ToolBarItem text="导出" iconCls="chart" handler="emportExcel" />

	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="deptName" header="登记处" field="deptName" width="150"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="name" header="姓名" field="name" width="60"
			renderer="detailHref" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="sex" header="性别" field="sex" width="50"
			dataset="SexDataset" align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="technical" header="职务" field="technical" width="90"
			dataset="zwDataset" align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="cardNo" header="身份证件号" field="cardNo" width="170"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="bzyzgzh" header="资格证编号" field="bzyzgzh"
			width="100" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="workstate" header="岗位状态" field="workstate" width="60"
			dataset="workstateDataset" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="bzyCode" header="是否颁证员" field="bzyCode" width="120"
			dataset="bzycodeDataset" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="computerType" header="系统操作权限" field="computerType"
			width="100" align="center" dataset="computerTypeDataset">
			<next:TextField />
		</next:Column>

		<next:Column id="marryStartDate" header="从事婚姻工作开始时间"
			field="marryStartDate" align="center" width="150">
			<next:TextField />
		</next:Column>
		<next:Column id="marryEndDate" header="培训状态" field="status"
			width="120" renderer="getStatus" align="center">
			<next:TextField />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
<input type="hidden" id="docpath" value="" />
<input type="hidden" id="personId" name="printQuery"
	queryData="queryData" value="" />
<input type="hidden" id="method" value="printMrmPerson" />
<input type="hidden" id="scaconfPath"
	value="mrmBasePerson/mrmBasePersonPrintDao" />
</html>
