<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils,com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<head>
<title>低保低收入家庭信息核对列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="samSureyCheckList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
     var organId='<%=BspUtil.getCorpOrganId()%>';
     var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
     var userId='<%=BspUtil.getEmpOrgan().getOrganId()%>';
     var userName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
     var activeTable='<%=StrUtil.n2b(request.getParameter("activeTable"))%>';
	     //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){	
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';	
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";				
			element.expand =true;
		}
	}
</script>
</head>
	
<body>
<model:datasets>
    <model:dataset id="samSureyDS" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyQueryCmd"  >
      <model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSurey">
      </model:record>
	</model:dataset>
	<!-- 待办 -->
    <model:dataset id="todoSamSureyWfDS" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" method="initialQuery">
      <model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSureyWf">
      </model:record>
	</model:dataset>
	<!-- 已办 -->
	<model:dataset id="doneSamSureyWfDS" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" method="initialQuery">
      <model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSureyWf">
      </model:record>
	</model:dataset>
	<model:dataset id="SamSureyWfHisDS" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfHisQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.surey.comm.data.SamSureyWfHis">
		</model:record>
	</model:dataset>
	<model:dataset id="SamSureyWfAssistanceHisDS" cmd="com.inspur.cams.drel.surey.assistance.cmd.SamSureyWfAssistanceHisQueryCmd" method="queryByFlowId">
		<model:record fromBean="com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis">
		</model:record>
	</model:dataset>
	<!-- 核对结果 -->
	<model:dataset id="SurveyTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_TYPE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 低保核对结果 -->
	<model:dataset id="miniAssistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 低收入核对结果 -->
	<model:dataset id="lowAssistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 环节意见 -->
	<model:dataset id="opinionCodeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_OPINION_CODE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 申请核对项目 -->
	<model:dataset id="assistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>	
	<!--属地-->
	<model:dataset id="domicileDataset" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:FitLayout>
		<next:TabPanel id="surey_check_tab" border="false">
			<next:Tabs>
			<!-- 待办列表 -->
			
			<next:Panel title="待办任务列表" width="100%" height="100%">
				<next:Panel width="100%" border="0">	
					<next:Html>
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form class="L5form">
								<table border="1" width="100%">
									<tr>
										<td class="FieldLabel" width="15%">姓名:</td>
										<td class="FieldInput" width="30%"><input type="text" id="name" maxlength="15" class="TextEditor" /></td>
										<td class="FieldLabel" width="15%">身份证号:</td>
										<td class="FieldInput" width="30%"><input type="text" id="idCard" maxlength="18"  style="width: 80%" field="身份证号" class="TextEditor" /></td>
										<td class="FieldButton" width="10%">
											<button onclick="query()">查 询</button>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">核对项目:</td>
										<td class="FieldInput">
											<select id="assistanceType" name="assistanceType">
												<option dataset="assistanceTypeDS"></option>
											</select>
										</td>
										<td colspan="2" class="FieldInput"></td>
										<td class="FieldButton">
											<button onclick="reset()">重 置</button>
										</td>
									</tr>
									<tr>
								<td class="FieldInput" colspan="5"><font color="red" size="2">*说明:办理后请到经办任务列表移交</font></td>
							</tr>
								</table>
							</form>
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>	
				<next:GridPanel id="surey_todo_grid" name="surey_todo_grid"   dataset="todoSamSureyWfDS" title="待办任务列表" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem text="办理" iconCls="select"  handler="sureyCheck"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
					     <next:RowNumberColumn width="18"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="flowId" header="流程ID" field="flowId" width="10%" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="surveyId" header="核对流水ID" field="surveyId" width="10%" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="applyTitle" header="申请核对名称" field="applyTitle" width="20%" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="name" header="申请人姓名" field="name" width="10%">
							<next:TextField />
						</next:Column>
						<next:Column id="idCard" header="身份证号码" field="idCard" width="20%">
							<next:TextField />
						</next:Column>
						<next:Column id="assistanceType" header="核对项目" field="assistanceType" dataset="assistanceTypeDS" width="10%" >
							<next:TextField />
						</next:Column>
						<next:Column id="preActivityOrganName" header="上一环节单位" field="preActivityOrganName"  width="20%" >
							<next:TextField />
						</next:Column>
						<next:Column id="curActivitySt" header="接收时间" field="curActivitySt" width="20%" >
							<next:TextField />
						</next:Column>
					    <next:Column id="curActivityArea" header="行政区划" field="curActivityArea"  width="20%" >
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
							<next:PagingToolBar dataset="todoSamSureyWfDS"  />
					</next:BottomBar>
				</next:GridPanel>						
			</next:Panel>			
			
			<!-- 已办列表 -->
			<next:Panel title="经办任务列表" width="100%" height="100%">
				<next:Panel width="100%" border="0" >	
					<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form class="L5form">
								<table border="1" width="100%">
									<tr>
										<td class="FieldLabel" width="15%">姓名:</td>
										<td class="FieldInput" width="30%"><input type="text" id="nameYiban" maxlength="15" class="TextEditor" /></td>
										<td class="FieldLabel" width="15%">身份证号:</td>
										<td class="FieldInput" width="30%"><input type="text" id="idCardYiban" maxlength="18"  style="width: 80%" field="身份证号" class="TextEditor" /></td>
										<td class="FieldButton" width="10%">
											<button onclick="queryYiban()">查 询</button>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">核对项目:</td>
										<td class="FieldInput">
											<select id="assistanceTypeYiban" name="assistanceType">
												<option dataset="assistanceTypeDS"></option>
											</select>
										</td>
										<td class="FieldInput" colspan="2"></td>
										<td class="FieldButton">
											<button onclick="reset()">重 置</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>	
				<next:GridPanel id="surey_done_grid" name="surey_done_grid"   dataset="doneSamSureyWfDS" title="经办任务列表" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem text="移交" iconCls="edit"  handler="transfer"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
					     <next:RowNumberColumn width="18"/>
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column id="applyTitle" header="申请核对名称" field="applyTitle" width="20%" >
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="name" header="申请人姓名" field="name" width="10%">
							<next:TextField />
						</next:Column>
						<next:Column id="idCard" header="身份证号码" field="idCard" width="20%">
							<next:TextField />
						</next:Column>
						<next:Column id="assistanceType" header="核对项目" field="assistanceType" dataset="assistanceTypeDS" width="10%" >
							<next:TextField />
						</next:Column>
						<next:Column id="preActivityOrganName" header="上一环节单位" field="preActivityOrganName"  width="15%" >
							<next:TextField />
						</next:Column>
						<next:Column id="nextActivityOrganName" header="下一环节单位" field="nextActivityOrganName"  width="15%" >
							<next:TextField />
						</next:Column>
						<next:Column id="curActivitySt" header="接收时间" field="curActivitySt" width="20%" >
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
							<next:PagingToolBar dataset="doneSamSureyWfDS"  />
					</next:BottomBar>
				</next:GridPanel>						
			</next:Panel>		

			</next:Tabs>
		</next:TabPanel>
	</next:FitLayout>
