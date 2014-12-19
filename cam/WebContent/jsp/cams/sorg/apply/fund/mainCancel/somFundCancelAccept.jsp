<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.*"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>基金会注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundCancelAccept.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var processId="<%=request.getParameter("processId")%>";
	var actDefUniqueId="<%=request.getParameter("actDefUniqueId")%>";
	var assignmentId="<%=request.getParameter("assignmentId")%>";
	var method="<%=request.getParameter("method") %>";
	var taskCode="";
	if(method=="INSERT"){
		taskCode="<%=SomIdHelp.getFundTaskCode()%>";
	}
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var act='<%=request.getParameter("act")%>';//环节名称
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require"/>
			<model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require"/>
			<model:field name="cancelDate" type="string" rule="require"/>
			<model:field name="cancelReason" type="string" rule="require|length{500}"/>
			<model:field name="liqResult" type="string" rule="require|length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd" global="true" sortField="IF_CHIEF" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="winLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople">
			<model:field name="name" type="string" rule="require|length{72}"/>
			<model:field name="liqDuties" type="string" rule="require|length{50}"/>
			<model:field name="ifChief" type="string" rule="require"/>
			<model:field name="workName" type="string" rule="length{100}"/>
			<model:field name="workDuties" type="string" rule="length{50}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic">
			<model:field name="fileName" type="string" rule="require|length{500}"/>
			<model:field name="fileMess" type="string" rule="require|length{100}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="winElectronicDataSet2" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic">
			<model:field name="fileMess" type="string" rule="require|length{500}"/>
			<model:field name="files" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_FUND_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_BUSINESS_ORGAN"></model:param>
			<model:param name="value" value="BORG_CODE"></model:param>
			<model:param name="text" value="BORG_NAME"></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifChiefSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>

