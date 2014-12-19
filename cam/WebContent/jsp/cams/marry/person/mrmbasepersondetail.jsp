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
<title>人员基本信息表列表</title>
<next:ScriptManager />
<script type="text/javascript">
			var organCode='<%=BspUtil.getOrganCode()%>';
			var organType = '<%=BspUtil.getOrganType()%>';
			var xzqu = '<%=request.getParameter("xzqu")%>';
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="mrmbasepersondetail.js"></script>
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
		global="true" pageSize="0">
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
	<!-- 是否编制 -->
	<model:dataset id="yesornoDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
    <!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 学历 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 年度 -->
	<model:dataset id="ndYearDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_QUALIFICATION_EXAM'></model:param>
			<model:param name="value" value='ND_YEAR'></model:param>
			<model:param name="text" value='ND_YEAR'></model:param>
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
<!-- 人员性质 -->
	<model:dataset id="kindDataset" enumName="MRM.KIND.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 编制性质 -->
	<model:dataset id="FormationDataset" enumName="MRM.FORMATION.NATURE"
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
				<td class="FieldLabel" nowrap>年龄:</td>
				<td class="FieldInput"><input type="text" id="queryAge" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>政治面貌:</td>
				<td class="FieldInput"><select id="politics" name="politics"
					title="政治面貌">
					<option dataset="PoliticalDataset" />
				</select></td>
				<td class="FieldLabel" nowrap>编制性质:</td>
				<td class="FieldInput"><select id="kind" name="kind"
					title="编制性质">
					<option dataset="kindDataset" />
				</select></td>
				<td class="FieldLabel" nowrap>岗位状态:</td>
				<td class="FieldInput"><select name="workstate"
					id="queryWorkState" field="workstate">
					<option dataset="workstateDataset" />
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>学历:</td>
				<td class="FieldInput"><select id="culture" name="culture"
					title="学历">
					<option dataset="EducationDataset" />
				</select></td>
				<td class="FieldLabel" nowrap>婚姻登记机关:</td>
				<td class="FieldInput">
				<input type="text" id="deptName" onclick="forHelp()" readonly="readonly" title="婚姻登记机关" /> 
				<input type="hidden" id="deptId" name="deptId" />
				</td>
				<td align="center" colspan="2" class="FieldLabel"
					style="text-align: center">
				<button onclick="query()">查 询</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
	<%
		if("0000000000".equals(organCode.substring(2))) { //省级
	%>
	    <next:ToolBarItem text="打印资格证书" iconCls="dy" handler="dyzgzs" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonQuery" />
		<next:ToolBarItem text="导出" iconCls="chart" handler="emportExcel" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
	<% 	
		} else if("00000000".equals(organCode.substring(4))){  //市级
	%>
	
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	  
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonQuery" />
	<% 		
		} else if("000000".equals(organCode.substring(6))) { //县级
	%>
	
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="设为颁证员" iconCls="add" handler="bzySet" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		
		<next:ToolBarItem text="打印" iconCls="edit" handler="commonQuery" />
	<% 
		}
	%>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="deptName" header="登记机关" field="deptName" width="140"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="姓名" field="name" width="70" renderer="detailHref"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="性别" field="sex" width="50" dataset="SexDataset"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="民族" field="nation" width="50" dataset="NationDataset"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column header="职务" field="technical" width="90"
			dataset="zwDataset" align="center">
			<next:TextField />
		</next:Column>

		<next:Column header="身份证件号" field="cardNo" width="170" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="资格证编号" field="certificateId" width="100"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="岗位状态" field="workstate" width="60"
			dataset="workstateDataset" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="是否颁证员" field="bzyCode" width="120"
			dataset="bzycodeDataset" align="center">
			<next:TextField />
		</next:Column>
		
		<next:Column header="政治面貌" field="politics" width="120"
			dataset="PoliticalDataset" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="编制性质" field="kind" width="120"
			dataset="kindDataset" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="学历" field="culture" width="120"
			dataset="EducationDataset" align="center">
			<next:TextField />
		</next:Column>
		
		<next:Column header="系统操作权限" field="computerType" width="100"
			align="center" dataset="computerTypeDataset">
			<next:TextField />
		</next:Column>

		<next:Column header="从事婚姻工作开始时间" field="marryStartDate" align="center"
			width="150">
			<next:TextField />
		</next:Column>
		<next:Column header="培训状态" field="status" width="120"
			renderer="getStatus" align="center">
			<next:TextField />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
<input type="hidden" id="docpath" value="" />
<input type="hidden" id="method"  value="printMrmPerson" />
<input type="hidden" id="personId" name="printQuery"
	queryData="queryData" value="" />
<input type="hidden" id="scaconfPath"
	value="mrmBasePerson/mrmBasePersonPrintDao" />
</html>