</next:ViewPort>

<!-- 低保 -->
<next:Window id="mininum_win" title="低保办理窗口" closeAction="hide" height="370" width="520" collapsible="false" resizable="false" border="false"   autoScroll="true">
		<next:FitLayout>
		<next:Panel autoWidth="true" autoHeight="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save" handler="save_mininnum"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="delete" handler="close_mininum"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" >
			<input type="hidden" id="mini_flowId" />
			<input type="hidden" id="mini_sureyId" />
			<input type="hidden" id="mini_domicileCode" />
			<input type="hidden" id="mini_apanageCode" />
			<input type="hidden" id="mini_flag"> 
			<table>
				<tr>
					<td class="FieldLabel" width="120px">姓名：</td>
					<td class="FieldInput" width="140px"><label id="mini_name" name="姓名" ></label></td>

					<td class="FieldLabel"  width="120px">身份证号码：</td>
					<td class="FieldInput"  width="140px"><label id="mini_idCard" name="身份证号码"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" >户籍地：</td>
					<td class="FieldInput" ><select id="mini_domicile" disabled="disabled"><option dataset="domicileDataset"></option></select></td>

					<td class="FieldLabel" >居住地：</td>
					<td class="FieldInput" ><select id="mini_apanage" disabled="disabled"><option dataset="domicileDataset"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel" >核对单位：</td>
					<td class="FieldInput"><input type="text" id="mini_surveyOrganName" name="核对单位" disabled="disabled" readonly="readonly"/></td>
				
					<td class="FieldLabel" >核对日期：</td>
					<td class="FieldInput"><input type="text" id="mini_surveyDate" name="核对日期" readonly="readonly" disabled="disabled" format="Y-m-d" onclick="LoushangDate(this);"/></td>
				</tr>
				<tr> 				
					<td class="FieldLabel" >核对结果：</td>
					<td class="FieldInput"><select  id="mini_surveyResult" name="核对结果" disabled="disabled"  onchange="showMiniResult(this.options[this.options.selectedIndex]);" ><option dataset="miniAssistanceTypeDS"></option></select></td>

					<td class="FieldLabel" ></td>
					<td class="FieldInput"></td>
				</tr>
				<tr>
					<td class="FieldLabel" >低保证发证机关：</td>
					<td class="FieldInput"><input type="text" id="mini_signOrgan" name="低保证发证机关" disabled="disabled"/></td>

					<td class="FieldLabel" >低保证发证日期：</td>
					<td class="FieldInput"><input type="text" id="mini_signDate" name="低保证发证日期" disabled="disabled" readonly="readonly" format="Y-m-d" onclick="LoushangDate(this);"/></td>
				</tr>
				<tr style="display:none">
					<td class="FieldLabel"><label>处理结果:</label></td>
					<td colspan="3" class="FieldInput">
						<input type="radio" id="mini_dealResult"  name="处理结果"  value="ED" disabled="disabled" onclick="mini_dealEnd(this.value);" />办理完结<br>
					    <div  id="mini_dealResultStyle"><input type="radio" id="mini_dealResult2" name="处理结果"  value="TR" disabled="disabled" onclick="mini_transmit(this.value);" />转办</div> 
					</td>
			   </tr>
			   <tr>
					<td class="FieldLabel" >补充意见：</td>
					<td class="FieldInput" colspan="3"><textArea id="mini_opinion" name="补充意见：" cols="8" rows="1"  style="width:90%"></textArea></td>
				</tr>
			</table>
			</form>
		</next:Html>
		</next:Panel>	
			
				</next:FitLayout>
