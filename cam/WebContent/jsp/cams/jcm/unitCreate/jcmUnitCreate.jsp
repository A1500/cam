<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>基层民政用户维护</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmUnitCreate.js"></script>
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
	<!-- 用户列表 -->
	<model:dataset id="jcmUserinfoList" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd"  method="queryUserinfo" pageSize="10" global="true">
	</model:dataset>
	
	<!-- 增加用户 -->
	<model:dataset id="jcmUserinfo" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" pageSize="10" global="true">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile">
			<model:field name="userId" type="string" rule="require|length{500}" />
			<model:field name="companyName" type="string" rule="require|length{100}" />
			<model:field name="organName" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="jcmUserinfoquery" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" pageSize="10" global="true">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"></model:record>
	</model:dataset>
	
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">登陆用户名</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="userId" style="width:40%"/></td>
					<td class="FieldLabel" style="width:10%">单位名称</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="unitName"  style="width:40%"  />
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">所属行政区划</td>
					<td class="FieldInput" style="width:20%"><input type="text"
						name="所属行政区划" id="organName"   style="width: 40%" readonly="readonly"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForManaSelect();" /> <input
						type="text" id="organCode"   style="display: none" /></td>
					<td class="FieldLabel" style="width:10%">单位所属业务类别</td>
					<td class="FieldInput" style="width:20%"><select id="unitType" style="width:40%">
					<option dataset=""></option> </select></td>
					<td class="FieldButton" style="width:20%"><button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="jcmUserinfoList" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem  text="基层民政用户维护" ></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="创建用户" handler="insert"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="USER_ID" header="登陆用户名" width="200" sortable="false"/>
		<next:Column field="COMPANY_NAME" header="单位名称" width="300" sortable="false"/>
		<next:Column field="ORGAN_NAME" header="所属行政区划"  width="200"sortable="false"/>
		<next:Column field="COMPANY_TYPE" header="单位所属业务类别"  width="200"sortable="false"/>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmUserinfoList"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="userinfo" closeAction="hide" title="基层民政用户维护" width="700" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content2" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="jcmUserinfo">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:30%">登陆用户名：</td>
				<td class="FieldInput" style="width:70%" ><input type="text" field="userId" /><font color="red">*   (默认密码为1)</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:20%">单位名称：</td>
				<td class="FieldInput" style="width:20%" ><input type="text" id="companyName" field="companyName"  style="width:40%" /><font color="red">*    </font><button onclick="chooseUnit()">点击选择已有单位</button></td>
    		</tr>
			<tr>
				<td class="FieldLabel" style="width:20%">所属行政区划：</td>
				<td class="FieldInput" style="width:20%"><input type="text"
						name="所属行政区划" field="organName" readonly="readonly"/><font color="red">*</font><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForManaSelectWin();" /> <input
						type="text" field="organCode"   style="display: none" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:20%">单位所属业务类别</td>
				<td class="FieldInput" style="width:20%"><select field="companyType">
				<option dataset=""></option> </select></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>

<next:Window id="unitWin" closeAction="hide" title="选择已有单位" width="700" modal="true">
	<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%">单位名称</td>
					<td class="FieldInput" style="width:20%" ><input type="text" id="unitName1"  style="width:80%"  />
						<td class="FieldLabel" style="width:20%">所属行政区划</td>
					<td class="FieldInput" style="width:20%"><input type="text"
						name="所属行政区划" id="organName1"   style="width: 80%" readonly="readonly"/><img
						src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForManaSelect1();" /> <input
						type="text" id="organCode1"   style="display: none" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:20%">单位所属业务类别</td>
					<td class="FieldInput" style="width:20%"><select id="unitType1" style="width:80%">
					<option dataset=""></option> </select></td>
					<td class="FieldButton" style="width:20%" colspan="2"><button onclick="querychoose()">查询</button> &nbsp&nbsp&nbsp&nbsp<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
	<next:EditGridPanel id="subgrid" dataset="jcmUserinfoquery" width="98%" stripeRows="true" height="300">
	<next:TopBar>
		<next:ToolBarItem  text="已有单位列表" ></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="submitUnit"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="companyName" header="单位名称" width="300" sortable="false"/>
		<next:Column field="organName" header="所属行政区划"  width="150"sortable="false"/>
		<next:Column field="companyType" header="单位所属业务类别"  width="150"sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmUserinfoquery"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Window>

</body>
</html>