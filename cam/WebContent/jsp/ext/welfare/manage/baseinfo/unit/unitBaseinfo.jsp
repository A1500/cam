<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
	<head>
		<title>企业年检查询列表</title>
		<%
			String username = ExtBspInfo.getUserInfo(request).getUserName();
			String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
			String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
		%>
		<next:ScriptManager/>
		<script language="javascript">
		var username='<%=username%>';
	    var peopleArea='<%=peopleArea%>';
	    var serialNum="";
		function init() {
			var unitStatusDataSet = L5.DatasetMgr.lookup("unitStatusDataSet");
			unitStatusDataSet.setParameter("COMPANY_NAME@=", username);
			unitStatusDataSet.load(true);
			if(unitStatusDataSet.getCount()==0){
				L5.Msg.alert("提示","正在进行资格认定申报，暂不能在此处查看，可通过资格认定申报界面查看申报内容...");
				return;
			}else{
				serialNum=unitStatusDataSet.getAt(0).get("serialNum");
			}
			ds.setParameter("WEAL_UNIT_STATUS.SERIAL_NUM@=",serialNum);
			ds.load();
		};
		</script>
	</head>
<body>
<model:datasets>
	<!-- 状态信息表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
	<!-- 根据登录用户名称查询企业字号 -->
	<model:dataset id="unitStatusDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitStatusQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus">
		</model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
	<next:Panel title="基本信息" width="99%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<fieldset>
		<legend>企业基本信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">编号</td>
				<td class="FieldInput" width="19%"><label title="编号" name="serialNum" field="serialNum" style="width: 95%"/></td>
	
				<td  class="FieldLabel" width="14%">企业名称</td>
				<td class="FieldInput" width="19%"><label title="企业名称" name="companyName" field="companyName" style="width: 95%"/></td>
				
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label name="legalPeople" field="legalPeople" style="width: 95%" /></td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" width="14%">注册地址</td>
				<td class="FieldInput" width="19%"><label name="address" field="address" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%">邮编</td>
				<td class="FieldInput" width="19%"><label name="postCode" field="postCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">网站地址</td>
				<td class="FieldInput" width="19%"><label name="webAddress" field="webAddress" style="width: 95%" /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" width="14%">经济性质</td>
				<td class="FieldInput" width="19%">
					<label dataset="ecoDataSet" id="economicNatureCode" field="economicNatureCode" name="经济性质" title="经济性质" style="width: 95%"/></td>
					
				<td  class="FieldLabel" width="14%">注册资金（万元）</td>
				<td class="FieldInput" width="19%"><label name="regFund" field="regFund" style="width: 95%" /> </td>	
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">组织机构代码</td>
				<td class="FieldInput" width="19%"><label name="organCode" field="organCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">营业执照编号</td>
				<td class="FieldInput" width="19%"><label name="licenseCode" field="licenseCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">税务登记编号</td>
				<td class="FieldInput" width="19%"><label name="registrationCode" field="registrationCode" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">经营范围 主营</td>
				<td class="FieldInput" width="19%"><label name="firstScope" field="firstScope" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">经营范围 兼营</td>
				<td class="FieldInput" width="19%"><label name="secondScope" field="secondScope" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="14%">批准通过时间</td>
				<td class="FieldInput" width="19%"><label id="approveDate" name="approveDate" field="approveDate" style="width: 95%" /></td>
			
				<td class="FieldLabel" width="14%">下一次年检年度</td>
				<td class="FieldInput" width="19%"><label id="nextCheck" name="nextCheck" field="nextCheck" style="width: 95%" /></td>
			
				<td class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"> </td>
			</tr>
   		</table>
		</fieldset>
		<fieldset>
		<legend>法人信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label  name="法人姓名" field="legalPeople" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%">身份证号码</td>
				<td class="FieldInput" width="19%"><label  name="法人身份证号码" field="legalIdCard" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label  name="法人固定电话" field="legalPhone" style="width: 95%" /></td>
				
			</tr>
			<tr>
				<td  class="FieldLabel" width="14%">手机号码</td>
				<td class="FieldInput" width="19%"><label  name="法人手机号码" field="legalTelphone" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td  class="FieldInput" width="14%"></td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td  class="FieldInput" width="14%"></td>
			</tr>
		</table>
		</fieldset>
		<fieldset>
		<legend>经办人信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label name="agentPeople" field="agentPeople" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">联系电话</td>
				<td class="FieldInput" width="19%"><label name="agentPhone" field="agentPhone" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">电子邮箱</td>
				<td class="FieldInput" width="19%"><label name="agentEmail" field="agentEmail" style="width: 95%" /> </td>
			</tr>
		</table>
		</fieldset>
		</form>
   </next:Html>
   </next:Panel>
</body>
</html>