</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="基金会注销登记"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<%
			if( !"supply".equals(request.getParameter("act")) ){	%>
				<next:ToolBarItem iconCls="print" text="打印受理通知书" handler="printAccept"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print" text="打印不予受理通知书" handler="printNoAccept"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<%

			}
		%>

			<next:ToolBarItem iconCls="select" text="提交" handler="submit" />
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="基金会注销登记申请表" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
							<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
								<table width="100%">
									<tr>
										<td class="FieldLabel" width="20%"><label>登记证号：</label></td>
										<td class="FieldInput" width="30%"><input id="sorgCode" field="sorgCode" name='"登记证号"' onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()" onblur="loadSorg()" style="width:50%"/><span style="color:red">*</span></td>
										<td class="FieldLabel" width="20%"><label>组织机构代码：</label></td>
										<td class="FieldInput" width="30%"><label field="organCode" name='"组织机构代码"'/></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会名称：</label></td>
										<td class="FieldInput"><label id='cnName'field="cnName" name='"基金会名称"'/></td>
										<td class="FieldLabel"><label>成立日期：</label></td>
										<td class="FieldInput"><label field="buildDate" name='"成立日期"'/></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会类型：</label></td>
										<td class="FieldInput">
											<select id="sorgKind" field="sorgKind" name='"基金会类型"' style="width:50%" disabled="disabled">
												<option dataset="sorgKindSelect" ></option>
											</select>
										</td>
										<td class="FieldLabel"><label>注销日期：</label></td>
										<td class="FieldInput"><input id="cancelDate" name='"注销日期"' field="cancelDate" format="Y-m-d" onclick="WdatePicker()" /><span style="color:red">*</span></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput"><label field="residence" name='"住所"'/></td>
										<td class="FieldLabel"><label>基金会电话：</label></td>
										<td class="FieldInput"><label field="sorgPhone" name='"基金会电话"'/></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>法定代表人：</label></td>
										<td class="FieldInput"><label field="legalPeople" name='"法定代表人"' /></td>
										<td class="FieldLabel"><label>业务主管单位：</label></td>
										<td class="FieldInput">
											<select id="borgName" field="borgName" name='"业务主管单位"' style="width:80%" disabled="disabled">
												<option dataset="businessOrganSelect" ></option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>注销原因：</label></td>
										<td class="FieldInput" colspan="3" ><textarea rows="3" id="cancelReason" name='"注销原因"' field="cancelReason" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>
						</fieldset>
						<fieldset>
							<legend>基金会履行内部程序</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:20%"><label>基金会履行内部程序：</label></td>
										<td class="FieldInput" colspan="3" ><textarea rows="3" id="process" name='"基金会履行内部程序"' field="process" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>
						</fieldset>
						<fieldset>
							<legend>业务主管单位审查意见</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:20%">业务主管单位审查意见：</td>
										<td class="FieldInput" colspan="3"><textarea rows="3" id="borgOpinion" name="业务主管单位审查意见" field="borgOpinion" style="width:93%" ></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>
						</fieldset>
						<fieldset>
							<legend>清算结论</legend>
							<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:20%"><label>清算结论（清算组织负责人签字）：</label></td>
										<td class="FieldInput" colspan="3" ><textarea rows="3" id="liqResult" name='"清算结论（清算组织负责人签字）"' field="liqResult" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>
						</fieldset>

						<%
						if( "supply".equals(request.getParameter("act")) ){
					%>
					<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">承办人意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">承办时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">承办补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet"  />
							</td>
							<td class="FieldLabel" style="width:17%">初审负责人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">初审时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">审核意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" />
							</td>
							<td class="FieldLabel" style="width:17%">审核人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审核时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">批准意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet"  />
							</td>
							<td class="FieldLabel" style="width:17%">批准人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">批准时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">批准补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
					</table>
					</form>
					</fieldset>
					<%
						}
					%>
					</next:Html>
				</next:Panel>

				<next:GridPanel id="gridLiqpeople" dataset="somLiqpeopleDataSet" title="清算组织人员" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="清算组织主要组成人员列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addLiqpeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="editLiqpeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delLiqpeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" hidden="true" />
						<next:Column header="姓名" field="name" width="10%" />
						<next:Column header="在清算组织中职务" field="liqDuties" width="25%" />
						<next:Column header="清算组织负责人" field="ifChief" dataset="ifChiefSelect" width="15%" />
						<next:Column header="工作单位" field="workName" width="18%" />
						<next:Column header="职务（职称）" field="workDuties" width="18%" />
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somLiqpeopleDataSet"/>
					</next:BottomBar>
				</next:GridPanel>

				<next:EditGridPanel id="uploadGrid" dataset="somElectronicDataSet" title="法律要件" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"></next:Column>
						<next:Column header="附件名称" field="fileName" width="30%" editable="false"></next:Column>
						<next:Column header="附件描述" field="fileMess" width="20%" editable="false"></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>

				<next:Panel title="处理意见" width="100%" height="100%">
					<next:Html>
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="15%"><label>处理意见：</label></td>
									<td class="FieldInput" width="85%">
										<select field="curOpinionId" name='"处理意见"'>
											<option dataset="opinionSelect"></option>
										</select><span style="color:red">*</span>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>处理补充意见：</label></td>
									<td class="FieldInput">
										<textarea rows="8" field="curOpinion" name='"处理补充意见"' style="width:90%"></textarea>
									</td>
								</tr>
							</table>
						</form>
					</next:Html>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>

<next:Window id="winLiqpeople" title="添加清算组织成员" width="650" height="100%" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	<next:Panel id="panelWinLiqpeople">
		<next:Html>
			<form id="formWinLiqpeople" method="post" dataset="winLiqpeopleDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="25%"><label>姓名：</label></td>
					<td class="FieldInput" width="25%"><input name='"姓名"' field="name" width="90%"/><span style="color:red">*</span></td>
					<td class="FieldLabel" width="25%"><label>清算组织负责人：</label></td>
					<td class="FieldInput" width="25%">
						<select name='"清算组织负责人"' field="ifChief" style="width:70%">
							<option dataset="ifChiefSelect" ></option>
						</select><span style="color:red">*</span>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>在清算组织中职务：</label></td>
					<td class="FieldInput" colspan="3"><input name='"在清算组织中职务"' field="liqDuties" style="width:90%"/><span style="color:red">*</span></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>工作单位：</label></td>
					<td class="FieldInput" colspan="3"><input name='"工作单位"' field="workName" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>职务（职称）：</label></td>
					<td class="FieldInput" colspan="3"><input name='"职务（职称）"' field="workDuties" style="width:90%"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="saveWinLiqpeople"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeWinLiqpeople"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>