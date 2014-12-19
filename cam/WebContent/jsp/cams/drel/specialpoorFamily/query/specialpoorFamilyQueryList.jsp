<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>特殊困难户查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="specialpoorFamilyQueryList.js"></script>
<script type="text/javascript">
    <%
	    String organArea = BspUtil.getCorpOrgan().getOrganCode();
    	String queryCode = "";
    	if(organArea.endsWith("0000000000")){//省370000000000
    		queryCode = organArea.substring(0,2);
 		} else if (organArea.endsWith("00000000")){//市370100000000
 			queryCode = organArea.substring(0,4);
 		} else if (organArea.endsWith("000000")){//县370104000000
 			queryCode = organArea.substring(0,6);
 		} else if (organArea.endsWith("000")){//乡370104003000
 			queryCode = organArea.substring(0,9);
 		}else{
 			queryCode = organArea;
 		}
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
    var queryCode='<%=queryCode%>';
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>

<model:datasets>
	<!-- 家庭信息 -->
	<model:dataset id="speFamilyDataset"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorFamilyQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorFamily">
		</model:record>
	</model:dataset>
	
	<model:dataset id="SpecialpoorSupportRefDataset" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportRef">
		</model:record>
	</model:dataset>
	<model:dataset id="supportName" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SUPPORT_UNIT_TYPE_CODE" pageSize="300">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='specialpoor_support_unit'></model:param>
			<model:param name="value" value='SUPPORT_UNIT_CODE'></model:param>
			<model:param name="text" value='SUPPORT_UNIT_NAME'></model:param>
			<model:param name="sort" value='SUPPORT_UNIT_TYPE_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!--致贫原因-->
	<model:dataset id="povertyCauseType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SPECIAL_POVERTY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!--救助类型-->
	<model:dataset id="assitanceDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_assitance_type'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:Panel width="100%" border="0">
		<next:Html>
			<fieldset><legend>查询条件 <img
				class="GroupBoxExpandButton"
				src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
				onclick="collapse(this)" /> </legend>
			<div>
			<form class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel"style="width:10%">户主姓名</td>
					<td class="FieldInput"style="width:10%"><input type="text" id="qFamilyName" /></td>
					<td class="FieldLabel"style="width:10%">身份证号码</td>
					<td class="FieldInput"style="width:10%"><input type="text" id="qFamilyCardNo"
						style="width: 135px" /></td>
					<td class="FieldLabel"style="width:10%">家庭人口数</td>
					<td class="FieldInput"style="width:10%"><input type="text" id="qPeopleNumStart"
						style="width: 30px; text-align: right;" maxlength="2" />&nbsp;-&nbsp;<input
						type="text" id="qPeopleNumEnd"
						style="width: 30px; text-align: right;" maxlength="2" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">地区</td>
					<td class="FieldInput" style="width: 20%"><input type="text"
						id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" style='width:80%'
						value="<%=organName%>" /> <input type="text"
						style="display: none;" name="lrdwId" id="lrdwId"
						value="<%=organArea%>" /> <img
						src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForDomicileSelect()" /></td>
					<td class="FieldLabel">是否低保标志</td>
					<td class="FieldInput"><select name="是否低保标志"
						id="qAssistanceFlag">
						<option dataset="commYesOrNoDS"></option>
					</select></td>
					<td class="FieldLabel">救助类型</td>
					<td class="FieldInput"><select name="救助类型"
						id="qAssistanceType">
						<option dataset="assitanceDataset"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">省直单位名称</td>
	                <td class="FieldInput" style="width:10%">
	               <select  id="supportNameID" style='width:80%'><option  dataset="supportName"></option></select>
	                </td>
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput"><input type="text" id="qFamilyPhone" /></td>
					<td class="FieldLabel">致贫原因</td>
					<td class="FieldInput" ><select name="致贫原因"
						id="qSpecialpoorCase">
						<option dataset="povertyCauseType"></option>
					</select></td>
					
				</tr>
				<tr>
					<td nowrap="nowrap" class="FieldLabel" colspan="6">
					<button id="queryId" onclick="query()">查 询</button>
					&nbsp;
					<button type="reset">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:GridPanel clickToSelectedForChkSM="true" id="daiBanGridPanel"
		dataset="speFamilyDataset" width="100%" height="100%"
		stripeRows="true" notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="export" text="导出Excel"
				handler="exportExcel" />
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="户主姓名" field="familyName" width="90"></next:Column>
			<next:Column header="身份证号码" field="familyCardNo" width="135"></next:Column>
			<next:Column header="家庭人口数" field="peopleNum" width="80" align="center"></next:Column>
			<next:Column header="联系电话" field="familyPhone" width="120"></next:Column>
			<next:Column header="帮包村名称" field="helpVillageName"   width="220" ></next:Column>
			<next:Column header="是否低保标志" field="assistanceFlag" width="90" dataset="commYesOrNoDS" align="center"></next:Column>
			<next:Column header="救助类型" field="assistanceType" width="90" dataset="assitanceDataset"></next:Column>
			<next:Column header="地区" field="domicileFullName" width="200" hidden="true"></next:Column>
			<next:Column header="家庭住址" field="address" width="200"></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="speFamilyDataset" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>

<next:Window id="specialpoorCase_win" height="300" width="240" title="致贫原因"
	resizable="false" closable="close">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="confirmspecialpoorCase()" />
		<next:ToolBarItem text="关闭" iconCls="return"
			handler="closespecialpoorCase()" />
		<next:ToolBarItem text="清除" iconCls="remove"
			handler="clearspecialpoorCase()" />
	</next:TopBar>
	<next:GridPanel id="specialpoorCase_panel" width="100%" height="100%"
		notSelectFirstRow="true" dataset="povertyCauseType" autoScroll="true">
		<next:Columns>
			<next:RowNumberColumn width="20" />
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column header="致贫原因" width="180" field="text">
				<next:TextField />
			</next:Column>
			<next:Column header="致贫原因" width="80" field="value" hidden="true">
				<next:TextField />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>