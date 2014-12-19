<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>殡葬墓地申建</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="../backspace.js"></script>
<script type="text/javascript" src="fisCemeInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
<%
	String cemeCode = BspUtil.getCorpOrgan().getOrganCode();
	if(cemeCode.endsWith("0000000000")){//省370000000000
		cemeCode=cemeCode.substring(0,2);
	} else if (cemeCode.endsWith("00000000")){//市370100000000
		cemeCode= cemeCode.substring(0,4);
	} else if (cemeCode.endsWith("000000")){//县370104000000
		cemeCode= cemeCode.substring(0,6);
	} else if (cemeCode.endsWith("000")){//乡370104003000
		cemeCode= cemeCode.substring(0,9);
	}
%>
	var cemeCode='<%=cemeCode%>'
	var method='<%=request.getParameter("method")%>';
	var cemeApplyId='<%=request.getParameter("cemeApplyId")%>';
	var curOrganName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
	var empOrganId = '<%=BspUtil.getEmpOrganId()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var parentOrganName='<%=BspUtil.getParentOrgan().getOrganName()%>';
	var parentOrganCode='<%=BspUtil.getParentOrgan().getOrganCode()%>';
	var parentOrganType='<%=BspUtil.getParentOrgan().getOrganType()%>';
	var recordIdNew = '<%=IdHelp.getUUID32()%>';
	var cemeApplyIdNew = '<%=IdHelp.getUUID32()%>';
	var opinionIdNew = '<%=IdHelp.getUUID32()%>';
	var hisIdNew = '<%=IdHelp.getUUID32()%>';
	var curTime = '<%=DateUtil.getTime()%>';
	var curDay = '<%=DateUtil.getDay()%>';


</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisCemeInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo">
		</model:record>
	</model:dataset>
	<model:dataset id="fisCemeExpendInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeExpendInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeExpendInfo">
			<model:field name="yearPlanto" type="string" rule="require|integer" /> 
			<model:field name="landProperties" type="string" rule="require" /> 		
			<model:field name="applyTime" type="string" rule="require" /> 
			<model:field name="planSinceHoleNum" type="string" rule="require|integer" />
			<model:field name="planSingleHole" type="string" rule="require|integer" />
			<model:field name="planDoubleHole" type="string" rule="require|integer" /> 
			<model:field name="planMoreHole" type="string" rule="require|integer" />
			<model:field name="yearPlanto" type="string" rule="require|integer" /> 
			<model:field name="totalArea" type="string" rule="require|integer" />
			<model:field name="businessArea" type="string" rule="require|integer" />
			<model:field name="filesroomArea" type="string" rule="require|integer" />
			<model:field name="officeromArea" type="string" rule="require|integer" />
			<model:field name="greenArea" type="string" rule="require|integer" />
			<model:field name="manageStyle" type="string" rule="require" />
			<model:field name="note" type="string" rule="require" />
			<model:field name="address" type="string" rule="require" />	
			<model:field name="fundTotal" type="string" rule="require|integer" />
			<model:field name="fundFinance" type="string" rule="require|integer" />
			<model:field name="fundHigher" type="string" rule="require|integer" />
			<model:field name="fundSelf" type="string" rule="require|integer" />
			<model:field name="fundLottery" type="string" rule="require|integer" />
			<model:field name="fundOther" type="string" rule="require|integer" />
			<model:field name="manageStyle" type="string" rule="require" /> 
		</model:record>
	</model:dataset>
	<!-- 公墓信息表查询备份 -->
	<model:dataset id="cemeQueryDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="20">
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
	
	<!-- 业务表 -->
	<model:dataset id="fisCemeApplyInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
			<model:field name="zeroResult" type="string" rule="require" />
			<model:field name="zeroTime" type="string" rule="require" />			
			<model:field name="zeroOpinion" type="string" rule="require" />	
		</model:record>
	</model:dataset>
	<!-- 业务表 -->
	<model:dataset id="queryApplyDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" method="queryExpend" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 主办单位性质  1:全额拨款,2:差额拨款,3:自收自支,4:企业,5:其他 -->
	<model:dataset id="corpProperties" enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true">
	</model:dataset>
	<!-- 单位状态 正常营业，关闭 -->
	<model:dataset id="corpState" enumName="FIS.FUNERALHOME.STATE" autoLoad="true" global="true">
	</model:dataset>
	
	<!-- 13:县级, 14:乡镇级, 15:村级 -->
	<model:dataset id="dominateState" enumName="FIS.FUNERALHOME.DOMINATION" autoLoad="true" global="true">
	</model:dataset>
	<!-- 公墓性质 1:公益性, 2:经营性 -->
	<model:dataset id="cemeProp" enumName="FIS.CEME.PROP" autoLoad="true" global="true">
	</model:dataset>
	<!-- 公益性公墓维护管理办法 1:免费, 2:收费-->
	<model:dataset id="manageStyle2GY" enumName="FIS.CEME.MANAGESTYLE" autoLoad="true" global="true">
	</model:dataset>
	
	<!-- #主办联办单位性质 1:企业,2:事业,其它 -->
	<model:dataset id="organizerPorp" enumName="FIS.CEME.ORGANIZERPROP" autoLoad="true" global="true">
	</model:dataset>
	<model:dataset id="agreementOpinion" enumName="FIS.CEMECREATE.OPINION" autoLoad="true" global="true">
	</model:dataset>
	
	<model:dataset id="accessoriesDataSet" 	cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd"	method="queryAccessoryType" global="true">
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
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="edit" text="数据校验" handler="jiaoYan"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Tabs>

