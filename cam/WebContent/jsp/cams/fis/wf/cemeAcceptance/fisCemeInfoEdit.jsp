<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>

<html>
<head>
<title>殡葬业务公墓验收审核</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeInfoEdit.js"></script> 
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<!--cemeApplyIdNew为insert时新生成的  -->
<script type="text/javascript">
	var cemeApplyId='<%=request.getParameter("cemeApplyId")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	
	var method='<%=request.getParameter("method")%>';
	var date ='<%=DateUtil.getDay()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	
	var cemeApplyIdNew = '<%=IdHelp.getUUID32()%>';
	var recordIdNew = '<%=IdHelp.getUUID32()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var organType = '<%=BspUtil.getOrganType()%>';
	var hisId = '<%= IdHelp.getUUID32()%>';
	var time ='<%=DateUtil.getTime()%>';
</script>
</head>
<body>

<model:datasets>

	<!--  -->
	<model:dataset id="fisCemeApplyInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		    <model:field name="firstResult" type="string" rule="require" />
			<model:field name="firstOpinion" type="string" rule="require" />
			<model:field name="firstTime" type="string" rule="require" />
			</model:record>
	</model:dataset>
	<!--  -->
	<!-- 查询备份 -->
	<model:dataset id="fisCemeApplyInfoBK" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"/>
	</model:dataset>
	<!--  -->
	<model:dataset id="confirmDs" enumName="FIS.IF_CONFIRM" autoLoad="true" global="true"></model:dataset>
	<!--  -->
	<model:dataset id="fisBaseOpinionDs" enumName="FIS.CEMEACCEPTANCE.OPINIONS" autoLoad="true" global="true"></model:dataset>

	<!-- 经营性公墓选择 -->
	<model:dataset id="fisCemeDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="200" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo">
			<model:field name="sinceHoleNum" type="string" rule="require|integer" />
			<model:field name="singleHole" type="string" rule="require|integer" />
			<model:field name="doubleHole" type="string" rule="require|integer" /> 
			<model:field name="moreHole" type="string" rule="require|integer" />
			<model:field name="cageHoleNum" type="string" rule="require|integer" />
			<model:field name="ecologicalHoleNum" type="string" rule="require|integer" />
			<model:field name="welfareHoleNum" type="string" rule="require|integer" />
			</model:record>
	</model:dataset>
		<model:dataset id="queryCeme" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="200" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo">
		</model:record>
	</model:dataset>
	
	<model:dataset id="fisCemeExpendInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeExpendInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeExpendInfo">
		<model:field name="sinceHoleNum" type="string" rule="require|integer" />
			<model:field name="singleHole" type="string" rule="require|integer" />
			<model:field name="doubleHole" type="string" rule="require|integer" /> 
			<model:field name="moreHole" type="string" rule="require|integer" />
			<model:field name="cageHoleNum" type="string" rule="require|integer" />
			<model:field name="ecologicalHoleNum" type="string" rule="require|integer" />
			<model:field name="welfareHoleNum" type="string" rule="require|integer" />
		</model:record>
	</model:dataset>
	<model:dataset id="queryExpend" cmd="com.inspur.cams.fis.base.cmd.FisCemeExpendInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeExpendInfo">
		</model:record>
	</model:dataset>
		<!-- 驳回记录表 -->
	<model:dataset id="historyDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="propertiesDataSet" enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!-- 公墓性质 -->
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP" autoLoad="true" global="true"></model:dataset>
	<!-- 管辖级别 -->
	<model:dataset id="dominationDS" enumName="FIS.CEME.DOMINATION" autoLoad="true" global="true"></model:dataset>
	
	<model:dataset id="accessoriesDataSet"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd"
		method="queryAccessoryType" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCemeAccessories">
		</model:record>
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
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="return" text="返回" handler="returnBack" />
		</next:TopBar>
		<next:TabPanel id="tabPanel" width="100%" >
		<next:Tabs>
			<next:Panel title="公墓信息" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form id="form1" method="post" dataset="fisCemeDataSet" onsubmit="return false" class="L5form">
					<fieldset>
					<legend>公墓基本信息</legend>
					<table border="1" width="100%" height="100%">
						<tr>
							<td class="FieldLabel" width="16%">公墓名称</td>
							<td class="FieldInput" width="16%"><label name="公墓名称" maxlength="50" field=name ></label>
								<div id="img"><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
											style="cursor: hand" onclick="forCemeSelect()" title="列表选择" id="CemeSelect"/></div></td>
							<td class="FieldLabel" width="16%">单位编号</td>
							<td class="FieldInput" width="16%"><label name="单位编号" field="organId" id="organId" style="font-weight: bold;"></label></td>
							<td class="FieldLabel" width="16%">公墓性质</td>
							<td class="FieldInput" width="16%">
								<label name="公墓性质" field="prop" dataset="cemePropDataSet"></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" >主管单位代码</td>
							<td class="FieldInput" ><label name="主管单位代码" id="MANA_LEVEL_ID" field="manaLevelId" maxlength="50" ></label></td>
						
							<td class="FieldLabel">单位性质</td>
							<td class="FieldInput">
								<label name="单位性质" field="properties" dataset="propertiesDataSet"></label>
							</td>
							<td class="FieldLabel">组织机构代码</td>
							<td class="FieldInput"><label name="组织机构代码" field="organCode" ></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >管辖级别</td>
							<td class="FieldInput" >
								<label name="管辖级别" id="domination" field="domination" maxlength="50"  dataset="dominationDS"></label>
								</td>
							<td class="FieldLabel" >主管单位</td>
							<td class="FieldInput"  colspan="3"><label name="主管单位" id="MANA_LEVEL" field="manaLevel" maxlength="50" ></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">主办单位</td>
							<td class="FieldInput"  ><label name="主办单位" field="organizer"  maxlength="25"></label></td>
							<td class="FieldLabel" >主办单位性质</td>
							<td class="FieldInput" colspan="3">
								<label  name="主办单位性质" field="organizerProperties"></label>
							</td>
						
						</tr>
						<tr>
							<td class="FieldLabel" >联办单位</td>
							<td class="FieldInput"  ><label name="联办单位" id="coOrganizer" field=coOrganizer maxlength="50" ></label></td>
							<td class="FieldLabel" >联办单位性质</td>
							<td class="FieldInput" colspan="3">
								<label name="联办单位性质" field="coOrganizerProperties" ></label>
							</td>
						</tr>
						<tr>
						<td class="FieldLabel">所属行政区划</td>
							<td class="FieldInput"><label id="deptName" name="所属行政区划" field="deptName" readonly="readonly" ></label></td>
							<td class="FieldLabel">所在地址</td>
							<td class="FieldInput"><label name="所在地址" maxlength="100" 
								field="address" ></label></td>
							<td class="FieldLabel">邮政编码</td>
							<td class="FieldInput"><label name="邮政编码" maxlength="6"
								field="portCode" ></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">法人代表</td>
							<td class="FieldInput"><label name="法人代表" maxlength="36" field="legalPeople" ></label></td>
							<td class="FieldLabel" >联系电话</td>
							<td class="FieldInput"  colspan="3"><label name="法人代表联系电话" id="OFFICE_PHONE" field="officePhone" maxlength="50" ></label></td>
						
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
						<!-- <tr>
							<td class="FieldLabel" >批准建设时间</td>
							<td class="FieldInput" ><label name="批准建设时间" id="approveTime" field="approveTime" ></label></td>
							<td class="FieldLabel">正式营业时间</td>
							<td class="FieldInput"><label id="qStartTime" name="正式营业时间" field="qStartTime" ></label></td>
						
							<td class="FieldLabel" >计划使用年限至</td>
							<td class="FieldInput" ><label name="计划使用年限至" id="yearPlanto" field="yearPlanto" maxlength="4" ></label></td>
						</tr> -->
						</table>
						</fieldset>
						</form>
			<form id="form2" dataset="fisCemeDataSet" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>验收信息</legend>
					<table border="1" width="100%" >
						<tr>
						<td class="FieldLabel" width="16%">占用土地性质</td>
							<td class="FieldInput" width="16%"><input name="占用土地性质" id="LAND_PROPERTIES" field="landProperties" maxlength="50" /></td>
							
							<td class="FieldLabel" width="16%">占地面积</td>
							<td class="FieldInput" width="16%"><input name="占地面积" id="totalArea" maxlength="13" style="text-align:right" 
								field="totalArea" width="16%"></input>亩</td>
							<td class="FieldLabel" width="16%">墓区建成面积</td>
							<td class="FieldInput" width="16%"><input name="墓区建成面积" id="builtArea" maxlength="13" style="text-align:right" 
								field="builtArea" width="16%"></input>亩</td>
						</tr>
						<tr>
							<td class="FieldLabel">建筑面积</td>
							<td class="FieldInput"><input name="建筑面积" id="builtTotalArea" maxlength="13" style="text-align:right" 
								field="builtTotalArea" />㎡</td>
							<td class="FieldLabel" >营业室面积</td>
							<td class="FieldInput" ><input name="营业室面积" id="businessArea" field="businessArea"  style="text-align:right"   maxlength="10" ></input>㎡</td>
							<td class="FieldLabel" >档案室面积</td>
							<td class="FieldInput" ><input name="档案室面积" id="filesroomArea" field="filesroomArea"   style="text-align:right"  maxlength="10" ></input>㎡</td>
						</tr>
						<tr>
							<td class="FieldLabel" >办公室面积</td>
							<td class="FieldInput" ><input name="办公室面积（㎡）" id="officeromArea" style="text-align:right"   field="officeromArea" maxlength="10" ></input>㎡</td>
							<td class="FieldLabel" >绿地面积</td>
							<td class="FieldInput" ><input name="绿地面积（㎡）" id="greenArea" style="text-align:right"   field="greenArea" maxlength="10" ></input>㎡</td>
							<td class="FieldLabel" >绿化覆盖率</td>
							<td class="FieldInput" ><input name="绿化覆盖率(%)" id="greenRatio" style="text-align:right"   field="greenRatio" maxlength="10" ></input>%</td>
						</tr>
						
						<tr>
							<td class="FieldLabel">总投资额</td>
							<td class="FieldInput"><input name="总投资额" id="totalInvestment" maxlength="13" style="text-align:right" 
								field="totalInvestment" ></input>万元</td>
						
							<td class="FieldLabel">固定资产</td>
							<td class="FieldInput"  colspan="3"><input name="固定资产" id="fixedAssets" maxlength="10" style="text-align:right" 
								field="fixedAssets"></input>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel" >建设资金合计</td>
							<td class="FieldInput" ><input name="建设资金合计" id="fundTotal" field="fundTotal"  style="text-align:right" maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >财政拨款</td>
							<td class="FieldInput" ><input name="财政拨款" id="fundFinance"  field="fundFinance" style="text-align:right" maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >上级部门拨款</td>
							<td class="FieldInput" ><input name="上级部门拨款" id="fundHigher"   field="fundHigher" style="text-align:right" maxlength="10" ></input>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel" >自筹</td>
							<td class="FieldInput" ><input name="自筹" id="fundSelf"   field="fundSelf" style="text-align:right"maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >福彩资助</td>
							<td class="FieldInput" ><input name="福彩资助" id="fundLottery"   field="fundLottery" style="text-align:right"maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >其他</td>
							<td class="FieldInput" ><input name="其他" id="fundOther"   field="fundOther" style="text-align:right" maxlength="10" ></input>万元</td>
						</tr>
						<tr>
			                <td class="FieldLabel">计划安葬墓穴数合计</td>
			                <td class="FieldInput"><label name="计划安葬墓穴数合计" id="planSinceHoleNum" field="planSinceHoleNum" style="text-align:right" maxlength="50"></label>个</td>
			                <td class="FieldLabel">实际安葬墓穴数合计</td>
		                    <td class="FieldInput" colspan="3"><input name="实际安葬墓穴数合计" id="sinceHoleNum" field="sinceHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
			           </tr>
			           <tr>
			                <td class="FieldLabel">计划单穴数</td>
			                <td class="FieldInput"><label name="计划单穴数" id="planSingleHole" field="planSingleHole" style="text-align:right" maxlength="50"></label>个</td>
			                <td class="FieldLabel">实际单穴数</td>
			                <td class="FieldInput" colspan="3"><input name="实际单穴数" id="singleHole" field="singleHole" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
			           </tr>
			           <tr>
			                <td class="FieldLabel">计划双穴数</td>
			                <td class="FieldInput"><label name="计划双穴数" id="planDoubleHole" field="planDoubleHole" style="text-align:right" maxlength="50"></label>个</td>
			                <td class="FieldLabel">实际双穴数</td>
			                <td class="FieldInput" colspan="3"><input name="实际双穴数" id="doubleHole" field="doubleHole" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
			          </tr>
			          <tr>
			                <td class="FieldLabel">计划多穴数</td>
			                <td class="FieldInput"><label name="计划多穴数" id="planMoreHole" field="planMoreHole" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际多穴数</td>
							  <td class="FieldInput" colspan="3"><input name="实际多穴数" id="moreHole" field="moreHole" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
							<tr>
							  <td class="FieldLabel">计划安放格位数量</td>
							  <td class="FieldInput"><label name="计划安放格位数量" id="planCageHoleNum" field="planCageHoleNum" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际安放格位数量</td>
							  <td class="FieldInput" colspan="3"><input name="实际安放格位数量" id="cageHoleNum" field="cageHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
							<tr>
							  <td class="FieldLabel">计划生态安葬数量</td>
							  <td class="FieldInput"><label name="计划生态安葬数量" id="planEcologicalHoleNum" field="planEcologicalHoleNum" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际生态安葬数量</td>
							  <td class="FieldInput" colspan="3"><input name="实际生态安葬数量" id="ecologicalHoleNum" field="ecologicalHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
							<tr>
							  <td class="FieldLabel">计划公益安葬数量</td>
							  <td class="FieldInput"><label name="计划公益安葬数量" id="planWelfareHoleNum" field="planWelfareHoleNum" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际公益安葬数量</td>
							  <td class="FieldInput" colspan="3"><input name="实际公益安葬数量" id="welfareHoleNum" field="welfareHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
						<TR>
							<td class="FieldLabel" >经营管理方式<br>(维护管理办法)</td>
							<td class="FieldInput"  colspan="5">
							<label name="经营管理方式（维护管理办法）" field="manageStyle" 
								style="height: 80"></label></td>
						</TR>
						
						<tr>
							<td class="FieldLabel">服务内容</td>
							<td class="FieldInput" colspan="5">
							<input type="checkbox" name="服务内容" value="1" 
								field="serviceScope" label="殡仪服务" disabled="disabled"/>殡仪服务 <br />
							<input type="checkbox" name="serviceScope" value="2"
								field="serviceScope" label="骨灰寄存" disabled="disabled"/>骨灰寄存 <br />
							<input type="checkbox" name="serviceScope" value="3"
								field="serviceScope" label="殡葬用品销售 " disabled="disabled"/>殡葬用品销售 <br />
							<input type="checkbox" name="serviceScope" value="4"
								field="serviceScope" label="骨灰安葬" disabled="disabled"/>骨灰安葬 <br/>
						</tr>
						<tr>
							<td class="FieldLabel">主办单位申请理由</td>
							<td class="FieldInput" colspan="5"><label name="主办单位申请理由" field="note" 
								style="height: 80"></label> </td>
						</tr>
					</table>
					</fieldset>
					</form>
					<form id="form3" dataset="fisCemeExpendInfoDataSet" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>验收信息</legend>
					<table border="1" width="100%" >
						<tr>
						<td class="FieldLabel" width="16%">占用土地性质</td>
							<td class="FieldInput" width="16%"><input name="占用土地性质" id="E_LAND_PROPERTIES" field="landProperties" maxlength="50" ></input></td>
							
							<td class="FieldLabel" width="16%">占地面积</td>
							<td class="FieldInput" width="16%"><input name="占地面积" id="E_totalArea" maxlength="13" style="text-align:right" 
								field="totalArea" width="16%"></input>亩</td>
							<td class="FieldLabel" width="16%">墓区建成面积</td>
							<td class="FieldInput" width="16%"><input name="墓区建成面积" id="E_builtArea" maxlength="13" style="text-align:right" 
								field="builtArea" width="16%"></input>亩</td>
						</tr>
						<tr>
							<td class="FieldLabel">建筑面积</td>
							<td class="FieldInput"><input name="建筑面积" id="E_builtTotalArea" maxlength="13" style="text-align:right" 
								field="builtTotalArea" />㎡</td>
							<td class="FieldLabel" >营业室面积</td>
							<td class="FieldInput" ><input name="营业室面积" id="E_businessArea" field="businessArea"  style="text-align:right"   maxlength="10" ></input>㎡</td>
							<td class="FieldLabel" >档案室面积</td>
							<td class="FieldInput" ><input name="档案室面积" id="E_filesroomArea" field="filesroomArea"   style="text-align:right"  maxlength="10" ></input>㎡</td>
						</tr>
						<tr>
							<td class="FieldLabel" >办公室面积</td>
							<td class="FieldInput" ><input name="办公室面积（㎡）" id="E_officeromArea" style="text-align:right"   field="officeromArea" maxlength="10" ></input>㎡</td>
							<td class="FieldLabel" >绿地面积</td>
							<td class="FieldInput" ><input name="绿地面积（㎡）" id="E_greenArea" style="text-align:right"   field="greenArea" maxlength="10" ></input>㎡</td>
							<td class="FieldLabel" >绿化覆盖率</td>
							<td class="FieldInput" ><input name="绿化覆盖率(%)" id="E_greenRatio" style="text-align:right"   field="greenRatio" maxlength="10" ></input>%</td>
						</tr>
						
						<tr>
							<td class="FieldLabel">总投资额</td>
							<td class="FieldInput"><input name="总投资额" id="E_totalInvestment" maxlength="13" style="text-align:right" 
								field="totalInvestment" ></input>万元</td>
						
							<td class="FieldLabel">固定资产</td>
							<td class="FieldInput"  colspan="3"><input name="固定资产" id="E_fixedAssets" maxlength="10" style="text-align:right" 
								field="fixedAssets"></input>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel" >建设资金合计</td>
							<td class="FieldInput" ><input name="建设资金合计" id="E_fundTotal" field="fundTotal"  style="text-align:right" maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >财政拨款</td>
							<td class="FieldInput" ><input name="财政拨款" id="E_fundFinance"  field="fundFinance" style="text-align:right" maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >上级部门拨款</td>
							<td class="FieldInput" ><input name="上级部门拨款" id="E_fundHigher"   field="fundHigher" style="text-align:right" maxlength="10" ></input>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel" >自筹</td>
							<td class="FieldInput" ><input name="自筹" id="E_fundSelf"   field="fundSelf" style="text-align:right"maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >福彩资助</td>
							<td class="FieldInput" ><input name="福彩资助" id="E_fundLottery"   field="fundLottery" style="text-align:right"maxlength="10" ></input>万元</td>
							<td class="FieldLabel" >其他</td>
							<td class="FieldInput" ><input name="其他" id="E_fundOther"   field="fundOther" style="text-align:right" maxlength="10" ></input>万元</td>
						</tr>
						<tr>
			                <td class="FieldLabel">计划安葬墓穴数合计</td>
			                <td class="FieldInput"><label name="计划安葬墓穴数合计" id="E_planSinceHoleNum" field="planSinceHoleNum" style="text-align:right" maxlength="50"></label>个</td>
			                <td class="FieldLabel">实际安葬墓穴数合计</td>
		                    <td class="FieldInput" colspan="3"><input name="实际安葬墓穴数合计" id="E_sinceHoleNum" field="sinceHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
			           </tr>
			           <tr>
			                <td class="FieldLabel">计划单穴数</td>
			                <td class="FieldInput"><label name="计划单穴数" id="E_planSingleHole" field="planSingleHole" style="text-align:right" maxlength="50"></label>个</td>
			                <td class="FieldLabel">实际单穴数</td>
			                <td class="FieldInput" colspan="3"><input name="实际单穴数" id="E_singleHole" field="singleHole" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
			           </tr>
			           <tr>
			                <td class="FieldLabel">计划双穴数</td>
			                <td class="FieldInput"><label name="计划双穴数" id="E_planDoubleHole" field="planDoubleHole" style="text-align:right" maxlength="50"></label>个</td>
			                <td class="FieldLabel">实际双穴数</td>
			                <td class="FieldInput" colspan="3"><input name="实际双穴数" id="E_doubleHole" field="doubleHole" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
			          </tr>
			          <tr>
			                <td class="FieldLabel">计划多穴数</td>
			                <td class="FieldInput"><label name="计划多穴数" id="E_planMoreHole" field="planMoreHole" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际多穴数</td>
							  <td class="FieldInput" colspan="3"><input name="实际多穴数" id="E_moreHole" field="moreHole" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
							<tr>
							  <td class="FieldLabel">计划安放格位数量</td>
							  <td class="FieldInput"><label name="计划安放格位数量" id="E_planCageHoleNum" field="planCageHoleNum" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际安放格位数量</td>
							  <td class="FieldInput" colspan="3"><input name="实际安放格位数量" id="E_cageHoleNum" field="cageHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
							<tr>
							  <td class="FieldLabel">计划生态安葬数量</td>
							  <td class="FieldInput"><label name="计划生态安葬数量" id="E_planEcologicalHoleNum" field="planEcologicalHoleNum" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际生态安葬数量</td>
							  <td class="FieldInput" colspan="3"><input name="实际生态安葬数量" id="E_ecologicalHoleNum" field="ecologicalHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
							<tr>
							  <td class="FieldLabel">计划公益安葬数量</td>
							  <td class="FieldInput"><label name="计划公益安葬数量" id="E_planWelfareHoleNum" field="planWelfareHoleNum" style="text-align:right" maxlength="50"></label>个</td>
							  <td class="FieldLabel">实际公益安葬数量</td>
							  <td class="FieldInput" colspan="3"><input name="实际公益安葬数量" id="E_welfareHoleNum" field="welfareHoleNum" style="text-align:right" maxlength="50"></input>个<font color="red">*</font></td>
							</tr>
						<TR>
							<td class="FieldLabel" >经营管理方式<br>(维护管理办法)</td>
							<td class="FieldInput"  colspan="5">
							<label name="经营管理方式（维护管理办法）" field="manageStyle" 
								style="height: 80"></label></td>
						</TR>
						
						<tr>
							<td class="FieldLabel">服务内容</td>
							<td class="FieldInput" colspan="5">
							<input type="checkbox" name="服务内容" value="1" 
								field="serviceScope" label="殡仪服务" disabled="disabled"/>殡仪服务 <br />
							<input type="checkbox" name="serviceScope" value="2"
								field="serviceScope" label="骨灰寄存" disabled="disabled"/>骨灰寄存 <br />
							<input type="checkbox" name="serviceScope" value="3"
								field="serviceScope" label="殡葬用品销售 " disabled="disabled"/>殡葬用品销售 <br />
							<input type="checkbox" name="serviceScope" value="4"
								field="serviceScope" label="骨灰安葬" disabled="disabled"/>骨灰安葬 <br/>
						</tr>
						<tr>
							<td class="FieldLabel">主办单位申请理由</td>
							<td class="FieldInput" colspan="5"><label name="主办单位申请理由" field="note" 
								style="height: 80"></label> </td>
						</tr>
					</table>
					</fieldset>
					</form>
					
				</next:Html>
			</next:Panel>

		
				
			
			
