<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>城市低保家庭查询</title>
		<next:ScriptManager />
		<script type="text/javascript" src="queryFamilyAction.js"></script>
		<script type="text/javascript" src="../../comm/samInfoDetailComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
		<script type="text/javascript">
		    <%
		    	String organArea=BspUtil.getCorpOrgan().getOrganCode();
		    String opreateName=BspUtil.getCorpOrgan().getOrganName();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
			
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
			var opreateName='<%=opreateName%>';
		</script>
	</head>
	<body>
		<model:datasets>
			<!-- 业务信息 -->
			<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
				<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
				</model:record>
			</model:dataset>
			<!-- 业务信息供身份证查询用 -->
			<model:dataset id="applyQueryDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
				<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
				</model:record>
			</model:dataset>
			
			<!-- 基础信息_家庭信息 -->
			<model:dataset id="baseinfoFamilyDS" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" method="querySamFamilyListForRecheck" pageSize="15" global="true">
				<model:params>
					<model:param name="assistanceType" value='01'></model:param>
					<model:param name="applyType" value='013'></model:param>
				</model:params>
			</model:dataset>
			
			<!-- 家庭基本信息 -->
			<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.archive.baseinfofamilyarchive.cmd.BaseinfoFamilyArchiveQueryCmd" global="true"  >
				<model:record fromBean="com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive">
				</model:record>
			</model:dataset>
			
			
			<!-- 查询人员身份证号用 -->
			<model:dataset id="cardNumDs" cmd="com.inspur.cams.drel.archive.baseinfopeoplearchive.cmd.BaseinfoPeopleArchiveQueryCmd" global="true" pageSize='-1'>
				<model:record fromBean="com.inspur.cams.drel.archive.baseinfopeoplearchive.data.BaseinfoPeopleArchive"></model:record>
			</model:dataset>
			
			<!-- 分类施保类别 -->
			<model:dataset id="samAssistanceItemList" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
					<model:param name="value" value='ITEM_CODE'></model:param>
					<model:param name="text" value='ITEM_NAME'></model:param>
				</model:params>
			</model:dataset>
			<!-- 救助对象类型 -->
			<model:dataset id="AssistanceDataset" autoLoad="true"
				cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
					<model:param name="value" value='CODE'></model:param>
					<model:param name="text" value='NAME'></model:param>
					<model:param name="includeCode" value='01,02,03'></model:param>
				</model:params>
			</model:dataset>
			<!-- 主要致贫原因 -->
			<model:dataset id="provertyCause" enumName="SAM_CITY_PROVERTY_CAUSE"
				autoLoad="true" global="true"></model:dataset>
			<!-- 分类施保类别 -->
			<model:dataset id="asisstanceClassDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
					<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
					<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
				</model:params>
			</model:dataset>
			<!-- 分类施保类别 -->
			<model:dataset id="asisstanceClassDataset1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" autoLoad="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
					<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
					<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
					<model:param name="ASSISTANCE_TYPE" value="01" />
				</model:params>
			</model:dataset>
			<!-- 复查结果 -->
    		<model:dataset id="samRecheckResultDs" enumName="SAM.RECHECK.RESULT" autoLoad="true" global="true"></model:dataset>
		</model:datasets>
		<next:Panel name="form" width="100%" border="0">
			<next:Html>
				<fieldset><legend>查询条件</legend>
				<div>
				<form class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">地区</td>
						<td class="FieldInput" width="25%">
							<input type="text" id="domicileName" name="domicileName" readonly="readonly" style="width: 180px" />
								<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor: hand" onclick="func_ForDomicileSelect()" />
							<input type="text" id="domicileCode" name="domicileCode" style="display: none" />
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">低保证号</td>
						<td class="FieldInput" width="25%">
							<input id="cardNo" name="cardNo" style="width: 180px" />
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">户主姓名</td>
						<td class="FieldInput" width="25%">
							<input type="text" name="familyName" id="familyName" style="width: 180px" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">身份证号码</td>
						<td class="FieldInput" width="25%">
							<input type="text" name="familyCardNo" id="familyCardNo" style="width: 180px" onchange="checkIDCard(this)"/>
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">家庭人口数</td>
						<td class="FieldInput" width="25%">
							<input type="text" id="sPeopleNum" name="sPeopleNum" style="width: 52px" />
							~
							<input type="text" id="ePeopleNum" name="ePeopleNum" style="width: 52px" />
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">主要致贫原因</td>
						<td class="FieldInput" width="25%">
							<select name="povertyCause" id="povertyCause" style="width: 180px">
								<option dataset="provertyCause"></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">救助对象类型</td>
						<td class="FieldInput" width="25%">
							<select disabled id="assistanceType_treatment" style="width: 180px">
								<option dataset="AssistanceDataset"></option>
							</select>
						</td>
						<td class="FieldLabel" nowrap="nowrap">分类施保类别</td>
						<td class="FieldInput">
							<select name="assistanceClass" id="assistanceClass" style="width: 180px">
								<option dataset="<%if("00000000".equals(organArea.substring(4, 12))){
								%>samAssistanceItemList<%}else{%>asisstanceClassDataset<%}%>"></option>
							</select>
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">救助对象年龄段</td>       
						<td class="FieldInput" width="25%">
						 	<input type="text" id="sAge" name="sAge" style="width: 52px" />         
			   
							<input type="text" id="eAge" name="eAge" style="width: 52px" />
						</td>
					</tr>
					<tr>
				    	<td class="FieldLabel" width="8%">家庭类型</td>
						<td class="FieldInput" >
					    	<input type="text" id='assistanceTypeName' style="width:85%" readOnly="true" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
							<input type="hidden" id='assistanceType'>
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">享受年月</td>
						<td class="FieldInput" width="25%">
							<input type="text" id="assistanceBegin" name="assistanceBegin" readonly="readonly" onclick="setmonth(this)"  style="width: 180px;padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
						</td>
						<td class="FieldLabel" width="8%">是否疑似</td>
						<td class="FieldInput" >
					    	<select id = 'isSuspect'>
					    		<option >请选择...</option>
					    		<option value = '0'>否</option>
					    		<option value = '1' selected="selected">是</option>
					    	</select>
						</td>
					</tr>
						
					<tr>
						<td nowrap="nowrap" class="FieldButton" colspan="6">
							<button id="queryId" onclick="query()">查询</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button onclick="resetQuery()">重置</button>
						</td>
					</tr>
				</table>
				</form>
				</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="infoQueryGrid" name="baseinfoFamilyResource"
			stripeRows="true" height="100%" width="100%" dataset="baseinfoFamilyDS" clickToSelectedForChkSM="true">
			<next:TopBar>
				<next:ToolBarItem id="qrToolbar" text="城市低保家庭查询信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail"  text="登记" handler="handle"/>
				<next:ToolBarItem iconCls="detail"  text="批量登记" handler="batchHandle"/>
				<next:ToolBarItem iconCls="stop" id = "ignore"  text="忽略" handler="ignore" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" id = "detail"  text="查看家庭核对信息" handler="peopleDetail" ></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
	    		<next:RowNumberColumn />
	    		<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="地区" field="DOMICILE_FULL_NAME" width="200" align="left" >
					<next:TextField />
				</next:Column>
				
				<next:Column header="户主姓名" field="FAMILY_NAME" width="80" align="left" renderer="detailHref">
					<next:TextField />
				</next:Column>
				<next:Column header="身份证号" field="FAMILY_CARD_NO" width="135" 	align="center"  hidden="true">
					<next:TextField />
				</next:Column>
				<next:Column header="低保证号" field="CARD_NO" width="130" align="left">
					<next:TextField />
				</next:Column>
				<next:Column header="主要致贫原因" field="POVERTY_CAUSE" width="100" align="center" dataset="provertyCause"  hidden="true">
					<next:TextField />
				</next:Column>
				<next:Column header="家庭人口数" field="PEOPLE_NUM" width="90" align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="90" align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="保障金额（元）" field="ASSISTANCE_MONEY" width="100"	align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
				<next:Column header="低保金加发类别" field="ASSISTANCE_CLASS" width="100" dataset="asisstanceClassDataset1" align="left" >
					<next:TextField />
				</next:Column>
				<next:Column header="低保金加发金额（元）" field="ASSISTANCE_CLASS_MONEY" width="100" align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
				<next:Column header="起始保障年月" field="BEGIN_DATE" width="100"	align="left">
					<next:TextField />
				</next:Column>
				<next:Column header="家庭住址" field="ADDRESS" width="300" align="left"  >
					<next:TextField />
				</next:Column>
				<next:Column header="联系电话" field="FAMILY_MOBILE" width="100"	align="left" >
					<next:TextField />					
				</next:Column>
				<next:Column header="上次复查时间" field="RECHECK_TIME" width="100" align="left" >
					<next:TextField />
				</next:Column>
				<next:Column header="距离上次复查已过天数" field="RECHECK_DAYS" width="100" align="right" >
					<next:TextField />
				</next:Column>
				<next:Column header="复查人" field="RECHECK_PEOPLE_NAME" width="100"	align="left" >
					<next:TextField />
				</next:Column>
				<next:Column header="复查单位" field="RECHECK_ORGAN_NAME" width="100" align="left" >
					<next:TextField />
				</next:Column>
				<next:Column header="复查结果" field="RECHECK_RESULT" width="100" align="left" dataset="samRecheckResultDs">
					<next:TextField />
				</next:Column>
				<next:Column header="业务主键" field="ENSURE_ID" width="100" align="left"  hidden="true">
					<next:TextField />
				</next:Column>
				<next:Column header="核查单位" field="ENSURE_UNIT" width="100" align="left" >
					<next:TextField />
				</next:Column>
				<next:Column header="反馈时间" field="FEEDBACK_TIME" width="100" align="left" >
					<next:TextField />
				</next:Column>
				<next:Column header="反馈结果" field="FEEDBACK_RESULT" width="100" align="left" >
					<next:TextField />
				
				</next:Column>
				<next:Column header="当前标示" field="CURRENT_STATUS" width="100" align="left"  renderer="getCheckFlag">
					<next:TextField />
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="baseinfoFamilyDS" />
			</next:BottomBar>
		</next:GridPanel>

<jsp:include page="../../../comm/assistanceType.jsp" flush="true">
	<jsp:param name= "assistanceType" value= "01"/> 
</jsp:include>			
<!-- 忽略信息窗口-->
<next:Window id="ignoreWin" closeAction="hide" title="忽略信息窗口"
	height="260" width="450" modal="true" modal="true">
	<next:Panel width="98%" height="100%" border="0" autoScroll="true" autoHeight="true" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="yes" text="确定" handler="ignoreConfirm"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<table width="100%">
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">操作人：</td>
						<td class="FieldInput" width="25%">
							<input type="text" id="operator" disabled name="operator"  />
						</td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">操作日期：</td>
						<td class="FieldInput" width="25%">
							<input id="operateTime" name="operateTime" disabled    />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">理由：</td>
						<td class="FieldInput" colspan="3" width="25%">
							<textArea type="text" id="ignoreReason" style="width:100%;height:150" name="ignoreReason"  ></textArea>
						</td>
					</tr>
				</table>
			</next:Html>
	</next:Panel>
</next:Window>
	</body>
</html>