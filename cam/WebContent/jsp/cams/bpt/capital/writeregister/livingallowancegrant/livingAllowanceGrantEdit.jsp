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
		<title>两参人员生活补助费发放名册修改</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="livingAllowanceGrantEdit.js"></script>
		<script language="javascript">
		 	var registerId='<%=request.getParameter("registerId")%>';
		    var respectiveYears='<%=request.getParameter("respectiveYears")%>';
		    var method='<%=request.getParameter("method")%>';
		    var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" global="true" method="queryYearDataSet" pageSize="500" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<!-- 发放类别 -->
	<model:dataset id="GrantTypeDataset" enumName="GRANTTYPE.FLAG" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志-->
	<model:dataset id="dsLoneFlag" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>  
</model:datasets>
<next:EditGridPanel id="editGridPanel" name="bptcapitaldetailGrid" width="100%" stripeRows="true" height="100%" dataset="ds" enableHdMenu="true" enableColumnHide="true" enableColumnMove="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem text="新增发放对象" iconCls="add" id="addGrantObject" handler="addGrantObject"/>
			<next:ToolBarItem text="删除发放对象" iconCls="remove" id="deleteGrantObject" handler="deleteGrantObject"/>
	        <next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	        <next:ToolBarItem iconCls="disable"  text="关闭" handler="func_close"/>
	</next:TopBar>
	<next:GroupingView></next:GroupingView>
	<next:Columns>
	     <next:RowNumberColumn width="40" header="序号"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="domicileName" header="户籍地" field="domicileName" width="230"></next:Column>
		<next:Column id="name" header="姓名" field="name" width="50" sortable="true"></next:Column>
		<next:Column id="idCord" header="身份证号" field="idCord" width="135" sortable="true"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="170" sortable="true"></next:Column>
		<next:Column id="credentialsNo" header="优抚证书编号" field="credentialsNo" width="120" sortable="true"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="130" dataset="ObjectTypeDataset" sortable="true"></next:Column>
		<next:Column id="changeState" header="发放类别" field="changeState" width="130" dataset="GrantTypeDataset" sortable="true"></next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="80" dataset="DomicileDataset" sortable="true"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="60" dataset="dsLoneFlag" sortable="true"></next:Column>
		<next:Column id="grantStaMon" header="省标准" field="grantStaMon" renderer="formatNum(this)" width="80" align="right" sortable="true" hidden="true"></next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths" width="80" align="right" sortable="true"></next:Column>
		<next:Column id="grantMon" header="发放金额" field="grantMon" width="80" renderer="formatNum(this)" align="right" sortable="true"></next:Column>
		
		<next:Column id="subTotal" header="地方补贴小计" field="subTotal"
			renderer="formatNum(this)" width="120" align="right" editable="false">
			<next:NumberField></next:NumberField>
		</next:Column>
		<next:Column id="increaseMechanism" header="自然增长机制"
			field="increaseMechanism" renderer="formatNum(this)" width="120"
			align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="grainOilMon" header="粮油补贴" field="grainOilMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="supplyMon" header="补发金额" field="supplyMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1"
			field="otherSubsidyOne" renderer="formatNum(this)" width="80"
			align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2"
			field="otherSubsidyTwo" renderer="formatNum(this)" width="80"
			align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3"
			field="otherSubsidyThree" renderer="formatNum(this)" width="80"
			align="right" editable="false">
			<next:NumberField/>	
		</next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4"
			field="otherSubsidyFour" renderer="formatNum(this)" width="80"
			align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5"
			field="otherSubsidyFive" renderer="formatNum(this)" width="80"
			align="right" editable="false">
			<next:NumberField/>
		</next:Column>
		<next:Column id="grantMonSum" header="发放资金总额" field="grantMonSum"
			renderer="formatNum(this)" width="80" align="right" editable="false">
			<next:NumberField/>	
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="200" sortable="true">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="addNewLiveAllowGrantObject" title="新增发放对象" resizable="false" width="780" height="330"  closeAction="hide" modal="true">
  <next:Panel>
	<next:Html>
		<form dataset="ds" id="form1" onsubmit="return false" class="L5form">
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
					<td class="FieldInput"><label id="objectType" field="objectType" dataset="ObjectTypeDataset"></label></td>
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
					<td class="FieldLabel">省标准(月/元)：</td>
				    <td class="FieldInput"><input type="text" id="grantStaMon" field="grantStaMon" onblur="checkIfFload(this);computeMon();" style="text-align:right"/></td>
					<td class="FieldLabel">发放月数：</td>
					<td class="FieldInput"><input type="text" id="grantMonths" field="grantMonths" onblur="checkIfFload(this);computeMon();" style="text-align:right"/></td>
					<td class="FieldLabel">发放金额(元)：</td>
					<td class="FieldInput"><label id="grantMon" field="grantMon" style="text-align:right"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">地方补贴小计(元)：</td>
					<td class="FieldInput"><label id="subTotal" field="subTotal" style="text-align:right"/></td>
					<td class="FieldLabel">自然增长机制：</td>
					<td class="FieldInput"><input id="increaseMechanism" field="increaseMechanism" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
					<td class="FieldLabel">粮油补贴(元)：</td>
					<td class="FieldInput"><input type="text" id="grainOilMon" field="grainOilMon" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">孤老增发(元)：</td>
					<td class="FieldInput"><input type="text" id="oldLonelyMon" field="oldLonelyMon" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">补发金额(元)：</td>
					<td class="FieldInput"><input type="text" id="supplyMon" field="supplyMon" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
					<td class="FieldLabel">其他补助1(元)：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyOne" field="otherSubsidyOne" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				</tr>
				<tr>
				    <td class="FieldLabel">其他补助2(元)：</td>
				    <td class="FieldInput"><input type="text" id="otherSubsidyTwo" field="otherSubsidyTwo" onblur="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
					<td class="FieldLabel">其他补助3(元)：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyThree" field="otherSubsidyThree" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">其他补助4(元)：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyFour" field="otherSubsidyFour" onblur="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				</tr>
				<tr>
				    <td class="FieldLabel">其他补助5(元)：</td>
				    <td class="FieldInput"><input type="text" id="otherSubsidyFive" field="otherSubsidyFive" onblur="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
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
