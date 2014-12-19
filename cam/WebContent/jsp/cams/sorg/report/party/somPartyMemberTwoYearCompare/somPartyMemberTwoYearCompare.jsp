<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 两年党员数综合比较 -->
<head>
<next:ScriptManager />
<script type="text/javascript" src="../js/somPartyReport.js"></script>
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
	function query(){
		var searchWrap=document.getElementById("searchWrap").value;
		ds.setParameter("ifLike", searchWrap);
		ds.load();
		ds.on('load',function(){
			ds.set("NEW_SUM",parseInt(nullToZero(ds.get("BETO_PARTY")))+parseInt(nullToZero(ds.get("RETO_PARTY")))+
				parseInt(nullToZero(ds.get("PARTY_IN"))));
			ds.set("NEW_DOWN",parseInt(nullToZero(ds.get("OUT_PARTY")))+parseInt(nullToZero(ds.get("STOP_PARTY")))+
				parseInt(nullToZero(ds.get("DIE_PARTY")))+parseInt(nullToZero(ds.get("OUT_TISSUE"))));
			ds.set("SHOULD_SUM",parseInt(nullToZero(ds.get("NEW_SUM")))+parseInt(nullToZero(ds.get("LAST_SUM")))-
				parseInt(nullToZero(ds.get("NEW_DOWN"))) );
			ds.set("BALANCE_SUM",parseInt(nullToZero(ds.get("YEAR_REALLY"))) - parseInt(nullToZero(ds.get("SHOULD_SUM"))));
		});
		document.getElementById("reDiv").style.display="block";
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.report.cmd.SomPartyReportCmd" global="true" method="queryMemberTwoYearCompare" autoLoad="false">
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="20%">
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
					<td class="FieldLabel">查询范围:</td>
					<td class="FieldInput" colspan="2" >					
						<select id="searchWrap">
						  <option value ="0">不包含下级</option>
						  <option value ="1">包含下级</option>
						</select>					
					</td>
					<td class="FieldButton">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="reset()">重 置</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="showDesc()">指标解释与表内关系</button>
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
			<div align="center" id="reDiv" style="display: none;">
			<div align="center"><span 
				style="font-size: large;font-weight:bold;">两年党员数综合比较</span></div>
			<div align="right" class="L5form">
			<button onclick="tableToExcel('showTable')" >打印</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table id="showTable" style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0" >
			   <tr>
					<td colspan="4" style="border-width: 0px">
						 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="4" style="border-width: 0px">
						 <div align="right"><span class= "btTitle">单位：人</span></div>
					</td>			
			   </tr>
				<tr >
					<td colspan="8" style="border-width: 0px">
						<table width="99.9%" align="center" dataset="ds" >
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2">项目</td>
							<td class="tdTitle" width="20%" align="center" colspan="2">人数</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">项目</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">人数</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2">甲</td>
							<td class="tdTitle" width="20%" align="center" colspan="2">A</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">甲</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">A</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2">一、上年底总数</td>
							<td class="tdTitle" width="5%" align="center" >1</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="LAST_SUM" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">停止党籍</td>
							<td class="tdTitle" width="5%" align="center" >9</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="STOP_PARTY" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2">二、本年增加</td>
							<td class="tdTitle" width="5%" align="center" >2</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="NEW_SUM" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">死亡</td>
							<td class="tdTitle" width="5%" align="center" >10</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="DIE_PARTY" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2" rowspan="2">发展党员</td>
							<td class="tdTitle" width="5%" align="center" rowspan="2">3</td>
							<td width="20%" style="padding-right: 2px"align="center" rowspan="2">
								<label field="BETO_PARTY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">转出组织关系</td>
							<td class="tdTitle" width="5%" align="center" >11</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="OUT_TISSUE" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="5%"  align="center" >
								<label style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center" >整建制转出</td>
							<td class="tdTitle" width="5%" align="center" >12</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="ROT_TISSUE" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2">恢复党籍</td>
							<td class="tdTitle" width="5%" align="center" >4</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="RETO_PARTY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">四、本年底应有数</td>
							<td class="tdTitle" width="5%" align="center" >13</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="SHOULD_SUM" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2">转入组织关系</td>
							<td class="tdTitle" width="5%" align="center" >5</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="PARTY_IN" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2" rowspan="2">五、本年底实有数</td>
							<td class="tdTitle" width="5%" align="center"  rowspan="2">14</td>
							<td width="20%" style="padding-right: 2px"align="center" rowspan="2">
								<label field="YEAR_REALLY" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="5%" align="center" ></td>
							<td class="tdTitle" width="20%" align="center" >整建制转入</td>
							<td class="tdTitle" width="5%" align="center" >6</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="ROT_IN" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2" >三、本年减少</td>
							<td class="tdTitle" width="5%" align="center" >7</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="NEW_DOWN" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="2">六、实有数与应有数之差</td>
							<td class="tdTitle" width="5%" align="center" >15</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="BALANCE_SUM" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="20%" align="center" colspan="2" >出党</td>
							<td class="tdTitle" width="5%" align="center" >8</td>
							<td width="20%" style="padding-right: 2px"align="center" >
								<label field="OUT_PARTY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td class="tdTitle" width="20%"  align="center"  colspan="4"></td>
						</tr>
						</table>
					</td>
					</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
	<next:Window id="descWin" title="指标解释与表内关系" closeAction="hide" width="740" modal='true'>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClose"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<p style="font-weight:bold;">一、指标解释</p>
			<p>1．本表统计本年党员数量的增减变化情况。</p>
			<p>2．“本年增加”系指本年内，发展党员、恢复党籍和组织关系从其他党组织转入本党组织的党员。</p>
			<p>3．“发展党员”系指本年发展的党员。</p>
			<p>4．“恢复党籍”系指本年办理恢复党籍手续的党员。</p>
			<p>5．“转入组织关系”系指本年从其他党组织转入本党组织的党员。</p>
			<p>6．“本年减少”系指本年内，出党、停止党籍、死亡及转往其他党组织的党员。</p>
			<p>7．“出党”系指本年受到组织处理而被开除党籍和取消党籍的党员。</p>
			<p>8．“停止党籍”系指因出国或去港澳定居等原因，本年办理停止党籍手续的党员。</p>
			<p>9．“死亡”系指本年死亡的党员。</p>
			<p>10．“转出组织关系”系指本年从本党组织转往其他党组织的党员。</p>
			<p style="margin-top:30px;font-weight:bold;">二、表内关系</p>
			<p>1．2栏=3栏至5栏之和</p>
			<p>2．5栏>=6栏</p>
			<p>3．7栏=8栏至11栏之和</p>
			<p>4．11栏12栏</p>
			<p>5．13栏=1栏+2栏–7栏</p>
			<p>6．15栏=14栏–13栏</p>
	   </next:Html>
	</next:Window>
<p height="50px"></p>
</body>
</html>
