<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>选举结果情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
	//查询条件打开合并函数
	function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		var gridO = L5.getCmp("gridO");
		if(element.id =="imageButton1"){
			if(gridO.collapsed){
				gridO.expand();
			}else{
				gridO.collapse();
			}
		}
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
<script type="text/javascript" src="cdcElectionResultEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="resultDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionResultQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionResult">
			<model:field name="otherPer" type="string"/>
			<model:field name="sovietFemalePer" type="string"/>
			<model:field name="sovietPartyPer" type="string"/>
			<model:field name="sovietFolkPer" type="string"/>
			<model:field name="groupFemalePer" type="string"/>
			<model:field name="groupPartyPer" type="string"/>
			<model:field name="groupFolkPer" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="peopleMDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='USER_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="peopleODs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="peopleSDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="peopleFDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
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
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="dutyDs" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="resultOtherDs" enumName="CDC.RESULT_OTHER" autoLoad="true" global="true"/>
	<model:dataset id="sovietMannerDs" enumName="CDC.SOVIET_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="subNameDs" enumName="CDC.SUB_NAME" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举结果</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">填报单位：</td>
			<td class="FieldInput"  style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="gridM" dataset="peopleMDs" width="99%"  stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="村委会成员基本信息" />
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertM"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateM"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delM"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns >
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="75" sortable="false"/>
		<next:Column field="age" header="年龄" width="75" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="duty" header="当选职务" dataset="dutyDs" width="90" sortable="false"/>
		<next:Column field="dutyVoteNum" header="当选职务票数" width="90" sortable="false"/>
		<next:Column field="voteNum" header="总票数" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否初次当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>
<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村民代表、村民小组长情况</legend>
<fieldset id="cdcFieldset">
<legend>村民代表推选情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">村民代表总数：</td>
			<td class="FieldInput"><input type="text" name="村民代表总数" id="sovietNum" field="sovietNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">村民代表推选方式：</td>
			<td class="FieldInput" colspan="3"><select name="村民代表推选方式" id="sovietManner" field="sovietManner" onchange="getSovietManner()"><option dataset="sovietMannerDs"></option></select></td>
		</tr>
		<tr id="sovietManner1" style="display:none">
			<td class="FieldLabel"></td>
			<td class="FieldInput" colspan="5"><input type="text" name="五至十户推选" id="sovietOneNum" field="sovietOneNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;户推选一名代表</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性成员数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="女性成员数" id="sovietFemaleNum" field="sovietFemaleNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="党员人数" id="sovietPartyNum" field="sovietPartyNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">少数民族成员：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="少数民族成员" id="sovietFolkNum" field="sovietFolkNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">女性成员比率：</td>
			<td class="FieldInput"><label field="sovietFemalePer" renderer="pRender"/></td>
			<td class="FieldLabel">党员比率：</td>
			<td class="FieldInput"><label field="sovietPartyPer" renderer="pRender"/></td>
			<td class="FieldLabel">少数民族比率：</td>
			<td class="FieldInput"><label field="sovietFolkPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>村民小组长情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">本小组有登记参加选举的村民总数：</td>
			<td class="FieldInput"><input type="text" name="本小组有登记参加选举的村民总数" id="groupVoterNum" field="groupVoterNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">参加推选的本小组村民数：</td>
			<td class="FieldInput"><input type="text" name="参加推选的本小组村民数" id="groupPeopleNum" field="groupPeopleNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">参加推选的本小组户数：</td>
			<td class="FieldInput"><input type="text" name="参加推选的本小组户数" id="groupNum" field="groupNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;户</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性成员数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="女性成员数" id="groupFemaleNum" field="groupFemaleNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="党员人数" id="groupPartyNum" field="groupPartyNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">少数民族成员：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="少数民族成员" id="groupFolkNum" field="groupFolkNum" onchange="forcheck(this);getPer()" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">女性成员比率：</td>
			<td class="FieldInput"><label field="groupFemalePer" renderer="pRender"/></td>
			<td class="FieldLabel">党员比率：</td>
			<td class="FieldInput"><label field="groupPartyPer" renderer="pRender"/></td>
			<td class="FieldLabel">少数民族比率：</td>
			<td class="FieldInput"><label field="groupFolkPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</fieldset>

<fieldset id="cdcFieldset">
<legend>村委会下属委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:32%">人民调解委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><input type="text" name="组成人员数" id="tjNum" field="tjNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><select name="是否村委会成员兼任主任" id="tjIfSame" field="tjIfSame"><option dataset="YorN"></option></select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:32%">治安保卫委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><input type="text" name="组成人员数" id="zaNum" field="zaNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><select name="是否村委会成员兼任主任" id="zaIfSame" field="zaIfSame"><option dataset="YorN"></option></select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:32%">公共卫生与计划生育委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><input type="text" name="组成人员数" id="wsNum" field="wsNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><select name="是否村委会成员兼任主任" id="wsIfSame" field="wsIfSame"><option dataset="YorN"></option></select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:32%">民政事务委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><input type="text" name="组成人员数" id="mzswNum" field="mzswNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><select name="是否村委会成员兼任主任" id="mzswIfSame" field="mzswIfSame"><option dataset="YorN"></option></select></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="gridS" dataset="peopleSDs" width="99%" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="下属委员会成员情况"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertS"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateS"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delS"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否新当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>

