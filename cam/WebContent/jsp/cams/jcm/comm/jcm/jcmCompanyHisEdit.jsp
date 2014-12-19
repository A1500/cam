<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位历史信息编辑</title>
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
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmCompanyHisDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>单位历史信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">历史表主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="历史表主键" id="companyHisId" field="companyHisId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="变更主键" id="companyChangeId" field="companyChangeId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="主键" id="companyId" field="companyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">组织机构代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="组织机构代码" id="companyCode" field="companyCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位名称" id="companyName" field="companyName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位性质：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位性质" id="companyNature" field="companyNature" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">法人：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="法人" id="companyPeopleName" field="companyPeopleName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">批准文号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="批准文号" id="companyNo" field="companyNo" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">住所：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="住所" id="companyAdress" field="companyAdress" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">邮编：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="邮编" id="companyPostCode" field="companyPostCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">从业人数：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="从业人数" id="companyJobNum" field="companyJobNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">编制人数：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="编制人数" id="companyEstNum" field="companyEstNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="联系电话" id="companyPhone" field="companyPhone" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">主管部门名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="主管部门名称" id="companyBorgName" field="companyBorgName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位所属业务类别：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位所属业务类别" id="companyType" field="companyType" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">固定总资产：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="固定总资产" id="companyMon" field="companyMon" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">状态：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="状态" id="companyStatus" field="companyStatus" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">建筑面积：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="建筑面积" id="grossArea" field="grossArea" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">办公地址：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="办公地址" id="officeAdress" field="officeAdress" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">房间间数：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="房间间数" id="roomsNum" field="roomsNum" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人姓名：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="负责人姓名" id="principalName" field="principalName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人职务：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="负责人职务" id="principalDuty" field="principalDuty" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人移动电话：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="负责人移动电话" id="principalMobile" field="principalMobile" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">负责人办公电话：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="负责人办公电话" id="principalPhone" field="principalPhone" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>