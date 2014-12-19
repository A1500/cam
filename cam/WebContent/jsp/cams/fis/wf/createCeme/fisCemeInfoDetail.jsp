<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<head>
<title>明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCemeInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var cemeApplyId='<%=request.getParameter("cemeApplyId")%>';
	var organType = '<%=BspUtil.getOrganType()%>';

	
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisCemeApplyInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"/>
	</model:dataset>
	<model:dataset id="fisCemeInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
		<!-- 审批意见历史流水 -->
	<model:dataset id="historyDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
	</model:dataset>
	<!--相关单位意见表 -->
	<model:dataset id="fisOpinionDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffOpinionQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoffOpinion"/>
	</model:dataset>
	<!-- 1:全额拨款,2:差额拨款,3:自收自支,4:企业,5:其他 -->
	<model:dataset id="corpProperties" enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true">
	</model:dataset>
	
	<model:dataset id="corpState" enumName="FIS.FUNERALHOME.STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 13:县级, 14:乡镇级, 15:村级 -->
	<model:dataset id="dominateState" enumName="FIS.FUNERALHOME.DOMINATION" autoLoad="true" global="true">
	</model:dataset>
	<model:dataset id="agreementOpinion" enumName="FIS.CEMECREATE.OPINION" autoLoad="true" global="true">
	</model:dataset>
	<model:dataset id="cemeProp" enumName="FIS.CEME.PROP" autoLoad="true" global="true">
	</model:dataset>
	<!-- #主办联办单位性质 1:企业,2:事业,其它 -->
	<model:dataset id="organizerPorp" enumName="FIS.CEME.ORGANIZERPROP" autoLoad="true" global="true">
	</model:dataset>
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
<next:TabPanel id="tab1" activeTab="0" width="100%"  height="100%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Tabs>
<next:Panel title="公墓申建信息" width="100%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="fisCemeInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>公墓新建申请明细</legend>
	<form id="editForm" dataset="fisCemeInfoDataSet" onsubmit="return false" class="L5form">
					<table border="1" width="100%" height="100%">
						<tr>
							<td class="FieldLabel" width="16%">公墓名称</td>
							<td class="FieldInput" width="16%"><label  maxlength="50" field=name style="width: 200"></label></td>
							<td class="FieldLabel" width="16%">单位编号</td>
							<td class="FieldInput" width="16%"><label  field="organId" style="font-weight: bold;"></label></td>
							<td class="FieldLabel" width="16%">单位性质</td>	
							<td class="FieldInput" width="16%"><label name="单位性质" field="properties" dataset="corpProperties"></label></td>
							
						</tr>
						<tr>
						<td class="FieldLabel" >公墓性质</td>
							<td class="FieldInput"><label name="公墓性质" field="prop" dataset="cemeProp"></label></td>
			
							<td class="FieldLabel" >管辖级别</td>
							<td class="FieldInput" ><label id="domination" field="domination" maxlength="50" style="width: 200" dataset="dominateState"></label></td>
							
							<td class="FieldLabel">组织机构代码</td>
							<td class="FieldInput"><label field="organCode" ></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >主管单位</td>
							<td class="FieldInput"  ><label name="主管单位" id="MANA_LEVEL" field="manaLevel" maxlength="50" style="width:200"></label></td>
							<td class="FieldLabel" >主管单位代码</td>
							<td class="FieldInput" colspan="3"><label  id="manaLevelId" field="manaLevelId" maxlength="50" style="width: 200"></label></td>
							
						</tr>
						<tr>
							<td class="FieldLabel">主办单位</td>
							<td class="FieldInput"  ><label name="主办单位" field="organizer"  style="width:200" maxlength="25"></label></td>
							<td class="FieldLabel" >主办单位性质</td>
							<td class="FieldInput" colspan="3"><label  name="主办单位性质" field="organizerProperties"></label>
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
							<td class="FieldLabel" >公墓负责人：</td>
							<td class="FieldInput"><label field="director" /></td>
							<td class="FieldLabel">负责人联系电话：</td>
							<td class="FieldInput" colspan="3"><label field="directorMobile" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">法人代表</td>
							<td class="FieldInput"><label name="法人代表" maxlength="36" field="legalPeople" ></label></td>
							<td class="FieldLabel" >联系电话</td>
							<td class="FieldInput"  colspan="3"><label name="法人代表联系电话" field="officePhone"></label></td>
						
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
					<tr>	
							<td class="FieldLabel" >计划安葬墓穴数：</td>
							<td class="FieldInput" ><label name="计划安葬墓穴数" id="planSinceHoleNum" field="planSinceHoleNum" style="text-align:right" maxlength="10" ></label>个</td>
							
							<td class="FieldLabel" >格位数量：</td>
							<td class="FieldInput" ><label name="计划安放格位数量" id="planCageHoleNum" field="planCageHoleNum" style="text-align:right" maxlength="10" ></label>个</td>
							
							<td class="FieldLabel" >生态安葬数量：</td>
							<td class="FieldInput" ><label name="计划生态安葬数量" id="planEcologicalHoleNum" field="planEcologicalHoleNum" style="text-align:right" maxlength="10" ></label>个</td>
					</tr>
					<tr>
					    <td class="FieldLabel">双穴数：</td>
						<td class="FieldInput" ><label name="双穴数" id="planDoubleHole" field="planDoubleHole" style="text-align:right" maxlength="10"></label>个</td>
						
					
						<td class="FieldLabel">单穴数：</td>
						<td class="FieldInput" ><label name="单穴数" id="planSingleHole" field="planSingleHole" style="text-align:right" maxlength="10" ></label>个</td>

						<td class="FieldLabel" >多穴数：</td>
						<td class="FieldInput" ><label name="多穴数" id="planMoreHole" field="planMoreHole" style="text-align:right" maxlength="10"></label>个</td>
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
							<td class="FieldLabel" >申建时间：</td>
							<td class="FieldInput" colspan="5"><label name="主办单位申请时间" id="applyTime" field="applyTime"  style="width: 60%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">主办单位申请原因</td>
							<td class="FieldInput" colspan="5"><label name="主办单位申请原因" field="note" 
								style="width: 60%;height: 80"></label> </td>
						</tr>
					</table>
					</form>
