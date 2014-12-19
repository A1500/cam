<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
<% String showWin=request.getParameter("showWin"); %>
var sorgId='<%=request.getParameter("sorgId")%>';
var showWin='<%=request.getParameter("showWin")%>';
function init(){
	var somOrganDataset = L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("SORG_ID",sorgId);
	somOrganDataset.load();	
	somOrganDataset.on("load",function(ds){
		if(ds.getCount()<1){
			ds.newRecord();
		}else{
			var rec=ds.getAt(0);
			var borgName = rec.get('borgName');
			var nowBorgName = getBorgName(borgName);
			rec.set('nowBorgName', nowBorgName);
		}
	});
	var somCertDataset = L5.DatasetMgr.lookup("somCertDataset");
	somCertDataset.setParameter("SORG_ID",sorgId);
	somCertDataset.load();	
	somCertDataset.on("load",function(ds){
		if(ds.getCount()>0){
			document.getElementById('signBeginDate').innerHTML=ds.get('signBeginDate');
			document.getElementById('signEndDate').innerHTML=ds.get('signEndDate');
			document.getElementById('signDate').innerHTML=ds.get('signDate');
		}else{
			var somCertDataset2 = L5.DatasetMgr.lookup("somCertDataset2");
			somCertDataset2.setParameter("SORG_ID",sorgId);
			somCertDataset2.load();	
			somCertDataset2.on("load",function(somCertDataset2){
				if(somCertDataset2.getCount()>0){
					document.getElementById('signBeginDate').innerHTML=somCertDataset2.get('signBeginDate');
					document.getElementById('signEndDate').innerHTML=somCertDataset2.get('signEndDate');
					document.getElementById('signDate').innerHTML=somCertDataset2.get('signDate');
				}
			});
		}
	});
}
function back(){
	history.go(-1);
}
function closeWin(){
	window.close();
}
/** *查询信息* **/
function getBorgName(borgCode){
	var publicCmd = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	publicCmd.setParameter("borgCode", borgCode);
	publicCmd.execute("nowBorgName");
	var getReturns = publicCmd.getReturn("borgName");
	if (getReturns == null || getReturns == "" || getReturns == undefined){
		return "";
	}else {
		return getReturns;
	}
}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan" pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="nowBorgName" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somCertDataset" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="cert_Type" value='0'></model:param>
			<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somCertDataset2" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="cert_Type" value='1'></model:param>
			<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%"height='100%'>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<% if("1".equals(showWin)){ %>
		<next:ToolBarItem  iconCls="disable" text="关闭" handler="closeWin" ></next:ToolBarItem>
		<% }else { %>
		<next:ToolBarItem  iconCls="undo" text="返回" handler="back" ></next:ToolBarItem>
		<% } %>
	</next:TopBar>
	<next:Panel width="100%" height="100%" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset="somOrganDataset">
				<table width="100%">
					<tr>
						<td class="FieldLabel"><label>社会组织名称：</label></td>
						<td class="FieldInput" colspan="3"><label field="cnName"  /></td>
						<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
						<td class="FieldInput" style="width: 5%;"><label field="sorgCode"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%"><label>社会组织种类：</label></td>
						<td class="FieldInput" style="width:10%"><label field="sorgType" dataset="sorgTypeSelect"></label></td>
						<td class="FieldLabel"><label>是否为分支：</label></td>
						<td class="FieldInput"><label field="ifBranch" dataset="comm_yesorno"></label></td>
						<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
						<td class="FieldInput" style="width: 5%;"><label field="organCode"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>业务范围：</label></td>
						<td class="FieldInput" colspan="5"><textarea rows="5" field="business" name='"业务范围"' style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>住所：</label></td>
						<td class="FieldInput" colspan="5"><label field="residence"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>法定代表人：</label></td>
						<td class="FieldInput"><label field="legalPeople"  /></td>
						<td class="FieldLabel"><label>活动地域：</label></td>
						<td class="FieldInput"><label field="actArea"  /></td>
						<td class="FieldLabel"><label>注册资金(万元)：</label></td>
						<td class="FieldInput"><label field="regMon"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>业务主管单位：</label></td>
						<td class="FieldInput" colspan="5"><label field="nowBorgName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:17%"><label>登记日期：</label></td>
						<td class="FieldInput" style="width:17%"><label id="regDate" field="regDate"  /></td>
						<td class="FieldLabel" style="width:17%"><label>有效期起：</label></td>
						<td class="FieldInput" style="width:17%"><label id="signBeginDate"  /></td>
						<td class="FieldLabel" style="width:17%"><label>有效期止：</label></td>
						<td class="FieldInput" style="width:17%"><label id="signEndDate"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>发证机关：</label></td>
						<td class="FieldInput" colspan='3'><label field="morgName"  /></td>
						<td class="FieldLabel"><label>发证日期：</label></td>
						<td class="FieldInput"><label id="signDate"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>联系人：</label></td>
						<td class="FieldInput" colspan='3'><label field="sorgPeople"  /></td>
						<td class="FieldLabel"><label>联系电话：</label></td>
						<td class="FieldInput"><label id="sorgPeoplePhone"  /></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>