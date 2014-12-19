<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>

<html>
	<head>
		<title>义务兵家庭优待金发放添加</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="compulsoryGrantAdd.js"></script>
		<script type="text/javascript" src="../../../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="CompulsoryGrantDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsQueryCommand" global="true" method="queryCompulGrantAdd">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCompulsory">
			<model:field name="domicileName" type="string"/>
			<model:field name="peopleId" type="string"/>
			<model:field name="belongYear" type="string"/>
			<model:field name="grantDate" type="string"/>
			<model:field name="grantMon" type="string"/>
			<model:field name="inTibetAdditional" type="string"/>
			<model:field name="meritAdditional" type="string"/>
			<model:field name="otherAdditional" type="string"/>
			<model:field name="total" type="string"/>
			<model:field name="receiveName" type="string"/>
			<model:field name="receiveContact" type="string"/>
			<model:field name="grantNumber" type="string"/>
			<model:field name="note" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO" 
	global="true" autoLoad="true">
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 开户银行 -->
	<model:dataset id="bank" enumName="BANK.CODE" global="true" autoLoad="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="disable"  text="关闭" handler="fun_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="CompulsoryGrantDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		    <tr>
		    	<td class="FieldLabel" nowrap>身份证号：</td>
				<td class="FieldInput"><input type="text" name="idCard" maxlength="18" title="身份证号" field="idCard" style="width: 135" onchange="queryByIdCardOrPeopleId()"/>
										<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getPeopleIdByIdCard()"/>
				<font color="red">*</font></td>
		    	<td class="FieldLabel" nowrap style="width:16%">姓名：</td>
				<td class="FieldInput" style="width:16%"><label field="name"/></td>
				<td class="FieldLabel" nowrap style="width:16%">性别：</td>
				<td class="FieldInput" style="width:16%"><label field="sex" dataset="SexDataset"/></td>
		    </tr>
			<tr>
				<td class="FieldLabel" nowrap>出生日期：</td>
				<td class="FieldInput" ><label field="birthday"/></td>
				<td class="FieldLabel" nowrap>民族：</td>
				<td class="FieldInput" ><label field="nation" dataset="NationDataset" /> </td>
				<td class="FieldLabel" nowrap>优待安置证编号：</td>
				<td class="FieldInput" ><label field="specialSettingNo"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label name="conscriptDate" field="conscriptDate"/></td>
				<td class="FieldLabel" nowrap>进藏 进疆：</td>
				<td class="FieldInput"><label field="composedPortrait" dataset="composedPort"/></td>
				<td class="FieldLabel">户籍类别：</td>
				<td class="FieldInput"><label name="domicileType" field="domicileType" id="domicileType" dataset="DomicileDataset"/></td>
			</tr>
	   		<tr>		
				<td class="FieldLabel" nowrap>联系方式：</td>
				<td class="FieldInput" ><label field="telContact"/></td>
				<td class="FieldLabel" nowrap>邮编：</td>
				<td class="FieldInput" colspan="3"><label field="postcode"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>家庭所属行政区划：</td>
				<td class="FieldInput" ><label field="domicileName"/></td>
				<td class="FieldLabel" nowrap>住址：</td>
				<td class="FieldInput" colspan="3"><label field="address"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>父亲姓名：</td>
				<td class="FieldInput" ><label field="fatherName"/></td>
				<td class="FieldLabel" nowrap>父亲单位：</td>
				<td class="FieldInput" ><label field="fatherUnit"/></td>
				<td class="FieldLabel" nowrap>父亲联系方式：</td>
				<td class="FieldInput" ><label field="fatherContact"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>母亲姓名：</td>
				<td class="FieldInput" ><label field="motherName"/></td>
				<td class="FieldLabel" nowrap>母亲单位：</td>
				<td class="FieldInput" ><label field="motherUnit"/></td>
				<td class="FieldLabel" nowrap>母亲联系方式：</td>
				<td class="FieldInput"  ><label field="motherContact"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap >开户银行：</td>
				<td class="FieldInput" ><label field="bank" dataset="bank" /> </td>
				<td class="FieldLabel" nowrap >开户账号：</td>
				<td class="FieldInput"  colspan="3"><label field="accountCode" /> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >发放所属年度</td>
				<td class="FieldInput"><input type="text" name="belongYear" field="belongYear" maxlength="4" onchange="queryOtherInfor()"/><font color="red">*</font></td>
				<td class="FieldLabel" >优待金发放时间</td>
				<td class="FieldInput"><input type="text" name="grantDate" field="grantDate" style="width: 100px;" maxlength="10"  format="Y-m-d" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" >优待金额</td>
				<td class="FieldInput"><input type="text" name="grantMon" field="grantMon" disabled="disabled"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >进藏进疆增发</td>
				<td class="FieldInput"><input type="text" name="inTibetAdditional" field="inTibetAdditional" disabled="disabled"/> </td>
				<td class="FieldLabel" >立功增发</td>
				<td class="FieldInput"><input type="text" name="meritAdditional" field="meritAdditional" onchange="changeTotal()"/> </td>
				<td class="FieldLabel" >其他增发</td>
				<td class="FieldInput"><input type="text" name="otherAdditional" field="otherAdditional" onchange="changeTotal()"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >合计</td>
				<td class="FieldInput"><input type="text" name="total" field="total" disabled="disabled"/> </td>
				<td class="FieldLabel" >领取人姓名</td>
				<td class="FieldInput"><input type="text" name="receiveName" field="receiveName"/><font color="red">*</font></td>
				<td class="FieldLabel" >领取人联系方式</td>
				<td class="FieldInput"><input type="text" name="receiveContact" field="receiveContact"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" >已发放次数</td>
				<td class="FieldInput" colspan="5"><input type="text" name="grantNumber" field="grantNumber" disabled="disabled"/> </td>
			</tr>
	   		<tr>	
				<td class="FieldLabel" >备注</td>
				<td class="FieldInput" colspan="5"><input type="text" name="note" field="note" style="width:90%"/></td>
				<input type="hidden" name="peopleId" field="peopleId"/>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
