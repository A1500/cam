<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新建</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="addPoliciesReg.js"></script>
		<script language="javascript">
			var empName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
			var organId='<%=BspUtil.getCorpOrganId()%>';
		    var organName='<%=BspUtil.getOrganName()%>';
		    var organCode='<%=BspUtil.getOrganCode()%>';
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="policRegDS" cmd="com.inspur.cams.prs.prspoliciesregulations.cmd.PrsPoliciesRegulationsQueryCmd" >
		<model:record fromBean="com.inspur.cams.prs.prspoliciesregulations.dao.PrsPoliciesRegulations">
		</model:record>
	</model:dataset>
	<model:dataset id="typeDS" enumName="PRS.POLICREG_TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
	<next:Panel title="基本信息" collapsible="false" width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="yes" text="下发" handler="click_save"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="返回" handler="click_return"/>
		</next:TopBar>
			<next:Html>
			<form id="form_content" method="post" dataset="policRegDS" onsubmit="return false" class="L5form">
				<table id="table1" border=1 width="100%">
					<tr>
						<td class="FieldLabel">文号：</td>
						<td colspan="3">
							<input type="text" id="fileNum" name="文号" field="fileNum" maxlength="100"   style="width: 300px">
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">标题：</td>
						<td colspan="3">
							<input type="text" id="regulationsTitle" name="标题" field="regulationsTitle" maxlength="100"   style="width: 300px">
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">类别：</td>
						<td colspan="3">
							<select id="type" name="类别" field="type" maxlength="100"   style="width: 300px"><option dataset="typeDS"></option></select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">接收单位：</td>
						<td colspan="3">
							<textarea id="acceptingCompany" name="接收单位" field="acceptingCompany"	rows="3" cols="30" style="width:90%" readonly="readonly"></textarea>
							<input type="button" name="selectdept" value="选择部门" onclick="selectUser()" style="CURSOR: hand">
							<input type="hidden"  id="acceptingCompanyCode" field = "acceptingCompanyCode" class="TextEditor"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">内容：</td>
						<td colspan="3">
							<textarea id="content" name="内容" field="content"	rows="4" cols="15" style="width:90%"></textarea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">备注：</td>
						<td colspan="3">
							<textarea id="remarks" name="备注：" field="remarks"	rows="2" cols="15" style="width:90%"></textarea>
						</td>
					</tr>
					<tr><td class="FieldLabel">附件</td>
					<td colspan="3">
					<input type=button value="添加" onclick="add_row()" style="CURSOR: hand"><span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
</body>
</html>
