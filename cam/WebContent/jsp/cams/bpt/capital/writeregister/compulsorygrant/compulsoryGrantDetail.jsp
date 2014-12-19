<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
	var peopleId = '<%=request.getParameter("peopleId")%>';
	var regDetailId = '<%=request.getParameter("regDetailId")%>';
</script>
<html>
	<head>
		<title>义务兵家庭优待金发放查看</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<model:dataset id="CompulsoryGrantDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsQueryCommand" global="true" method="queryCompulGrantUpdate">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCompulsoryDetails">
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="specialSettingNo" type="string"/>
			<model:field name="conscriptDate" type="string"/>
			<model:field name="composedPortrait" type="string"/>
			<model:field name="domicileType" type="string"/>
			<model:field name="telContact" type="string"/>
			<model:field name="postcode" type="string"/>
			<model:field name="domicileName" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="fatherName" type="string"/>
			<model:field name="fatherUnit" type="string"/>
			<model:field name="fatherContact" type="string"/>
			<model:field name="motherName" type="string"/>
			<model:field name="motherUnit" type="string"/>
			<model:field name="motherContact" type="string"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountCode" type="string"/>
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
	<next:Html>
		<form id="editForm" dataset="CompulsoryGrantDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		    <tr>
		    	<td class="FieldLabel" nowrap style="width:16%">姓名：</td>
				<td class="FieldInput" style="width:16%"><label field="name"/></td>
				<td class="FieldLabel" nowrap style="width:16%">性别：</td>
				<td class="FieldInput" style="width:16%"><label field="sex" dataset="SexDataset"/></td>
				<td class="FieldLabel" nowrap>身份证号：</td>
				<td class="FieldInput"><label name="idCard" title="身份证号" field="idCard"/></td>
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
				<td class="FieldInput"><label name="belongYear" field="belongYear"/></td>
				<td class="FieldLabel" >优待金发放时间</td>
				<td class="FieldInput"><label name="grantDate" field="grantDate"/></td>
				<td class="FieldLabel" >优待金额</td>
				<td class="FieldInput"><label name="grantMon" field="grantMon"/></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >进藏进疆增发</td>
				<td class="FieldInput"><label name="inTibetAdditional" field="inTibetAdditional"/> </td>
				<td class="FieldLabel" >立功增发</td>
				<td class="FieldInput"><label name="meritAdditional" field="meritAdditional"/> </td>
				<td class="FieldLabel" >其他增发</td>
				<td class="FieldInput"><label name="otherAdditional" field="otherAdditional"/> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" >合计</td>
				<td class="FieldInput"><label name="total" field="total"/> </td>
				<td class="FieldLabel" >领取人姓名</td>
				<td class="FieldInput"><label name="receiveName" field="receiveName"/></td>
				<td class="FieldLabel" >领取人联系方式</td>
				<td class="FieldInput"><label name="receiveContact" field="receiveContact"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" >已发放次数</td>
				<td class="FieldInput" colspan="5"><label name="grantNumber" field="grantNumber"/> </td>
			</tr>
	   		<tr>	
				<td class="FieldLabel" >备注</td>
				<td class="FieldInput" colspan="5"><label name="note" field="note" style="width:90%"/></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
		<script type="text/javascript">
			function init() {
				var CompulsoryGrantDataSet = L5.DatasetMgr.lookup("CompulsoryGrantDataSet");
				CompulsoryGrantDataSet.setParameter("regDetailId",regDetailId);
				CompulsoryGrantDataSet.setParameter("peopleId",peopleId);
				CompulsoryGrantDataSet.load();
			}
		</script>
</body>
</html>
