<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.*"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<html>
	<head>
		<title>假肢和矫形器生产装配企业建设情况统计表</title>
		<next:ScriptManager />
		<script type="text/javascript" src="fitBuildReport.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
		<script type="text/javascript">
		
		    <%
		    SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
			String date=sdf.format(new Date());
			String username= GetBspInfo.getBspInfo(request).getUserName();
			String titel ="假肢和矫形器生产装配企业建设情况统计表";
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
		</script>
		<style>
body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdBottom {
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

tr{   
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
} 

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}
.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.prosthesis.query.cmd.FitReportQueryCmd" global="true" method="queryBuildinfoReport" autoLoad="false">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	 	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"  bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true"><div> 
		</div><next:Html><div> 
			</div><div align="center" id="reDiv" style="display: none;">
			<div><!--style="display: none;"-->
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;font-weight:bold;"><%=titel %></span></div>
			</div>
			<br/>
			<div align="right" class="L5form">
				<button onclick="exportExcel()" id="excelId">导出Excel</button>&nbsp;&nbsp;
			</div>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle"></span></div>
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">填报单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="11" style="border-width: 0px">
						<table width="99.9%" dataset="ds"  align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%" rowspan="2" align="center" >地区</td>
							<td class="tdTitle" width="3%" rowspan="2" align="center"  >企业总数</td>
							<td class="tdTitle" width="3%" colspan="9" align="center"  >建设情况（万平方米）</td>
							
						</tr>
						<tr>
							<td class="tdTitle" width="3%"  align="center"  >总经营面积</td>
							<td class="tdTitle" width="3%"  align="center"  >制作间面积</td>
							<td class="tdTitle" width="3%"  align="center"  >康复室面积</td>
							<td class="tdTitle" width="3%"  align="center"  >接待室面积</td>
							<td class="tdTitle" width="3%"  align="center"  >训练厅面积</td>
							<td class="tdTitle" width="3%"  align="center"  >理疗室面积</td>
							<td class="tdTitle" width="3%"  align="center"  >办公面积</td>
							<td class="tdTitle" width="3%"  align="center"  >休闲区面积</td>
							<td class="tdTitle" width="3%"  align="center"  >其它</td>
						</tr>
					<tr  repeat="true">
							 <td style="display: none">
								<label readonly="true" field="ID" /></label>
				            </td>
							<td align="center"><a href="#"><label style="width: 100px;cursor: hand;" field="NAME"  onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ID" /></label></a></td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="FIT_NUM" renderer="nullToZero"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="OPERATE_AREA" renderer="nullToZero"/></label>
							</td>
								
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="PRODUCT_AREA" renderer="nullToZero"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="RECOVERY_AREA" renderer="nullToZero"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="RECEPTION_AREA" renderer="nullToZero"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="TRAIN_AREA" renderer="nullToZero"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="TREATMENT_AREA" renderer="nullToZero"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="WORK_AREA" renderer="nullToZero"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="LEISURE_AREA" renderer="nullToZero"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="OTHER_AREA" renderer="nullToZero"/></label>
							</td>
						</tr>
						</tbody>
						</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>	
	</body>
</html>