<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");
%>
<html>
	<head>
		<title>除义务兵家庭外其他优抚对象优待金发放修改</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="nonCompulsoryGrantEdit.js"></script>
		<script language="javascript">
			var registerId='<%=request.getParameter("registerId")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsQueryCommand" global="true" method="queryCompulsoryUpdate" pageSize="500" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCompulsoryDetails">
			<model:field name="domicileCode" type="string"/>
			<model:field name="domicileName" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="accountCode" type="string"/>
			<model:field name="domicileType" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileTypeEnum" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否孤老 -->
	<model:dataset id="LoneIfEnum" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true"></model:dataset>
</model:datasets>

<next:EditGridPanel id="editGridPanel" name="bptcompulsorydetailsGrid" width="100%" stripeRows="true" height="100%" dataset="ds" autoExpandColumn="note" enableHdMenu="true" enableColumnHide="true" enableColumnMove="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="新增发放对象" iconCls="add" id="addGrantObject" handler="addGrantObject"/>
		<next:ToolBarItem text="删除发放对象" iconCls="remove" id="deleteGrantObject" handler="deleteGrantObject"/>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"/>
		<next:ToolBarItem iconCls="disable"  text="关闭" handler="fun_close"/>
    </next:TopBar>
    <next:GroupingView></next:GroupingView>
	<next:Columns>
	     <next:RowNumberColumn width="40" header="序号"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="domicileName" header="户籍地" field="domicileName" sortable="true"></next:Column>   
		<next:Column id="name" header="姓名" field="name" width="90"  sortable="true"></next:Column>
		<next:Column id="idCard" header="身份证号" field="idCard" width="140"  sortable="true"></next:Column>
		<next:Column id="objectTypeCode" header="优抚对象类别" field="objectTypeCode" width="130" dataset="ObjectTypeDataset" sortable="true"></next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" sortable="true" dataset="DomicileTypeEnum"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="90" sortable="true" dataset="LoneIfEnum"></next:Column>
		<next:Column id="supportPattern" header="供养方式" field="supportPattern" width="90" sortable="true" dataset="SupportPatternEnum"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="140" sortable="true"></next:Column>
		<next:Column id="grantMonSta" header="发放标准" field="grantMonSta" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths" width="80" align="right" editable="false"></next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1" field="otherSubsidyOne" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2" field="otherSubsidyTwo" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3" field="otherSubsidyThree" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4" field="otherSubsidyFour" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5" field="otherSubsidyFive" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="grantMonSum" header="发放总额" field="grantMonSum" renderer="formatNum(this)" align="right" width="90" sortable="true">
			<next:NumberField/>
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="90" sortable="true">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="addNewCompulsoryGrantObject" title="新增发放对象" resizable="false" width="850" height="300"  closeAction="hide" modal="true">
  <next:Panel width="99%" height="100%">
	<next:Html>
		<form dataset="ds" id="form1" onsubmit="return false" class="L5form">
			<table border="0" width="99%">
				<input type="hidden" id="regDetailId" field="regDetailId" title="名删名细id"/>
				<input type="hidden" id="registerId" field="registerId" title="名册id"/>
				<input type="hidden" id="peopleId" field="peopleId" title="人员ID"/>
				<input type="hidden" id="domicileCode" field="domicileCode" title="行政区划代码"/>
				<tr>
					<td class="FieldLabel" style="width:16%">户籍地：</td>
					<td class="FieldInput" style="width:16%"><label id="domicileName" field="domicileName"></label></td>
					<td class="FieldLabel" style="width:16%">姓名：</td>
					<td class="FieldInput" style="width:16%"><label id="name" field="name"></label></td>
					<td class="FieldLabel" style="width:16%">身份证号：</td>
					<td class="FieldInput" style="width:16%" nowrap="nowrap"><label id="idCard" field="idCard"></label></td>
				</tr>
				<tr>	
					<td class="FieldLabel">优抚对象类别：</td>
					<td class="FieldInput" style="width:16%"><label id="objectTypeCode" field="objectTypeCode" dataset="ObjectTypeDataset"></label></td>
				    <td class="FieldLabel">户籍类别：</td>
				    <td class="FieldInput" nowrap="nowrap"><label id="domicileType" field="domicileType" dataset="DomicileTypeEnum"></label></td>
				    <td class="FieldLabel">是否孤老：</td>
				    <td class="FieldInput" nowrap="nowrap"><label id="oldLonelyFlag" field="oldLonelyFlag" dataset="LoneIfEnum"></label></td>
				</tr>
				<tr>  
					<td class="FieldLabel">供养方式：</td>
				    <td class="FieldInput" nowrap="nowrap"><label id="supportPattern" field="supportPattern" dataset="SupportPatternEnum"></label></td> 
				    <td class="FieldLabel">银行帐号：</td>
				    <td class="FieldInput" nowrap="nowrap"><label id="accountCode" field="accountCode"></label></td>
					<td class="FieldLabel">发放标准：</td>
					<td class="FieldInput"><input id="grantMonSta" field="grantMonSta" renderer="formatNum(this)" onchange="checkIfFload(this);computeSumMon();" style="text-align:right"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">发放月数：</td>
					<td class="FieldInput"><input type="text" id="grantMonths" field="grantMonths" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">孤老增发：</td>
					<td class="FieldInput"><input type="text" id="oldLonelyMon" field="oldLonelyMon" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">其他补助1：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyOne" field="otherSubsidyOne" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">其他补助2：</td>
				    <td class="FieldInput"><input type="text" id="otherSubsidyTwo" field="otherSubsidyTwo" onchange="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
					<td class="FieldLabel">其他补助3：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyThree" field="otherSubsidyThree" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">其他补助4：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyFour" field="otherSubsidyFour" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">其他补助5：</td>
				    <td class="FieldInput"><input type="text" id="otherSubsidyFive" field="otherSubsidyFive" onchange="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
					<td class="FieldLabel">发放资金总额：</td>
					<td class="FieldInput" colspan="3"><label id="grantMonSum" field="grantMonSum" style="text-align:right"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">备注：</td>
					<td class="FieldInput" colspan="5"><textarea id="note" field="note" rows="2" style="width:96%"></textarea></td>
				</tr>
			</table>
		</form>        
	</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>
