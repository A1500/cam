<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
	String titel ="辅导员统计表";
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<next:ScriptManager />

<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="counsellorSum.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.query.dept.cmd.CounsellerQueryCmd" global="true" method="query" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE"/>
			<model:field name="ORGAN_NAME"/>
			<model:field name="TOTALNUM"/>
			<model:field name="NAN_NUM"/>
			<model:field name="NV_NUM"/>
			<model:field name="DY_NUM"/>
			<model:field name="TY_NUM"/>
			<model:field name="YJS_NUM"/>
			<model:field name="DXBK_NUM"/>
			<model:field name="ZK_NUM"/>
			<model:field name="SG_NUM"/>
			<model:field name="XLZXS_NUM"/>
			<model:field name="HYJTZXS_NUM"/>
			<model:field name="LS_NUM"/>
			<model:field name="ZFGMFW_NUM"/>
			<model:field name="GKZM_NUM"/>
			<model:field name="ZYZ_NUM"/>
			<model:field name="QT_NUM"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	 
	<next:Panel width="100%" border="0"  bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true"><div> 
		</div><next:Html><div> 
			</div><div align="center" id="reDiv" >
			<div><!--style="display: none;"-->
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;font-weight:bold;"><%=titel %></span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<%=date.substring(0,8)%></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="ds" align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="2%" align="center" rowspan="2">总人数</td>
							<td class="tdTitle" width="3%"  align="center" colspan="2">性别</td>
							<td class="tdTitle" width="3%"  align="center" colspan="2">政治面貌</td>
							<td class="tdTitle" width="3%" align="center"  colspan="3">学历</td>
							<td class="tdTitle" width="3%" align="center"  colspan="4">专业资格证</td>
							<td class="tdTitle" width="3%" align="center"  colspan="4">人员来源</td>
							
						</tr>
						<tr>	
							<td class="tdTitle"  width="2%" align="center" >男</td>
							<td class="tdTitle"  width="2%" align="center" >女</td>
							<td class="tdTitle"  width="2%" align="center" >党员</td>
							<td class="tdTitle"  width="2%" align="center" >团员</td>
							<td class="tdTitle"  width="2%" align="center" >研究生</td>
							<td class="tdTitle"  width="2%" align="center" >大学本科</td>
							<td class="tdTitle"  width="2%" align="center" >专科</td>
							<td class="tdTitle"  width="2%" align="center" >社工</td>
							<td class="tdTitle"  width="2%" align="center" >心理咨询师</td>
							<td class="tdTitle"  width="2%" align="center" >婚姻家庭咨询师</td>
							<td class="tdTitle"  width="2%" align="center" >律师</td>
							<td class="tdTitle"  width="2%" align="center" >政府购买服务</td>
							<td class="tdTitle"  width="2%" align="center" >公开招募</td>
							<td class="tdTitle"  width="2%" align="center" >志愿者</td>
							<td class="tdTitle"  width="2%" align="center" >其他</td>
						</tr>
						<tr  repeat="true">
							<td align="center" ><a href="#"><label style="width: 150px;"
								field="ORGAN_NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;"
								field="ORGAN_CODE" /></label></a></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTALNUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="NAN_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="NV_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="DY_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TY_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YJS_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="DXBK_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ZK_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SG_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="XLZXS_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="HYJTZXS_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="LS_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ZFGMFW_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GKZM_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ZYZ_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="QT_NUM"/></label></td>
						</tr>
						</tbody>
						</table>
					</td >
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