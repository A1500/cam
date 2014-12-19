<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<% 
	String registerType = request.getParameter("registerType");
	String title = "";
	if ("11".equals(registerType)) {
		title = "伤残资金";
	} else if ("21".equals(registerType)) {
		title = "三属资金";
	} else if ("41".equals(registerType)) {
		title = "在乡复员资金";
	} else if ("42".equals(registerType)) {
		title = "带病回乡资金";
	} else if ("51".equals(registerType)) {
		title = "两参人员资金";
	} else if("00".equals(registerType)) {
		title = "优待金发放";
	}

%>
<script type="text/javascript">
   var organCode='<%=BspUtil.getOrganCode()%>';
   var registerType = '<%=registerType%>'
   
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
<html>
	<head>
		<title>excel导入<%= title%>发放信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="imp_disablity.js"></script>
	</head>
<body>
<model:datasets>
	
	<!-- 伤残信息 -->
	<model:dataset id="disabiltyTemp"
		cmd="com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalQueryCommand" global="true"
		 method="queryDisabilityMark">
		 <model:record fromBean="com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark"></model:record>
	</model:dataset>
	  
	<model:dataset id="isvaildate" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel" align="center" style="text-align: center"><button onclick="query()">查 询</button></td>
							</tr>
							<tr>	
								<td class="FieldLabel">是否验证成功：</td>
								<td class="FieldInput">
									<select id="isVailidate"> 
											<option dataset="isvaildate"></option>
									</select>
								</td>	
								 <td class="FieldLabel">是否导入数据库：</td>
								<td class="FieldInput">
										<select  id="isInDB" > 
											<option dataset="isvaildate"></option>
										</select>
								</td>	
								<td class="FieldLabel" align="center" style="text-align: center"><button onclick="reset()">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="baseGridPanel" name="basicInfoGridPanel" bodyStyle="margin-top:5px;" width="100%" height="98%" autoScroll="false" stripeRows="true" dataset="disabiltyTemp" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem handler="update" iconCls="save" text="修改" ></next:ToolBarItem>
		<next:ToolBarItem handler="deleteRecord" iconCls="delete" text="删除" ></next:ToolBarItem>
		<next:ToolBarItem handler="into" iconCls="save" text="导入Excel" ></next:ToolBarItem>
		<next:ToolBarItem handler="save" iconCls="save" text="写入数据库" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id='NAME' header='姓名' field='name' width='60' >
			<next:TextField allowBlank='false' />
		</next:Column>
		
		<next:Column id='ID_CARD' header='身份证号' field='idCard' width='140' >
			<next:TextField allowBlank='false' />
		</next:Column>
		
		<next:Column id='grantMon' header='发放金额' field='grantMon' width='100' >
			<next:TextField allowBlank='false' />
		</next:Column>
		<%-- 
		<next:Column id='subTotal' header='地方补贴小计' field='subTotal' width='100' >
			<next:TextField allowBlank='false' />
		</next:Column>
		--%>
		<next:Column id='grantMonSum' header='发放资金总额' field='grantMonSum' width='100' >
			<next:TextField allowBlank='false' />
		</next:Column>
		
		<next:Column id='GRANT_DATE' header='发放日期' field='grantDate' width='100' >
			<next:TextField allowBlank='false' />
		</next:Column>
		
		<next:Column id='VALIDATE_FLAG' header='是否通过验证' field='validateFlag' width='100' renderer="change_func" >
			<next:TextField allowBlank='false' />
		</next:Column>
		
		<next:Column id='ERROR_MESSAGE' header='错误信息' field='errorMessage' width='200' >
			<next:TextField allowBlank='false' />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="disabiltyTemp"/>
	</next:BottomBar>
</next:GridPanel>

<next:Window id="addNewDemobilizedGrantObject" title="导入excel" resizable="false" width="600" height="100"  closeAction="hide" modal="true">
	<next:Panel>
	<next:Html>
		<form onsubmit="return false" id="form_content"  style="width: 99%; height: 100%;" class="L5form">
			<table  border="1" width="100%" >
			<tr>  
				<td width="12%" nowrap="nowrap" class="FieldLabel">excel文件：</td>
				<td width="78%" nowrap="nowrap" class="FieldInput">
				<input style="width:450px;" type="file" id="filename" name="file" title="文件名"  /></td>	
				
				<td width="10%" nowrap="nowrap" align="center"><button onclick="upload()">导入</button></td>
			</tr>
			</table>
		</form>
	</next:Html>
	</next:Panel>
</next:Window>

<next:Window id="saveData" title="写入数据库" resizable="false" width="600" autoHeight="true"  closeAction="hide" modal="true">
	<next:Panel>
	<next:Html>
		<form onsubmit="return false" style="width: 99%; height: 100%;" class="L5form">
			<table  border="1" width="100%" >
			<tr>  
				<td class="FieldLabel">发放起月份：</td>
				<td class="FieldInput"><input type="text" id="startDate"
					class="TextEditor" style="width: 80" format="Y-m" maxlength="7" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"><font color="red">*</font></td>
				<td class="FieldLabel">发放止月份：</td>
				<td class="FieldInput"><input type="text" id="endDate"
					class="TextEditor" format="Y-m" style="width: 80" maxlength="7" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"><font color="red">*</font></td>
				<td class="FieldLabel" align="center"><button onclick="impData()">写入数据库</button></td>		
			</tr>
			</table>
		</form>
	</next:Html>
	</next:Panel>
</next:Window>

</body>
</html>