</next:Window>
<!-- 低收入 -->
<next:Window id="lowIncome_win" title="低收入办理窗口" closeAction="hide" height="370" width="520" collapsible="false" resizable="false" border="false" autoScroll="true">
		<next:FitLayout>
		<next:Panel autoWidth="true" autoHeight="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save" handler="save_lowIncome"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="delete" handler="close_lowIncome"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" >
			<input type="hidden" id="lowIncome_flowId" />
			<input type="hidden" id="lowIncome_sureyId" />
			<input type="hidden" id="lowIncome_domicileCode" />
			<input type="hidden" id="lowIncome_apanageCode" />
			<input type="hidden" id="lowIncome_flag"> 
			<table>
				<tr>
					<td class="FieldLabel" width="110px">姓名：</td>
					<td class="FieldInput" width="140px"><label id="lowIncome_name" name="姓名" ></label></td>

					<td class="FieldLabel"  width="110px">身份证号码：</td>
					<td class="FieldInput"  width="140px"><label id="lowIncome_idCard" name="身份证号码"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" >户籍地：</td>
					<td class="FieldInput" ><select id="lowIncome_domicile" disabled="disabled"><option dataset="domicileDataset"></option></select></td>

					<td class="FieldLabel" >居住地：</td>
					<td class="FieldInput" ><select id="lowIncome_apanage" disabled="disabled"><option dataset="domicileDataset"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel" >核对单位：</td>
					<td class="FieldInput"><input type="text" id="lowIncome_surveyOrganName" name="核对单位" disabled="disabled" readonly="readonly"/></td>
				
					<td class="FieldLabel" >核对日期：</td>
					<td class="FieldInput"><input type="text" id="lowIncome_surveyDate" name="核对日期" disabled="disabled" readonly="readonly" format="Y-m-d" onclick="LoushangDate(this);"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >核对结果：</td>
					<td class="FieldInput"><select id="lowIncome_surveyResult" name="核对结果" disabled="disabled"  onchange="showLowResult(this.options[this.options.selectedIndex]);"><option dataset="lowAssistanceTypeDS"></option></select></td>
						
					<td class="FieldLabel" ></td>
					<td class="FieldInput"></td>
				</tr>
				<tr>
					<td class="FieldLabel" >低收入认定单位：</td>
					<td class="FieldInput"><input type="text" id="lowIncome_signOrgan" name="低保证发证机关" disabled="disabled"/></td>

					<td class="FieldLabel" >低收入认定日期：</td>
					<td class="FieldInput"><input type="text" id="lowIncome_signDate" name="低保证发证日期" disabled="disabled" readonly="readonly" format="Y-m-d" onclick="LoushangDate(this);"/></td>
				</tr>
				<tr style="display:none">
					<td class="FieldLabel"><label>处理结果:</label></td>
					<td colspan="3" class="FieldInput">
						<input type="radio" id="lowIncome_dealResult"  name="处理结果"  value="ED" disabled="disabled" onclick="lowIncome_dealEnd(this.value);" />办理完结<br>
					    <div  id="lowIncome_dealResult2" style="display:none"><input type="radio" id="lowIncome_dealResult3" name="处理结果"  value="TR"  onclick="lowIncome_transmit(this.value);" />转办</div> 
					</td>
			   </tr>
			   <tr>
					<td class="FieldLabel" >补充意见：</td>
					<td class="FieldInput" colspan="3"><textArea id="lowIncome_opinion" name="补充意见：" cols="8" rows="1"  style="width:90%"></textArea></td>
				</tr>
			</table>
			</form>
		</next:Html>
		</next:Panel>	
			
		</next:FitLayout>
</next:Window>
</body>
</html>