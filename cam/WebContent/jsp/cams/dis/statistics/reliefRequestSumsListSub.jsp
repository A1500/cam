<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>救灾需求统计</title>
<next:ScriptManager />
<style>
.body2 {
	background-color: #EAF4FD;
}

.table2 {
	border-collapse: collapse;
}

.input2 {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

.tdTitleNoTop {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-width: 0px;
}

.tdTitleNoBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-bottom-width: 0px;
}

.tr2 {
	yexj00: expression(this .   style .   background =(   rowIndex %   2 ==   1)
		?   
		 'white ' :     '#EAF4FD ' )
}

.td2 {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
	String date = sdf.format(new Date());
	int i = 0;
%>
<script type="text/javascript">
	var disYear='<%=request.getParameter("disYear")%>';
	var reliefType='<%=request.getParameter("reliefType")%>';
	if(disYear=='undefined')
		disYear='';
	if(reliefType=='undefined')
		reliefType='';
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var orgAreaCode = organCode.substring(2,8)+"000000";
</script>
<script type="text/javascript" src="reliefRequestSumsListSub.js"></script>
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
	<!-- 统计 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" method="queryReqSums" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="DCNUM" type="string" />
			<model:field name="DCFOOD" type="string" />
			<model:field name="DCCLOTHES" type="string" />
			<model:field name="DCWATER" type="string" />
			<model:field name="DCMONEY" type="string" />
			<model:field name="SWNUM" type="string" />
			<model:field name="SWMONEY" type="string" />
			<model:field name="YJNUM" type="string" />
			<model:field name="YJFOOD" type="string" />
			<model:field name="YJCLOTHES" type="string" />
			<model:field name="YJWATER" type="string" />
			<model:field name="YJMONEY" type="string" />
			<model:field name="GDNUM" type="string" />
			<model:field name="GDFOOD" type="string" />
			<model:field name="GDCLOTHES" type="string" />
			<model:field name="GDWATER" type="string" />
			<model:field name="GDMONEY" type="string" />
			<model:field name="CJNUM" type="string" />
			<model:field name="CJRBHOUSE" type="string" />
			<model:field name="CJRPHOUSE" type="string" />
			<model:field name="CJMONEY" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel id="editDeadPanel"
	bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
	width="100%" height="100%" autoScroll="true">
	<next:Html>
		<div align="center" id="reDiv"
			style="display: none; overflow-y: scroll;">
		<div align="center" style="width: 800px;">
		<div align="center"><span id="reportTitle"
			style="font-size: large;">救助需求统计</span></div>
		</div>
		<div align="right" class="L5form">
		<button id="backBtn" onclick="back()" style="display: none;">返回</button>
		&nbsp;&nbsp;
		<button onclick="exportexcel()"  style="right: 50px;">导出Excel</button>
		&nbsp;&nbsp;&nbsp;&nbsp;</div>
		<br />
		<table style="border-style: hidden;" class="table2" cellpadding="0"
			cellspacing="0" border="0" width="90%">
			<tr class="tr2" style="">
				<td style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				</td>
			</tr>
			<tr>
				<td align="left">
				<table width="90%" class="table2" dataset="ds">
					<tr>
						<td class="tdTitle" width="10%" rowspan="2">单位</td>
						<%
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("DC")!=-1) {
						%>
							<td class="tdTitle" align="center" width="15%" colspan="5">冬春生活救助</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("SW")!=-1) {
						%>
						<td class="tdTitle" align="center" width="15%" colspan="2">遇难人员家属抚慰</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("YJ")!=-1) {
						%>
						<td class="tdTitle" align="center" width="15%" colspan="5">应急救助</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("GD")!=-1) {
						%>
						<td class="tdTitle" align="center" width="15%" colspan="5">过渡救助</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("CJ")!=-1) {
						%>
						<td class="tdTitle" align="center" width="15%" colspan="4">灾区民房恢复重建补助</td>
						<%
							}
						%>
					</tr>
					<tr>
						<%
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("DC")!=-1) {
						%>
						<td class="tdTitle" width="5%" align="center" id="DCNUM" >救助户数</td>
						<td class="tdTitle" width="5%" align="center" id="DCFOOD">救助口粮<br />
						(公斤)</td>
						<td class="tdTitle" width="5%" align="center" id="DCCLOTHES">救助衣被<br />
						(件)</td>
						<td class="tdTitle" width="5%" align="center" id="DCWATER">救助饮水<br />
						(元)</td>
						<td class="tdTitle" width="5%" align="center" id="DCMONEY">救助金额<br />
						(元)</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("SW")!=-1) {
						%>
						<td class="tdTitle" width="5%" align="center" id="SWNUM">救助户数</td>
						<td class="tdTitle" width="5%" align="center" id="SWMONEY">救助金额<br />
						(元)</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("YJ")!=-1) {
						%>
						<td class="tdTitle" width="5%" align="center" id="YJNUM">救助户数</td>
						<td class="tdTitle" width="5%" align="center" id="YJFOOD">救助口粮<br />
						(公斤)</td>
						<td class="tdTitle" width="5%" align="center" id="YJCLOTHES">救助衣被<br />
						(件)</td>
						<td class="tdTitle" width="5%" align="center" id="YJWATER">救助饮水<br />
						(元)</td>
						<td class="tdTitle" width="5%" align="center" id="YJMONEY">救助金额<br />
						(元)</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("GD")!=-1) {
						%>
						<td class="tdTitle" width="5%" align="center" id="GDNUM">救助户数</td>
						<td class="tdTitle" width="5%" align="center" id="GDFOOD">救助口粮<br />
						(公斤)</td>
						<td class="tdTitle" width="5%" align="center" id="GDCLOTHES">救助衣被<br />
						(件)</td>
						<td class="tdTitle" width="5%" align="center" id="GDWATER">救助饮水<br />
						(元)</td>
						<td class="tdTitle" width="5%" align="center" id="GDMONEY">救助金额<br />
						(元)</td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("CJ")!=-1) {
						%>
						<td class="tdTitle" width="5%" align="center" id="CJNUM">救助户数</td>
						<td class="tdTitle" width="5%" align="center" id="CJRBHOUSE">重建间数</td>
						<td class="tdTitle" width="5%" align="center" id="CJRPHOUSE">修缮间数</td>
						<td class="tdTitle" width="5%" align="center" id="CJMONEY">救助金额<br />
						(元)</td>
						<%
							}
						%>
					</tr>
					<tr repeat="true" class="tr2">
						<td nowrap align="left" class="td2"><label id="test"
							field="ORGAN_NAME" size="6"
							onclick="forDown(this.parentNode.parentNode)"
							style="color: #0000FF"></label></td>

						<%
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("DC")!=-1) {
						%>
						<td align="center" class="td2"><a href='#'><label field="DCNUM" onclick="openUrls(this)"></label>
						<label style="display: none;" field="ORGAN_CODE" ></label></a></td>
						<td align="right" class="td2"><label field="DCFOOD" /></td>
						<td align="right" class="td2"><label field="DCCLOTHES" /></td>
						<td align="right" class="td2"><label field="DCWATER" /></td>
						<td align="right" class="td2"><label field="DCMONEY" /></td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("SW")!=-1) {
						%>
						<td align="center" class="td2"><label field="SWNUM" /></td>
						<td align="right" class="td2"><label field="SWMONEY" /></td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("YJ")!=-1) {
						%>
						<td align="center" class="td2"><label field="YJNUM" /></td>
						<td align="right" class="td2"><label field="YJFOOD" /></td>
						<td align="right" class="td2"><label field="YJCLOTHES" /></td>
						<td align="right" class="td2"><label field="YJWATER" /></td>
						<td align="right" class="td2"><label field="YJMONEY" /></td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("GD")!=-1) {
						%>
						<td align="center" class="td2"><label field="GDNUM" /></td>
						<td align="right" class="td2"><label field="GDFOOD" /></td>
						<td align="right" class="td2"><label field="GDCLOTHES" /></td>
						<td align="right" class="td2"><label field="GDWATER" /></td>
						<td align="right" class="td2"><label field="GDMONEY" /></td>
						<%
							}
							if(!"undefined".equalsIgnoreCase((String)request.getParameter("reliefType")) && 
									((String)request.getParameter("reliefType")).indexOf("CJ")!=-1) {
						%>
						<td align="center" class="td2"><label field="CJNUM" /></td>
						<td align="right" class="td2"><label field="CJRBHOUSE" /></td>
						<td align="right" class="td2"><label field="CJRPHOUSE" /></td>
						<td align="right" class="td2"><label field="CJMONEY" /></td>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="90%" class="table2">
					<tr class="tr2">
						<td class="td2" style="border-width: 0px">
						<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
						</td>
						<td class="td2" style="border-width: 0px">
						<div align="right"><span class="btTitle">制表时间：<%=date%></span></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>