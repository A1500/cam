<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
   var organCode='<%=BspUtil.getOrganCode()%>';
</script>
<html>
<!-- 社会组织综合查询主页面 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somQueryMain.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="../../../comm/dicm/autoComplete.js"></script>
<link href="../../../comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
</head> 
<body>
<model:datasets>
<!-- 证书 -->
<model:dataset id="Certdataset" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" autoLoad="true" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
				<model:param name="cert_status" value='1'></model:param>
		</model:params>	
</model:dataset>



	<!-- 社会组织种类 -->
	<model:dataset id="sorgType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织类型 -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行（事）业 -->
	<model:dataset id="busScope" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否为分支机构 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelectDic" cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="社会组织综合查询"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="进行查询" iconCls="edit" handler="forQuery"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
		<form class="L5form">
		<fieldset><legend>社会组织主体查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:10%"><label>社会组织名称：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="sorgName"/></td>
				<td class="FieldLabel" style="width:10%"><label>登记证号：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="sorgCode" /></td>
				<td class="FieldLabel" style="width:10%"><label>社会组织种类：</label></td>
				<td class="FieldInput" style="width:10%"><select id="sorgType"><option dataset="sorgType"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>是否为分支：</label></td>
				<td class="FieldInput"><select id="ifBranch"><option dataset="comm_yesorno"></option></select></td>
				<td class="FieldLabel"><label>社会组织类型：</label></td>
				<td class="FieldInput"><select id="sorgKind"><option dataset="sorgKind"></option></select></td>
				<td class="FieldLabel"><label>社会组织状态：</label></td>
				<td class="FieldInput"><select id="sorgStatus"><option dataset="sorgStatus"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>登记日期：</label></td>
				<td class="FieldInput"><input type="text" id="regDate"  format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)"/></td>
				<td class="FieldLabel"><label>活动地域：</label></td>
				<td class="FieldInput"><input type="text" id="actArea" /></td>
				<td class="FieldLabel"><label>业务范围：</label></td>
				<td class="FieldInput"><input type="text" id="business" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>组织英文名称：</label></td>
				<td class="FieldInput"><input type="text" id="enName" /></td>
				<td class="FieldLabel"><label>社会缩写名称：</label></td>
				<td class="FieldInput"><input type="text" id="abName" /></td>
				<td class="FieldLabel"><label>社会组织电子邮箱：</label></td>
				<td class="FieldInput"><input type="text" id="sorgEmail" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>组织机构代码：</label></td>
				<td class="FieldInput"><input type="text" id="organCode" /></td>
				<td class="FieldLabel"><label>社会组织电话：</label></td>
				<td class="FieldInput"><input type="text" id="sorgPhone" /></td>
				<td class="FieldLabel"><label>社会组织传真：</label></td>
				<td class="FieldInput"><input type="text" id="sorgFax" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>社会组织邮编：</label></td>
				<td class="FieldInput"><input type="text" id="sorgPost" /></td>
				<td class="FieldLabel"><label>社会组织通信地址：</label></td>
				<td class="FieldInput"><input type="text" id="sorgAdds" /></td>
				<td class="FieldLabel"><label>社会组织网址：</label></td>
				<td class="FieldInput"><input type="text" id=sorgWeb /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务主管单位：</label></td>
				<td class="FieldInput">
				<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','5')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
				<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        		<ul></ul> 
     			</div>
     			<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
     			<input type="hidden" id="ifHis" /></td>
				<td class="FieldLabel"><label>登记管理机关名称：</label></td>
				<td class="FieldInput"><input type="text" id="morgName" /></td>
				<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
				<td class="FieldInput">
				<input type="text"  id="morgAreaName" class="TextEditor" title="登记管理机关"  readonly="readonly" onclick="selectOrganNoDs()"/>
				<input type="hidden"  id="morgArea" class="TextEditor"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>所属行（事）业：</label></td>
				<td class="FieldInput"><select id="busScope"><option dataset="busScope"></option></select></td>
				<td class="FieldLabel"><label>资金数额大于：</label></td>
				<td class="FieldInput"><input type="text" id="regMon" /></td>
				<td class="FieldLabel"><label>法定代表人：</label></td>
				<td class="FieldInput"><input type="text" id="legalPeople" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>会员数量大于：</label></td>
				<td class="FieldInput"><input type="text" id="memberNum" /></td>
				<td class="FieldLabel"><label>单位会员数量大于：</label></td>
				<td class="FieldInput"><input type="text" id="unitsNum" /></td>
				<td class="FieldLabel"><label>个人会员数量大于：</label></td>
				<td class="FieldInput"><input type="text" id="peopleNum" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>常务理事数大于：</label></td>
				<td class="FieldInput"><input type="text" id="standCouncilNum" /></td>
				<td class="FieldLabel"><label>理事数大于：</label></td>
				<td class="FieldInput"><input type="text" id="councilNum" /></td>
				<td class="FieldLabel"><label>从业人员数大于：</label></td>
				<td class="FieldInput"><input type="text" id="engagedNum" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>住所：</label></td>
				<td class="FieldInput"><input type="text" id="residence" /></td>
				<td class="FieldLabel"><label>注销日期：</label></td>
				<td class="FieldInput"><input type="text" id="cancelDate" format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)" /></td>
				<td class="FieldLabel"><label></label></td>
				<td class="FieldInput"></td>
			</tr>
		</table>
		</fieldset>
		<!-- 
		<fieldset><legend>社会组织证书查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:10%"><label>发证机关：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="signOrgan" /></td>
				<td class="FieldLabel" style="width:10%"><label>发证日期：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="signDate"  format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)"/></td>
				<td class="FieldLabel" style="width:10%"><label>证件有效日期止：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="signEndDate"  format="Y-m-d"  readonly="readonly" onclick="LoushangDate(this);"/></td>
			</tr>
		</table>
		</fieldset>
		<fieldset><legend>社会组织账户查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:10%"><label>开户银行：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="bank" /></td>
				<td class="FieldLabel" style="width:10%"><label>开户日期：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="accountDate"  format="Y-m-d"  readonly="readonly"  onclick="showQueryDate(this)"/></td>
				<td class="FieldLabel" style="width:10%"><label>开户银行帐号：</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="accountCode" /></td>
			</tr>
		</table>
		</fieldset>
		 -->
		</form>
</next:Html>
</next:Panel>
<jsp:include page="../../comm/borg/borgSelectWindow.jsp" flush="true"/>  
</body>
</html>