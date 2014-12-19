<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位历史信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyHis.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var companyId='<%=request.getParameter("companyId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyHisDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyHisQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyHis"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmCompanyHisDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>单位历史信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">历史表主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyHisId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyChangeId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">组织机构代码：</td>
			<td class="FieldInput" style="width:36%"><label field="companyCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位名称：</td>
			<td class="FieldInput" style="width:36%"><label field="companyName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位性质：</td>
			<td class="FieldInput" style="width:36%"><label field="companyNature"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">法人：</td>
			<td class="FieldInput" style="width:36%"><label field="companyPeopleName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">批准文号：</td>
			<td class="FieldInput" style="width:36%"><label field="companyNo"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">住所：</td>
			<td class="FieldInput" style="width:36%"><label field="companyAdress"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">邮编：</td>
			<td class="FieldInput" style="width:36%"><label field="companyPostCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">从业人数：</td>
			<td class="FieldInput" style="width:36%"><label field="companyJobNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">编制人数：</td>
			<td class="FieldInput" style="width:36%"><label field="companyEstNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><label field="companyPhone"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">主管部门名称：</td>
			<td class="FieldInput" style="width:36%"><label field="companyBorgName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位所属业务类别：</td>
			<td class="FieldInput" style="width:36%"><label field="companyType"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">固定总资产：</td>
			<td class="FieldInput" style="width:36%"><label field="companyMon"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">状态：</td>
			<td class="FieldInput" style="width:36%"><label field="companyStatus"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">建筑面积：</td>
			<td class="FieldInput" style="width:36%"><label field="grossArea"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">办公地址：</td>
			<td class="FieldInput" style="width:36%"><label field="officeAdress"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">房间间数：</td>
			<td class="FieldInput" style="width:36%"><label field="roomsNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人姓名：</td>
			<td class="FieldInput" style="width:36%"><label field="principalName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人职务：</td>
			<td class="FieldInput" style="width:36%"><label field="principalDuty"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人移动电话：</td>
			<td class="FieldInput" style="width:36%"><label field="principalMobile"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人办公电话：</td>
			<td class="FieldInput" style="width:36%"><label field="principalPhone"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>