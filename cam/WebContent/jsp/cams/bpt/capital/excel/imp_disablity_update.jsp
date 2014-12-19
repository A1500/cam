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
		<title>修改伤残资金发放信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="imp_disablity_update.js"></script>
		<script type="text/javascript">
			var id="<%=request.getParameter("id")%>";
		</script>
	</head>
<body>
<model:datasets>
	<!-- 查询导入的信息 -->
	<model:dataset id="disabiltyTemp"
		cmd="com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalQueryCommand" global="true"
		 method="queryDisabilityMark">
		 <model:record fromBean="com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark"></model:record>
	</model:dataset>
</model:datasets>	
  <next:Panel  height="100%" autoScroll="true" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
	</next:TopBar>
	<next:Html>
		<form dataset="disabiltyTemp" id="form1" onsubmit="return false" class="L5form">
			<table border="0" width="99%">
				<tr>
					<td class="FieldLabel">身份证号：</td>
					<td class="FieldInput"><input type="text" readonly="readonly" id="idCard" field="idCard" style="width:135px;"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getIdCard()"/></td>
					<td class="FieldLabel">姓名：</td>
					<td class="FieldInput"><input type="text" id="name" field="name"/></td>
					<td class="FieldLabel">资金金额：</td>
					<td class="FieldInput"><label id="grantMon" field="grantMon" style="text-align:right"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">护理费：</td>
				    <td class="FieldInput"><input type="text" id="nursingMon" field="nursingMon" onchange="checkIfFload(this);computeSumMon();" style="text-align:right"/></td>
					<td class="FieldLabel">地方补贴小计：</td>
					<td class="FieldInput"><label id="subTotal" field="subTotal" style="text-align:right"/></td>
					<td class="FieldLabel">自然增长机制：</td>
					<td class="FieldInput"><input id="increaseMechanism" field="increaseMechanism" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">粮油增发：</td>
					<td class="FieldInput"><input type="text" id="grainOilMon" field="grainOilMon" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">煤补增发：</td>
					<td class="FieldInput"><input type="text" id="coalSubsidyMon" field="coalSubsidyMon" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				    <td class="FieldLabel">抗日增发：</td>
				    <td class="FieldInput"><input type="text" id="antiJapaneseMon" field="antiJapaneseMon" onchange="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">孤老增发：</td>
					<td class="FieldInput"><input type="text" id="oldLonelyMon" field="oldLonelyMon" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">其他补助1：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyOne" field="otherSubsidyOne" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				    <td class="FieldLabel">其他补助2：</td>
				    <td class="FieldInput"><input type="text" id="otherSubsidyTwo" field="otherSubsidyTwo" onchange="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">其他补助3：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyThree" field="otherSubsidyThree" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"/></td>
					<td class="FieldLabel">其他补助4：</td>
					<td class="FieldInput"><input type="text" id="otherSubsidyFour" field="otherSubsidyFour" onchange="checkIfFload(this);computeSumMon()" style="text-align:right"></input></td>
				    <td class="FieldLabel">其他补助5：</td>
				    <td class="FieldInput"><input type="text" id="otherSubsidyFive" field="otherSubsidyFive" onchange="checkIfFload(this);computeSumMon()" style="text-align: right"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">发放资金总额：</td>
					<td class="FieldInput" colspan="5"><label id="grantMonSum" field="grantMonSum" style="text-align:right"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">备注：</td>
					<td class="FieldInput" colspan="5"><textarea id="note" field="note" rows="2" style="width:96%"></textarea></td>
				</tr>
			</table>
		</form>        
	</next:Html>
	</next:Panel>
</body>
</html>