<next:Panel id="shenhePanel" title="审核审批" width="100%" height="100%">
<next:Html>
    <form id="shenheForm"   dataset="fisCemeApplyInfoDs" onsubmit="return false" style="padding: 5px;" class="L5form">
		 <div id="shenHe2" >
			<fieldset><legend>审核意见</legend>
			<table width="100%">
			<tr>
			<td class="FieldLabel" rowspan="3" width="100px;" >申请<br>报告<br>文件</td>
			<td class="FieldLabel" width="10%" id="firstReportNameLabel">文件名称</td>
			<td class="FieldInput" id="firstReportNameInput"><input type="text" validateName="报告文件名"  name="firstReportName" id="firstReportName" field="firstReportName" style="width: 300px"  /></td>
			</tr>
			<tr>
			<td class="FieldLabel" style="width:10%" id="firstReportNumberLabel">文件文号</td>
			<td class="FieldInput" ><input type="text" validateName="报告文号"  name="firstReportNumber" id="firstReportNumber" field="firstReportNumber" style="width: 300px"  /></td>
			</tr>
			<tr>
			<td class="FieldLabel" style="width:10%" id="firstReportTimeLabel">文件时间</td>
			<td class="FieldInput" ><input type="text" validateName="报告时间"format="Y-m-d" style="width: 100px" name="firstReportTime" id="firstReportTime" field="firstReportTime" maxlength="10"  readonly="readonly"/><img  src="../../../../../skins/images/default/rl.gif" id="img1" align="middle"  onclick="getTimes(this)"  ></td>
			</tr>
			
			<tr>
			<td class="FieldLabel" rowspan="4" width="100px;">审<br>核<br>内<br>容</td>
			<td class="FieldLabel" width="10%">审核结果</td>
			<td class="FieldInput">
			<input type="hidden" id="select" name="select" />
							<select style="width:130px;" name="firstResult" validateName="县级审核结果" id="firstResult" field="firstResult"  onChange="onChangeSelect();">
								<option dataset="fisBaseOpinionDs"></option>
							</select>
			</td>
			</tr>
			<tr>
			<td class="FieldLabel" width="10%">审核意见</td>
			<td class="FieldInput"><textarea name="审核意见" field="firstOpinion"  onpropertychange="if(value.length>1000) value=value.substr(0,1000)" maxlength="1500" validateName="县级审核意见" cols="55" rows="8"></textarea><font color="red">*可输入1000字</font></td>	
			</tr>
			<tr>
			<td class="FieldLabel" width="10%">审核时间</td>
			<td class="FieldInput" ><input type="text" validateName="县级审核时间"format="Y-m-d" style="width: 100px" name="firstTime" id="firstTime" field="firstTime" maxlength="10" readonly="readonly" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
			</tr>
			</table>
			</fieldset>
			</div>  
	    </form>
	</next:Html>
	</next:Panel>
		<next:Panel title="附件" height="200%">
			<next:EditGridPanel id="uploadGrid" width="99.9%" stripeRows="true" height="100%" dataset="accessoriesDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="附件管理" 	handler="clickUploadFile"></next:ToolBarItem>
			</next:TopBar>

			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="材料类型" field="code" width="40%" editable="false" dataset="accessoriesType"><next:TextField />
				</next:Column>
				<next:Column header="附件名称" field="accessoriesName" width="30%" editable="false"><next:TextField />
				</next:Column>
				<next:Column header="附件描述" field="note" width="28%" editable="false" ><next:TextField />
				</next:Column>
			</next:Columns>
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
<next:Window id="uploadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件"
				handler="addUploadFile"></next:ToolBarItem>
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
				renderer="delUploadFile">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="accessoriesItemDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
	
</next:Window>

<next:Window id="downloadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="downloadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭"
				handler="closeDownloadList"></next:ToolBarItem>
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