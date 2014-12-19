<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<html>
<head>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="../backspace.js"></script>
<script type="text/javascript" src="fisCemeCityCheck.js"></script>
<script language="javascript">
<%	
	String cemeApplyId=request.getParameter("primaryKey");
	String primaryKey=request.getParameter("primaryKey");
	//System.out.println(primaryKey);
	if(primaryKey==null)
		primaryKey="";
	String assignmentId=(String)request.getParameter("assignmentId");
	String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
	String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
	//然调用接口
	WfQuery wfQuery = new WfQuery();
	//List<Map> list = wfQuery.getActButtons(actDefUniqueId);
	List<Map> list1=wfQuery.getActFields(actDefUniqueId);

	Map actMap = wfQuery.getActivityDefInfoByActDefUniqueId(actDefUniqueId);
	String actDefName = (String)actMap.get("actDefName");
	//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
	//如果域是只读的则显示为只读
	//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
	String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
	//boolean isHidden,isReadOnly,isNotNull;
%>
		var createTime = '<%=DateUtil.getTime()%>';
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
		//新的打分ID
		var newScoreId = '<%=IdHelp.getUUID32()%>';
		//新的流程历史ID
		var newHisId = '<%=IdHelp.getUUID32()%>';
		//公墓编号
		var organId='<%=request.getParameter("organId")%>';
		//新增、修改
		var recordId='<%=request.getParameter("recordId")%>';
		var cemeApplyId='<%=request.getParameter("primaryKey")%>';
		var assignmentId='<%=assignmentId%>';
		var actDefName = '<%=actDefName%>';
		
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
	<!-- 年检结果枚举 -->
	<model:dataset id="checkResultDs" enumName="FIS.CEME.RESULT"
		autoLoad="true" global="true"></model:dataset>
	<!-- 初检结果枚举 -->
	<model:dataset id="cJDs" enumName="FIS.CEME.RESULT1"
		autoLoad="true" global="true"></model:dataset>
	<!-- 打分结果业务表 -->
	<model:dataset id="daFenDataset" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"></model:record>
	</model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="propertiesDataSet" enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!-- 公墓性质 -->
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP" autoLoad="true" global="true"></model:dataset>
	<!-- 管辖级别 -->
	<model:dataset id="dominationDS" enumName="FIS.CEME.DOMINATION" autoLoad="true" global="true"></model:dataset>
	<!-- 是否-->
	<model:dataset id="yesOrnoDs" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 年检结果表 -->
	<model:dataset id="resultDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"></model:record>
	</model:dataset>
	<model:dataset id="accessoriesDataSet"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd"
		method="queryAccessories" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCemeAccessories"></model:record>
	</model:dataset>
	
	<model:dataset id="accessoriesItemDataSet"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd"
		method="queryAccessoriesItem" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCemeAccessories"></model:record>
	</model:dataset>
	
	<model:dataset id="accessoriesType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CEME_ACCESSORIES_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 墓穴信息 -->
	<model:dataset id="CemeInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
	<!-- 年检打分 -->
	<model:dataset id="scoreDataSet"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckScoreQueryCmd"
		method="queryScore" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCemeCheckScore">
			<model:field name="businesscertificateScore" type="int" rule="require" />
			<model:field name="businesslicenseScore" type="int" rule="require" />
			<model:field name="taxcertificateScore" type="int" rule="require" />
			<model:field name="feeScore" type="int" rule="require" />
			<model:field name="purchasegravesScore" type="int" rule="require" />
			<model:field name="pledgeScore" type="int" rule="require" />
			<model:field name="staffresponsibilitiesScore" type="int" rule="require" />
			<model:field name="officeTimeScore" type="int" rule="require" />
			<model:field name="provincialdocumentsScore" type="int" rule="require" />
			<model:field name="departmentchargesScore" type="int" rule="require" />
			<model:field name="nooffenseScore" type="int" rule="require" />
			<model:field name="propergraveScore" type="int" rule="require" />
			<model:field name="boxesandbagsScore" type="int" rule="require" />
			<model:field name="deathcertificateScore" type="int" rule="require" />
			<model:field name="ashescontractScore" type="int" rule="require" />
			<model:field name="contractorssignatureScore" type="int" rule="require" />
			<model:field name="contractoridScore" type="int" rule="require" />
			<model:field name="addcontractScore" type="int" rule="require" />
			<model:field name="othermaterialsScore" type="int" rule="require" />
			<model:field name="tombstoneTwentyScore" type="int" rule="require" />
			<model:field name="tombstoneFiftyScore" type="int" rule="require" />
			<model:field name="tombstoneoverfiftyScore" type="int" rule="require" />
			<model:field name="operatingareaScore" type="int" rule="require" />
			<model:field name="archivesareaScore" type="int" rule="require" />
			<model:field name="officeareaScore" type="int" rule="require" />
			<model:field name="roadsafetyScore" type="int" rule="require" />
			<model:field name="civilizationMemorialScore" type="int" rule="require" />
			<model:field name="fireMemorialScore" type="int" rule="require" />
			<model:field name="ecologyScore" type="int" rule="require" />
			<model:field name="greenCoverageScore" type="int" rule="require" />
			<model:field name="greenareaRatioScore" type="int" rule="require" />
			<model:field name="burialTombScore" type="int" rule="require" />
			<model:field name="burialConformScore" type="int" rule="require" />
			<model:field name="acceptanceComplianceScore" type="int" rule="require" />
			<model:field name="changeComplianceScore" type="int" rule="require" />
			<model:field name="paymentCertificateScore" type="int" rule="require" />
			<model:field name="agenciesScore" type="int" rule="require" />
			<model:field name="businessTrainingScore" type="int" rule="require" />
			<model:field name="systemSoundScore" type="int" rule="require" />
			<model:field name="contingencyPlansScore" type="int" rule="require" />
			<model:field name="informationScore" type="int" rule="require" />
			<model:field name="tombstoneTwentyNum" type="int" rule="require" />
			<model:field name="tombstoneFiftyNum" type="int" rule="require" />
			<model:field name="tombstoneoverfiftyNum" type="int" rule="require" />
			<model:field name="operatingareaNum" type="float" rule="require" />
			<model:field name="archivesareaNum" type="float" rule="require" />
			<model:field name="officeareaNum" type="float" rule="require" />
			<model:field name="ecologyNum" type="float" rule="require" />
			<model:field name="greenCoverageNum" type="float" rule="require" />
			<model:field name="greenareaRatioNum" type="float" rule="require" />
			<model:field name="yearSinceHoleNum" type="float" rule="require" />
			<model:field name="totalSinceHoleNum" type="float" rule="require" />
			<model:field name="yearBoneAshNum" type="float" rule="require" />
			<model:field name="yearMaintenanceFee" type="float" rule="require" />
			<model:field name="yearOverproofHoleNum" type="float" rule="require" />
			<model:field name="isSpeculation" type="float" rule="require" />
		</model:record>
	</model:dataset>
	<!--  年检历史记录 -->
	<model:dataset id="historyDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="经营性公墓年检"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="select" text="提交" handler="reportClick" />
			<next:ToolBarItem iconCls="no" text="驳回整改" handler="reject" id="no"/>
			<next:ToolBarItem iconCls="detail" text="流程明细" handler="detailwf" />
			<next:ToolBarItem iconCls="return" text="返回" handler="returnClick" id="returnClick"/>
		</next:TopBar>
		<next:TabPanel width="100%" height="100%" id="tabPanel">
		<next:Tabs>
			<next:Panel title="公墓信息" width="100%" height="100%" autoScroll="true">
	
				<next:Html>
					<form id="editForm" dataset="CemeInfoDs" onsubmit="return false"
						class="L5form">
					<table border="1" width="100%" height="100%">
						<tr>
							<td class="FieldLabel" width="100">公墓名称</td>
							<td class="FieldInput"  style="width: 210"><label name="公墓名称" maxlength="50" field=name style="width: 200"></label></td>
							<td class="FieldLabel" width="100">单位编号</td>
							<td class="FieldInput" style="width: 210"><label name="单位编号" field="organId" style="font-weight: bold;"></label></td>
							<td class="FieldLabel" width="150">公墓性质</td>
							<td class="FieldInput">
								<label name="公墓性质" field="prop" dataset="cemePropDataSet"></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" >管辖级别</td>
							<td class="FieldInput" >
								<label name="管辖级别" id="domination" field="domination" maxlength="50" style="width: 200" dataset="dominationDS"></label>
								</td>
							
							<td class="FieldLabel">单位性质</td>
							<td class="FieldInput" >
								<label name="单位性质" field="properties" dataset="propertiesDataSet"></label>
							</td>
							
							<td class="FieldLabel">组织机构代码</td>
							<td class="FieldInput"><label name="组织机构代码" field="organCode" ></label></td>
						
							
						</tr>
						<tr>
							
							<td class="FieldLabel" >主管单位</td>
							<td class="FieldInput" ><label name="主管单位" id="MANA_LEVEL" field="manaLevel" maxlength="50" style="width:200"></label></td>
							<td class="FieldLabel" >主管单位代码</td>
							<td class="FieldInput" colspan="3"><label name="主管单位代码" id="MANA_LEVEL_ID" field="manaLevelId" maxlength="50" style="width: 200"></label></td>
							
						</tr>
						<tr>
							<td class="FieldLabel">主办单位</td>
							<td class="FieldInput"  ><label name="主办单位" field="organizer"  style="width:200" maxlength="25"></label></td>
							<td class="FieldLabel" >主办单位性质</td>
							<td class="FieldInput" colspan="3">
								<label  name="主办单位性质" field="organizerProperties"></label>
							</td>
						
						</tr>
						<tr>
							<td class="FieldLabel" >联办单位</td>
							<td class="FieldInput"  ><label name="联办单位" id="coOrganizer" field=coOrganizer maxlength="50" style="width:200"></label></td>
							<td class="FieldLabel" >联办单位性质</td>
							<td class="FieldInput" colspan="3">
								<label name="联办单位性质" field="coOrganizerProperties" ></label>
							</td>
						</tr>
						<tr>
						<td class="FieldLabel">所属行政区划</td>
							<td class="FieldInput"><label id="deptName" name="所属行政区划" field="deptName" readonly="readonly" ></label></td>
							<td class="FieldLabel">所在地址</td>
							<td class="FieldInput"><label name="所在地址" maxlength="100" style="width: 200"
								field="address" ></label></td>
							<td class="FieldLabel">邮政编码</td>
							<td class="FieldInput"><label name="邮政编码" maxlength="6"
								field="portCode" ></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">法人代表</td>
							<td class="FieldInput"><label name="法人代表" maxlength="36" field="legalPeople" ></label></td>
							<td class="FieldLabel" >联系电话</td>
							<td class="FieldInput"  colspan="3"><label name="法人代表联系电话" id="OFFICE_PHONE" field="officePhone" maxlength="50" style="width:200"></label></td>
						
						</tr>
						
						<tr>
						
							<td class="FieldLabel">编制人数</td>
							<td class="FieldInput"><label id="numberOf" name="编制人数" maxlength="9" style="text-align:right" 
								field="numberOf" ></label>人</td>
							<td class="FieldLabel">实有人数</td>
							<td class="FieldInput"><label id="numberReal" name="实有人数" maxlength="9" style="text-align:right" 
								field="numberReal" ></label>人</td>
								<td class="FieldLabel" >参加民政部门业务培训人数</td>
							<td class="FieldInput" ><label name="参加民政部门业务培训人数"  style="text-align:right" id="trainNum" field="trainNum" maxlength="50" ></label>人</td>
							
						</tr>
						<tr>
							<td class="FieldLabel" >计算机管理员</td>
							<td class="FieldInput" ><label name="计算机管理员"  style="text-align:right" id="computerManager" field="computerManager" maxlength="50" ></label></td>
							<td class="FieldLabel" >联系电话</td>
							<td class="FieldInput"  colspan="3"><label name="计算机管理员联系电话" id="computerManagerPhone" field="computerManagerPhone" maxlength="50" ></label></td>
						
						
						</tr>
						<tr>
							<td class="FieldLabel" >计算机数量</td>
							<td class="FieldInput" ><label name="计算机数量（台）"  style="text-align:right" id="computerNum" field="computerNum" maxlength="50" ></label>台</td>
						<td class="FieldLabel" >信息系统安装时间</td>
							<td class="FieldInput"  colspan="3"><label name="信息系统安装时间" id="fixTime" field="fixTime" maxlength="50" ></label></td>
						
						</tr>
						<tr>
						<td class="FieldLabel">网站网址</td>
							<td class="FieldInput">
								<label name="网站网址" maxlength="50" field="web" ></label>
							</td>
							<td class="FieldLabel">电子邮件地址</td>
							<td class="FieldInput" ><label name="电子邮件地址" maxlength="50"
								field="email" ></label></td>
							<td class="FieldLabel">服务电话</td>
							<td class="FieldInput"><label name="服务电话" maxlength="16"
								field="servicePhone" ></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >批准建设时间</td>
							<td class="FieldInput" ><label name="批准建设时间" id="approveTime" field="approveTime" ></label></td>
							<td class="FieldLabel">正式营业时间</td>
							<td class="FieldInput"><label id="qStartTime" name="正式营业时间" field="qStartTime" ></label></td>
						
							<td class="FieldLabel" >计划使用年限至</td>
							<td class="FieldInput" ><label name="计划使用年限至" id="yearPlanto" field="yearPlanto" maxlength="4" ></label></td>
						</tr>
						<tr>
						<td class="FieldLabel" >占用土地性质</td>
							<td class="FieldInput" ><label name="占用土地性质" id="LAND_PROPERTIES" field="landProperties" maxlength="50" ></label></td>
							
							<td class="FieldLabel">占地面积</td>
							<td class="FieldInput"><label name="占地面积" id="totalArea" maxlength="13" style="text-align:right" 
								field="totalArea" ></label>亩</td>
							<td class="FieldLabel">墓区建成面积</td>
							<td class="FieldInput"><label name="墓区建成面积" id="builtArea" maxlength="13" style="text-align:right" 
								field="builtArea" ></label>亩</td>
						</tr>
						<tr>
							<td class="FieldLabel">建筑面积</td>
							<td class="FieldInput"><label name="建筑面积" id="builtTotalArea" maxlength="13" style="text-align:right" 
								field="builtTotalArea" />㎡</td>
							<td class="FieldLabel" >营业室面积</td>
							<td class="FieldInput" ><label name="营业室面积" id="businessArea" field="businessArea"  style="text-align:right"   maxlength="10" ></label>㎡</td>
							<td class="FieldLabel" >档案室面积</td>
							<td class="FieldInput" ><label name="档案室面积" id="filesroomArea" field="filesroomArea"   style="text-align:right"  maxlength="10" ></label>㎡</td>
						</tr>
						<tr>
							<td class="FieldLabel" >办公室面积</td>
							<td class="FieldInput" ><label name="办公室面积（㎡）" id="officeromArea" style="text-align:right"   field="officeromArea" maxlength="10" ></label>㎡</td>
							<td class="FieldLabel" >绿地面积</td>
							<td class="FieldInput" ><label name="绿地面积（㎡）" id="greenArea" style="text-align:right"   field="greenArea" maxlength="10" ></label>㎡</td>
							<td class="FieldLabel" >绿化覆盖率</td>
							<td class="FieldInput" ><label name="绿化覆盖率(%)" id="greenRatio" style="text-align:right"   field="greenRatio" maxlength="10" ></label>%</td>
						</tr>
						
						<tr>
							<td class="FieldLabel">总投资额</td>
							<td class="FieldInput"><label name="总投资额" id="totalInvestment" maxlength="13" style="text-align:right" 
								field="totalInvestment" ></label>万元</td>
						
							<td class="FieldLabel">固定资产</td>
							<td class="FieldInput"  colspan="3"><label name="固定资产" id="fixedAssets" maxlength="10" style="text-align:right" 
								field="fixedAssets"></label>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel" >建设资金合计</td>
							<td class="FieldInput" ><label name="建设资金合计" id="fundTotal" field="fundTotal"  style="text-align:right" maxlength="10" ></label>万元</td>
							<td class="FieldLabel" >财政拨款</td>
							<td class="FieldInput" ><label name="财政拨款" id="fundFinance"  field="fundFinance" style="text-align:right" maxlength="10" ></label>万元</td>
							<td class="FieldLabel" >上级部门拨款</td>
							<td class="FieldInput" ><label name="上级部门拨款" id="fundHigher"   field="fundHigher" style="text-align:right" maxlength="10" ></label>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel" >自筹</td>
							<td class="FieldInput" ><label name="自筹" id="fundSelf"   field="fundSelf" style="text-align:right"maxlength="10" ></label>万元</td>
							<td class="FieldLabel" >福彩资助</td>
							<td class="FieldInput" ><label name="福彩资助" id="fundLottery"   field="fundLottery" style="text-align:right"maxlength="10" ></label>万元</td>
							<td class="FieldLabel" >其他</td>
							<td class="FieldInput" ><label name="其他" id="fundOther"   field="fundOther" style="text-align:right" maxlength="10" ></label>万元</td>
						</tr>
						<TR>
							<td class="FieldLabel" >经营管理方式<br>(维护管理办法)</td>
							<td class="FieldInput"  colspan="5">
							<label name="经营管理方式（维护管理办法）" field="manageStyle" 
								style="width: 60%;height: 80"></label></td>
						</TR>
						
						<tr>
							<td class="FieldLabel">服务内容</td>
							<td class="FieldInput" colspan="5"><input type="checkbox" name="服务内容" value="1" 
								field="serviceScope" label="殡仪服务" disabled="disabled"/>殡仪服务 <br />
							<input type="checkbox" name="serviceScope" value="2"
								field="serviceScope" label="骨灰寄存" disabled="disabled"/>骨灰寄存 <br />
							<input type="checkbox" name="serviceScope" value="3"
								field="serviceScope" label="殡葬用品销售 " disabled="disabled"/>殡葬用品销售 <br />
							<input type="checkbox" name="serviceScope" value="4"
								field="serviceScope" label="骨灰安葬" disabled="disabled"/>骨灰安葬 <br/>
								
						</tr>
						<tr>
							<td class="FieldLabel">备注</td>
							<td class="FieldInput" colspan="5"><label name="备注" field="note" 
								style="width: 60%;height: 80"></label> </td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<!-- 公墓年检标准 -->
			<next:Panel title="公墓年检标准" height="100%" width="100%"
				autoScroll="true">
				<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="detail" text="下载年检打分标准" handler="downloadCheckStandard"/>
				</next:TopBar>
				<next:Html>
					<form id="editForm" method="post" dataset="scoreDataSet"
						onsubmit="return false" class="L5form">
					<fieldset><legend>公墓年检标准(满分：100)</legend>
					<table border="1" width="100%" height="100%">

						<tr>
							<td class="FieldButton" colspan="3">检查项目</td>
							<td class="FieldButton" width="5%">分值</td>
							<td class="FieldButton" >得分</td>
							<td class="FieldButton" width="25%">扣分原因</td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="8" width="20%" style="text-align:left">在销售服务场所公开展示内容
							(10分)</td>
							<td class="FieldLabel" width="30%" style="text-align:left"  colspan="2">《经营性公墓合格证》</td>
							<td class="FieldLabel" id="businesscertificateScoreLimit" style="text-align: center" width="15%">1</td>
							<td class="FieldInput"  ><input type="text"
								name="经营性合格证得分" field="businesscertificateScore" style="text-align:right"
								id="businesscertificateScore"    style="width: 50px" 
								maxlength="5" onchange="checkNum(this.id)"  /></td>
							<td class="FieldInput" width="35%"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="经营性合格证原因" style="width: 400px" id="businesscertificateReason"
								field="businesscertificateReason" maxlength="50" ></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">营业执照</td>
							<td class="FieldLabel"  id="businesslicenseScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text"
								name="营业执照得分" field="businesslicenseScore" style="text-align:right"
								id="businesslicenseScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="营业执照原因" style="width: 400px" id="businesslicenseReason"
								field="businesslicenseReason" maxlength="50"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">税务登记证</td>
							<td class="FieldLabel" id="taxcertificateScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="税务登记证得分" style="text-align:right"
								field="taxcertificateScore" id="taxcertificateScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="税务登记证原因"
								style="width: 400px" field="taxcertificateReason" maxlength="50" id="taxcertificateReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">收费项目、收费标准、收费依据等价格公示内容</td>
							<td class="FieldLabel" id="feeScoreLimit" style="text-align: center">2</td>
							<td class="FieldInput" ><input type="text" name="收费得分" style="text-align:right"
								field="feeScore" id="feeScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="收费原因"
								style="width: 400px" field="feeReason" maxlength="50" id="feeReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">购置墓穴(格位)的条件和程序</td>
							<td class="FieldLabel" id="purchasegravesScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" style="text-align:right"
								name="购置墓穴/安葬程序得分" field="purchasegravesScore"
								id="purchasegravesScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="购置墓穴/安葬程序原因" style="width: 400px"
								field="purchasegravesReason" maxlength="50" id="purchasegravesReason"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">服务承诺</td>
							<td class="FieldLabel" id="pledgeScoreLimit" style="text-align: center">2</td>
							<td class="FieldInput" ><input type="text" name="服务承诺得分" style="text-align:right"
								field="pledgeScore" id="pledgeScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="服务承诺原因"
								style="width: 400px" field="pledgeReason" maxlength="50" id="pledgeReason"></textarea></td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">工作人员职责及照片、编号</td>
							<td class="FieldLabel" id="staffresponsibilitiesScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="工作人员职责及照片、编号得分" style="text-align:right"
								field="staffresponsibilitiesScore"
								id="staffresponsibilitiesScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="工作人员职责原因"
								style="width: 400px" field="staffresponsibilitiesReason" maxlength="50" id="staffresponsibilitiesReason"></textarea></td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">办公时间、服务电话和监督电话</td>
							<td class="FieldLabel" id="officeTimeScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text"
								name="办公时间、服务电话、监督电话得分" field="officeTimeScore" style="text-align:right"
								id="officeTimeScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="办公时间、服务电话、监督电话原因" style="width: 400px"
								field="officeTimeReason" maxlength="50" id="officeTimeReason"></textarea></td>

						</tr>
						<tr>
							<td rowspan="4" class="FieldLabel" style="text-align:left">墓穴(格位)销售管理(5分)</td>
							<td class="FieldLabel" style="text-align:left"  colspan="2">使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》</td>
							<td class="FieldLabel"  id="provincialdocumentsScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》得分"
								field="provincialdocumentsScore" id="provincialdocumentsScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)" style="text-align:right"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="全省统一证原因"
								style="width: 400px" field="provincialdocumentsReason" maxlength="50" id="provincialdocumentsReason"></textarea></td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">物价部门核定收费标准</td>
							<td class="FieldLabel" id="departmentchargesScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="物价部门收费标准得分" style="text-align:right"
								field="departmentchargesScore" id="departmentchargesScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="物价部门收费标准原因" style="width: 400px"
								field="departmentchargesReason" maxlength="50" id="departmentchargesReason"></textarea></td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">无违法出租或买卖墓穴(格位)现象</td>
							<td class="FieldLabel" id="nooffenseScoreLimit" style="text-align: center">2</td>
							<td class="FieldInput" ><input type="text" name="无违法出租或买卖墓穴（格位）现象得分"
								field="nooffenseScore" id="nooffenseScore"  style="width: 50px" style="text-align:right"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="无违法出租原因"
								style="width: 400px" field="nooffenseReason" maxlength="50" id="nooffenseReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">对超过20年的墓穴能够妥善处理</td>
							<td class="FieldLabel" id="propergraveScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text"
								name="对超过20年的墓穴能够妥善处理得分" field="propergraveScore" style="text-align:right"
								id="propergraveScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="墓穴妥善处理原因" style="width: 400px"
								field="propergraveReason" maxlength="50" id="propergraveReason"></textarea> </td>

						</tr>
						<tr>
							<td rowspan="7" class="FieldLabel" style="text-align:left">墓穴(格位)销售档案管理(7分)</td>
							<td class="FieldLabel" style="text-align:left"  colspan="2">使用全省统一的卷盒和卷袋</td>
							<td class="FieldLabel" id="boxesandbagsScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="使用全省统一的卷盒和卷袋得分" style="text-align:right"
								field="boxesandbagsScore" id="boxesandbagsScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="统一卷盒原因"
								style="width: 400px" field="boxesandbagsReason" maxlength="50" id="boxesandbagsReason"></textarea></td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有死亡证明或火化证明的复印件</td>
							<td class="FieldLabel" id="deathcertificateScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="有死亡证明或火化证明的复印件得分" style="text-align:right"
								field="deathcertificateScore" id="deathcertificateScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="死亡证明复印件原因"
								style="width: 400px" field="deathcertificateReason" maxlength="50" id="deathcertificateReason"></textarea></td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有骨灰安放(葬)合同</td>
							<td class="FieldLabel" id="ashescontractScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text"
								name="骨灰安放合同得分" field="ashescontractScore" style="text-align:right"
								id="ashescontractScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="骨灰安放合同原因" style="width: 400px"
								field="ashescontractReason" maxlength="50" id="ashescontractReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有丧事承办人签名的骨灰安放(葬)处理表、业务流程单等</td>
							<td class="FieldLabel" id="contractorssignatureScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="有丧事承办人签名的骨灰安放（葬）处理表、业务流程单等得分"
								field="contractorssignatureScore" style="text-align:right"
								id="contractorssignatureScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="承办人签名原因"
								style="width: 400px" field="contractorssignatureReason" maxlength="50" id="contractorssignatureReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有丧事承办人的有效身份证件复印件</td>
							<td class="FieldLabel" id="contractoridScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="有丧事承办人的有效身份证件复印件得分" style="text-align:right"
								field="contractoridScore" id="contractoridScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="承办人身份证原因"
								style="width: 400px" field="contractoridReason" maxlength="50" id="contractoridReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有补充签订的合同或者协议</td>
							<td class="FieldLabel" id="addcontractScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="有补充签订的合同或者协议得分" style="text-align:right"
								field="addcontractScore" id="addcontractScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="补充合同协议原因"
								style="width: 400px" field="addcontractReason" maxlength="50" id="addcontractReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有其他应当归档的材料</td>
							<td class="FieldLabel"  id="othermaterialsScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="有其他应当归档的材料得分" style="text-align:right"
								field="othermaterialsScore" id="othermaterialsScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="其他材料原因"
								style="width: 400px" field="othermaterialsReason" maxlength="50" id="othermaterialsReason"></textarea> </td>

						</tr>
						<tr>
							<td rowspan="3" class="FieldLabel" style="text-align:left">墓穴建设(9分)</td>
							<td class="FieldLabel" style="text-align:left" style="width: 30%">墓穴面积或墓碑高度超过规定标准20%以下的个数</td>
							<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数" style="text-align:right"
							field="tombstoneTwentyNum" id="tombstoneTwentyNum" onchange="checkNumOnly(this.id)" maxlength="10" style="width: 70px"/>
							<td class="FieldLabel" id="tombstoneTwentyScoreLimit" style="text-align: center">2</td>
							<td class="FieldInput" ><input type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数得分" style="text-align:right"
								field="tombstoneTwentyScore" id="tombstoneTwentyScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓碑20%以下原因"
								style="width: 400px" field="tombstoneTwentyReason" maxlength="50" id="tombstoneTwentyReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准20%至50%的个数</td>
							<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准20%至50%的个数" style="text-align:right"
							field="tombstoneFiftyNum" id="tombstoneFiftyNum" onchange="checkNumOnly(this.id)" maxlength="10" style="width: 70px"/>
							<td class="FieldLabel" id="tombstoneFiftyScoreLimit"  style="text-align: center">3</td>
							<td class="FieldInput" ><input type="text"
								name="墓穴面积或墓碑高度超过规定标准20%至50%的个数得分" field="tombstoneFiftyScore"  style="width: 50px" style="text-align:right"
								id="tombstoneFiftyScore" 
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="墓碑20%到50%原因" style="width: 400px"
								field="tombstoneFiftyReason" maxlength="50" id="tombstoneFiftyReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准50%以上的个数</td>
							<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数" style="text-align:right"
							field="tombstoneoverfiftyNum" id="tombstoneoverfiftyNum" onchange="checkNumOnly(this.id)" maxlength="10" style="width: 70px"/>
							<td class="FieldLabel" id="tombstoneoverfiftyScoreLimit" style="text-align: center">4</td>
							<td class="FieldInput" ><input type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数得分" field="tombstoneoverfiftyScore"
								id="tombstoneoverfiftyScore"  maxlength="5"  style="width: 50px"  onchange="checkNum(this.id)" style="text-align:right"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓碑50%以上原因"
								style="width: 400px" field="tombstoneoverfiftyReason" maxlength="50" id="tombstoneoverfiftyReason"></textarea> </td>

						</tr>
						<tr>
							<td rowspan="10" class="FieldLabel" style="text-align:left">墓区管理(30分)</td>
							<td class="FieldLabel" style="text-align:left">营业室面积</td>
							<td class="FieldLabel"><input type="text" name="营业室面积" style="text-align:right"
							field="operatingareaNum" id="operatingareaNum" onchange="checkAssMon(this.id)" maxlength="12" style="width: 70px"/>㎡</td>
							<td class="FieldLabel" id="operatingareaScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="营业室面积得分" style="text-align:right"
								field="operatingareaScore" id="operatingareaScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="营业室面积原因"
								style="width: 400px" field="operatingareaReason" maxlength="50" id="operatingareaReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left">档案室面积</td>
							<td class="FieldLabel"><input type="text" name="档案室面积" style="text-align:right"
							field="archivesareaNum" id="archivesareaNum" onchange="checkAssMon(this.id)" maxlength="12" style="width: 70px"/>㎡</td>
							<td class="FieldLabel" id="archivesareaScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="档案室面积得分" style="text-align:right"
								field="archivesareaScore" id="archivesareaScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="档案室面积原因"
								style="width: 400px" field="archivesareaReason" maxlength="50" id="archivesareaReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left">办公室面积</td>
							<td class="FieldLabel"><input type="text" name="办公室面积" style="text-align:right"
							field="officeareaNum" id="officeareaNum" onchange="checkAssMon(this.id)" maxlength="12" style="width: 70px"/>㎡</td>
							<td class="FieldLabel" id="officeareaScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="办公室面积得分" style="text-align:right"
								field="officeareaScore" id="officeareaScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="办公室面积原因"
								style="width: 400px" field="officeareaReason" maxlength="50" id="officeareaReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">道路、供水、供电畅通，安全防护措施到位</td>
							<td class="FieldLabel"  id="roadsafetyScoreLimit" style="text-align: center">3</td>
							<td class="FieldInput" ><input type="text" name="道路、供水、供电畅通，安全防护措施到位得分"
								field="roadsafetyScore" id="roadsafetyScore"  style="width: 50px" style="text-align:right"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="道路供水原因"
								style="width: 400px" field="roadsafetyReason" maxlength="50" id="roadsafetyReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">有文明祭奠举措，无封建迷信活动</td>
							<td class="FieldLabel" id="civilizationMemorialScoreLimit" style="text-align: center">3</td>
							<td class="FieldInput" ><input type="text" name="有文明祭奠举措，无封建迷信活动得分" style="text-align:right"
								field="civilizationMemorialScore"  style="width: 50px"
								id="civilizationMemorialScore" 
								maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="文明祭奠原因"
								style="width: 400px" field="civilizationMemorialReason" maxlength="50" id="civilizationMemorialReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批</td>
							<td class="FieldLabel" id="fireMemorialScoreLimit"  style="text-align: center">2</td>
							<td class="FieldInput" ><input type="text" name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分"
								field="fireMemorialScore" id="fireMemorialScore"  style="width: 50px" style="text-align:right"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="明火祭奠原因"
								style="width: 400px" field="fireMemorialReason" maxlength="50" id="fireMemorialReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left">生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例(%)</td>
							<td class="FieldLabel"><input type="text" name="生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例" style="text-align:right"
							field="ecologyNum" id="ecologyNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
							<td class="FieldLabel"  id="ecologyScoreLimit" style="text-align: center">6</td>
							<td class="FieldInput" ><input type="text" name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分" style="text-align:right"
								field="ecologyScore" id="ecologyScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="生态原因"
								style="width: 400px" field="ecologyReason" maxlength="50" id="ecologyReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left">绿化覆盖率(%)</br>(注：指绿化植物的垂直投影面积占总用地面积的比值)</td>
							<td class="FieldLabel"><input type="text" name="绿化覆盖率"
							field="greenCoverageNum" id="greenCoverageNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px" style="text-align:right"/>
							<td class="FieldLabel" id="greenCoverageScoreLimit" style="text-align: center">6</td>
							<td class="FieldInput" ><input type="text" name="绿化覆盖率得分" style="text-align:right"
								field="greenCoverageScore" id="greenCoverageScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿化率原因"
								style="width: 400px" field="greenCoverageReason" maxlength="50" id="greenCoverageReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left">绿地面积和占总面积的比例(%)</td>
							<td class="FieldLabel"><input type="text" name="绿地面积和占总面积的比例" style="text-align:right"
							field="greenareaRatioNum" id="greenareaRatioNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
							<td class="FieldLabel" id="greenareaRatioScoreLimit" style="text-align: center">6</td>
							<td class="FieldInput" ><input type="text" name="绿地面积和占总面积的比例得分" style="text-align:right"
								field="greenareaRatioScore" id="greenareaRatioScore"  style="width: 50px" style="text-align:right"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿地面积比率原因"
								style="width: 400px" field="greenareaRatioReason" maxlength="50" id="greenareaRatioReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">按照所购墓穴(格位)标准进行安葬或安放，无自行改建墓穴(格位)</td>
							<td class="FieldLabel" id="burialTombScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分" style="text-align:right"
								field="burialTombScore" id="burialTombScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="标准安葬墓穴原因"
								style="width: 400px" field="burialTombReason" maxlength="50" id="burialTombReason"></textarea> </td>

						</tr>
						<tr>
							<td rowspan="9" class="FieldLabel" style="text-align:left">公墓管理(39分)</td>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">墓区建设地点和规模与申报材料相符</td>
							<td class="FieldLabel"  id="burialConformScoreLimit" style="text-align: center">6</td>
							<td class="FieldInput" ><input type="text" name="墓区建设地点和规模与申报材料相符得分" style="text-align:right"
								field="burialConformScore" id="burialConformScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓区相符原因"
								style="width: 400px" field="burialConformReason" maxlength="50" id="burialConformReason"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定</td>
							<td class="FieldLabel" id="acceptanceComplianceScoreLimit" style="text-align: center">6</td>
							<td class="FieldInput" ><input type="text" name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分" style="text-align:right"
								field="acceptanceComplianceScore"  style="width: 50px"
								id="acceptanceComplianceScore" 
								maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="手续符合规定原因"
								style="width: 400px" field="acceptanceComplianceReason" maxlength="50" id="acceptanceComplianceReason"></textarea> </td>
						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">公墓更名、变更法人代表,改变性质或改变合作(合资)单位符合《山东省公墓管理办法》规定</td>
							<td class="FieldLabel" id="changeComplianceScoreLimit"  style="text-align: center">3</td>
							<td class="FieldInput" ><input type="text"
								name="公墓更名、变更法人代表，改变性质或改变合作（合资）单位符合《山东省公墓管理办法》规定得分" field="changeComplianceScore" style="text-align:right"
								id="changeComplianceScore"   style="width: 50px"
								maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="改变符合规定/公墓更名符合规定原因" style="width: 400px"
								field="changeComplianceReason" maxlength="50" id="changeComplianceReason"></textarea> </td>

						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证
							</td>
							<td class="FieldLabel" id="paymentCertificateScoreLimit" style="text-align: center">7</td>
							<td class="FieldInput" ><input type="text" name="公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证得分" style="text-align:right"
								field="paymentCertificateScore" id="paymentCertificateScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)" /></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="有交款凭证原因"
								style="width: 400px" field="paymentCertificateReason" maxlength="50" id="paymentCertificateReason"></textarea> </td>
						</tr>
						<tr>
							<td class="FieldLabel"  style="text-align:left"  colspan="2">墓区管理机构的组建与申报报告相符</td>
							<td class="FieldLabel"  id="agenciesScoreLimit" style="text-align: center">4</td>
							<td class="FieldInput" ><input type="text"
								name="墓区管理机构的组建与申报报告相符得分" field="agenciesScore" id="agenciesScore"  style="width: 50px" style="text-align:right"
								 maxlength="5"  onchange="checkNum(this.id)"/> </td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
								name="管理机构组建相符原因" style="width: 400px" field="agenciesReason" maxlength="50" id="agenciesReason"></textarea> </td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">工作人员参加省或设区的市人民政府民政部门组织的业务培训</td>
							<td class="FieldLabel" id="businessTrainingScoreLimit" style="text-align: center">1</td>
							<td class="FieldInput" ><input type="text" name="工作人员参加省或设区的市人民政府民政部门组织的业务培训得分" style="text-align:right"
								field="businessTrainingScore" id="businessTrainingScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="业务培训原因"
								style="width: 400px" field="businessTrainingReason" maxlength="50" id="businessTrainingReason"></textarea> </td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">公墓管理的各项规章制度健全</td>
							<td class="FieldLabel" id="systemSoundScoreLimit" style="text-align: center">3</td>
							<td class="FieldInput"  ><input type="text" name="公墓管理的各项规章制度健全得分" style="text-align:right"
								field="systemSoundScore" id="systemSoundScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="规章制度健全原因"
								style="width: 400px" field="systemSoundReason" maxlength="50" id="systemSoundReason"></textarea> </td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">有高峰应急预案</td>
							<td class="FieldLabel" id="contingencyPlansScoreLimit" style="text-align: center">3</td>
							<td class="FieldInput"  ><input type="text" name="有高峰应急预案得分" style="text-align:right"
								field="contingencyPlansScore" id="contingencyPlansScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="应急预案原因"
								style="width: 400px" field="contingencyPlansReason" maxlength="50" id="contingencyPlansReason"></textarea> </td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align:left"  colspan="2">实行信息化管理，使用省厅研制的软件信息系统</td>
							<td class="FieldLabel" id="informationScoreLimit" style="text-align: center">6</td>
							<td class="FieldInput" ><input type="text" name="实行信息化管理，使用省厅研制的软件信息系统得分" style="text-align:right"
								field="informationScore" id="informationScore"  style="width: 50px"
								 maxlength="5"  onchange="checkNum(this.id)"/></td>
							<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="信息化原因"
								style="width: 400px" field="informationReason" maxlength="50" id="informationReason"></textarea> </td>
						</tr>
					</table>
					</fieldset>
					</form>
					<div id="cityDiv">
					<form id="form1" method="post" dataset="scoreDataSet" onsubmit="return false" class="L5form">
						<fieldset><legend>年检报告</legend>
						    <table border="1" width="100%" height="100%">
						        <tr>
						           <td class='FieldLabel'>本年安葬墓穴数</td>
						           <td class='FieldInput'><label name="本年安葬墓穴数"id="yearSinceHoleNum" field="yearSinceHoleNum" ></label>个</td>
						           <td class='FieldLabel'>累计安葬墓穴数</td>
						           <td class='FieldInput'><label name="累计安葬墓穴数"id="totalSinceHoleNum" field="totalSinceHoleNum" ></label>个</td>
						        </tr>
						        <tr>
						           <td class='FieldLabel'>本年存放骨灰</td>
						           <td class='FieldInput'><label name="本年存放骨灰" id="yearBoneAshNum" field="yearBoneAshNum" ></label>个</td>
						           <td class='FieldLabel'>累计存放骨灰</td>
						           <td class='FieldInput'><label name="累计存放骨灰" id="totalBoneAshNum" field="totalBoneAshNum" ></label>个</td>
						        </tr>
						        <tr>
						           <td class='FieldLabel'>本年缴纳维护费</td>
						           <td class='FieldInput' colspan="3"><label name="本年缴纳维护费" id="yearMaintenanceFee" field="yearMaintenanceFee" ></label>万元</td>
						        </tr>
						        <tr>
						           <td class='FieldLabel'>本年安葬超标墓穴数</td>
						           <td class='FieldInput'><label name="本年安葬超标墓穴数"id="yearOverproofHoleNum" field="yearOverproofHoleNum" ></label>个</td>
						           <td class='FieldLabel'>有无炒买炒卖行为</td>
						           <td class='FieldInput'><label id="isSpeculation" field="isSpeculation" dataset="yesOrnoDs" name="有无炒买炒卖行为"></td>
						        </tr>
						    </table>
						</fieldset>
					</form>
					</div>
					<div id="townDiv">
					   <form id="form2" method="post" dataset="scoreDataSet" onsubmit="return false" class="L5form">
						<fieldset><legend>年检报告</legend>
						    <table border="1" width="100%" height="100%">
						        <tr>
						           <td class='FieldLabel'>本年安葬墓穴数</td>
						           <td class='FieldInput'><input type="text" name="本年安葬墓穴数"id="yearSinceHoleNum" field="yearSinceHoleNum" onchange="checkNumOnly(this.id)"/></td>
						           <td class='FieldLabel'>累计安葬墓穴数</td>
						           <td class='FieldInput'><input type="text" name="累计安葬墓穴数"id="totalSinceHoleNum" field="totalSinceHoleNum" onchange="checkNumOnly(this.id)"/></td>
						        </tr>
						        <tr>
						           <td class='FieldLabel'>本年存放骨灰</td>
						           <td class='FieldInput'><input type="text" name="本年存放骨灰" id="yearBoneAshNum" field="yearBoneAshNum" onchange="checkNumOnly(this.id)"/></td>
						           <td class='FieldLabel'>累计存放骨灰</td>
						           <td class='FieldInput'><input type="text" name="累计存放骨灰" id="totalBoneAshNum" field="totalBoneAshNum" onchange="checkNumOnly(this.id)"/></td>
						        </tr>
						        <tr>
						           <td class='FieldLabel'>本年缴纳维护费</td>
						           <td class='FieldInput' colspan="3"><input name="本年缴纳维护费" type="text" id="yearMaintenanceFee" field="yearMaintenanceFee" onchange="checkAssMon(this.id)"/>万元</td>
						        </tr>
						        <tr>
						           <td class='FieldLabel'>本年安葬超标墓穴数</td>
						           <td class='FieldInput'><input type="text" name="本年安葬超标墓穴数"id="yearOverproofHoleNum" field="yearOverproofHoleNum" onchange="checkNumOnly(this.id)"/></td>
						           <td class='FieldLabel'>有无炒买炒卖行为</td>
						           <td class='FieldInput'>
						               <select id="isSpeculation" field="isSpeculation" name="有无炒买炒卖行为">
						                   <option dataset="yesOrnoDs"></option>
						               </select>
						           </td>
						        </tr>
						    </table>
						</fieldset>
					</form>
					</div>
				</next:Html>
			</next:Panel>
			<!-- 及年检报告 -->
			<next:Panel title="年检报告" height="100%" width="100%"
				autoScroll="true" id="statisticalScore">
				<next:Html>
					<form id="editForm" method="post" dataset="daFenDataset"
						onsubmit="return false" class="L5form">
					
					<div id="xjdiv">
					<fieldset><legend>县级检查记录</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="31%" colspan="2">总得分:</td>
							<td class="FieldInput" colspan="3" width="69%"><input  style="text-align:right"
								type="text" name="总得分" field="firstTotalScore" readonly="readonly"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">检<br>
							查</td>
							<td class="FieldLabel" width="8%">县级检查时间</td>
							<td class="FieldInput"><input type="text" name="检查时间"
								id="firstTime" field="firstTime" readonly="readonly"
								format="Y-m-d" onclick="LoushangDate(this)" /></td>
							<td class="FieldLabel">县级检查结果</td>
							<td class="FieldInput"><select  name="检查结果"
								field="firstResult" id="firstResult">
								<option dataset="cJDs"></option></select></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">县级检查意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="20"
								name="检查意见" id="firstOpinion" field="firstOpinion" maxlength="1500"
								style="width: 80%" readonly="readonly"> </textarea><font color="red">*可输入1000字</font></td>
						</tr>
					</table>
					</fieldset>
					</div>
					
					<div id="sjdiv">
					<fieldset><legend>市级检查记录</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="31%" colspan="2">总得分:</td>
							<td class="FieldInput" colspan="3" width="69%"><input  style="text-align:right"
								type="text" name="总得分" field="secondTotalScore" readonly="readonly" id="secondTotalScore"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">年<br>
							检</td>
							<td class="FieldLabel">市级年检时间</td>
							<td class="FieldInput"><input type="text" name="年检时间"
								field="secondTime" readonly="readonly" format="Y-m-d"
								onclick="LoushangDate(this)" id="secondTime"/></td>
							<td class="FieldLabel">市级年检结果</td>
							<td class="FieldInput"><select  name="年检结果"
								field="secondResult" id="secondResult">
								<option dataset="checkResultDs"></option></select></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="100px;">市级年检报告:</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="20" maxlength="49"
								style="width: 80%" name="年检报告" field="secondAnnuareport" id="annuareport"></textarea><font color="red">*可输入240字</font></td>
						</tr>

					</table>
					</fieldset>
					</div>
					
					</form>
				</next:Html>
			</next:Panel>
			<!-- 业务材料 -->
			<next:Panel title="业务材料">
				<next:EditGridPanel id="uploadGrid" width="99.9%"
					stripeRows="true" height="100%" dataset="accessoriesDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="附件管理"
							handler="clickUploadFile"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="材料类型" field="code" width="40%"
							editable="false" dataset="accessoriesType">
							<next:TextField />
						</next:Column>
						<next:Column header="附件名称" field="accessoriesName" width="30%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="附件描述" field="note" width="28%"
							editable="false" >
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="accessoriesDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
	</next:Panel>
</next:ViewPort>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230"
	width="666" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;"
			class="L5form">
		<table border="1" width="100%">

			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file"
					type="file" id="files" name="files" style="width: 95%; height: 40" /></br>
				<span style="color: red">上传文件最大不能超过5M</span></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width: 80%"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"  
					id="fileMess" rows="5" style="width: 95%"  ></textarea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>

<!-- 下载附件列表  -->
<next:Window id="uploadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件"
				handler="addUploadFile" id="Cupload"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭"
				handler="closeUploadList"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件名称" width="18%" field="accessoriesName"
				editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="附件描述" width="15%" field="note" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="删除附件" field="" width="10%" editable="false"
				renderer="delUploadFile" id="CdelFile">
				<next:TextField />
			</next:Column>
			<next:Column header="下载附件" field="" width="10%" editable="false"
				renderer="downloadUploadFile">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="accessoriesItemDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>