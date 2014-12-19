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
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager></next:ScriptManager>
<link href="../../apply/welfarecorpQualification/css/welfareapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	//初始化
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var taskCode='<%=taskCode%>';
	function init(){
		var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
		wealUnitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
		wealUnitInfoDataSet.load();
	}
	//明细页面翻页功能键
	function backPage(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/yearlyCheck/applytask/welfarecorpYearlyCheckList.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}

	function nextPage(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply2Detail.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	function lastPage(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/yearlyCheck/applytask/welfarecorpYearlyCheckList.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
</script>
</head>
<body>
<model:datasets>
	<!-- 业务信息表 -->
	<model:dataset id="wealUnitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()" />
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPage()" />
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPage();"/>
</div>
<form method="post"  onsubmit="return false">
<TABLE height=677 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=597>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=668 align=center dataset="wealUnitInfoDataSet"
				border=0>
				<TBODY>
					<TR>
						<TD width='668' height=34 align=right class=title3><STRONG>编号：鲁福企字第（<label  field="serialNum" id='serialNum' style='font-size: 14.0pt; font-family: 宋体'></label>）号
						</STRONG></TD>
					</TR>
					<TR>
						<TD class=title1 vAlign=top align=middle height=150>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=150></TD>
								</TR>
							</TBODY>
						</TABLE>
						<DIV align=center></DIV>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='668' height=34 align=middle class=title1><STRONG>社会福利企业
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=middle class=title1><label id="applyYear" field="applyYear" style="font-size:30px;font-weight:400"></label>&nbsp;&nbsp;<STRONG>年度检查表
									</STRONG></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=300>
			<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0 dataset="wealUnitInfoDataSet">
				<TBODY>
					<TR >
						<TD width="20%" align="left" height=150>&nbsp;</TD>
						<TD  align="left" class=title3 width="200"><STRONG>企业名称（章）： </STRONG></TD>
						<TD height=40 colspan='4'><label 
							name='企业名称' field="companyName" style='font-size: 14.0pt; font-family: 宋体' id='companyName' SIZE='70' MAXLENGTH='72'/></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><br>
						<STRONG>法&nbsp;人&nbsp;代&nbsp;表&nbsp;：</STRONG></TD>
						<TD height=40 colspan='4' align="left" ><label 
							name='法人代表' style='font-size: 14.0pt; font-family: 宋体' field="legalPeople" id='legalPeople'
							height=40 SIZE='70' MAXLENGTH='72'/></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><STRONG>填&nbsp;表&nbsp;时&nbsp;间&nbsp;：</STRONG></TD>
						<td height=40 colspan='4'>
						<label name='填表时间' field="regDate" id='regDate' style='font-size: 14.0pt; font-family: 宋体' height=40 readonly="readonly" format="Y-m-d"/></td>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align="middle" height=100 class="title3" style="font-size: 25px"><strong>山东省民政厅监制</strong>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>1</td>
		</tr>
	</TBODY>
</TABLE>
</form>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()" />
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPage()" />
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPage();"/>
</div>
</body>
</html>