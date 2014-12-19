<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.comm.util.IdHelp" %>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>等级评定资格取消表</title>
<%
String applyId=request.getParameter("applyId");
String organType=request.getParameter("organType");
String method=request.getParameter("method");
String deptId=request.getParameter("deptId");

String organArea=BspUtil.getCorpOrgan().getOrganCode();
String cityCode=organArea.substring(0,4)+"00000000";
String cityName=DicUtil.getTextValueFromDic("dic_city","ID",cityCode,"FULL_NAME");

String organName=BspUtil.getOrganName();
%>
<next:ScriptManager/>
<script>
var applyId='<%=request.getParameter("applyId")%>';
var appId='<%=IdHelp.getUUID32()%>';
var nowDate ='<%=DateUtil.getDay()%>';
var method='<%=request.getParameter("method")%>';
var deptId='<%=request.getParameter("deptId")%>';
var myDate = new Date();
var organType='<%=request.getParameter("organType")%>';
var cityName ='<%=cityName.substring(0,3)%>';
var organName ='<%=organName%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="mrmLevelQuitApply.js"></script>
<style type="text/css">
<!--
label {
	font-size: 17px;
}
-->
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="applyDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>	
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true" method="getOrganInfo">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisAll">
			<model:field name="foreign" type="string"/>	
			<model:field name="townOpinionId" type="string"/>	
			<model:field name="cityOpinionId" type="string"/>	
			<model:field name="provinceOpinionId" type="string"/>	
			<model:field name="departmentOpinionId" type="string"/>	
		</model:record>
	</model:dataset>
	<model:dataset id="mrmElectronicDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" method="queryCatalog" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>		
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="MRM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
		</model:record>
	</model:dataset>
	<model:dataset id="applyQueryDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<model:dataset id="opinionDataSet" enumName="MRM.WORKFLOW.OPINION" autoLoad="true" global="true" />
</model:datasets>
<next:Panel>
  <next:TopBar>
    <next:ToolBarItem symbol="->"></next:ToolBarItem>
    <next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
    <next:ToolBarItem iconCls="select"  text="提交" handler="submit"/>
    <next:ToolBarItem iconCls="undo" text="取消" handler="undo"></next:ToolBarItem>
  </next:TopBar>
  <next:TabPanel>
     <next:Tabs>
        <next:Panel title="等级评定取消" autoHeight="true">
	       <next:Html>
					<form id="editForm"  dataset="applyDs" onsubmit="return false" style="padding:20px;" class="L5form">
						<table border="1"  width="700" align="center" class="noprint">
							<tr>
								<td colspan="4" align="center">
									<br><br>
									<font size="5" style="">取消婚姻登记机关等级资格申报表</font><br><br><br><br><br>
									 <div align="left">
									<p align="left" style='text-indent: 100.0pt' >
									取消等级资格单位： <label field="organName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									取 消 等 级：
							         <label id="skinValue" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									申 报 单 位： <label field="organName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									</p>
									<p align="left" style='text-indent: 100.0pt' >
									申 报 时 间：
									<input type="text" id="creatDate"  title="成立日期" format="Y-m-d"  
									style="width: 280px;font-size: 17px;"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" 
									onclick="getTimes(this)" />
									<br><br>
									</p>
									</div>
								</td>
							</tr>
						    <tr>
								<td align="center" width="15%">申请取消等级资格单位名称</td>
								<td width="30%"> <label field="organName" style="font-size: 17px"></label></td>
								<td width="30%" align="center">取消等级</td>
								<td width="25%"><label id="applyLev" style="font-size: 17px"></label> </td>
							</tr>
							<tr>
							    <td rowspan="5" align=center>退出<br>原因</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="reason" field="reason" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									></textarea>
								</td>
							</tr>
							<tr>&nbsp;</tr><tr>&nbsp;</tr><tr>&nbsp;</tr><tr>&nbsp;</tr>
							<tr>
								<td rowspan="4" align="center">县级人民政府<br>民政部门<br>意见</td>
								<td colspan="3" >
									<label field="townOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea id="townOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<label field="townOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="townAuditTime"/>
								</td>
							</tr>
							
							<tr>
								<td rowspan="4"  align="center">地市级人民政<br>府民政部门<br>意见</td>
								<td colspan="3" >
									<label field="cityOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="cityOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
									<label field="cityOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="cityAuditTime"/>
								</td>
							</tr>	
							
							<tr>
								<td rowspan="4" align="center">省级人民政府<br>民政部门<br>意见</td>
								<td colspan="3" >
									<label field="provinceOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<label field="provinceOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="provinceAuditTime"/>
								</td>
							</tr>	
							
                            <tr>
								<td rowspan="4" align="center">民政部<br>审批意见</td>
								<td colspan="3" >
									<label field="departmentOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="departmentOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<label field="departmentOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="departmentAuditTime"/>
								</td>
							</tr>
					   </table>
					</form>
			   </next:Html>
			</next:Panel>
     </next:Tabs>
  </next:TabPanel>
</next:Panel>
</body>
</html>
