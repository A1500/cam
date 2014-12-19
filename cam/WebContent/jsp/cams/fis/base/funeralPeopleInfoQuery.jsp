<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>殡仪馆人员信息查询</title>
<script type="text/javascript">
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
</script>
<next:ScriptManager />
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="funeralPeopleInfoQuery.js"></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
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
	<!-- 服务机构人员信息 -->
	<model:dataset id="fisPeoInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisPeopleInfoQueryCmd"
		global="true" pageSize="10" sortField="workDate" method="queryForPeopleRecords">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisPeopleInfo"></model:record>
	</model:dataset>
	<!-- 职务 -->
	<model:dataset id="fisPostionDS" enumName="FIS.POSITION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO" autoLoad="true" global="true">
	</model:dataset>
	<!-- 行政级别 -->
	<model:dataset id="fisProfessionDS" enumName="FIS.PROFESSION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 男女 -->
	<model:dataset id="commSexDS" enumName="COMM.SEX" autoLoad="true" global="true">
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="fisEducation" enumName="FIS.EDUCATION" autoLoad="true" global="true"></model:dataset>
	<!-- 工种 -->
	<model:dataset id="fisWorkType" enumName="FIS.WORK.TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 编制性质 -->
	<model:dataset id="fisPeopleTypeDS" enumName="FIS.PEOPLE.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
	
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
	<fieldset><legend>查询条件
	<img class="GroupBoxExpandButton"
					src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" /> </legend>
				<div>
					<form class="L5form">
						<table width="100%" >
							<tr>
						        <td class="FieldLabel" >姓名</td>
						        <td class="FieldInput" >
						        	<input type="text" name="qName" id="qName"/>
						        </td>
						        <td class="FieldLabel" >身份证号</td>
						        <td class="FieldInput" >
						        	<input type="text" name="qIdCard" id="qIdCard" style="width:140" maxlength="18"/>
						        </td>
						        <td class="FieldLabel" >性别</td>
						        <td class="FieldInput"  >
						        	<select name="qSex" id="qSex">
						        		<option dataset="commSexDS"></option>
						        	</select>
						        </td>
						    </tr>
						    <tr>
						        <td class="FieldLabel" >编制性质</td>
						        <td class="FieldInput"  >
						        	<select name="qSex" id="qPeopleType">
						        		<option dataset="fisPeopleTypeDS"></option>
						        	</select>
						        </td>
						        <td class="FieldLabel" >文化程度</td>
						        <td class="FieldInput"  >
						        	<select name="qSex" id="qEducation">
						        		<option dataset="fisEducation"></option>
						        	</select>
						        </td>
						   		<td class="FieldLabel" >殡仪馆名称:</td>
						        <td class="FieldInput" ><input type="text" name="殡仪馆"
									id="qOrganName" readonly="readonly" style="width: 70%"/><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand;display: none;" onclick="forOrganHelp(this.id)" />&nbsp;
									<button  style="cursor: hand" onclick="forOrganHelp(this.id)">选择</button>
								<td style="display: none;"><input type="text" id="qOrganId" />
						        </td>
						     </tr>
						     <tr>
						        <td class="FieldLabel" >行政级别</td>
						        <td class="FieldInput" >
						        	<select name="qSex" id="qProfession">
						        		<option dataset="fisProfessionDS"></option>
						        	</select>
						        </td>
						        <td class="FieldLabel" >工种</td>
						        <td class="FieldInput">
						        	<select name="qWorkType" id="qWorkType">
						        		<option dataset="fisWorkType"></option>
						        	</select>
						        </td>
						        <td class="FieldLabel" >是否离岗</td>
						        <td class="FieldInput" >
						        	<select name="qSex" id="qIfCancel">
						        		<option dataset=commYesOrNoDS></option>
						        	</select>
						        </td>
						    </tr>
						     <tr>
						        <td class="FieldLabel" nowrap="nowrap" >从业时间</td>
						        <td class="FieldInput" colspan="3">
									<input type="text" id="startDate" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
							        &nbsp;至&nbsp;
							       	<input type="text" id="endDate" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
						        </td>
						        <td  nowrap="nowrap" class="FieldLabel" colspan="4">
									<button onclick="query()">查 询</button>&nbsp;<button onclick="resetQuery()">重 置</button>
							    </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="funeralServicePeople" stripeRows="true" 
	height="100%" width="100%" dataset="fisPeoInfoDS" clickToSelectedForChkSM="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="查询结果"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="showDetails" />
		<next:ToolBarItem text="导出" iconCls="export"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="peopleId" header="人员编号" field="PEOPLE_ID" width="90"
			hidden="true" />

		<next:Column id="name" header="人员姓名" field="NAME" width="80"
			renderer="detailHref" align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" dataset="commSexDS"
			width="50" align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="idCard" header="身份证件号" field="ID_CARD" width="140"
			align="left">
			<next:TextField />
		</next:Column>

		<next:Column id="PEOPLE_TYPE" header="编制性质" field="PEOPLE_TYPE"
			width="70" align="center" dataset="fisPeopleTypeDS">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="EDUCATION" header="文化程度" field="EDUCATION" width="70"
			align="center" dataset="fisEducation">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="PROFESSION" header="行政级别" field="PROFESSION"
			width="70" align="center" dataset="fisProfessionDS">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="POSITION" header="职务" field="POSITION" width="80"
			align="center" dataset="fisPostionDS">
			<next:TextField />
		</next:Column>

		<next:Column id="phone" header="联系电话" field="PHONE" width="100"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="duty" header="工种(专业等级)" field="DUTY" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="workDate" header="从业日期" field="WORK_DATE" width="90"
			align="center">
			<next:TextField />
		</next:Column>

		<next:Column id="ifCancel" header="是否离岗" field="IF_CANCEL"
			dataset="commYesOrNoDS" width="80" align="center">
			<next:TextField />
		</next:Column>
		
		<next:Column id="createOrganName" header="所属殡仪馆" field="CREATE_ORGAN_NAME"
			 width="140" align="center">
			<next:TextField />
		</next:Column>
	</next:Columns>

	<next:BottomBar>
		<next:PagingToolBar dataset="fisPeoInfoDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>