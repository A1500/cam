<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市社区服务填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcServiceInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="serviceReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceReport"/>
	</model:dataset>
	<model:dataset id="serviceInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceInfoQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R07'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="serviceTypeDataSet" enumName="CDC.SERVICE.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="serviceModeDataSet" enumName="CDC.SERVICE.MODE" autoLoad="true" global="true"/>
	<model:dataset id="serviceContentDataSet" enumName="CDC.SERVICE.CONTENT" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="serviceReportDataSet" onsubmit="return false" class="L5form">
<next:EditGridPanel id="grid" dataset="serviceInfoDataSet" width="99%" stripeRows="true" height="400" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="addService"/>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateService"/>
		<next:ToolBarItem iconCls="delete" text="删除" handler="deleteService"/>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn/>
		<next:Column field="serviceName" header="名称" width="10%" sortable="false"/>
		<next:Column field="serviceType" header="服务类型" width="8%" sortable="false"><next:ComboBox dataset="serviceTypeDataSet"/></next:Column>
		<next:Column field="morgName" header="主管单位" width="10%" editable="false" sortable="false" />
		<next:Column field="serviceAdds" header="服务地点" width="10%" sortable="false"/>
		<next:Column field="peopleNum" header="人数" width="20%" align="right" sortable="false"/>
		<next:Column field="foundDate" header="成立时间" width="10%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="serviceInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:31%">填报单位：</td>
			<td class="FieldInput" style="width:22%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:24%">填报日期：</td>
			<td class="FieldInput" style="width:31%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区服务状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="5">公共服务</td>
			<td class="FieldLabel" style="width:10%" colspan="2">开展服务社区数：</td>
			<td class="FieldInput" style="width:14%"><label field="serviceNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:6%" rowspan="3">服务方式：</td>
			<td class="FieldLabel" style="width:10%">现场办理项目数：</td>
			<td class="FieldInput" style="width:15%"><label field="publicLocaleNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">一站式服务大厅数：</td>
			<td class="FieldInput"><label field="onceNum" renderer="gRender"/></td>
			<td class="FieldLabel">全程代理项目数：</td>
			<td class="FieldInput"><label field="publicSupplyNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">服务项目数：</td>
			<td class="FieldInput"><label field="publicNum" renderer="gRender"/></td>
			<td class="FieldLabel">其他项目数：</td>
			<td class="FieldInput"><label field="publicOtherNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">主管单位总数：</td>
			<td class="FieldInput"><label field="publicMorgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:6%" rowspan="2">服务时间：</td>
			<td class="FieldLabel">全天项目数：</td>
			<td class="FieldInput"><label field="publicDayNum" renderer="gRender"/></td>
		</tr>
			<tr>
			<td class="FieldLabel" colspan="2">服务人员数：</td>
			<td class="FieldInput"><label field="publicPeopleNum" renderer="pRender"/></td>
			<td class="FieldLabel">非全天项目数：</td>
			<td class="FieldInput"><label field="publicNotdayNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="3">便民利民服务</td>
			<td class="FieldLabel" style="width:13%" colspan="2">项目数：</td>
			<td class="FieldInput" style="width:14%"><label field="facilitateNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">服务场所总面积：</td>
			<td class="FieldInput" style="width:15%"><label field="facilitateArea" renderer="aRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">主管单位数：</td>
			<td class="FieldInput" style="width:14%"><label field="facilitateMorgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">24小时服务项目数：</td>
			<td class="FieldInput" style="width:15%"><label field="facilitateDayNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">服务人员：</td>
			<td class="FieldInput" style="width:14%" colspan="4"><label field="facilitatePeopleNum" renderer="pRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="5">志愿者服务</td>
			<td class="FieldLabel" style="width:7%" rowspan="4">志愿者组织：</td>
			<td class="FieldLabel" style="width:7%">总数：</td>
			<td class="FieldInput" style="width:14%"><label field="voluntNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">当年成立数量：</td>
			<td class="FieldInput" style="width:15%"><label field="voluntYearNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对儿童个数：</td>
			<td class="FieldInput" style="width:14%"><label field="voluntChildNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%"colspan="2">针对残疾人个数：</td>
			<td class="FieldInput" style="width:15%"><label field="voluntHandiNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对老年人个数：</td>
			<td class="FieldInput" style="width:14%"><label field="voluntOldNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">针对困难群众个数：</td>
			<td class="FieldInput" style="width:15%"><label field="voluntDiffNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对其他个数：</td>
			<td class="FieldInput" colspan="4"><label field="voluntOtherNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:6%" >志愿者：</td>
			<td class="FieldLabel" style="width:7%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label field="volunteerNum" renderer="pRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">注册人数：</td>
			<td class="FieldInput" style="width:15%"><label field="regNum" renderer="pRender"/></td>
		</tr>
	</table>