<next:Panel title="扩建公墓信息" width="100%" autoScroll="true">
	<next:Html>

						<form id="form1" method="post" dataset="fisCemeInfoDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>原扩建公墓信息</legend>
						<table border="1" width="100%" height="100%">
						<tr>
							<td class="FieldLabel" width="16%">公墓名称</td>
							<td class="FieldInput"  width="16%"><label name="公墓名称" maxlength="50" field=name></label>
							<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
							style="cursor: hand" onclick="forCemeSelect()" title="列表选择" id="imgs"/></td>
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
							<td class="FieldInput" colspan="3"><label  name="主办单位性质" field="organizerProperties" dataset="organizerPorp"></label>
							</td>
						
						</tr>
						<tr>
							<td class="FieldLabel" >联办单位</td>
							<td class="FieldInput"  ><label name="联办单位" id="coOrganizer" field=coOrganizer maxlength="50" style="width:200"></label></td>
							<td class="FieldLabel" >联办单位性质</td>
							<td class="FieldInput" colspan="3"><label name="联办单位性质" field="coOrganizerProperties" dataset="organizerPorp"></label></td>
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
						</table>
					</fieldset>
					</form>
					<form id="form2" method="post" dataset="fisCemeExpendInfoDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>扩建信息</legend>
						<table border="1" width="100%" height="100%" dataset="fisCemeExpendInfoDataSet" >				
						<tr>
							
							<td class="FieldLabel" width="12%" >新增公墓计划使用年限至</td>
							<td class="FieldInput" ><input type="text" name="新增公墓计划使用年限至" id="yearPlantoNew" field="yearPlanto" maxlength="4" /><font color="red">*</font></td>
							<td class="FieldLabel">所在地址</td>
							<td class="FieldInput" colspan="3"><input type="text" name="所在地址" maxlength="100" field="address" style="width: 200"/><font color="red">*</font></td>
						
						</tr>
						<tr>
						<td class="FieldLabel" width="16%">占用土地性质</td>
							<td class="FieldInput" width="16%"><input type="text" name="占用土地性质" id="LAND_PROPERTIES" field="landProperties" maxlength="50" /><font color="red">*</font></td>
							
							<td class="FieldLabel" width="16%">占地面积</td>
							<td class="FieldInput" width="16%"><input type="text" name="占地面积" id="totalArea" maxlength="13" style="text-align:right" 
								field="totalArea" />亩<font color="red">*</font></td>
							<td class="FieldLabel" width="16%">墓区建成面积</td>
							<td class="FieldInput" width="16%"><input type="text" name="墓区建成面积" id="builtArea" maxlength="13" style="text-align:right" 
								field="builtArea" />亩<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">建筑面积</td>
							<td class="FieldInput"><input type="text" name="建筑面积" id="builtTotalArea" maxlength="13" style="text-align:right" 
								field="builtTotalArea" />㎡<font color="red">*</font></td>
							<td class="FieldLabel" >营业室面积</td>
							<td class="FieldInput" ><input type="text" name="营业室面积" id="businessArea" field="businessArea"  style="text-align:right"   maxlength="10" />㎡<font color="red">*</font></td>
							<td class="FieldLabel" >档案室面积</td>
							<td class="FieldInput" ><input type="text" name="档案室面积" id="filesroomArea" field="filesroomArea"   style="text-align:right"  maxlength="10" />㎡<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" >办公室面积</td>
							<td class="FieldInput" ><input type="text" name="办公室面积（㎡）" id="officeromAinput" type="text"style="text-align:right"   field="officeromArea" maxlength="10" />㎡<font color="red">*</font></td>
							<td class="FieldLabel" >绿地面积</td>
							<td class="FieldInput" ><input type="text" name="绿地面积（㎡）" id="greenArea" style="text-align:right" field="greenArea" maxlength="10" />㎡<font color="red">*</font></td>
							<td class="FieldLabel" >绿化覆盖率</td>
							<td class="FieldInput" ><input type="text" name="绿化覆盖率(%)" id="greenRatio" style="text-align:right"   field="greenRatio" maxlength="10" />%<font color="red">*</font></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">总投资额</td>
							<td class="FieldInput"><input type="text" name="总投资额" id="totalInvestment" maxlength="13" style="text-align:right" 
								field="totalInvestment" />万元<font color="red">*</font></td>
						
							<td class="FieldLabel">固定资产</td>
							<td class="FieldInput"  colspan="3"><input type="text" name="固定资产" id="fixedAssets" maxlength="10" style="text-align:right" 
								field="fixedAssets"/>万元<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" >建设资金合计</td>
							<td class="FieldInput" ><input type="text" name="建设资金合计" id="fundTotal" field="fundTotal"  style="text-align:right" maxlength="10" />万元<font color="red">*</font></td>
							<td class="FieldLabel" >财政拨款</td>
							<td class="FieldInput" ><input type="text" name="财政拨款" id="fundFinance"  field="fundFinance" style="text-align:right" maxlength="10" />万元<font color="red">*</font></td>
							<td class="FieldLabel" >上级部门拨款</td>
							<td class="FieldInput" ><input type="text" name="上级部门拨款" id="fundHigher"   field="fundHigher" style="text-align:right" maxlength="10" />万元<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" >自筹</td>
							<td class="FieldInput" ><input type="text" name="自筹" id="fundSelf"   field="fundSelf" style="text-align:right" maxlength="10" />万元<font color="red">*</font></td>
							<td class="FieldLabel" >福彩资助</td>
							<td class="FieldInput" ><input type="text" name="福彩资助" id="fundLottery"   field="fundLottery" style="text-align:right" maxlength="10" />万元<font color="red">*</font></td>
							<td class="FieldLabel" >其他</td>
							<td class="FieldInput" ><input type="text" name="其他" id="fundOther"   field="fundOther" style="text-align:right" maxlength="10" />万元<font color="red">*</font></td>
						</tr>
						<tr>	
							<td class="FieldLabel" >计划公益安葬数量：</td>
							<td class="FieldInput" ><input type="text" name="计划公益安葬数量" id="planWelfareHoleNum" field="planWelfareHoleNum" style="text-align:right" maxlength="10" />个</td>
					
							<td class="FieldLabel" >计划生态安葬数量：</td>
							<td class="FieldInput" ><input type="text" name="计划生态安葬数量" id="planEcologicalHoleNum" field="planEcologicalHoleNum" style="text-align:right" maxlength="10" />个</td>
					
							<td class="FieldLabel" >计划格位数量：</td>
							<td class="FieldInput" ><input type="text" name="计划安放格位数量" id="planCageHoleNum" field="planCageHoleNum" style="text-align:right" maxlength="10" />个</td>
					</tr>
					<tr>	
							<td class="FieldLabel" >计划安葬墓穴总数：</td>
							<td class="FieldInput" colspan="5"><input type="text" name="计划安葬墓穴数" id="planSinceHoleNum" field="planSinceHoleNum" style="text-align:right" maxlength="10" />个<font color="red">*</font></td>
					</tr>	
					<tr>
					
						<td class="FieldLabel">双穴数：</td>
						<td class="FieldInput" ><input type="text" name="双穴数"  id="planDoubleHole" field="planDoubleHole" style="text-align:right" maxlength="10" />个<font color="red">*</font></td>
						
					
						<td class="FieldLabel">单穴数：</td>
						<td class="FieldInput" ><input type="text" name="单穴数" id="planSingleHole" field="planSingleHole" style="text-align:right" maxlength="10" />个<font color="red">*</font></td>

						<td class="FieldLabel" >多穴数：</td>
						<td class="FieldInput" ><input type="text" name="多穴数" id="planMoreHole" field="planMoreHole" style="text-align:right" maxlength="10" />个<font color="red">*</font></td>
					</tr>
						<TR>
							<td class="FieldLabel" >维护管理办法</td>
							<td class="FieldInput"  colspan="5"><select name="维护管理办法" field="manageStyle" ><option dataset="manageStyle2GY">维护管理办法 </option></select><font color="red">*</font></td>	

						</TR>
						
						<tr>
							<td class="FieldLabel">服务内容</td>
							<td class="FieldInput" colspan="5"><input type="checkbox" name="服务内容" value="1" 
								 field="serviceScope" label="殡仪服务" />殡仪服务 <br />
							<input type="checkbox" name="serviceScope" value="2"
								 field="serviceScope" label="骨灰寄存" />骨灰寄存 <br />
							<input type="checkbox" name="serviceScope" value="3"
								field="serviceScope" label="殡葬用品销售 " />殡葬用品销售 <br />
							<input type="checkbox" name="serviceScope" value="4"
								field="serviceScope" label="骨灰安葬" />骨灰安葬 <br/>
								
						</tr>
						<tr>
							<td class="FieldLabel" >申建时间：</td>
							<td class="FieldInput" colspan="5"><input type="text" name="主办单位申请时间" id="applyTime" field="applyTime" format="Y-m-d" readonly="readonly" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">主办单位申请原因</td>
							<td class="FieldInput" colspan="5"><input type="text" name="主办单位申请原因" field="note" 
								style="width: 60%;height: 80"/><font color="red">*</font> </td>
						</tr>
						</table>
				</fieldset>
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
							<td class="FieldInput"><input type="text" name="检查时间" id="guotuTime" field="guotuTime" readonly="readonly" format="Y-m-d" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="10"
								name="检查意见" id="guotuOpinion" field="guotuOpinion" maxlength="1500"
								style="width: 80%"> </textarea><font color="red">可输入1000字</font></td>
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
							<td class="FieldInput"><input type="text" name="城乡规划审核时间" id="townTime" field="townTime" readonly="readonly" format="Y-m-d" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="10"
								name="城乡规划审核意见" id="townOpinion" field="townOpinion" maxlength="1500"
								style="width: 80%"> </textarea><font color="red">可输入1000字</font></td>
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
							<td class="FieldInput"><input type="text" name="环境保护审核时间" id="huanbaoTime" field="huanbaoTime" readonly="readonly" format="Y-m-d" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="10"
								name="环境保护审核意见" id="huanbaoOpinion" field="huanbaoOpinion" maxlength="1500"
								style="width: 80%"> </textarea><font color="red">可输入1000字</font></td>
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
							<td class="FieldInput"><input type="text" name="林业审核时间" id="linyeTime" field="linyeTime" readonly="readonly" format="Y-m-d" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">部门审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="10"
								name="林业审核意见" id="linyeOpinion" field="linyeOpinion" maxlength="1500"
								style="width: 80%"> </textarea><font color="red">可输入1000字</font></td>
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
							<td class="FieldInput"><input type="text" name="其他审核时间" id="qitaTime" field="qitaTime" readonly="readonly" format="Y-m-d" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">其他审核意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="10"
								name="住建审核意见" id="qitaOpinion" field="qitaOpinion" maxlength="1500"
								style="width: 80%"> </textarea><font color="red">可输入1000字</font></td>
						</tr>
					</table>

