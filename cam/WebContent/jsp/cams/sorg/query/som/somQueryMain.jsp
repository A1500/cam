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
<!-- �����֯�ۺϲ�ѯ��ҳ�� -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somQueryMain.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="../../../comm/dicm/autoComplete.js"></script>
<link href="../../../comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
</head> 
<body>
<model:datasets>
<!-- ֤�� -->
<model:dataset id="Certdataset" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" autoLoad="true" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
				<model:param name="cert_status" value='1'></model:param>
		</model:params>	
</model:dataset>



	<!-- �����֯���� -->
	<model:dataset id="sorgType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- �����֯���� -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- �����֯״̬ -->
	<model:dataset id="sorgStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- �����У��£�ҵ -->
	<model:dataset id="busScope" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- �Ƿ�Ϊ��֧���� -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- ҵ�����ܵ�λ -->
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
		<next:ToolBarItem symbol="�����֯�ۺϲ�ѯ"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="���в�ѯ" iconCls="edit" handler="forQuery"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
		<form class="L5form">
		<fieldset><legend>�����֯�����ѯ����</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:10%"><label>�����֯���ƣ�</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="sorgName"/></td>
				<td class="FieldLabel" style="width:10%"><label>�Ǽ�֤�ţ�</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="sorgCode" /></td>
				<td class="FieldLabel" style="width:10%"><label>�����֯���ࣺ</label></td>
				<td class="FieldInput" style="width:10%"><select id="sorgType"><option dataset="sorgType"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>�Ƿ�Ϊ��֧��</label></td>
				<td class="FieldInput"><select id="ifBranch"><option dataset="comm_yesorno"></option></select></td>
				<td class="FieldLabel"><label>�����֯���ͣ�</label></td>
				<td class="FieldInput"><select id="sorgKind"><option dataset="sorgKind"></option></select></td>
				<td class="FieldLabel"><label>�����֯״̬��</label></td>
				<td class="FieldInput"><select id="sorgStatus"><option dataset="sorgStatus"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>�Ǽ����ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="regDate"  format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)"/></td>
				<td class="FieldLabel"><label>�����</label></td>
				<td class="FieldInput"><input type="text" id="actArea" /></td>
				<td class="FieldLabel"><label>ҵ��Χ��</label></td>
				<td class="FieldInput"><input type="text" id="business" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>��֯Ӣ�����ƣ�</label></td>
				<td class="FieldInput"><input type="text" id="enName" /></td>
				<td class="FieldLabel"><label>�����д���ƣ�</label></td>
				<td class="FieldInput"><input type="text" id="abName" /></td>
				<td class="FieldLabel"><label>�����֯�������䣺</label></td>
				<td class="FieldInput"><input type="text" id="sorgEmail" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>��֯�������룺</label></td>
				<td class="FieldInput"><input type="text" id="organCode" /></td>
				<td class="FieldLabel"><label>�����֯�绰��</label></td>
				<td class="FieldInput"><input type="text" id="sorgPhone" /></td>
				<td class="FieldLabel"><label>�����֯���棺</label></td>
				<td class="FieldInput"><input type="text" id="sorgFax" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>�����֯�ʱࣺ</label></td>
				<td class="FieldInput"><input type="text" id="sorgPost" /></td>
				<td class="FieldLabel"><label>�����֯ͨ�ŵ�ַ��</label></td>
				<td class="FieldInput"><input type="text" id="sorgAdds" /></td>
				<td class="FieldLabel"><label>�����֯��ַ��</label></td>
				<td class="FieldInput"><input type="text" id=sorgWeb /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>ҵ�����ܵ�λ��</label></td>
				<td class="FieldInput">
				<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="ҵ�����ܵ�λ"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','5')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
				<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        		<ul></ul> 
     			</div>
     			<input type="hidden" id="borgName" name="borgName" field="borgName" title="ҵ�����ܵ�λ����"/>
     			<input type="hidden" id="ifHis" /></td>
				<td class="FieldLabel"><label>�Ǽǹ���������ƣ�</label></td>
				<td class="FieldInput"><input type="text" id="morgName" /></td>
				<td class="FieldLabel"><label>�Ǽǹ����������������</label></td>
				<td class="FieldInput">
				<input type="text"  id="morgAreaName" class="TextEditor" title="�Ǽǹ������"  readonly="readonly" onclick="selectOrganNoDs()"/>
				<input type="hidden"  id="morgArea" class="TextEditor"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>�����У��£�ҵ��</label></td>
				<td class="FieldInput"><select id="busScope"><option dataset="busScope"></option></select></td>
				<td class="FieldLabel"><label>�ʽ�������ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="regMon" /></td>
				<td class="FieldLabel"><label>���������ˣ�</label></td>
				<td class="FieldInput"><input type="text" id="legalPeople" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>��Ա�������ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="memberNum" /></td>
				<td class="FieldLabel"><label>��λ��Ա�������ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="unitsNum" /></td>
				<td class="FieldLabel"><label>���˻�Ա�������ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="peopleNum" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>�������������ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="standCouncilNum" /></td>
				<td class="FieldLabel"><label>���������ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="councilNum" /></td>
				<td class="FieldLabel"><label>��ҵ��Ա�����ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="engagedNum" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>ס����</label></td>
				<td class="FieldInput"><input type="text" id="residence" /></td>
				<td class="FieldLabel"><label>ע�����ڣ�</label></td>
				<td class="FieldInput"><input type="text" id="cancelDate" format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)" /></td>
				<td class="FieldLabel"><label></label></td>
				<td class="FieldInput"></td>
			</tr>
		</table>
		</fieldset>
		<!-- 
		<fieldset><legend>�����֤֯���ѯ����</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:10%"><label>��֤���أ�</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="signOrgan" /></td>
				<td class="FieldLabel" style="width:10%"><label>��֤���ڣ�</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="signDate"  format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)"/></td>
				<td class="FieldLabel" style="width:10%"><label>֤����Ч����ֹ��</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="signEndDate"  format="Y-m-d"  readonly="readonly" onclick="LoushangDate(this);"/></td>
			</tr>
		</table>
		</fieldset>
		<fieldset><legend>�����֯�˻���ѯ����</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:10%"><label>�������У�</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="bank" /></td>
				<td class="FieldLabel" style="width:10%"><label>�������ڣ�</label></td>
				<td class="FieldInput" style="width:10%"><input type="text" id="accountDate"  format="Y-m-d"  readonly="readonly"  onclick="showQueryDate(this)"/></td>
				<td class="FieldLabel" style="width:10%"><label>���������ʺţ�</label></td>
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