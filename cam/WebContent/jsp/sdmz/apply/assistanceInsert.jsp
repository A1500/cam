<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>



<%@page import="org.loushang.bsp.share.organization.bean.OrganView"%>

<%
	//String organArea = BspUtil.getCorpOrgan().getCorpOrganId();
	String organArea1 = BspUtil.getCorpOrgan().getOrganCode();
	String organArea=null;
	int sign=0;
	String organName=null;
	String organValue=null;
	String parentOrganValue=null;
	String parentOrganName=null;
	if(organArea1.substring(4,12).equals("00000000"))
	{
		organArea=organArea1.substring(0,4);
		sign=1;
		
		
	}else if(organArea1.substring(6,12).equals("000000"))
	{
		sign=2;
		 organName=BspUtil.getCorpOrgan().getOrganName();
		 organValue=BspUtil.getCorpOrgan().getOrganCode();
		 organArea=organArea1.substring(0,4);
	}
	else if(organArea1.substring(9,12).equals("000"))
	{
		sign=3;
		 organArea=organArea1.substring(0,4);
		OrganView organView=BspUtil.getParentOrgan();
		organValue=BspUtil.getCorpOrgan().getOrganCode();
		parentOrganName=organView.getOrganName();
		 parentOrganValue=organView.getOrganCode();
	}else if(!organArea1.substring(9,12).equals("000"))
	{
		sign=4;
		 organArea=organArea1.substring(0,4);
		 String organArea2=organArea1.substring(0,6);
		organValue=organArea2+"000000";
	}
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
	var sign = "<%=sign%>";
	var organName="<%=organName%>";
	var organValue = "<%=organValue%>";
	var parentOrganName="<%=parentOrganName%>";
	var parentOrganValue = "<%=parentOrganValue%>";
