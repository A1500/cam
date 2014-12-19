<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>人员调动申请</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleTransfer.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
		var corpOrganId = '<%=BspUtil.getCorpOrganId()%>';
		var empOrganId = '<%=BspUtil.getEmpOrganId()%>';
</script>
</head>
<body >
<model:datasets>
	<model:dataset id="jcmPtPendingDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleTransferManageQueryCmd" method="">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleTransferManage"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel width="100%" border="0" title="人员调动申请" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem ></next:ToolBarItem>
		<next:ToolBarItem />
	</next:TopBar>
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
		<form class="L5form">
			<table border="1" width="48%">
				<tr>
					<td class="FieldLabel" style="width:15%">人员姓名：</td>
					<td class="FieldInput" style="width:18%" align="center"><input type="text" id="transfer_people_id" onclick="selectPeople()"/></td>
					<td class="FieldLabel" style="width:15%">原单位：</td>
					<td class="FieldInput" style="width:18%" align="center"><input type="text" disabled="true" id="from_dept_id" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">申请单位：</td>
					<td class="FieldInput" style="width:18%" align="center"><input type="text" disabled="true" id="to_dept_id" /></td>
					<td class="FieldLabel" style="width:15%">申请时间：</td>
					<td class="FieldInput" style="width:18%" align="center"><input type="text" disabled="true" id="apply_date" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">申请类型：</td>
					<td class="FieldInput" style="width:18%" align="center"><input type="text" disabled="true" id="apply_type" value="全职"/></td>
					<td class="FieldLabel" style="width:15%"></td>
					<td class="FieldButton" style="width:18%" align="center">
					<button onclick="query()" style="width:60%" >发起申请21</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
</next:Html>
</next:Panel>
<next:Panel width="100%" border="0"  title="人员详细信息" height="100%">
<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
		<form class="L5form">
			<table border="1" width="84%">
				<tr>
					<td class="FieldLabel" style="width:15%">姓名：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_name" /></td>
					<td class="FieldLabel" style="width:15%">性别：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_sex" /></td>
					<td class="FieldLabel" style="width:15%">政治面貌：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_politics" /></td>
					<td class="FieldInput" rowspan="4" title="照片">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">身份证号：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_card" /></td>
					<td class="FieldLabel" style="width:15%">出生年月：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_birthday" /></td>
					<td class="FieldLabel" style="width:15%">民族：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_nation" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">邮编：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_PC" /></td>
					<td class="FieldLabel" style="width:15%">联系电话：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_number" /></td>
					<td class="FieldLabel" style="width:15%">学历：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_edu" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">毕业院校：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_shcool" /></td>
					<td class="FieldLabel" style="width:15%">参加工作时间：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="job_start_time" /></td>
					<td class="FieldLabel" style="width:15%">家庭住址：</td>
					<td class="FieldInput" style="width:18%"><input type="text" disabled="true" id="people_adress" /></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>