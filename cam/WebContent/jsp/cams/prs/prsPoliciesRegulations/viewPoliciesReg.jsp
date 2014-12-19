<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>详情</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="viewPoliciesReg.js"></script>
		<script language="javascript">
			var empName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
			var organId='<%=BspUtil.getCorpOrganId()%>';
		    var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
		    var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		    var page='<%=request.getParameter("page")%>';
		    var queryId='<%=request.getParameter("queryId")%>';
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
			<next:ToolBarItem iconCls="return" text="返回" handler="click_return"/>
		</next:TopBar>
			<next:Html>
			<form id="form_content" method="post" dataset="policRegDS" onsubmit="return false" class="L5form">
				<table id="table1" border=1 width="100%">
					<tr>
						<td class="FieldLabel" width="100">文号：</td>
						<td >
							<label id="regulationsTitle" name="文号" field="FILE_NUM" ></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" width="100">标题：</td>
						<td >
							<label id="regulationsTitle" name="标题" field="REGULATIONS_TITLE" ></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">类别：</td>
						<td >
							<label id="type" name="类别" field="TYPE"  dataset="typeDS"></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">接收单位：</td>
						<td >
							<textarea id="acceptingCompany" name="接收单位" field="ACCEPTING_COMPANY"	rows="3" cols="30" style="width:90%" readonly="readonly"></textarea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">内容：</td>
						<td >
							<textarea id="content" name="内容" field="CONTENT"	rows="4" cols="15" style="width:90%"  readonly="readonly"></textarea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">备注：</td>
						<td >
							<textarea id="remarks" name="备注" field="REMARKS"	rows="2" cols="15" style="width:90%" readonly="readonly"></textarea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">附件</td>
						<td >
							<div id="fileName"></div>
	           			</td>
           			</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
</body>
</html>
