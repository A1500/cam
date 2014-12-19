<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>问题处理信息管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="prsProblemDealInsert.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
			var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var method='<%=request.getParameter("method")%>';
			var problemId='<%=request.getParameter("problemId")%>';
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
	<model:dataset id="problemFromDS" enumName="PROBLEM_FROM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="supervisionDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dealFlagDS" enumName="DEAL_FLAG" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel id="problem_winPanel"  width="100%" height="100%" collapsible="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save_problem"/>
			<next:ToolBarItem iconCls="undo" text="返回" handler="return_problem"/>
		</next:TopBar>
		<next:Html>
			<form class="L5form" id="form_content" dataset="problemDealDS">
				<table width="100%">
					<tr >
						<td class="FieldLabel" >问题标题：</td>
						<td class="FieldInput">
							<input type="text" id="problemTitle" name="问题标题：" field="problemTitle"  maxlength="50"  style="width:90%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">问题编号：</td>
						<td class="FieldInput">
							<input type="text" id="problemNumbers" name="问题编号：" field="problemNumbers"   style="width:90%"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反映人单位:</td>
						<td class="FieldInput">
							<input type="text" id="problemCompany" name="反映人单位:"  field="problemCompany"  maxlength="25" style="width:90%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">反映人姓名：</td>
						<td class="FieldInput" >
							<input type="text" id="problemPerson" name="反映人姓名："  field="problemPerson"  maxlength="25" style="width:90%"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" >反映人数：</td>
						<td class="FieldInput" >
							<input type="text" id="personNumber" name="反映人数:"  field="personNumber"  maxlength="10" style="width:90%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" >反映问题时间：</td>
						<td class="FieldInput" >
							<input type="text" id="problemDate" name="反映问题时间：" field="problemDate" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style="width:90%"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" >来源方式:</td>
						<td class="FieldInput" >
							<select id="problemFrom" name="来源方式:" field="problemFrom"  style="width:90%"><option dataset="problemFromDS"></option></select>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">是否督办件：</td>
						<td class="FieldInput" >
							<select  id="supervision" name="是否督办件：" field="supervision" style="width:90%"  ><option dataset="supervisionDS"></option></select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反映内容：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="content" name="反映内容：" field="content" cols="15" rows="3"  style="width:90%"></textArea>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">诉求内容：</td>
						<td class="FieldInput" colspan="3">
							<textArea type="text" id="demands" name="诉求内容：" field="demands" cols="15" rows="3" style="width:90%;"></textArea>
							<font color="red">*</font>
						</td>
					</tr>
					 <tr>
						<td class="FieldLabel"><label>处理结果:</label></td>
						<td colspan="3" class="FieldInput">
						<input type="radio" id="dealFlag"  name="处理结果" field="dealFlag" value="01"  onclick="send_problem11();" />待办<br>
						<input type="radio" id="dealFlag"  name="处理结果" field="dealFlag" value="03" onclick="send_problem1();" />已办理<br>
					    <input type="radio" id="dealFlag" name="处理结果" field="dealFlag" value="02" onclick="send_problem();" />转办单位
					     <select  name="area1" id="area1" onchange="setDomicile()" ><option  dataset="domicileCityDataset"></option></select>
					     <select  name="area" id="area"  ><option  dataset="domicileDataset"></option></select>
					     <font color="red">*</font>
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
							<input type="text" id="dealTime" name="处理时间：" field="dealTime"  format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/>
						</td>
				</tr>
				<tr><td class="FieldLabel">附件</td>
					<td colspan="3">
					<input type=button value="添加" onclick="add_row()" style="CURSOR: hand"><span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>