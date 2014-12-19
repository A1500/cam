<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var username = '<%=GetBspInfo.getBspInfo(request).getUserName()%>';
</script>

<html>
	<head>
		<title>问题处理信息管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="prsProblemDealProcess.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
			 var organId='<%=BspUtil.getCorpOrganId()%>';
		     var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		     var problemId='<%=request.getParameter("problemId")%>';
		     var problemFrom='<%=request.getParameter("problemFrom")%>';
		     var page='<%=request.getParameter("page")%>';
		     var queryId='<%=request.getParameter("queryId")%>';
		</script>
	</head>
<body>
<model:datasets>
    <model:dataset id="problemDealDS" cmd="com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealQueryCmd">
      <model:record fromBean="com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal">
      </model:record>
	</model:dataset>
	<!-- 属地 -->
<model:dataset id="domicileCityDataset" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<model:dataset id="domicileDataset" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="problemFromDS" enumName="PROBLEM_FROM" autoLoad="true"  global="true"></model:dataset>
	<model:dataset id="supervisionDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dealFlagDS" enumName="DEAL_FLAG" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel id="problem_winPanel"  width="100%" height="100%" collapsible="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="确定" handler="save_problem"/>
			<next:ToolBarItem iconCls="undo" text="返回" handler="return_problem"/>
		</next:TopBar>
		<next:Html>
			<form id="form_content" class="L5form" dataset="problemDealDS">
				<table width="100%">
					<tr >
						<td class="FieldLabel" >问题标题：</td>
						<td class="FieldInput">
							<input type="text" id="problemTitle" name="问题标题：" field="problemTitle"  maxlength="50"  style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">问题编号：</td>
						<td class="FieldInput">
							<input type="text" id="problemNumbers" name="问题编号：" field="problemNumbers"   style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反映人单位:</td>
						<td class="FieldInput">
							<input type="text" id="problemCompany" name="反映人单位:"  field="problemCompany"  maxlength="25" style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">反映人姓名：</td>
						<td class="FieldInput" >
							<input type="text" id="problemPerson" name="反映人姓名："  field="problemPerson"  maxlength="25" style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" >反映人数：</td>
						<td class="FieldInput" >
							<input type="text" id="personNumber" name="反映人数:"  field="personNumber"  maxlength="10" style="width:90%" disabled="disabled"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" >反映问题时间：</td>
						<td class="FieldInput" >
							<input type="text" id="problemDate" name="反映问题时间：" field="problemDate" format="Y-m-d" onclick="LoushangDate(this);" style="width:90%"disabled="disabled"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" >来源方式:</td>
						<td class="FieldInput" >
							<select id="problemFrom" name="来源方式:" field="problemFrom"  style="width:90%" disabled="disabled"><option dataset="problemFromDS"></option></select>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">是否督办件：</td>
						<td class="FieldInput" >
							<select  id="supervision" name="是否督办件：" field="supervision" style="width:90%" disabled="disabled" ><option dataset="supervisionDS"></option></select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反映内容：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="content" name="反映内容：" field="content" cols="15" rows="3" disabled="disabled"  style="width:90%"></textArea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">诉求内容：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="demands" name="诉求内容：" field="demands" cols="15" rows="3" disabled="disabled" style="width:90%;"></textArea>
						</td>
					</tr>

				   <tr>
						<td class="FieldLabel"><label>处理结果:</label></td>
						<td colspan="3" class="FieldInput">
							<input type="radio" id="dealFlag" name="处理结果" value="03" field="dealFlag" onclick="send_problem1();"/>办理<br>
					   		<input type="radio" id="dealFlag" name="处理结果" value="02" field="dealFlag" onclick="send_problem();"/>转办单位
					   		 <select  name="area1" id="area1" onchange="setDomicile()" ><option  dataset="domicileCityDataset"></option></select>
					     <select  name="area" id="area"  ><option  dataset="domicileDataset"></option></select>
						     	
					    </td>
				  </tr>
				  <tr>
						<td class="FieldLabel">处理情况：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="deal" name="处理情况：" field="deal" cols="15" rows="3" style="width:90%;"></textArea>
						</td>
				   </tr>
				  <tr>
						<td class="FieldLabel">受理人：</td>
						<td class="FieldInput" >
							<input type="text" id="dealPerson" name="处理人：" field="dealPerson" />
						</td>
						<td class="FieldLabel">受理时间：</td>
						<td class="FieldInput" colspan="5">
							<input type="text" id="dealTime" name="处理时间：" field="dealTime"  format="Y-m-d" onclick="LoushangDate(this);"  />
						</td>
				</tr>
				<tr>
						<td class="FieldLabel">附件</td>
						<td colspan="3">
							<div id="fileName"></div>
	           			</td>
           			</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>