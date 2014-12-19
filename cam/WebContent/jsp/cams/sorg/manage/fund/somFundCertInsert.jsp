<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<!-- 基金会证书录入功能表 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundCertInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somCertComm.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
<%			String taskCode=SomIdHelp.getFundTaskCode();
		    StringBuffer localStringBuffer = new StringBuffer();
		    localStringBuffer.append(request.getScheme());
		    localStringBuffer.append("://");
		    localStringBuffer.append(request.getServerName());
		    localStringBuffer.append(":");
		    localStringBuffer.append(request.getServerPort());
		    localStringBuffer.append(request.getContextPath());
		    String url= localStringBuffer.toString();
	%>
	var pathUrl = '<%= url%>';
	var taskCode='<%=taskCode%>';//业务编号
</script>

</head>
<body>
<model:datasets>
	<model:dataset id="somFundCertDataset"
		cmd="com.inspur.cams.sorg.manage.cmd.SomCertQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert">
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="signBeginDate" type="string" rule="require" />
			<model:field name="signEndDate" type="string" rule="require" />
			<model:field name="issueReason" type="string" rule="require" />
			<model:field name="signDate" type="string" rule="require" />
			<model:field name="printTime" type="string" rule="require" />
			<model:field name="certStatus" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
		<model:params>
			<model:param name="sorg_type" value='J'></model:param>
			<model:param name="sorg_status" value='22'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="checkCertDataset"
		cmd="com.inspur.cams.sorg.manage.cmd.SomCertQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="sorg_type" value='J'></model:param>
			<model:param name="cert_status" value='1'></model:param>
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

<next:Panel title="基金会证书录入功能页面" width="100%">
	<next:Html>
		<form method="post" onsubmit="return false"
			dataset="somFundCertDataset" class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>登记证号：</label></td>
				<td class="FieldInput" style="width: 10%;"><input type="text"
					name="登记证号" field="sorgCode" onblur="loadCertSorg('insert');"
					id="sorgCode" onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()"/><font color="red">*</font></td>
				<td class="FieldLabel" style="width: 10%;"><label>组织机构代码：</label></td>
				<td class="FieldInput" style="width: 10%;"><label
					id="organCode" field="organCode" readonly="readonly" value="" /></td>
				<td class="FieldLabel" style="width: 10%;"></td>
				<td class="FieldInput" style="width: 10%;"><select style="display: none" name="证件类型"
					id="certType" field="certType">
					<option dataset="certType"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>基金会名称：</label></td>
				<td class="FieldInput" colspan="5"><label id="sorgName"
					field="sorgName" readonly="readonly" value="" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务范围：</label></td>
				<td class="FieldInput" colspan="5">
				<textarea rows="5"  id="businessForPrint" cols="150" style="height: 50px; overflow-y: visible"></textarea></td>
			</tr>
			<tr></tr>

			<tr>
				<td class="FieldLabel"><label>住所：</label></td>
				<td class="FieldInput" colspan="5"><label id="residence"
					field="residence" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>法定代表人：</label></td>
				<td class="FieldInput"><label id="legalPeople"
					field="legalPeople" readonly="readonly" /></td>
				<td class="FieldLabel"><label>活动地域：</label></td>
				<td class="FieldInput"><input type="text" id="actArea" field="actArea" style="width:95%"/></td>
				<td class="FieldLabel"><label>注册资金(万元)：</label></td>
				<td class="FieldInput"><label id="regMon" field="regMon"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务主管单位：</label></td>
				<td class="FieldInput" colspan="3"><select
					id="borgName" field="borgName" disabled="disabled" style="width:40%">
					<option dataset="businessOrganSelect"></option>
				</select></td>
				<td class="FieldLabel"><label>登记日期：</label></td>
				<td class="FieldInput"><label  id="regDate"  field="regDate" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
				<td class="FieldInput" style="width: 10%;"><input name="有效期起"
					id="signBeginDate" type="text" format="Y-m-d"
					field="signBeginDate" onclick="WdatePicker();" value=""></input><font
					color="red">*</font></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
				<td class="FieldInput" style="width: 10%;"><input name="有效期止"
					type="text" format="Y-m-d" id="signEndDate"
					field="signEndDate" onclick="WdatePicker();" /><font
					color="red">*</font></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
				<td class="FieldInput" style="width: 10%;"><label
					id="signPeriod" field="signPeriod" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因：</label></td>
				<td class="FieldInput"><select name="发证原因" id="issueReason"
					field="issueReason">
					<option dataset="issueReason"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel"><label>发证机关：</label></td>
				<td class="FieldInput"><label field="signOrgan" id="signOrgan" /></td>
				<td class="FieldLabel"><label>发证日期：</label></td>
				<td class="FieldInput"><input type="text" format="Y-m-d" id="signDate" field="signDate" onclick="WdatePicker();" /></td>
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
				<td class="FieldInput"><select field="certStatus" name="证件状态"
					id="certStatus" onchange="forChangeStatus();">
					<option dataset="certStatus"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel"><label>制证人：</label></td>
				<td class="FieldInput"><label field="printPeople"
					id="printPeople" /><font color="red">*</font></td>
				<td class="FieldLabel"><label>制证时间：</label></td>
				<td class="FieldInput"><input id="printTime" type="text"
					format="Y-m-d" field="printTime"
					onclick="WdatePicker();" name="制证时间" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>领证人：</label></td>
				<td class="FieldInput"><input type="text" field="fetchPeople" /></td>
				<td class="FieldLabel"><label>领证日期：</label></td>
				<td class="FieldInput"><input type="text" field="fetchDate"
					format="Y-m-d" onclick="WdatePicker();" /></td>
				<td class="FieldLabel"><label>发证人</label></td>
				<td class="FieldInput"><label field="issuePeople"
					id="issuePeople" /></td>
			</tr>
			<tr id="receiveTr" style="display: none;">
				<td class="FieldLabel"><label>收缴标志：</label></td>
				<td class="FieldInput"><select field="ifReceive" id="ifReceive">
					<option dataset="ifReceive"></option>
				</select></td>
				<td class="FieldLabel"><label>收缴人：</label></td>
				<td class="FieldInput"><input type="text" field="receivePeople" /></td>
				<td class="FieldLabel"><label>收缴日期：</label></td>
				<td class="FieldInput"><input type="text" field="receiveDate"
					format="Y-m-d" onclick="WdatePicker();" /></td>
			</tr>
		</table>
		<div id="sorgId" style="display: none;"></div>
		<div id="sorgType" style="display: none;"></div>
		<div id="morgName" style="display: none;"></div>
		<div id="morgArea" style="display: none;"></div>
		<div id="sorgKind" style="display: none;"></div>
		<div id="ifBranch" style="display: none;"></div>
		</form>
	</next:Html>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="forSave"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
</next:Panel>
<next:Window id="certTypeWin" closeAction="hide" title="选择证书类别" width="300"  modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="save" handler="confirmCertTypeWin"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeCertTypeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table>
				<tr>
					<td class="FieldLabel"><label>选择证件类型：</label></td>
					<td class="FieldInput"><select name="证件类型" id="certTypeSelect" >
						<option dataset="certType"></option>
					</select></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>