<next:EditGridPanel id="gridF" dataset="peopleFDs" width="99%" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="村财会人员情况"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertF"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateF"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delF"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="ifCert" header="是否有从业资格证书" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>
<next:Panel width="99%" autoScroll="true" >
	<next:BottomBar >
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:BottomBar>
</next:Panel>
<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">另行选举情况 <img class="GroupBoxExpandButton" id = "imageButton1"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
	<table width="100%">
		<tr>
			<td class="FieldLabel">另行选举：</td>
			<td class="FieldInput" colspan="5"><select name="另行选举" id="other" field="other"><option dataset="resultOtherDs"></option></select></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四增：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日新满18周岁的村民：</td>
			<td class="FieldInput"><input type="text" name="上次选举登记日至本次另行选举日新满18周岁的村民" id="othAddOne" field="othAddOne" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员：</td>
			<td class="FieldInput"><input type="text" name="新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员" id="othAddTwo" field="othAddTwo" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员：</td>
			<td class="FieldInput"><input type="text" name="因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员" id="othAddThree" field="othAddThree" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利期满恢复政治权利的村民：</td>
			<td class="FieldInput"><input type="text" name="被剥夺政治权利期满恢复政治权利的村民" id="othAddFour" field="othAddFour" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四减：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等：</td>
			<td class="FieldInput"><input type="text" name="上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等" id="othRedOne" field="othRedOne" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭迁出本村的村民：</td>
			<td class="FieldInput"><input type="text" name="因婚姻、家庭迁出本村的村民" id="othRedTwo" field="othRedTwo" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">死亡的村民：</td>
			<td class="FieldInput"><input type="text" name="死亡的村民" id="othRedThree" field="othRedThree" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利的村民：</td>
			<td class="FieldInput"><input type="text" name="被剥夺政治权利的村民" id="othRedFour" field="othRedFour" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">参加另行选举投票的村民总数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="参加另行选举投票的村民总数" id="voterNum" field="voterNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">委托投票人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="委托投票人数" id="entrustNum" field="entrustNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">使用流动票箱投票人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="使用流动票箱投票人数" id="flowNum" field="flowNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><input type="text" name="代写选票人数" id="replaceNum" field="replaceNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">设立分会场数：</td>
			<td class="FieldInput"><input type="text" name="设立分会场数" id="subNum" field="subNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;个</td>
			<td class="FieldLabel">投票箱总数：</td>
			<td class="FieldInput"><input type="text" name="投票箱总数" id="boxNum" field="boxNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;个</td>
		</tr>
		<!-- 
		<tr>
			<td class="FieldLabel">参加投票选民占村民总数的百分比：</td>
			<td class="FieldInput" colspan="5"><label field="otherPer" renderer="pRender"/></td>
		</tr>
		-->
	</table>
	</div>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="gridO" dataset="peopleODs" width="99%" closable="true" collapsible="true" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="另行选举结果"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertO"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateO"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delO"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="75" sortable="false"/>
		<next:Column field="age" header="年龄" width="75" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="duty" header="当选职务" dataset="dutyDs" width="90" sortable="false"/>
		<next:Column field="dutyVoteNum" header="当选职务票数" width="90" sortable="false"/>
		<next:Column field="voteNum" header="总票数" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否初次当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>

<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">重新选举情况 <img class="GroupBoxExpandButton" id = "imageButton2"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="4">四增：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次重新选举日新满18周岁的村民：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="上次选举登记日至本次另行选举日新满18周岁的村民" id="reAddOne" field="reAddOne" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员：</td>
			<td class="FieldInput"><input type="text" name="新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员" id="reAddTwo" field="reAddTwo" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员：</td>
			<td class="FieldInput"><input type="text" name="因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员" id="reAddThree" field="reAddThree" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利期满恢复政治权利的村民：</td>
			<td class="FieldInput"><input type="text" name="被剥夺政治权利期满恢复政治权利的村民" id="reAddFour" field="reAddFour" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四减：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等：</td>
			<td class="FieldInput"><input type="text" name="上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等" id="reRedOne" field="reRedOne" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭迁出本村的村民：</td>
			<td class="FieldInput"><input type="text" name="因婚姻、家庭迁出本村的村民" id="reRedTwo" field="reRedTwo" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">死亡的村民：</td>
			<td class="FieldInput"><input type="text" name="死亡的村民" id="reRedThree" field="reRedThree" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利的村民：</td>
			<td class="FieldInput"><input type="text" name="被剥夺政治权利的村民" id="reRedFour" field="reRedFour" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
	</table>
	</div>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>

