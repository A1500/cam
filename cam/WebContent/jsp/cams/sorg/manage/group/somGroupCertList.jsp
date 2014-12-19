<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<!-- 社会团体证书主功能表 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupCertList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somCertComm.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
<%
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
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somGroupCertDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" pageSize="10" autoLoad="false">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="sorg_Type" value='S'></model:param>
			<model:param name="MORG_AREA" value='<%=BspUtil.getOrganCode()%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="Certdataset" global="true"
		cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="sorg_Type" value='S'></model:param>
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
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<form class="L5form">
		<fieldset><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel"><label>社团名称：</label></td>
				<td class="FieldInput"><input type="text" id="sorgName" /></td>
				<td class="FieldLabel"><label>发证机关：</label></td>
				<td class="FieldInput"><input type="text" id="signOrgan" /></td>
				<td class="FieldButton">
				<button onclick="query()">查询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>登记证号：</label></td>
				<td class="FieldInput"><input type="text" id="sorgCode" /></td>
				<td class="FieldLabel"><label>证件状态：</label></td>
				<td class="FieldInput"><select id="certStatus">
					<option dataset="certStatus"></option>
				</select></td>
				<td class="FieldButton">
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="hlistPanel" dataset="somGroupCertDataset" enableHdMenu="true" height="99.9%"  width="100%">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="社会团体证书信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="证书换发" iconCls="add" handler="changeCert"></next:ToolBarItem>
		<next:ToolBarItem text="补录证书信息" iconCls="add" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem text="修改证书信息" iconCls="edit" handler="updateCert"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="社会团体名称" field="sorgName" sortable="true"editable="false" renderer="jtxxDetailHref" width="25%"><next:TextField/></next:Column>
		<next:Column header="登记证号" field="sorgCode" sortable="true"editable="false" width="12%"><next:TextField/></next:Column>
		<next:Column header="登记日期" field="regDate" sortable="true"editable="false" width="10%"><next:TextField/></next:Column>
		<%-- <next:Column header="证书类别" field="certType" sortable="true"dataset="certType" editable="false" width="8%"><next:TextField /></next:Column>
		--%>
		<next:Column header="证书状态" field="certStatus" sortable="true"dataset="certStatus" editable="false" width="8%"><next:TextField /></next:Column>
		<next:Column header="证书有效期起" field="signBeginDate" sortable="true"editable="false" width="12%"><next:TextField /></next:Column>
		<next:Column header="证书有效期止" field="signEndDate" sortable="true"editable="false" width="12%"><next:TextField /></next:Column>
		<next:Column header="领证日期" field="fetchDate" sortable="true"editable="false" width="10%"><next:TextField /></next:Column>
		<next:Column header="发证机关" field="signOrgan" sortable="true"editable="false" width="15%"><next:TextField /></next:Column>
		<next:Column header="登记管理机关名称"field="morgName" sortable="true"editable="false" width="13.7%"><next:TextField /></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somGroupCertDataset" />
	</next:BottomBar>
</next:EditGridPanel>

<%-- 证书详细信息 --%>
<next:Window id="Cert" closeAction="hide" title="证书详细信息" width="700"
	height="400"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="社会团体证书明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="重新打印证书" iconCls="add" handler="rePrint"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closewin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="Certdataset">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
				<td class="FieldInput" style="width: 5%;"><label field="sorgCode" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
				<td class="FieldInput" style="width: 5%;"><label field="organCode" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 5%;"></td>
				<td class="FieldInput" style="width: 10%;"></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>社团名称：</label></td>
				<td class="FieldInput" colspan="5"><label field="sorgName" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务范围：</label></td>
				<td class="FieldInput" colspan="5"><label style="height: 50px;" field="business" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>住所：</label></td>
				<td class="FieldInput" colspan="5"><label field="residence" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>法定代表人：</label></td>
				<td class="FieldInput"><label field="legalPeople" readonly="readonly"/></td>
				<td class="FieldLabel"><label>活动地域：</label></td>
				<td class="FieldInput"><label field="actArea" readonly="readonly"/></td>
				<td class="FieldLabel"><label>注册资金(万元)：</label></td>
				<td class="FieldInput"><label field="regMon" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务主管单位：</label></td>
				<td class="FieldInput" colspan="3"><label  id="borgName"  field="borgName" dataset="businessOrganSelect"/></td>
				<td class="FieldLabel"><label>登记日期：</label></td>
				<td class="FieldInput"><label  id="regDate"  field="regDate" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="signBeginDate" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="signEndDate" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="signPeriod" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因：</label></td>
				<td class="FieldInput"><label field="issueReason"  dataset="issueReason"/></td>
				<td class="FieldLabel"><label>发证机关：</label></td>
				<td class="FieldInput"><label field="signOrgan" readonly="readonly"/></td>
				<td class="FieldLabel"><label>发证日期：</label></td>
				<td class="FieldInput"><label field="signDate" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因描述：</label></td>
				<td class="FieldInput" colspan="5"><label style="height: 50px;" field="issueReasonDesc" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>制证人：</label></td>
				<td class="FieldInput"><label field="printPeople" readonly="readonly"/></td>
				<td class="FieldLabel"><label>制证时间：</label></td>
				<td class="FieldInput"><label field="printTime" readonly="readonly"/></td>
				<td class="FieldLabel"><label></label></td>
				<td class="FieldInput"></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>领证人：</label></td>
				<td class="FieldInput"><label field="fetchPeople" readonly="readonly"/></td>
				<td class="FieldLabel"><label>领证日期：</label></td>
				<td class="FieldInput"><label field="fetchDate" readonly="readonly"/></td>
				<td class="FieldLabel"><label>发证人</label></td>
				<td class="FieldInput"><label field="issuePeople" readonly="readonly"/></td>
			</tr>
			<tr id="receive" style="display: none;">
				<td class="FieldLabel"><label>收缴标志：</label></td>
				<td class="FieldInput"><label field="ifReceive" readonly="readonly" dataset="ifReceive"/></td>
				<td class="FieldLabel"><label>收缴人：</label></td>
				<td class="FieldInput"><label field="receivePeople" readonly="readonly"/></td>
				<td class="FieldLabel"><label>收缴日期：</label></td>
				<td class="FieldInput"><label field="receiveDate" readonly="readonly"/></td>
			</tr>
			<tr style="display: none;">
				<td class="FieldLabel"><label>证件状态：</label></td>
				<td class="FieldInput"><input type="text" id="wincertStatus"
					field="certStatus" readonly="readonly" /></td>
			</tr>
		</table>
		<div id="id" style="display: none;" field="id"></div>
		</form>
	</next:Html>