</next:Html>
</next:Panel>

<next:Panel title="相关单位意见" width="100%" autoScroll="true">
<next:Html>
<form id="form80" method="post" dataset="fisOpinionDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>国土资源单位意见</legend>

		<table width="100%">
						
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">国<br>	土<br>资<br>源</td>
							<td class="FieldLabel" width="8%">部门审核时间</td>
							<td class="FieldInput"><label name="检查时间" id="guotuTime" field="guotuTime" readonly="readonly" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  rows="10" name="检查意见" id="guotuOpinion" field="guotuOpinion" maxlength="1500"
								style="width: 80%" readonly="readonly"> </textarea></td>
						</tr>
					</table>

</fieldset>
</form>
<form id="form81" method="post" dataset="fisOpinionDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>城乡规划单位意见</legend>

		<table width="100%">
						
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">城<br>	乡<br>规<br>划</td>
							<td class="FieldLabel" width="8%">部门审核时间</td>
							<td class="FieldInput"><label name="城乡规划审核时间" id="townTime" field="townTime" readonly="readonly" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  rows="10" name="城乡规划审核意见" id="townOpinion" field="townOpinion" maxlength="1500"
								style="width: 80%" readonly="readonly"> </textarea></td>
						</tr>
					</table>

</fieldset>
</form>

<form id="form82" method="post" dataset="fisOpinionDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>环境保护单位意见</legend>

		<table width="100%">
						
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">环<br>	境<br>保<br>护</td>
							<td class="FieldLabel" width="8%">部门审核时间</td>
							<td class="FieldInput"><label name="环境保护审核时间" id="huanbaoTime" field="huanbaoTime" readonly="readonly" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  rows="10" name="环境保护审核意见" id="huanbaoOpinion" field="huanbaoOpinion" maxlength="1500"
								style="width: 80%" readonly="readonly"> </textarea></td>
						</tr>
					</table>

</fieldset>
</form>
<form id="form81" method="post" dataset="fisOpinionDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>林业部门意见</legend>

		<table width="100%">
						
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">林<br>	业</td>
							<td class="FieldLabel" width="8%">部门审核时间</td>
							<td class="FieldInput"><label name="林业审核时间" id="linyeTime" field="linyeTime" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  rows="10"	name="林业审核意见" id="linyeOpinion" field="linyeOpinion" maxlength="1500"
								style="width: 80%" readonly="readonly"> </textarea></td>
						</tr>
					</table>

