<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基础信息社会组织明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="cdcOrganInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organId='<%=request.getParameter("organId")%>';
	function init(){
		var cdcOrganInfoDataSet=L5.DatasetMgr.lookup("cdcOrganInfoDataSet");
		cdcOrganInfoDataSet.setParameter("ORGAN_ID@=",organId);
		cdcOrganInfoDataSet.load();
	}
	function returnBack(){
		history.go(-1);
	}
	function pRender(val){
		if(val!="")
		return val+" 人";
	}
	function gRender(val){
		if(val!="")
		return val+" 个";
	}
	function aRender(val){
		if(val!="")
		return val+" 平方米";
	}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcOrganInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganInfo"/>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.ORGAN_KIND" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcOrganInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>社区社会组织信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">社会组织名称：</td>
			<td class="FieldInput" style="width:20%"><label name="社会组织名称" id="corpName" field="corpName" maxlength="200" /></td>
			<td class="FieldLabel" style="width:10%">组织机构代码：</td>
			<td class="FieldInput" style="width:20%"><label name="组织机构代码" id="organizationCode" field="organizationCode" maxlength="50" /></td>
			<td class="FieldLabel" style="width:10%">社会组织性质：</td>
			<td class="FieldInput" style="width:20%"><label name="社会组织性质" id="organKind" field="organKind" dataset = "organTypeDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">负责人姓名：</td>
			<td class="FieldInput" style="width:20%"><label name="负责人姓名" id="legalPeople" field="legalPeople" maxlength="50" /></td>
			<td class="FieldLabel" style="width:10%">联系电话：</td>
			<td class="FieldInput" style="width:20%"><label name="电话" id="organPhone" field="organPhone" maxlength="50" /></td>
			<td class="FieldLabel" style="width:10%">邮政编码：</td>
			<td class="FieldInput" style="width:20%"><label name="邮政编码" id="postCode" field="postCode" maxlength="6" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">成员人数：</td>
			<td class="FieldInput"><label name="成员人数" field="memberNum" renderer="pRender" /></td>
			<td class="FieldLabel">办公场所数量：</td>
			<td class="FieldInput"><label name="办公场所数量" field="officialNum" renderer="gRender" /></td>
			<td class="FieldLabel">办公场所面积(㎡)：</td>
			<td class="FieldInput"><label name="办公场所面积" field="floorArea" renderer="aRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">业务范围：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><label name="业务范围" id="businessScope" field="businessScope" maxlength="50" style="width:57%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">地址：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><label name="地址" id="organAdds" field="organAdds" maxlength="50" style="width:57%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>