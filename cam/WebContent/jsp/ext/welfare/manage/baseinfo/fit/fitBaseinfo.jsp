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
			var fitStatusDataSet = L5.DatasetMgr.lookup("fitStatusDataSet");
			fitStatusDataSet.setParameter("COMPANY_NAME@=", username);
			fitStatusDataSet.load(true);
			if(fitStatusDataSet.getCount()==0){
				L5.Msg.alert("提示","正在进行资格认定申报，暂不能在此处查看，可通过资格认定申报界面查看申报内容...");
				return;
			}else{
				serialNum=fitStatusDataSet.getAt(0).get("serialNum");
			}
			ds.setParameter("WEAL_FIT_STATUS.SERIAL_NUM@=",serialNum);
			ds.load();
		};
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus"></model:record>
	</model:dataset>
	<!-- 根据登录用户名称查询企业字号 -->
	<model:dataset id="fitStatusDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus">
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
				<td class="FieldInput" width="19%"><label  title="编号" name="serialNum" field="serialNum" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%">企业名称</td>
				<td class="FieldInput" width="19%"><label title="企业名称" name="companyName" field="companyName" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">注册地址</td>
				<td class="FieldInput" width="19%"><label name="address" field="address" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">邮编</td>
				<td class="FieldInput" width="19%"><label name="postCode" field="postCode" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">网站地址</td>
				<td class="FieldInput" width="19%"><label name="webAddress" field="webAddress" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">经济性质</td>
				<td class="FieldInput" width="19%">
					<label id="economicNatureCode" dataset="ecoDataSet" field="economicNatureCode" name="经济性质" title="经济性质" style="width: 95%">
					     	</label> </td>
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
				<td  class="FieldLabel" width="14%">注册资金<br>（万元）</td>
				<td class="FieldInput" width="19%"><label name="regFund" field="regFund" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%">经营范围</td>
				<td class="FieldInput" width="19%" colspan="3"><textarea name="businessScope" field="businessScope" disabled="disabled" style="width: 95%" ></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" width="14%">初次认定时间</td>
				<td class="FieldInput" width="19%"><label id="cognizanceDate" name="cognizanceDate" field="cognizanceDate"  format="Y-m-d" style="width: 95%" /></td>
				
				<td  class="FieldLabel" width="14%">下一次年检年度</td>
				<td class="FieldInput" width="19%"><label id="nextCheck" name="nextCheck" field="nextCheck" style="width: 95%" maxlength="4"/></td>
			
				<td  class="FieldLabel" width="14%">下一次换证年度</td>
				<td class="FieldInput" width="19%"><label id="nextChagneCert" name="nextChagneCert" field="nextChagneCert" style="width: 95%" maxlength="4" /></td>
			</tr>
   		</table>
		</fieldset>
	   	<fieldset>
		<legend>法定代表人信息</legend>
		<table border="1"  width="100%" >
			<tr>		
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label name="legalPeople" field="legalPeople" style="width: 95%" /></td>
			
				<td  class="FieldLabel" width="14%">身份证号</td>
				<td class="FieldInput" width="19%"><label name="legalIdCard" field="legalIdCard" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label name="legalPhone" field="legalPhone" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">手机</td>
				<td class="FieldInput" width="19%"><label name="legalTelphone" field="legalTelphone" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">电子邮箱</td>
				<td class="FieldInput" width="19%"><label name="legalEmail" field="legalEmail" style="width: 95%" /> </td>
				
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
   		</table>
		</fieldset>
		<fieldset style="display:none">
		<legend>经办人信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">姓名</td>
				<td class="FieldInput" width="19%"><label name="agentPeople" field="agentPeople" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">身份证号</td>
				<td class="FieldInput" width="19%"><label name="agentIdCard" field="agentIdCard" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">固定电话</td>
				<td class="FieldInput" width="19%"><label name="agentPhone" field="agentPhone" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">手机</td>
				<td class="FieldInput" width="19%"><label name="agentTelphone" field="agentTelphone" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">电子邮箱</td>
				<td class="FieldInput" width="19%"><label name="agentEmail" field="agentEmail" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%"></td>
				<td class="FieldInput" width="19%"></td>
			</tr>
		</table>
		</fieldset>
		<fieldset>
		<legend>场地信息</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td  class="FieldLabel" width="14%">总经营面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="operateArea" field="operateArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">制作间面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="productArea" field="productArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">康复室面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="recoveryArea" field="recoveryArea" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">接待室面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="receptionArea" field="receptionArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">训练厅面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="trainArea" field="trainArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">理疗室面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="treatmentArea" field="treatmentArea" style="width: 95%" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" width="14%">办公面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="workArea" field="workArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">休闲区面积（m2）</td>
				<td class="FieldInput" width="19%"><label name="leisureArea" field="leisureArea" style="width: 95%" /> </td>
			
				<td  class="FieldLabel" width="14%">其它（m2）</td>
				<td class="FieldInput" width="19%"><label name="otherArea" field="otherArea" style="width: 95%" /> </td>
			</tr>
		</table>
		</fieldset>
		</form>
   </next:Html>
   </next:Panel>