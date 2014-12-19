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
		<title>老烈士(平反)子女生活补助金修改</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="martyrEdit.js"></script>
		<script language="javascript">
		 	var registerId='<%=request.getParameter("registerId")%>';
		    var method='<%=request.getParameter("method")%>';
		    var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="dsLife" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" method="queryYearDataSet" global="true" pageSize="500" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectds" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 发放类别 -->
	<model:dataset id="GrantTypeDataset" enumName="GRANTTYPE.FLAG" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志-->
	<model:dataset id="dsLoneFlag" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>  
</model:datasets>
<next:EditGridPanel id="editGridPanel" width="100%" stripeRows="true" height="100%" dataset="dsLife" enableHdMenu="true" enableColumnHide="true" enableColumnMove="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem text="新增发放对象" iconCls="add" id="addGrantObject" handler="addGrantObject"/>
			<next:ToolBarItem text="删除发放对象" iconCls="remove" id="deleteGrantObject" handler="deleteGrantObject"/>
	        <next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	        <next:ToolBarItem iconCls="disable"  text="关闭" handler="fun_close"/>
	</next:TopBar>
	<next:GroupingView></next:GroupingView>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="domicileName" header="户籍地" field="domicileName" width="230" editable="false"></next:Column>
		<next:Column id="name" header="姓名" field="name" width="50" sortable="true" editable="false"></next:Column>
		<next:Column id="idCord" header="身份证号" field="idCord" width="135" sortable="true" editable="false"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="170" sortable="true" editable="false"></next:Column>
		<next:Column id="credentialsNo" header="抚恤证编号" field="credentialsNo" width="120" sortable="true" editable="false"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="130" dataset="objectds" sortable="true" editable="false"></next:Column>
		<next:Column id="changeState" header="发放类别" field="changeState" width="130" dataset="GrantTypeDataset" sortable="true" editable="false"></next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="80" dataset="DomicileDataset" sortable="true" editable="false"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="60" dataset="dsLoneFlag" sortable="true" editable="false"></next:Column>
		<next:Column id="grantStaMon" header="省标准" hidden="true" field="grantStaMon" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMon" header="发放金额" field="grantMon" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		
		<next:Column id="otherSubsidyOne" header="地方补贴" field="otherSubsidyOne" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		
		<next:Column id="grantMonSum" header="发放资金总额" field="grantMonSum" renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="200" editable="false">
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dsLife"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="addNewDemobilizedIllGrantObject" title="新增发放对象" resizable="false" width="820" height="240"  closeAction="hide" modal="true">
  <next:Panel>
	<next:Html>
		<form dataset="dsLife" id="form1" onsubmit="return false" class="L5form">
			<table border="0" width="99%">
				<tr>
					<td class="FieldLabel">户籍地：</td>
					<td class="FieldInput"><label id="domicileName" field="domicileName"></label></td>
					<td class="FieldLabel">姓名：</td>
					<td class="FieldInput"><label id="name" field="name"></label></td>
					<td class="FieldLabel">身份证号：</td>
					<td class="FieldInput"><label id="idCord" field="idCord"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">银行帐号：</td>
				    <td class="FieldInput"><label id="accountCode" field="accountCode"></label></td>
					<td class="FieldLabel">优抚证号：</td>
					<td class="FieldInput"><label id="credentialsNo" field="credentialsNo"></label></td>
					<td class="FieldLabel">优抚对象类别：</td>
					<td class="FieldInput"><label id="objectType" field="objectType" dataset="objectds"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">发放类别：</td>
				    <td class="FieldInput">
				    	<select id="changeState" field="changeState" title="发放类别">
								<option dataset="GrantTypeDataset"></option>
						</select><font color="red">*</font>
					</td>
				    <td class="FieldLabel">户籍类别：</td>
				    <td class="FieldInput"><label id="domicileType" field="domicileType" dataset="DomicileDataset"></label></td>
					<td class="FieldLabel">是否孤老：</td>
				    <td class="FieldInput"><label id="oldLonelyFlag" field="oldLonelyFlag" dataset="dsLoneFlag"></label></td>
				</tr>
				<tr>	
					<td class="FieldLabel">发放标准(月/元)：</td>
				    <td class="FieldInput"><input type="text" id="grantStaMon" field="grantStaMon" onblur="checkIfFload(this);computeMon();" style="text-align:right"/></td>
					<td class="FieldLabel">发放月数：</td>
					<td class="FieldInput"><input type="text" id="grantMonths" field="grantMonths" onblur="checkIfFload(this);computeMon();" style="text-align:right"/></td>
					<td class="FieldLabel">资金金额(元)：</td>
					<td class="FieldInput"><label id="grantMon" field="grantMon" style="text-align:right"></input></td>
				</tr>
				
				<tr>
					<td class="FieldLabel">地方补贴(元)：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyOne" field="otherSubsidyOne" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
					<td class="FieldLabel">发放资金总额(元)：</td>
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
