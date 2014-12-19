<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基础信息社区共建单位明细</title>
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
		if(val!=""){
			return val+" 人";
		}
    }
    function aRender(val){
		if(val!=""){
			return val+" 平方米";
		}
    }
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcOrganInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganInfo"/>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.CORP_TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcOrganInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>基础信息社区共建单位信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">共建单位名称：</td>
			<td class="FieldInput" style="width:20%"><label field="corpName" /></td>
			<td class="FieldLabel" style="width:10%">组织机构代码：</td>
			<td class="FieldInput" style="width:20%"><label field="organizationCode" /></td>
			<td class="FieldLabel" style="width:10%">共建单位性质：</td>
			<td class="FieldInput" style="width:20%"><label  field="organKind" dataset = "organTypeDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">法人代表：</td>
			<td class="FieldInput" style="width:20%"><label field="legalPeople"/></td>
			<td class="FieldLabel" style="width:10%">联系电话：</td>
			<td class="FieldInput" style="width:20%"><label  field="organPhone"/></td>
			<td class="FieldLabel" style="width:10%">邮政编码：</td>
			<td class="FieldInput" style="width:20%"><label  field="postCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">职工人数：</td>
			<td class="FieldInput"><label name="职工人数" field="memberNum" renderer="pRender" /></td>
			<td class="FieldLabel">办公场所面积：</td>
			<td class="FieldInput"><label name="办公场所面积" field="floorArea" renderer="aRender"/ ></td>
			<td class="FieldLabel">进驻时间：</td>
			<td class="FieldInput"><label field="enterDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">主管单位：</td>
			<td class="FieldInput" colspan="5"><label field="morgName" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">地址：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><label  field="organAdds"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>