<next:Window id="mWin" title="村委会成员基本信息" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirmM"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWinM"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="peopleMDs" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">姓名：</td>
			<td class="FieldInput"><input type="text" name="姓名" id="name" field="name" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">性别：</td>
			<td class="FieldInput"><select name="性别" id="sex" field ="sex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">年龄：</td>
			<td class="FieldInput"><input type="text" name="年龄" id="age" field="age" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">民族：</td>
			<td class="FieldInput"><select name="民族" id="folk" field ="folk"><option dataset="NationDataset"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">政治面貌：</td>
			<td class="FieldInput"><select name="政治面貌" id="political" field ="political"><option dataset="politicalDataSet"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">文化程度</td>
			<td class="FieldInput"><select name="文化程度" id="education" field ="education"><option dataset="educationDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">当选职务：</td>
			<td class="FieldInput" colspan="3"><select name="当选职务" id="duty" field ="duty"><option dataset="dutyDs"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">当选票数：</td>
			<td class="FieldInput"><input type="text" name="当选票数" id="mdutyVoteNum" field="dutyVoteNum" onchange="forcheck(this)" maxlength="30"/><font color="red">*</font></td>
			<td class="FieldLabel">总票数</td>
			<td class="FieldInput"><input type="text" name="总票数" id="mvoteNum" field="voteNum" onchange="forcheck(this)" maxlength="30"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">是否初次当选：</td>
			<td class="FieldInput"><select name="是否初次当选" id="ifFirstM" field ="ifFirst" onchange="firstChangeM(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">是否连选连任</td>
			<td class="FieldInput"><select name="是否连选连任" id="ifRedutyM" field ="ifReduty" onchange="redutyChangeM(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>

<next:Window id="oWin" title="另行选举结果" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirmO"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWinO"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="peopleODs" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">姓名：</td>
			<td class="FieldInput"><input type="text" name="姓名" id="name" field="name" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">性别：</td>
			<td class="FieldInput"><select name="性别" id="sex" field ="sex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">年龄：</td>
			<td class="FieldInput"><input type="text" name="年龄" id="age" field="age" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">民族：</td>
			<td class="FieldInput"><select name="民族" id="folk" field ="folk"><option dataset="NationDataset"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">政治面貌：</td>
			<td class="FieldInput"><select name="政治面貌" id="political" field ="political"><option dataset="politicalDataSet"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">文化程度</td>
			<td class="FieldInput"><select name="文化程度" id="education" field ="education"><option dataset="educationDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">当选职务：</td>
			<td class="FieldInput" colspan="3"><select name="当选职务" id="duty" field ="duty"><option dataset="dutyDs"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">当选票数：</td>
			<td class="FieldInput"><input type="text" name="当选票数" id="odutyVoteNum" field="dutyVoteNum" onchange="forcheck(this)" maxlength="30"/><font color="red">*</font></td>
			<td class="FieldLabel">总票数</td>
			<td class="FieldInput"><input type="text" name="总票数" id="ovoteNum" field="voteNum" onchange="forcheck(this)" maxlength="30"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">是否初次当选：</td>
			<td class="FieldInput"><select name="是否初次当选" id="ifFirstO" field ="ifFirst" onchange="firstChangeO(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">是否连选连任</td>
			<td class="FieldInput"><select name="是否连选连任" id="ifRedutyO" field ="ifReduty" onchange="redutyChangeO(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>

<next:Window id="sWin" title="下属委员会成员情况" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirmS"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWinS"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="peopleSDs" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">姓名：</td>
			<td class="FieldInput"><input type="text" name="姓名" id="name" field="name" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">性别：</td>
			<td class="FieldInput"><select name="性别" id="sex" field ="sex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">年龄：</td>
			<td class="FieldInput"><input type="text" name="年龄" id="age" field="age" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">民族：</td>
			<td class="FieldInput"><select name="民族" id="folk" field ="folk"><option dataset="NationDataset"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">政治面貌：</td>
			<td class="FieldInput"><select name="政治面貌" id="political" field ="political"><option dataset="politicalDataSet"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">文化程度</td>
			<td class="FieldInput"><select name="文化程度" id="education" field ="education"><option dataset="educationDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">是否初次当选：</td>
			<td class="FieldInput"><select name="是否初次当选" id="ifFirstS" field ="ifFirst" onchange="firstChangeS(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">是否连选连任</td>
			<td class="FieldInput"><select name="是否连选连任" id="ifRedutyS" field ="ifReduty" onchange="redutyChangeS(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>

<next:Window id="fWin" title="村财会人员情况" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirmF"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWinF"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="peopleFDs" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">姓名：</td>
			<td class="FieldInput"><input type="text" name="姓名" id="name" field="name" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">性别：</td>
			<td class="FieldInput"><select name="性别" id="sex" field ="sex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">年龄：</td>
			<td class="FieldInput"><input type="text" name="年龄" id="age" field="age" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">民族：</td>
			<td class="FieldInput"><select name="民族" id="folk" field ="folk"><option dataset="NationDataset"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">政治面貌：</td>
			<td class="FieldInput"><select name="政治面貌" id="political" field ="political"><option dataset="politicalDataSet"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">文化程度</td>
			<td class="FieldInput"><select name="文化程度" id="education" field ="education"><option dataset="educationDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">是否有从业资格证书：</td>
			<td class="FieldInput" colspan="3"><select name="是否有从业资格证书" id="ifCert" field ="ifCert"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