</fieldset>
</form>
<form id="form86" method="post" dataset="fisOpinionDataSet" onsubmit="return false" class="L5form">
		<fieldset>
		<legend>其他部门意见</legend>
		
				<table width="100%">
								
								<tr>
									<td class="FieldLabel" rowspan="2" width="100px;">其<br>	他</td>
									<td class="FieldLabel" width="8%">部门审核时间</td>
									<td class="FieldInput"><label field="qitaTime" readonly="readonly" format="Y-m-d" onclick="LoushangDate(this)" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="8%">部门审核意见</td>
									<td class="FieldInput" colspan="3"><textarea  readonly="readonly" field="qitaOpinion" maxlength="1500"
										style="width: 80%" rows="10"> </textarea></td>
								</tr>
							</table>
		
		</fieldset>
		</form>

</next:Html>
</next:Panel>


<next:Panel title="公墓申建审批" width="100%" autoScroll="true">
		<next:Html>
		<form id="form8" method="post" dataset="fisCemeApplyInfoDataSet" onsubmit="return false" class="L5form">
		<div id="shouLi" >
		<fieldset>
		<legend>乡镇受理意见</legend>
			<table width="100%">
						
						<tr>
							<td class="FieldLabel" rowspan="4" width="100px;">乡<br>	镇<br>受<br>理</td>
							<td class="FieldLabel" width="10%">受理时间</td>
							<td class="FieldInput"><label type="text" name="检查时间" id="zeroTime" field="zeroTime" style="width: 30%" readonly="readonly" format="Y-m-d" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">乡镇(街办)名称：</td>
							<td class="FieldInput"><label type="text" name="当前乡镇(街办)名称" id="zeroUnit" field="zeroUnit" style="width: 30%" maxlength="50"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="10%">乡镇(街办)审核结果：</td>
							<td class="FieldInput"><label field="zeroResult" style="width: 30%" dataset="agreementOpinion"></td>	
												
						</tr>
						<tr>
							<td class="FieldLabel" width="10%">受理意见</td>
							<td class="FieldInput" colspan="3"><textarea  readonly="readonly"   rows="10" name="检查意见" id="zeroOpinion" field="zeroOpinion" maxlength="1500" style="width: 80%"> </textarea></td>
						</tr>
					</table>
			</fieldset>
			</div>
			<div id="shenPi" >
					<fieldset><legend>县级审批</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" rowspan="3" width="100px;">批<br>	复<br>内<br>容</td>
							<td class="FieldLabel" width="10%">批复时间</td>
							<td class="FieldInput"><label  field="firstReportTime" style="width: 30%" readonly="readonly" format="Y-m-d" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">批复文件名：</td>
							<td class="FieldInput" ><label  field="firstReportName" style="width: 30%" maxlength="50" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">批复文号：</td>
							<td class="FieldInput" ><label field="firstReportNumber" style="width: 30%" maxlength="50" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" rowspan="4" width="100px;">县<br>	级<br>审<br>批</td>
							<td class="FieldLabel" width="10%">审核时间</td>
							<td class="FieldInput"><label field="firstTime" style="width: 30%" readonly="readonly" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%" >区县名称：</td>
							<td class="FieldInput" ><label type="text" id="firstUnit" field="firstUnit" style="width: 30%" maxlength="50" /></td>
						</tr>
							<tr>
							<td class="FieldLabel" width="10%">审核结果：</td>
							<td class="FieldInput"><label field="firstResult" style="width: 30%" dataset="agreementOpinion" /></td>	
												
						</tr>
						<tr>
							<td class="FieldLabel" width="10%">审批意见</td>
							<td class="FieldInput" colspan="3"><textarea  rows="10" name="审批意见" id="firstOpinion" field="firstOpinion" maxlength="1500"
								style="width: 80%" readonly="readonly" > </textarea></td>
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
				<next:ToolBarItem iconCls="add" text="附件下载" handler="clickUploadFileTown"></next:ToolBarItem>
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
<next:Window id="downloadList" closeAction="hide" title="附件下载列表"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="downloadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件下载列表"></next:ToolBarItem>
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
			<next:Column header="下载附件" field="" width="10%" editable="false"  renderer="downloadUploadFile">
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