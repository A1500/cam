<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());	
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var username = '<%=username%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="page_disability.js"></script>
<script type="text/javascript" src="../../../prsComm.js"></script>
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.prs.query.cmd.PrsDisability5_8Cmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			
			<model:field name="YZ_5" type="string" />
			<model:field name="YG_5" type="string" />
			
			<model:field name="YZ_6" type="string" />
			<model:field name="YG_6" type="string" />
			
			<model:field name="YZ_7" type="string" />
			<model:field name="YG_7" type="string" />
			
			<model:field name="YZ_8" type="string" />
			<model:field name="YG_8" type="string" />
		</model:record>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='FULL_NAME'></model:param>
		</model:params>
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
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" nowrap>退役时间:</td>
					<td class="FieldInput" colspan="3" ><input type="text" id="cxsj_q"
						format="Y-m-d" style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_z" 
						format="Y-m-d" style="width: 100px;" maxlength="10"onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					<td>
					
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
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="right" class="L5form">
				<button onclick="excel()" id="excelId">导出Excel</button>
			</div>
			<div align="center"><span id="reportTitle"
				style="font-size: large;">山东省退役士兵因战、因公5~8级伤残统计表</span>
			</div>
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				<tr style="border-width: 0px">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime" /></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center">
						<tr>
							<td class="tdTitle" width="15%" align="center" rowspan="3">单&nbsp;&nbsp;&nbsp;&nbsp;位</td>
							<td class="tdTitle" width="70%" align="center" colspan="8" >伤残退役士兵</td>
						</tr>
						<tr>
							<td class="tdTitle" width="8%" align="center" colspan="2">五级</td>
							<td class="tdTitle" width="8%" align="center" colspan="2">六级</td>
							<td class="tdTitle" width="8%" align="center" colspan="2">七级</td>
							<td class="tdTitle" width="8%" align="center" colspan="2">八级</td>
						</tr>
						<tr>
							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>

						</tr>
						
						<tr repeat="true">
							<td align="center"><a href="#"><label 
								onclick="test(this)" style="width: 20%;height: 20px;line-height:20px;" field="ORGAN_NAME" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'2')"  field="YZ_5" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'3')"  field="YG_5" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>

							<td align="right"><a href="#"><label onclick="querydetail(this,'4')"  field="YZ_6" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'5')"  field="YG_6" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'6')"  field="YZ_7" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'7')"  field="YG_7" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'8')"  field="YZ_8" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'9')"  field="YG_8" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
						</tr>
					</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=username %></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">制表时间：<%=date %></span></div></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
