<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>供养对象入出院信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samInOutInfoManager.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript">
		 	<%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
			String organCode=BspUtil.getCorpOrgan().getOrganCode();//用于行政区划过滤
			if(organCode.endsWith("0000000000")){//省370000000000
				organCode= organCode.substring(0,2);
			} else if (organCode.endsWith("00000000")){//市370100000000
				organCode=  organCode.substring(0,4);
			} else if (organCode.endsWith("000000")){//县370104000000
				organCode=  organCode.substring(0,6);
			} else if (organCode.endsWith("000")){//乡370104003000
				organCode=  organCode.substring(0,9);
			}
		    %>
		    var organCode='<%=organCode%>';
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="samGeroKeptPersonDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd" method="queryInoutList" global="true"  pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson"/>
	</model:dataset>
	<!-- yes or no -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="nation" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 出院原因 -->
	<model:dataset id="reason" enumName="SAM_REASON"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">敬老院名称</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="gerocomiumName" style="width:80%"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForGeroSelect()" /> <input
						type="text" id="gerocomiumId" name="gerocomiumId" 
						style="display: none" /></td>
					<td class="FieldLabel" style="width:10%">姓名</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="personName" style="width:80%" />
					<td class="FieldLabel" style="width:10%">身份证号</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="idCard" style="width:80%" />
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">所在房间</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="inRoom" style="width:80%"/>
					<td class="FieldLabel" style="width:10%">所在床位</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="inBed" style="width:80%"/>
					<td class="FieldLabel" style="width:10%">在院状态</td>
					<td class="FieldInput" style="width:20%"><select id="isStatus" style="width:80%">
					<option dataset="comm_yesorno"></option> </select></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">主管单位名称</td>
					<td class="FieldInput" style="width:20%"><input type="text"
						name="所属行政区划" id="manaLevel" field="manaLevel" maxlength="50"
						style="width: 80%" readonly="readonly"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForManaSelect()" /> <input
						type="text" id="manaLevelId" name="manaLevelId" field="manaLevelId"
						style="display: none" /></td>
					<td class="FieldLabel" style="width:10%"></td>
					<td class="FieldInput" style="width:20%"></td>
					<td class="FieldLabel" style="width:10%"></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="samGeroKeptPersonDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="入院办理" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="床位调整" handler="editInGero"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="出院办理" handler="outGero"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="GEROCOMIUM_NAME" header="敬老院"  sortable="false"/>
		<next:Column field="PERSON_NAME" header="姓名"  sortable="false"/>
		<next:Column field="SEX" header="性别"  sortable="false" dataset="sex"/>
		<next:Column field="ID_CARD" header="身份证号"  sortable="false"/>
		<next:Column field="BIRTHDAY" header="出生日期"  sortable="false"/>
		<next:Column field="NATION" header="民族"  sortable="false" dataset="nation"/>
		<next:Column field="POLITICS_STATUS" header="政治面貌"  sortable="false" dataset="DmZzmmDataSet"/>
		<next:Column field="FAMILY_ADD" header="家庭住址"  sortable="false"/>
		<next:Column field="IF_ARCHIVE" header="是否已建健康档案"  sortable="false" dataset="comm_yesorno"/>
		<next:Column field="IN_ROOM" header="所在房间"  sortable="false"/>
		<next:Column field="IN_BED" header="所在床位"  sortable="false"/>
		<next:Column field="IS_STATUS" header="在院状态"  sortable="false" dataset="comm_yesorno"/>
		<next:Column field="INOUT_DATE" header="入/出院时间"  sortable="false"/>
		<next:Column field="REASON" header="出院原因"  sortable="false" dataset="reason"/>
		<next:Column field="UPDATE_PERSON" header="经办人"  sortable="false"/>
		<next:Column field="UPDATE_DATE" header="更新时间"  sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samGeroKeptPersonDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>