<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<!-- 党员基本情况 -->
<head>
<next:ScriptManager />
<script type="text/javascript" src="../js/somPartyReport.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src="exCommon.js"></script>
<script>
	function showDesc(){
		var win = L5.getCmp("descWin");
		win.show();
	}
	function winClose(){
		var win=L5.getCmp("descWin");
		win.hide();
	}
	function exportPrint(){
	
	}
	function init(){
		query();
	}
	function query(){
		if(_$("startDate")!=""){
			ds.setParameter("startDate",_$("startDate"));
		}
		if(_$("endDate")!=""){
			ds.setParameter("endDate",_$("endDate"));
		}
		ds.load();
	}
	function tableToExcel(tname) {
	  if(confirm('是否要导出到excel?')!=0)
	  { 
		   window.clipboardData.setData("Text",document.all(tname).outerHTML);
		   try
		   {
		    ExApp = new ActiveXObject("Excel.Application")
		    var ExWBk = ExApp.workbooks.add()
		    var ExWSh = ExWBk.worksheets(1)
		    ExApp.DisplayAlerts = false
		    ExApp.visible = true
		   }  
		   catch(e)
		   {
		    alert("导出没有成功！1.您的电脑没有安装Microsoft Excel软件!2.请设置Internet选项自定义级别，对没有标记安全级别的  ActiveX控件进行提示。")
		    return false
		   } 
		    ExWBk.worksheets(1).Paste;
	 }else
     { 
       return;
	 }
  	}
  	
 function nullToZero(str){
 	if(str == ""){
 		str = "0";
 	}
 	return str;
 }
</script>
<style>
body {
	background-color: #EAF4FD;
}

#showTable table{
	border-collapse: collapse;
}

#showTable input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

#showTable tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}
#showTable btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

#showTable tdBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-style: none;
	border-left-style: none;
	border-right-style: none;
    border-bottom-style: none;
    FONT-SIZE: 10pt;
}

#showTable tr{   
	yexj00:expression(this.style.background=(rowIndex%1==1)? 'white ': '#EAF4FD ')
} 

#showTable td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
	height:20px; 
	line-height:20px; 
	overflow:hidden; 
}
#showTable tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
</head>
<body>
<model:datasets> 
	<model:dataset id="ds" cmd="com.inspur.cams.dataexchange.log.DataExChangeLogQueryCmd" global="true" method="queryReport" autoLoad="false">
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="10%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<%
					Calendar c = Calendar.getInstance();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
					%>
					<td class="FieldLabel">查询时间:</td>
					<td class="FieldInput" colspan="3">
						<input type="text"  id="startDate" name="startDate" class="TextEditor" maxlength="10"  onpropertychange="changeDateStyle(this)" value='<%=c.get(Calendar.YEAR)%>-01-01'  format="Y-m-d"/>
						<img  src="<%=SkinUtils.getImage(request,"default/rl.gif")%>" align="middle" onclick="getTimes('startDate');" /> 
						&nbsp;&nbsp;至&nbsp;&nbsp;
						<input type="text"  id="endDate" name="endDate" class="TextEditor" maxlength="10"  onpropertychange="changeDateStyle(this)"  value='<%=sdf.format(c.getTime())%>'  format="Y-m-d"/>
						<img  src="<%=SkinUtils.getImage(request,"default/rl.gif")%>" align="middle" onclick="getTimes('endDate');" /> 
					</td>
					<td class="FieldButton">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv">
			<div align="center"><span 
				style="font-size: large;font-weight:bold;">数据查询情况按单位统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="tableToExcel('showTable')" >导出</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table id="showTable" style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0" >
			   <tr>
					<td colspan="4" style="border-width: 0px">
						 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="4" style="border-width: 0px">
						 <div align="right"><span class= "btTitle">单位：条</span></div>
					</td>			
			   </tr>
			   
				<tr >
					<td colspan="8" style="border-width: 0px">
						<table width="99.9%" align="center" dataset="ds" >
						<tr>
							<td class="tdTitle" width="30%" align="center" colspan="2">查询单位</td>
							<td class="tdTitle" width="10%"  align="center"  >合计（条）</td>
							<td class="tdTitle" width="10%"  align="center"  >婚姻登记信息（条）</td>
							<td class="tdTitle" width="10%"  align="center"  >殡葬信息（条）</td>
						</tr>
						<tr repeat="true">
							<td width="30%" align="center" colspan="2"><label field="UNITNAME" style="height: 20px;" /></label></td>
							<td width="10%" align="center" >
								<label field="SUMCOUNT" style="height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="HUNYINCOUNT" style="height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="BINZANGCOUNT" style="height: 20px;" /></label>
							</td>
						</tr>
						</table>
					</td>
					</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
<p height="50px"></p>
</body>
</html>
