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
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src="querytestlist.js"></script>
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
			 var query_organCode = '<%=request.getParameter("xzqh") %>';
			 var autoQuery = '<%=request.getParameter("autoQuery")%>';
	       	   var domicileType = '<%=request.getParameter("domicileType")%>';
	       	   var testedType = '<%=request.getParameter("testedType")%>';
	       	   var query_startTime = '<%=request.getParameter("cxsjq") == null?"":request.getParameter("cxsjq")%>';
	       	   var query_endTime = '<%=request.getParameter("cxsjz")%>';
	       	   var query_timeType='<%=request.getParameter("timeType")%>';
	       	var lifehardorill='<%=request.getParameter("lifehardorill")%>';
	       	var isdemobilizedill='<%=request.getParameter("isdemobilizedill")%>';
	       	var disabilityLevelCode='<%=request.getParameter("disabilityLevelCode")%>';
		</script>
<%
	String struId = BspUtil.getStruId();
	
%>
</head>
<body>
<model:datasets>
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand"
		global="true" method="queryTongJiTested">
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
	<model:dataset id="dsdemo" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
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
<next:Panel name="form" width="98%" border="0" autoScroll="true"
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
				<td class="FieldLabel" nowrap>所属机构：</td>
				<input type="hidden" name="struid" value="<%=struId %>" />
				<td class="FieldInput"><input type="hidden" id="domicileCode"/>
				<input type="text" id="domicileName" class="TextEditor"
					title="属地行政区划" onclick="forHelp()" /></td>
				<td class="FieldLabel" nowrap>姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap>身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" /></td>
				
			<td align="center"><button onclick="query()">查 询</button></td>
			</tr>
			<tr>
				
					<td class="FieldLabel" nowrap>户籍类别：</td>
				<td class="FieldInput"><select name="domicileType"
					field="domicileType" title="户籍类别">
					<option dataset="DomicileDataset"></option>
				</select></td>

				<td class="FieldLabel" nowrap>残疾等级：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="disabilityLevelCode" field="disabilityLevelCode" title="残疾等级">
					<option dataset="DisabilityLevelDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap>参试类别：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="testedType" title="参试类别">
					<option dataset="dsTest"></option>
				</select></td>
				<td align="center"><button onclick="reset()">重 置</button></td>
				
			</tr>
			<tr>
				
				<td class="FieldLabel" nowrap>享受带病回乡补助人员：</td>
				<td class="FieldInput"><select id="isdemobilizedill"
					 title="户籍类别">
					<option dataset="dsdemo"></option>
				</select></td>

				<td class="FieldLabel" nowrap>患病及家庭困难：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="lifehardorill"  >
					<option value=0 selected="selected">请选择...</option>
					<option value=1>患病</option>
					<option value=2>家庭困难</option>
					<option value=3>患病及家庭困难</option>
				</select></td>
				<td class="FieldLabel">批准日期：</td>
				<td  align="left" style="background-color: #f5fafa;text-align:left;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="timeType" onchange="showTime('')">
				<option value="2">截止日期</option>
				<option value="1">起止日期</option>
				</select> </td>
				<td colspan="2" class="FieldInput"   id ="times" style="display: none;" ><input type="text" id="cxsj_qs"
					format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
					type="text" id="cxsj_zs" format="Y-m-d"
					style="width: 80px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
				</td>
				<td colspan="2" class="FieldInput"  id = "time" ><input type="text" id="cxsj_z"
					format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid"
	width="98%" stripeRows="true" height="98%"
	dataset="BaseinfoPeopleDataSet" title="参试人员信息" notSelectFirstRow="true">
		<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
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
