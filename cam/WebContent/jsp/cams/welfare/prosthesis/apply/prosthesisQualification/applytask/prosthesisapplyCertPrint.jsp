 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<script type="text/javascript" src="../../../../certmanager/certComm.js"></script>
<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	function init(){
 		var ds = L5.DatasetMgr.lookup("ds");
 		ds.setParameter("TASK_CODE@=", taskCode);
 		ds.load(true);
 		//**************初始化默认值**************
 		var serialNum=ds.getAt(0).get("serialNum");
 		document.getElementById('serialNum').innerHTML=serialNum.substring(0, 7)+'<br>'+serialNum.substring(7, serialNum.length);
 		var approveDate=document.getElementById('approveDate').innerHTML;
 		//如果第一次打印初始化（通过从数据获取是否有值进行判断）
 		if(ds.getAt(0).get("startDate")==""){
			document.getElementById('startDate').value=approveDate;
			setEndDate(approveDate);
 		}
 		if(ds.getAt(0).get("signOrgan")==""){
			document.getElementById('signOrgan').value="山东省民政厅";
 		}
 		if(ds.getAt(0).get("signDate")==""){
			document.getElementById('signDate').value=approveDate;
 		}
 		if(ds.getAt(0).get("issuerPeople")==""){
			document.getElementById('issuerPeople').value='<%=GetBspInfo.getBspInfo().getUserName()%>';
 		}
 	}
 	//打印受理通知
 	function printAccept(){
 		forRePrint("fit");
 	}
 	function save(){
 		var ds = L5.DatasetMgr.lookup("ds");
 		var welfCertRecord=ds.getCurrent();
 		welfCertRecord.set("startDate",document.getElementById('startDate').value);
 		welfCertRecord.set("endDate",document.getElementById('endDate').value);
 		welfCertRecord.set("signOrgan",document.getElementById('signOrgan').value);
 		welfCertRecord.set("signDate",document.getElementById('signDate').value);
		var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealCertCommand");
		command.setParameter("record", welfCertRecord);
		command.execute("update");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
 	}
 	function getTimes(item) {
 		LoushangDate(item);
 	}
 	//获得当前日期 
 	function getCurDate(){
 		var date=new Date();
 		var year=""+date.getFullYear();
 		var month=date.getMonth()+1;
 		if(month<10){month="0"+month;}
 		var day = date.getDate();
 		if(day<10){day = "0"+day;}
 		return year+"-"+month+"-"+day;
 	}
 	// 根据开始日期与任期回写结束日期
	function setEndDate(obj){
		var date=new   Date(obj.substring(0, 4),   obj.substring(5, 7)-1,   obj.substring(8, 10));
		date.setYear(date.getYear()+3);
		date.setDate(date.getDate()-1);
		document.getElementById('endDate').value=date;
	}
</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealCertQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealCert"></model:record>
	</model:dataset>
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="printAccept();"/>
	<input field="" type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
</div>
<div align="center">
	<form method="post"  onsubmit="return false" id='form0' dataset='ds'>
<TABLE height=677 cellSpacing=0 cellPadding=0 width=800 align=center  
	style="border:0px">
	<TBODY>
		<TR>
			<TD width=800 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=500>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=800 align=center >
				<TBODY>
					<TR>
						<TD class=title1 vAlign=top align=middle height=150>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' >
							<TBODY>
								<TR>
									<TD height=50></TD>
								</TR>
							</TBODY>
						</TABLE>
						<DIV align=center></DIV>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' id='optiontable1' >
							<TBODY>
								<TR>
									<TD  align=middle style="font-size: 25px" colspan="4"><STRONG>企业资格认定证书信息</STRONG></TD>
								</TR>
								<TR>
									<TD height=50 colspan="4" align=right>
										<div align="center" style="width:300">鲁假肢证字第<label style="width:100" id='serialNum'></label>号</div>
									</TD>
								</TR>
								<TR>
									<TD height=40 width="100"  align=left style="font-size: 20px;">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称:</TD>
									<TD align=left  style="font-size: 20px"><label  style="width:100" field='companyName' id='companyName'/></TD>
									<TD align=left width="100"  style="font-size: 20px">法人代表:</TD>
									<TD align=left style="font-size: 20px"><label style="width:100" field='legalPeople' id='legalPeople'/></TD>
								</TR>
								<TR>
									<TD height=40 align=left style="font-size: 20px">单位性质:</TD>
									<TD align=left style="font-size: 20px"><label style="width:100" field='organType' id='organType' dataset="ecoDataSet"/></TD>
									<TD align=left style="font-size: 20px">经营范围:</TD>
									<TD align=left style="font-size: 20px"><label style="width:100" field='businessScope' id='businessScope'/></TD>
								</TR>
								<TR>
									<TD height=40 align=left style="font-size: 20px">场地面积:</TD>
									<TD align=left style="font-size: 20px" colspan="3"><label  style="width:100" field='siteArea' id='siteArea'/></TD>
								</TR>
								<TR>
									<TD height=40 align=left style="font-size: 20px">单位地址:</TD>
									<TD align=left style="font-size: 20px"><label  style="width:100" field='companyAddress' id='companyAddress'/></TD>
									<TD align=left style="font-size: 20px">批准日期:</TD>
									<TD align=left style="font-size: 20px"><label  style="width:100" field='approveDate' id='approveDate'/></TD>
								</TR>
								<TR>
									<TD height=40 colspan="4" style="font-size: 20px">有效期限:<input type="text" format="Y-m-d" style="width: 100px;" id="startDate" maxlength="10" readonly="readonly" field='startDate' onblur="setEndDate(this.value)" onclick="getTimes(this)"/> 至
									<input type="text" format="Y-m-d" style="width: 100px;" id="endDate" maxlength="10" readonly="readonly" field='endDate' onclick="getTimes(this)"/> </TD>
								</TR>
								<TR>
									<TD align=right style="font-size: 15px" colspan="4">
										<div align="right" style="width:200">发证机关:<input type="text"  style="width:100" field='signOrgan' id='signOrgan'/></input></div>
									</TD>
								</TR>
								<TR>
									<TD align=right style="font-size: 15px" colspan="4">
										<div align="right" style="width:200">
											发证日期:<input type="text" format="Y-m-d" style="width: 100px;" id="signDate" maxlength="10" readonly="readonly" field='signDate' onclick="getTimes(this)"/> 
										</div>
									</TD>
								</TR>
								<TR>
									<TD align=right style="font-size: 15px" colspan="4">
										<div align="right" style="width:200">发证人:<input type="text"  style="width:100" field='issuerPeople' id='issuerPeople'/></input></div>
									</TD>
								</TR>
								<TR>
									<TD align=right style="font-size: 15px" colspan="4">
										<div align="right" style="width:200">
											领证人:<input type="text"  id="licensePeople"  style="width:100" field='licensePeople' /> 
										</div>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
</form>
</div>

</body>
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
						<option value='0' >正本</option>
						<option value='1' >副本</option>
					</select></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</html>