</fieldset>
</form>

</next:Html>
</next:Panel>

<next:Panel title="乡镇受理意见" width="100%" autoScroll="true">
<next:Html>

<form id="form8" method="post" dataset="fisCemeApplyInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>乡镇(街办)受理意见</legend>

		<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:31%" colspan="2">当前乡镇(街办)名称：</td>
							<td class="FieldInput" style="width:69%"><input type="text" name="当前乡镇(街办)名称" id="zeroUnit" field="zeroUnit" style="width: 30%" maxlength="50"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="31%" colspan="2">乡镇(街办)受理结果：</td>
							<td class="FieldInput" style="width:69%"><select name="乡镇(街办)审核结果" field="zeroResult" style="width: 30%"><option dataset="agreementOpinion">乡镇(街办)审核结果 </option></select><font color="red">*</font></td>	
												
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2" width="100px;">乡<br>	镇<br>受<br>理</td>
							<td class="FieldLabel" width="8%">乡镇(街办)受理时间</td>
							<td class="FieldInput"><input type="text" name="检查时间" id="zeroTime" field="zeroTime" readonly="readonly" format="Y-m-d" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="8%">乡镇(街办)受理意见</td>
							<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="10"
								name="检查意见" id="zeroOpinion" field="zeroOpinion" maxlength="1500"
								style="width: 80%"> </textarea><font color="red">*可输入1000字</font></td>
						</tr>
					</table>

</fieldset>
</form>
</next:Html>
</next:Panel>

<next:Panel title="附件">
		<next:EditGridPanel id="uploadGrid" width="99.9%"
			stripeRows="true" height="100%" dataset="accessoriesDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="附件管理" 	handler="clickUploadFile"></next:ToolBarItem>
			</next:TopBar>

			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="材料类型" field="code" width="40%" editable="false" dataset="accessoriesType"> <next:TextField />
				</next:Column>
				<next:Column header="附件名称" field="accessoriesName" width="30%" editable="false">	<next:TextField />
				</next:Column>
				<next:Column header="附件描述" field="note" width="28%" editable="false" > <next:TextField />
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="accessoriesDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
	</next:Panel>

</next:Tabs>
</next:TabPanel>
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