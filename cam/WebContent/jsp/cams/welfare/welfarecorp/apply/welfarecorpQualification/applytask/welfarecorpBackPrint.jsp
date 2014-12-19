 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	String companyName = request.getParameter("companyName");
	String organName = BspUtil.getCorpOrgan().getOrganName();
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="../css/prosthesisapplyPrint.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	var index=0;
 	var tOrganname;
 	function init(){
 		
 	 	
 		var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
		welfFitApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		welfFitApplyDataSet.load();
		welfFitApplyDataSet.on('load',function(ds){
			if(ds.getCount()>0){
				var rejectReason = ds.getAt(0).get("rejectReason");
				//rejectReason格式: 条件1^*条件2^*条件3^*条件4^*条件5#*2013-05-15&*主管部门
				if(rejectReason==""){
					document.getElementById("organName").value='<%=organName %>';
					document.getElementById("time").value=getCurDate();
					document.getElementById("lorganName").innerHTML= '<%=organName %>';
					document.getElementById("ltime").innerHTML= getCurDate();
				}else{
					var reasonOrganname = rejectReason.split("#*");
					tOrganname = reasonOrganname[1].split("&*");
					var resasons = reasonOrganname[0].split("^*");
					for(var i=0;i<resasons.length;i++){
						if(i>2){
							var otr=optiontable1.insertRow((4+index));//插入一个tr 
					 		var ocel1=otr.insertCell(0);//插入一个td   
					 		ocel1.width='668';
					 		ocel1.height=34;
					 		ocel1.align="left"; 
					 		ocel1.style.fontSize="20px";
					 		ocel1.innerHTML='<STRONG>&nbsp;&nbsp;'+(i+1)+'、<input type="text" name="option" style="width:500" id="o'+(i+1)+'"/></input></STRONG>';
					 		var otr=optiontable.insertRow((4+index));//插入一个tr 
					 		var ocel1=otr.insertCell(0);//插入一个td   
					 		ocel1.width='668';
					 		ocel1.height=34;
					 		ocel1.align="left"; 
					 		ocel1.style.fontSize="15px";
					 		ocel1.innerHTML='<STRONG>&nbsp;&nbsp;'+(i+1)+'、<label  id="l'+(i+1)+'"></label></STRONG>';
						}
						document.getElementById("o"+(i+1)).value=resasons[i];
				 		index++; 
					}
					document.getElementById("fm").innerHTML=index;
					document.getElementById("fm1").innerHTML=index;
					document.getElementById("lorganName").innerHTML= tOrganname[1];
					document.getElementById("ltime").innerHTML= tOrganname[0];
					document.getElementById("organName").value=tOrganname[1];
					document.getElementById("time").value=tOrganname[0];
				}
			}else{
				document.getElementById("organName").value='<%=organName %>';
				document.getElementById("time").value=getCurDate();
			}
			var urlinfo = window.location.href; 
	 	 	var companyName = urlinfo.split("?")[1].split("=")[2];
	 	 	companyName=decodeURIComponent(companyName);
	 	 	document.getElementById("companyNames1").innerHTML=companyName;
	 	 	document.getElementById("companyNames2").innerHTML=companyName;
	 	 	document.getElementById("companyNames3").innerHTML=companyName;
	 	 	document.getElementById("companyNames4").innerHTML=companyName;
		});
		
 	}
 	function MakeWord(){
 	save();
	var its=document.getElementsByName("option");
	document.getElementById("div1").style.display="";
 	for(var i=0;i<its.length;i++){
 		var iid = its[i].id.substr(1,1);
 		document.getElementById("l"+iid).innerHTML=its[i].value;
 	}
 	var word = new ActiveXObject("Word.Application");
 	var doc = word .Documents.Add("",0,0);//不打开模版直接加入内容
 	var   Range=doc.Range();
 	var sel = document.body.createTextRange();
 	sel.moveToElementText(form1);//此处form是页面form的id
 	sel.select();
 	document.getElementById("div1").style.display="none";
 	sel.execCommand("Copy"); 
 	Range.Paste();
 	word .Application.Visible = true;
 	sel.collapse(true);
	sel.select(); 
 	}
 	function save(){
 		var rejectReason="";
 		var its=document.getElementsByName("option");
 	 	for(var i=0;i<its.length;i++){
 	 		var iid = its[i].id.substr(1,1);
 	 		rejectReason+=document.getElementById("o"+iid).value;
 	 		if(i!=its.length-1){
 	 			rejectReason+="^*";
 	 		}
 	 	}
		rejectReason+="#*"+document.getElementById("time").value+"&*"+document.getElementById("organName").value;
		
 		var welfFitApplyDataSet = L5.DatasetMgr.lookup("welfFitApplyDataSet");
 		var fitApplyRecord=welfFitApplyDataSet.getCurrent();
 		fitApplyRecord.set("rejectReason",rejectReason);
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
		command.setParameter("record", fitApplyRecord);
		command.execute("saveFitApply");
		if (!command.error) {
				
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
</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="word" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="MakeWord();"/>

</div>
<div align="center">
	<form method="post"  onsubmit="return false" id='form0'>
<TABLE height=677 cellSpacing=0 cellPadding=0 width=600 align=center 
	style="border:0px">
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=500>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=600 align=center >
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
						<TABLE cellSpacing=0 cellPadding=0 width='100%' id='optiontable1'>
							<TBODY>
								<TR>
									<TD width='668'  align=middle class=title3 style="font-size: 25px"><STRONG>关于对<label style="font-size: 25px" id="companyNames1"></label>
									</br>企业资格认定情况的通知
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 20px"><STRONG><label style="font-size: 20px" id="companyNames2"></label>企业：
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 20px"><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;你单位在如下<label style="font-size: 20px" id='fm'></label>方面不符合资格认定的的要求，具体情况如下。
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 20px"><STRONG>&nbsp;&nbsp;1、<input type="text" name="option" style="width:500" id='o1'></input>
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 20px"><STRONG>&nbsp;&nbsp;2、<input type="text" name="option" style="width:500" id='o2'/></input>
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 20px"><STRONG>&nbsp;&nbsp;3、<input type="text" name="option" style="width:500" id='o3'/></input>
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=150></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=right style="font-size: 15px">
										<div align="center" style="width:200"><input type="text"  style="width:100" id='organName'/></input>(主管部门)</div>
									</TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=right style="font-size: 15px">
										<div align="center" style="width:200">
											<input type="text" format="Y-m-d" style="width: 100px;" id="time" maxlength="10" readonly="readonly"  onclick="getTimes(this)"/>(时&nbsp;&nbsp;&nbsp;&nbsp;间) 
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

<!-- 此处为导出word 准备 -->
<div align="center" style='display:none' id="div1">
	<form method="post"  onsubmit="return false" id='form1'>
<TABLE height=677 cellSpacing=0 cellPadding=0 width=600 align=center 
	style="border:0px">
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=500>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=600 align=center >
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
						<TABLE cellSpacing=0 cellPadding=0 width='100%' id='optiontable'>
							<TBODY>
								<TR>
									<TD width='668' height=34 align=middle class=title3 style="font-size: 20px"><STRONG>关于对<label style="font-size: 25px" id="companyNames3"></label></br>企业资格认定情况的通知
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 15px"><STRONG><label style="font-size: 20px" id="companyNames4"></label>企业：
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 15px"><STRONG>&nbsp;&nbsp;&nbsp;&nbsp;你单位在如下<label style="font-size: 15px" id='fm1'></label>方面不符合资格认定的的要求，具体情况如下。
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 15px"><STRONG>&nbsp;&nbsp;1、<label  id='l1'></label>
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 15px"><STRONG>&nbsp;&nbsp;2、<label  id='l2'></label>
									</STRONG></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=left style="font-size: 15px"><STRONG>&nbsp;&nbsp;3、<label  id='l3'></label>
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=150></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=right style="font-size: 15px">
										<label  id='lorganName'>&nbsp;&nbsp;&nbsp;&nbsp;
									</TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=right style="font-size: 15px">
										<label  id='ltime'>&nbsp;&nbsp;&nbsp;&nbsp;
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
</html>