</next:Window>


<%-- 发证页面 --%>
<next:Window id="certF" closeAction="hide" title="证书详细信息" width="700"
	height="400" autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="社会团体证书明细"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确认发证" iconCls="add" handler="signcert" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closecertF"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="Certdataset">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>登记证号：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="sorgCode" id="sorgCode" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 10%;"><label>组织机构代码：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="organCode" id="organCode" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 10%;"><label>证件类型：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="certType" id="certType" readonly="readonly" dataset="certType"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>社团名称：</label></td>
				<td class="FieldInput" colspan="5"><label field="sorgName" id="sorgName" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务范围：</label></td>
				<td class="FieldInput" colspan="5" rowspan="2"><label style="height: 50px;" field="business" id="business" readonly="readonly"/></td>
			</tr>
			<tr></tr>

			<tr>
				<td class="FieldLabel"><label>住所：</label></td>
				<td class="FieldInput" colspan="5"><label field="residence" id="residence" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>法定代表人：</label></td>
				<td class="FieldInput"><label field="legalPeople" id="legalPeople" readonly="readonly"/></td>
				<td class="FieldLabel"><label>活动地域：</label></td>
				<td class="FieldInput"><label field="actArea" id="actArea" readonly="readonly"/></td>
				<td class="FieldLabel"><label>注册资金(万元)：</label></td>
				<td class="FieldInput"><label field="regMon" id="regMon" readonly="readonly"/>万元</td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>业务主管单位：</label></td>
				<td class="FieldInput" colspan="3"><label  id="borgName"  field="borgName" dataset="businessOrganSelect"/></td>
				<td class="FieldLabel"><label>登记日期：</label></td>
				<td class="FieldInput"><label  id="regDate"  field="regDate" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="signBeginDate" id="signBeginDate" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="signEndDate" id="signEndDate" readonly="readonly"/></td>
				<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
				<td class="FieldInput" style="width: 10%;"><label field="signPeriod" id="signPeriod" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因：</label></td>
				<td class="FieldInput"><label field="issueReason" id="issueReason" readonly="readonly" dataset="issueReason"/></td>
				<td class="FieldLabel"><label>发证机关：</label></td>
				<td class="FieldInput"><label field="signOrgan" readonly="readonly"/></td>
				<td class="FieldLabel"><label>发证日期：</label></td>
				<td class="FieldInput"><label field="signDate" id="signDate" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>发证原因描述：</label></td>
				<td class="FieldInput" colspan="5"><label style="height: 50px;" field="issueReasonDesc" id="issueReasonDesc" readonly="readonly"/></td>
			</tr>
			<tr></tr>
			<tr>
				<td class="FieldLabel"><label>制证人：</label></td>
				<td class="FieldInput"><label field="printPeople" id="printPeople" readonly="readonly"/></td>
				<td class="FieldLabel"><label>制证时间：</label></td>
				<td class="FieldInput"><label field="printTime" id="printTime" readonly="readonly"/></td>
				<td class="FieldLabel"><label></label></td>
				<td class="FieldInput"></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>领证人：</label></td>
				<td class="FieldInput"><input type="text" field="fetchPeople" /><font color="red">*</font></td>
				<td class="FieldLabel"><label>领证日期：</label></td>
				<td class="FieldInput"><input type="text" id="fetchDatewin" onclick="WdatePicker();"  value="" format="Y-m-d" /><font color="red">*</font></td>
				<td class="FieldLabel"><label>发证人</label></td>
				<td class="FieldInput"><label  id="issuePeople" value=""/></td>
			</tr>
			<tr style="display:none;">
				<td class="FieldLabel"><label>证件状态：</label></td>
				<td class="FieldInput"><input type="text" id="wincertStatus"
					field="certStatus" readonly="readonly" /></td>
			</tr>
		</table>
		<div id="id" style="display: none;" field="id"></div>
		</form>
	</next:Html>
</next:Window>
<next:Window id="printDemo" closeAction="hide" title="选择证书类别" width="250" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="进入设置" iconCls="detail" handler="inPrintDemo" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeP"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table>
				<tr>
					<td class="FieldLabel"><label>选择证书类别：</label></td>
					<td class="FieldInput"><select id="printCertType" ><option value="">请选择......</option><option value="0">主体正本</option><option value="1">主体副本</option><option value="2">分支正本</option><option value="3">分支副本</option></select></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="certTypeWin" closeAction="hide" title="选择证书类别" width="300"  modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="save" handler="confirmReCertTypeWin"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeReCertTypeWin"></next:ToolBarItem>
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