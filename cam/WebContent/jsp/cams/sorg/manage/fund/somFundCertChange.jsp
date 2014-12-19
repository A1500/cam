<%@ page language="java" contentType="text/html; charset=utf-8"pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<!-- 修改基金会证书信息表 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundCertChange.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somCertComm.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somFundCertDataset"
		cmd="com.inspur.cams.sorg.manage.cmd.SomCertQueryCmd"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert">
			<model:field name="sorgCode" type="string" rule="require"/>
			<model:field name="certType" type="string" rule="require"/>
			<model:field name="signBeginDate" type="string" rule="require"/>
			<model:field name="signEndDate" type="string" rule="require"/>
			<model:field name="issueReason" type="string" rule="require"/>
			<model:field name="signDate" type="string" rule="require"/>
			<model:field name="printTime" type="string" rule="require"/>
			<model:field name="certStatus" type="string" rule="require"/>
		</model:record>
		<model:params>
				<model:param name="id" value='<%=request.getParameter("id")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书类别枚举 -->
	<model:dataset id="certType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书状态枚举 -->
	<model:dataset id="certStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书收缴标志 -->
	<model:dataset id="ifReceive" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_RECEIVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书发证原因 -->
	<model:dataset id="issueReason" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_ISSUEREASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="修改基金会证书信息页面"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存修改" handler="saveChange"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somFundCertDataset">
			<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>登记证号：</label></td>
				<td class="FieldInput" style="width: 10%;"><label  id="sorgCode"  field="sorgCode" readonly="readonly" value=""/></td>
				<td class="FieldLabel" style="width: 10%;"><label>组织机构代码：</label></td>
				<td class="FieldInput" style="width: 10%;">
				<input type="text" id="organCode" field="organCode" style="width:95%"/></td>
				<td class="FieldLabel" style="width: 10%;"></td>
				<td class="FieldInput" style="width: 10%;"><select style="display: none" field="certType"  readonly="readonly"><option dataset="certType" ></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>基金会名称：</label></td>
				<td class="FieldInput" colspan="5">
				<input type="text" id="sorgName" field="sorgName" style="width:95%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务范围：</label></td>
				<td class="FieldInput" colspan="5">
				<input type="text" id="business" field="business" style="width:95%"/></td>
			</tr>
			<tr></tr>

			<tr>
				<td class="FieldLabel"><label>住所：</label></td>
				<td class="FieldInput" colspan="5">
				<input type="text" id="residence" field="residence" style="width:95%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>法定代表人：</label></td>
				<td class="FieldInput">
				<input type="text" id="legalPeople" field="legalPeople" style="width:95%"/></td>
				<td class="FieldLabel"><label>活动地域：</label></td>
				<td class="FieldInput">
				<input type="text" id="actArea" field="actArea" style="width:95%"/></td>
				<td class="FieldLabel"><label>注册资金(万元)：</label></td>
				<td class="FieldInput">
				<input type="text" id="regMon" field="regMon" style="width:95%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务主管单位：</label></td>
				<td class="FieldInput" colspan="3"><select
					id="borgName" field="borgName" disabled="disabled" style="width:40%">
					<option dataset="businessOrganSelect"></option>
				</select></td>
				<td class="FieldLabel"><label>登记日期：</label></td>
				<td class="FieldInput">
				<input type="text"
					format="Y-m-d" id="regDate" field="regDate"
					onclick="WdatePicker();" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
				<td class="FieldInput" style="width: 10%;"><input
					id="signBeginDate" type="text" format="Y-m-d" field="signBeginDate"
					onclick="WdatePicker();" value=""></input></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
				<td class="FieldInput" style="width: 10%;"><input type="text"
					format="Y-m-d" id="signEndDate" field="signEndDate"
					onclick="WdatePicker();" /></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
				<td class="FieldInput" style="width: 10%;"><label  id="signPeriod"  field="signPeriod" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因：</label></td>
				<td class="FieldInput"><select field="issueReason" name="发证原因" readonly="readonly"><option dataset="issueReason" ></option></select></td>
				<td class="FieldLabel"><label>发证机关：</label></td>
				<td class="FieldInput"><label  id="signOrgan" field="signOrgan" value=""/></td>
				<td class="FieldLabel"><label>发证日期：</label></td>
				<td class="FieldInput">
				<input type="text"
					format="Y-m-d" id="signDate" field="signDate"
					onclick="WdatePicker();" /></td>
			</tr>
			<tr>

				<td class="FieldLabel"><label>发证原因描述：</label></td>
				<td class="FieldInput" colspan="5"><textarea rows="2"
					field="issueReasonDesc" cols="100"   onkeydown="document.getElementById('spanTS').innerHTML='最多可输入100字符！您还可以输入'+(99-this.value.length)+'个字符'; if(this.value.length>=99){if(event.keyCode != 8)event.returnValue=false;}"
					style="height: 50px; overflow-y: visible"></textarea><span id="spanTS" style="color:red;"></span>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>年检记录：</label></td>
				<td class="FieldInput" colspan="5"><textarea rows="2" id="checkResult"
					field="checkResult" cols="100"   onkeydown="document.getElementById('spanTS2').innerHTML='最多可输入100字符！您还可以输入'+(99-this.value.length)+'个字符'; if(this.value.length>=99){if(event.keyCode != 8)event.returnValue=false;}"
					style="height: 50px; overflow-y: visible"></textarea><span id="spanTS2" style="color:red;"></span>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td class="FieldLabel"><label>证件状态：</label></td>
				<td class="FieldInput"><select field="certStatus" name="证件状态"><option dataset="certStatus"></option></select></td>
				<td class="FieldLabel"><label>制证人：</label></td>
				<td class="FieldInput"><input type="text" name="制证人" field="printPeople" /></td>
				<td class="FieldLabel"><label>制证时间：</label></td>
				<td class="FieldInput"><input type="text" name="制证时间" format="Y-m-d"
					field="printTime" onclick="WdatePicker();" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>领证人：</label></td>
				<td class="FieldInput"><input type="text" name="领证人" field="fetchPeople" /></td>
				<td class="FieldLabel"><label>领证日期：</label></td>
				<td class="FieldInput"><input type="text" name="领证日期" field="fetchDate" format="Y-m-d" onclick="WdatePicker();"/></td>
				<td class="FieldLabel"><label>发证人</label></td>
				<td class="FieldInput"><input type="text" field="issuePeople" name="发证人" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>收缴标志:</label></td>
				<td class="FieldInput"><select field="ifReceive" name="收缴标志"><option dataset="ifReceive"></option></select></td>
				<td class="FieldLabel"><label>收缴人:</label></td>
				<td class="FieldInput"><input type="text" field="receivePeople"  name="收缴人"/></td>
				<td class="FieldLabel"><label>收缴日期:</label></td>
				<td class="FieldInput"><input type="text" field="receiveDate" name="收缴日期"  format="Y-m-d" onclick="WdatePicker();"/></td>
			</tr>

		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>