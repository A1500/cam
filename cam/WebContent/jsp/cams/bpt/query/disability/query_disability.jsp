<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var cxzt = '<%=request.getParameter("cxzt")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_disability.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript" src="../querycomm.js"></script>
<script type="text/javascript">
	queryPage = true;
	if(cxsjq != null && cxsjq != "") {
		timeType = "1";
		startTime = cxsjq;
	}
	endTime = cxsjz;
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

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>

</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.DisabilityCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="yzzxcount_1" type="string" />
			<model:field name="yzzzcount_1" type="string" />
			<model:field name="yzcount_1" type="string" />
			<model:field name="ygzxcount_1" type="string" />
			<model:field name="ygzzcount_1" type="string" />
			<model:field name="ygcount_1" type="string" />
			<model:field name="ybzxcount_1" type="string" />
			<model:field name="ybzzcount_1" type="string" />
			<model:field name="ybcount_1" type="string" />

			<model:field name="yzzxcount_2" type="string" />
			<model:field name="yzzzcount_2" type="string" />
			<model:field name="yzcount_2" type="string" />
			<model:field name="ygzxcount_2" type="string" />
			<model:field name="ygzzcount_2" type="string" />
			<model:field name="ygcount_2" type="string" />
			<model:field name="ybzxcount_2" type="string" />
			<model:field name="ybzzcount_2" type="string" />
			<model:field name="ybcount_2" type="string" />

			<model:field name="yzzxcount_3" type="string" />
			<model:field name="yzzzcount_3" type="string" />
			<model:field name="yzcount_3" type="string" />
			<model:field name="ygzxcount_3" type="string" />
			<model:field name="ygzzcount_3" type="string" />
			<model:field name="ygcount_3" type="string" />
			<model:field name="ybzxcount_3" type="string" />
			<model:field name="ybzzcount_3" type="string" />
			<model:field name="ybcount_3" type="string" />

			<model:field name="yzzxcount_4" type="string" />
			<model:field name="yzzzcount_4" type="string" />
			<model:field name="yzcount_4" type="string" />
			<model:field name="ygzxcount_4" type="string" />
			<model:field name="ygzzcount_4" type="string" />
			<model:field name="ygcount_4" type="string" />
			<model:field name="ybzxcount_4" type="string" />
			<model:field name="ybzzcount_4" type="string" />
			<model:field name="ybcount_4" type="string" />

			<model:field name="yzzxcount_5" type="string" />
			<model:field name="yzzzcount_5" type="string" />
			<model:field name="yzcount_5" type="string" />
			<model:field name="ygzxcount_5" type="string" />
			<model:field name="ygzzcount_5" type="string" />
			<model:field name="ygcount_5" type="string" />
			<model:field name="ybzxcount_5" type="string" />
			<model:field name="ybzzcount_5" type="string" />
			<model:field name="ybcount_5" type="string" />

			<model:field name="yzzxcount_6" type="string" />
			<model:field name="yzzzcount_6" type="string" />
			<model:field name="yzcount_6" type="string" />
			<model:field name="ygzxcount_6" type="string" />
			<model:field name="ygzzcount_6" type="string" />
			<model:field name="ygcount_6" type="string" />
			<model:field name="ybzxcount_6" type="string" />
			<model:field name="ybzzcount_6" type="string" />
			<model:field name="ybcount_6" type="string" />

			<model:field name="yzzxcount_7" type="string" />
			<model:field name="yzzzcount_7" type="string" />
			<model:field name="yzcount_7" type="string" />
			<model:field name="ygzxcount_7" type="string" />
			<model:field name="ygzzcount_7" type="string" />
			<model:field name="ygcount_7" type="string" />
			<model:field name="ybzxcount_7" type="string" />
			<model:field name="ybzzcount_7" type="string" />
			<model:field name="ybcount_7" type="string" />

			<model:field name="yzzxcount_8" type="string" />
			<model:field name="yzzzcount_8" type="string" />
			<model:field name="yzcount_8" type="string" />
			<model:field name="ygzxcount_8" type="string" />
			<model:field name="ygzzcount_8" type="string" />
			<model:field name="ygcount_8" type="string" />
			<model:field name="ybzxcount_8" type="string" />
			<model:field name="ybzzcount_8" type="string" />
			<model:field name="ybcount_8" type="string" />

			<model:field name="yzzxcount_9" type="string" />
			<model:field name="yzzzcount_9" type="string" />
			<model:field name="yzcount_9" type="string" />
			<model:field name="ygzxcount_9" type="string" />
			<model:field name="ygzzcount_9" type="string" />
			<model:field name="ygcount_9" type="string" />
			<model:field name="ybzxcount_9" type="string" />
			<model:field name="ybzzcount_9" type="string" />
			<model:field name="ybcount_9" type="string" />

			<model:field name="yzzxcount_10" type="string" />
			<model:field name="yzzzcount_10" type="string" />
			<model:field name="yzcount_10" type="string" />
			<model:field name="ygzxcount_10" type="string" />
			<model:field name="ygzzcount_10" type="string" />
			<model:field name="ygcount_10" type="string" />
			<model:field name="ybzxcount_10" type="string" />
			<model:field name="ybzzcount_10" type="string" />
			<model:field name="ybcount_10" type="string" />

			<model:field name="totalcount" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">伤残人员统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table width="2830" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
						<tr>
							<td class="tdTitle" width="100" align="center" rowspan="3">单位</td>
							<td class="tdTitle" align="center" colspan="9">一级</td>
							<td class="tdTitle" align="center" colspan="9">二级</td>
							<td class="tdTitle" align="center" colspan="9">三级</td>
							<td class="tdTitle" align="center" colspan="9">四级</td>
							<td class="tdTitle" align="center" colspan="9">五级</td>
							<td class="tdTitle" align="center" colspan="9">六级</td>
							<td class="tdTitle" align="center" colspan="9">七级</td>
							<td class="tdTitle" align="center" colspan="9">八级</td>
							<td class="tdTitle" align="center" colspan="9">九级</td>
							<td class="tdTitle" align="center" colspan="9">十级</td>
							<td class="tdTitle" align="center" rowspan="3">总计</td>
						</tr>
						<tr>
							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

							<td class="tdTitle" align="center" colspan="3">因战</td>
							<td class="tdTitle" align="center" colspan="3">因公</td>
							<td class="tdTitle" align="center" colspan="3">因病</td>

						</tr>
						<tr>
							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>

							<td class="tdTitle" width="30" align="center">在乡</td>
							<td class="tdTitle" width="30" align="center">在职</td>
							<td class="tdTitle" width="30" align="center">小计</td>
						</tr>
						<tr repeat="true">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label   onclick="redirectQuery_dis(this,'01','1','1')" field="yzzxcount_1"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','1','2')" field="yzzzcount_1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','1')" field="yzcount_1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','2','1')" field="ygzxcount_1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','2','2')" field="ygzzcount_1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','2')" field="ygcount_1"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','3','1')" field="ybzxcount_1" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','3','2')" field="ybzzcount_1" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'01','3')" field="ybcount_1" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','1','1')"  field="yzzxcount_2"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','1','2')" field="yzzzcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','1')" field="yzcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','2','1')" field="ygzxcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','2','2')"  field="ygzzcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','2')" field="ygcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','3','1')" field="ybzxcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','3','2')" field="ybzzcount_2" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'02','3')" field="ybcount_2" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','1','1')"  field="yzzxcount_3"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','1','2')" field="yzzzcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','1')" field="yzcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','2','1')" field="ygzxcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','2','2')" field="ygzzcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','2')" field="ygcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','3','1')" field="ybzxcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','3','2')" field="ybzzcount_3" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'03','3')" field="ybcount_3" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','1','1')"  field="yzzxcount_4"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','1','2')" field="yzzzcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','1')" field="yzcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','2','1')" field="ygzxcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','2','2')" field="ygzzcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','2')" field="ygcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','3','1')" field="ybzxcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','3','2')" field="ybzzcount_4" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'04','3')" field="ybcount_4" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','1','1')"  field="yzzxcount_5"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','1','2')" field="yzzzcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','1')" field="yzcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','2','1')" field="ygzxcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','2','2')" field="ygzzcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','2')" field="ygcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','3','1')"  field="ybzxcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','3','2')" field="ybzzcount_5" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'05','3')" field="ybcount_5" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','1','1')"  field="yzzxcount_6"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','1','2')" field="yzzzcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','1')" field="yzcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','2','1')" field="ygzxcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','2','2')" field="ygzzcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','2')" field="ygcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','3','1')" field="ybzxcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','3','2')" field="ybzzcount_6" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'06','3')" field="ybcount_6" 
								></label></a></td>



							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','1','1')"  field="yzzxcount_7"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','1','2')" field="yzzzcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','1')" field="yzcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','2','1')" field="ygzxcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','2','2')" field="ygzzcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','2')" field="ygcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','3','1')" field="ybzxcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','3','2')" field="ybzzcount_7" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  onclick="redirectQuery_dis(this,'07','3')" field="ybcount_7" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','1','1')"  field="yzzxcount_8"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','1','2')" field="yzzzcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','1')" field="yzcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','2','1')" field="ygzxcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','2','2')" field="ygzzcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','2')" field="ygcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','3','1')" field="ybzxcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','3','2')" field="ybzzcount_8" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'08','3')" field="ybcount_8" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','1','1')"  field="yzzxcount_9"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','1','2')" field="yzzzcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','1')" field="yzcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','2','1')" field="ygzxcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','2','2')" field="ygzzcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','2')" field="ygcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','3','1')" field="ybzxcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','3','2')" field="ybzzcount_9" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'09','3')" field="ybcount_9" 
								></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','1','1')"   field="yzzxcount_10"
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','1','2')"  field="yzzzcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','1')"  field="yzcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','2','1')"  field="ygzxcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','2','2')"  field="ygzzcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','2')"  field="ygcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','3','1')"  field="ybzxcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','3','2')"  field="ybzzcount_10" 
								></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'10','3')"  field="ybcount_10" ></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery_dis(this,'00')"   field="totalcount"></label></a></td>
						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>