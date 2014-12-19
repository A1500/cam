<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.drel.sam.dao.jdbc.SamSpecialAssistanceItemDao"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="java.util.*"%>
<% 
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
	String titel = "专项补贴资金明细";
	SamSpecialAssistanceItemDao dao= new SamSpecialAssistanceItemDao();
	ParameterSet pset=new ParameterSet();
	pset.setParameter("AREA_CODE",BspUtil.getOrganCode());
	pset.setParameter("IN_USE","1");
	pset.setParameter("sort","ITEM_CODE");
	pset.setParameter("dir","ASC");
	DataSet typeDS=dao.query(pset);
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
<html>
<head>
<next:ScriptManager />

<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript" src="waterPrice.js"></script>
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
	text-align: left;
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true" method="querySpecialReleaseStat" autoLoad="false">
	</model:dataset>
	
	
	<!-- 专项补贴项目 -->
	<model:dataset id="specialAssItemDS" cmd="com.inspur.cams.drel.sam.cmd.SamSpecialAssistanceItemQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem">
		</model:record>
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
			<form id="queryForm" style="width: 100%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="30%">统计时间:</td>
					<td class="FieldInput" width="40%"  colspan="2">
	                     <input type="text" id="cxsj_q" format="Y-m" name="cxsj_q" readonly="readonly" onclick="setmonth(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/> 
	                </td>          
					<td class="FieldLabel" >
						<button onclick="query()">查 询</button> 
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
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true"><div> 
		</div><next:Html><div> 
			</div><div align="center" id="reDiv" style="display: none;"><div><!--style="display: none;"-->
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;font-weight:bold;"><%=titel %></span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="exportExcel()" >导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle">单位：户 、元</span></div>
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="ds" align="center" id="contantTable">
							<tbody id="resultsBody">
						<tr id="firstTR">
							<td class="tdTitle" width="3%" align="center" rowspan="2">单位</td>
							<%for(int i=0;i<typeDS.getCount();i++){
								Record rec=typeDS.getRecord(i); %> 
								
								<td class="tdTitle" width="3%" align="center" colspan="3"><%=rec.get("itemName") %></td>
							<%} %>
							<td class="tdTitle" width="3%" align="center" rowspan="2">总户数</td>
							<td class="tdTitle" width="3%" align="center" rowspan="2">所需资金总额（元）</td>
						</tr>
						<tr id="secTR">
							<%for(int i=0;i<typeDS.getCount();i++){ 
							%>
							<td class="tdTitle" width="3%"  align="center" >低保户数合计</td>
							<td class="tdTitle" width="3%" align="center"   >人数</td>
							<td class="tdTitle" width="3%" align="center" >所需资金（元）</td>
							<%} %>
						</tr>
						<tr  id="forthTR" repeat="true">
							<td style="display: none">
								<label readonly="true" field="ID" /></label>
				            </td>
							<td align="center"><a href="#"><label id="mylabel" style="width: 100px;cursor: hand;" field="NAME"  onclick="queryNextLevel(this)"  /></label><label style="display: none;" field="ID" /></label></a></td>
							<%for(int i=0;i<typeDS.getCount();i++){
								Record rec=typeDS.getRecord(i); %> 
									<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;cursor: hand;" field="<%="RELEASE_FAMILY_SUM"+(i+1) %>"  renderer='getMoneyFormatNoPoint' /></label></td>
									<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;cursor: hand;" field="<%="RELEASE_PEOPLE_SUM"+(i+1) %>"  renderer='getMoneyFormatNoPoint' /></label></td>
									<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;cursor: hand;" field="<%="ASSISTANCE_MON_SUM"+(i+1) %>"  renderer="getMoneyFormat" /></label></td>
							<%} %>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;cursor: hand;" field="RELEASE_FAMILY_SUM"   renderer='getMoneyFormatNoPoint'/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;cursor: hand;" field="ASSISTANCE_MON_SUM" renderer="getMoneyFormat"  /></label></td>
						
						</tr>
						</tbody>
						</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>