</script>
<html>
	<head>
		<title></title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="assistanceInsert.js"></script>
		<script type="text/javascript" src="../jtxx/IDCard.js"></script>
		<script type="text/javascript" src="../jtxx/jtxxComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset  id="applyDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyCmd"  method="initInsertJsp" >
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	</model:dataset>
	<model:dataset id="jtxxDataset" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxQueryCommand" global="true" autoLoad="true" method="queryJtxx">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="cityDateSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="areaDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="streetDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
		    <model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sftyDataset" enumName="AGREE_STATE.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="applyWayDataset" enumName="APPLY_WAY.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="xbdmDataset" enumName="APPLY_SEX.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="800">
		<next:Panel title="救助服务办理单">
			<next:Html>
			<form id="applyForm" method="post" dataset="applyDataset" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
				<td colspan="4" align="center"><font size="20" >救助业务受理</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请人:</label></td>
					<td class="FieldInput"><input type="text" id="applyPeople" name="applyPeople" field="applyPeople" onchange="checkCN('applyPeople','applyIdcard','申请人');"/><font color="red">*</font></td>
					<td class="FieldLabel"><label>身份证号:</label></td>
					<td class="FieldInput"><input type="text" id="applyIdcard" name="applyIdcard" field="applyIdcard" style="width: 140px" maxlength="18" onchange="checkIDCardJzfa('applyIdcard','身份证');"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>家庭人口:</label></td>
					<td class="FieldInput"><input type="text" name="applyPeopleNum" field="applyPeopleNum" maxlength="2" style="width: 30px" onchange="CheckJtrk()"/><font color="red">*</font></td>
					<td class="FieldLabel"><label>家庭成员:</label></td>
					<td class="FieldInput"><input type="text" name="familyMember" field="familyMember" maxlength="50"/></td>
				</tr>
				<tr>					
					<td class="FieldLabel"><label>联系电话:</label></td>
					<td class="FieldInput"><input type="text" id="applyTel" field="applyTel" onchange="checkDhhm()"/><font color="red">*</font></td>
					<td class="FieldLabel"><label>申请方式:</label></td>
					<td class="FieldInput"><select name="applyWay" field="applyWay" ><option dataset="applyWayDataset"></option></select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>性别:</label></td>
					<td colspan="3" class="FieldInput"><input type="radio" name="applySex" field="applySex" dataset="xbdmDataset"/></td>
				</tr>	
				<tr>
					<td class="FieldLabel"><label>家庭住址:</label></td>
					<td colspan="3" class="FieldInput"><input type="text"  name="applyAdd" field="applyAdd" style="width: 500px" maxlength="100"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请日期:</label></td>
					<td class="FieldInput"><input type="text" name="applyDate" field="applyDate"  readonly="readonly"/></td>
					<td class="FieldLabel"><label>受理单位:</label></td>
					<td class="FieldInput"><input type="text" name="currentOrgName" field="currentOrgName"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请事由:<br/>
					<font color="red" size="1">*不得超过250字</font></label></td>
					<td colspan="3" class="FieldInput"><textarea  name="applyReasons" field="applyReasons" cols="100" rows="5"  onchange="checkTextarea(250,'applyReasons')"/></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>本单位意见:<br/>
					<font color="red" size="1">*不得超过150字</font></label></td>
					<td colspan="3" class="FieldInput"><textarea name="handleOpinion" field="handleOpinion" cols="100" rows="5"   onchange="checkTextarea(150,'handleOpinion')" /></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>受理结果:</label></td>
					<td colspan="3" class="FieldInput">
					<input type="radio" id="handleResult"  name="handleResult" field="handleResult" value="4" onclick="disable4()"/>等待审核 <br>
					<input type="radio" id="handleResult"  name="handleResult" field="handleResult" value="0" onclick="disable1()"/>办理完结 <select  name="agreeState" field="agreeState" disabled="disabled"><option  dataset="sftyDataset"></option></select><br>
				    <input type="radio" id="handleResult" name="handleResult" field="handleResult" value="1" onclick="disable2()" />转办单位
				     <select  name="city" id="city" ><option  dataset="cityDateSet"></option>
				     </select>
				     <select  name="area"   onclick="getStreet()" disabled="disabled" ><option  dataset="areaDataset"></option>
				     </select>
				     区
				     <select  name="street" field="street" disabled="disabled"><option  dataset="streetDataset" ></option></select>
				     街道
				     <font color="red" size="1">*如果街道未选择则提交至民政审批单位。</font>
				     <br>
				     <input type="radio" id="handleResult" name="handleResult"/>其他 &nbsp &nbsp &nbsp
				      <select  name="other"   ><option  ></option> 
				     </select>
				    </td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>受理人姓名:</label></td>
					<td colspan="3" class="FieldInput"><input type="text" name="acceptPeople" field="acceptPeople"  readonly="readonly"/></td>
				</tr>
				</table>
			</form>	
	   </next:Html>
	</next:Panel>
		<next:Panel border="false" width="500">
		<next:Buttons>
		   		<next:ToolButton  text="确定" handler="Evt_butsave_onclick" ></next:ToolButton>
		   		<next:ToolButton  text="返回" handler="Evt_butreturn_onclick"></next:ToolButton>
		   		<next:ToolButton  text="查询家庭信息" handler="forItemHelp"></next:ToolButton>
		    </next:Buttons>
		</next:Panel>
	</next:Panel>
	
<next:GridHelpWindow id="jtxx_help" dataset="jtxxDataset" > 
  <next:GridHelpColumns>
  	 
     <next:GridHelpColumn header="户主姓名" sortable="true" field="familyName"/>
     <next:GridHelpColumn header="身份证号" sortable="true" field="familyCardNo"/>
  </next:GridHelpColumns>
     <next:TextHelpField>
         <next:QueryHelpField header="户主姓名" field="family_Name"></next:QueryHelpField>
         <next:QueryHelpField header="身份证号" field="family_Card_No"></next:QueryHelpField>
    </next:TextHelpField></next:GridHelpWindow>
</body>
</html>