</form>
</next:Html>
</next:Panel>

<next:Window id="detailWin" title="社区服务" resizable="false" width="800" height="300" modal="true" closable="false"  closeAction="hide" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="serviceInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>社区服务信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" >服务类型：</td>
			<td class="FieldInput" >
				<select field="serviceType" id = "serviceType" onchange="serviceTypeChange()">
					<option dataset="serviceTypeDataSet"/>
				</select> <font color="red">*</font>
			</td>
		</tr>
		<tr id = "public"  >
		<td colspan="2">
			<table width="100%">
				<tr  >
					<td class="FieldLabel">名称：</td>
					<td class="FieldInput"><input type="text"  name = "名称"  field="serviceName" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">服务内容：</td>
					<td class="FieldInput"><input type="text" name = "服务内容"  field="content" maxlength="30" /> <font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel">主管单位：</td>
					<td class="FieldInput"><input type="text" name = "主管单位"  field="morgName" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">服务方式：</td>
					<td class="FieldInput"><select field = "serviceMode" ><option dataset = "serviceModeDataSet"></option> </select> <font color="red">*</font>  </td>
				</tr>
				<tr >
					<td class="FieldLabel">负责人：</td>
					<td class="FieldInput"><input type="text" name = "负责人"  field="headmen" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">是否全天服务：</td>
					<td class="FieldInput"><select field = "serviceTime" ><option dataset = "YorN"></option> </select> <font color="red">*</font>  </td>
				</tr>
				<tr >
					<td class="FieldLabel">服务地点：</td>
					<td class="FieldInput"><input type="text" name = "服务地点"  field="serviceAdds" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">服务人员数</td>
					<td class="FieldInput"><input type="text" name = "服务人员数（个）"  field="peopleNum" onchange="forcheck(this)" maxlength="30" /> <font color="red">*</font></td>
				</tr>
			</table>
		</td>
		</tr>
		<tr id = "benefit"  style="display: none;" >
		<td colspan="2">
			<table width="100%">
				<tr  >
					<td class="FieldLabel">名称：</td>
					<td class="FieldInput"><input type="text" name = "名称"  field="serviceName" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">服务内容：</td>
					<td class="FieldInput"><input type="text" name = "服务内容"  field="content" maxlength="30" /> <font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel">主管单位：</td>
					<td class="FieldInput"><input type="text" name = "主管单位"  field="morgName" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">负责人：</td>
					<td class="FieldInput"><input type="text" name = "负责人"  field="headmen" maxlength="30" /> <font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel">服务性质：</td>
					<td class="FieldInput"><input type="text" name = "服务性质"  field="serviceKind" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">从业人员数：</td>
					<td class="FieldInput"><input type="text" name = "从业人员数（个）"  field="peopleNum" maxlength="30"  onchange="forcheck(this)"/> <font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel">服务地点：</td>
					<td class="FieldInput"><input type="text" name = "服务地点"  field="serviceAdds" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">服务场所面积（㎡）：</td>
					<td class="FieldInput"><input type="text" name = "服务场所面积"  field="serviceArea" onchange="fordecimalcheck(this)" maxlength="30" /> <font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel">是否24小时服务：</td>
					<td class="FieldInput"><select id = "serviceTime" field = "serviceTime"><option dataset = "YorN"></option> </select> <font color="red">*</font> </td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
			</table>
		</td>
		</tr>
		<tr id = "volunteer"  style="display: none;" >
		<td colspan="2">
			<table width="100%">
				<tr  >
					<td class="FieldLabel">名称：</td>
					<td class="FieldInput"><input type="text" name = "名称"  field="serviceName" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel">服务内容：</td>
					<input type="text" name = "服务sss内容" style="visibility: hidden" field="content" maxlength="30" />
					<td class="FieldInput"><select name = "服务内容" id="serviceContent"  field="contents"><option dataset ="serviceContentDataSet"></option> </select> <font color="red">*</font> </td>
				</tr>
				<tr >
					<td class="FieldLabel">服务性质：</td>
					<td class="FieldInput"><input type="text" name = "服务性质"  field="serviceKind" maxlength="30" /></td>
					<td class="FieldLabel">成立时间：</td>
					<td class="FieldInput"><input type="text" name = "成立时间"  field="foundDate"  readonly="readonly" format="Y-m-d" onclick="LoushangDate(this)" /> <font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel">志愿者总人数（个）：</td>
					<td class="FieldInput"><input type="text" name = "志愿者总人数"  field="peopleNum" maxlength="30" onchange="forcheck(this)" /> <font color="red">*</font></td>
					<td class="FieldLabel">注册志愿者人数（个）：</td>
					<td class="FieldInput"><input type="text" name = "注册志愿者人数"  field="registeNum" maxlength="30" onchange="forcheck(this)" /> <font color="red">*</font></td>
				</tr>
			</table>
		</td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
</body>
</html>