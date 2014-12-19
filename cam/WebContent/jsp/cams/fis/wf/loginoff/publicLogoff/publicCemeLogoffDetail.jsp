<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<html>
<head>
<title>殡葬业务公墓撤销审核</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="publicCemeLogoffDetail.js"></script> 
<script type="text/javascript" src="../backspace.js"></script> 
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var recordId='<%=request.getParameter("recordId")%>';
	var cemeApplyId='<%=request.getParameter("cemeApplyId")%>';
	var logoffId = '<%=request.getParameter("logoffId")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
</script>
</head>
<body>

<model:datasets>
	    <!--公墓审批业务表  -->
	<model:dataset id="fisCemeApplyInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"/>
	</model:dataset>
	<!-- 审核结果 -->
	<model:dataset id="fisBaseOpinionDs" enumName="FIS.BASE_OPINION" autoLoad="true" global="true"></model:dataset>
	<!-- 备案信息 -->
	<model:dataset id="fisCemeLogoffDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoff"/>
	</model:dataset>
	<!-- 外管单位意见 -->
	<model:dataset id="cemeLogoffOpinionDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffOpinionQueryCmd" pageSize="5">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoffOpinion"/>
	</model:dataset>
	<!--公墓信息-->
	<model:dataset id="fisCemeDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="5">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
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
<next:Panel>
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="detail" handler="rejectDetail" text="查看审批记录"></next:ToolBarItem>
        <next:ToolBarItem iconCls="return" handler="goBack" text="返回"></next:ToolBarItem>
    </next:TopBar>
<next:TabPanel width="100%" height="100%" id="TabPanel">
<next:Tabs>
<next:Panel title="公墓信息" width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="fisCemeDataSet" onsubmit="return false"
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
					field="serviceScope" label="殡仪服务" readonly="readonly"/>殡仪服务 <br />
				<input type="checkbox" name="serviceScope" value="2"
					field="serviceScope" label="骨灰寄存" readonly="readonly"/>骨灰寄存 <br />
				<input type="checkbox" name="serviceScope" value="3"
					field="serviceScope" label="殡葬用品销售 " readonly="readonly"/>殡葬用品销售 <br />
				<input type="checkbox" name="serviceScope" value="4"
					field="serviceScope" label="骨灰安葬" readonly="readonly"/>骨灰安葬 <br/>
					
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

<next:Panel id="detailPanel" title="关闭事项" width="100%" height="99%">
		<next:Html>
		<form id="beianForm1"    onsubmit="return false" dataset="fisCemeDataSet" style="padding: 5px;" class="L5form">
		  <fieldset>
		   <legend>安葬穴位数量信息</legend>
		    <table width="98%">
		         <tr>
			       <td class="FieldLabel" width="10%">安葬墓穴数量</td>
			       <td class="FieldInput" width="40%"><label name="sinceHoleNum" id="sinceHoleNum" field="sinceHoleNum"/></td>
			       <td class="FieldLabel" width="10%">安放格位数量</td>
			       <td class="FieldInput" width="40%"><label name="cageHoleNum" id="cageHoleNum" field="cageHoleNum"/></td>
			    </tr>
			    <tr>
			       <td class="FieldLabel" width="10%">生态安葬数量</td>
			       <td class="FieldInput" width="40%"><label name="ecologicalHoleNum" id="ecologicalHoleNum" field="ecologicalHoleNum"/></td>
			       <td class="FieldLabel" width="10%">公益安葬数量</td>
			       <td class="FieldInput" width="40%"><label name="welfareHoleNum" id="welfareHoleNum" field="welfareHoleNum"/></td>
			    </tr>
		     </table>
		    </fieldset>
		 </form>
		 
		<form id="beianForm"    onsubmit="return false" dataset="fisCemeLogoffDs" style="padding: 5px;" class="L5form">
		   <fieldset>
		   
		   <legend>公墓撤销备案信息</legend>
			  <table width="98%">
				<tr>
					<td  class="FieldLabel" >撤销原因</td>
					<td class="FieldInput" colspan="7"><textarea name="logoffReason" field="logoffReason"  validateName="县级审核意见" cols="50" rows="8" readonly="readonly"></textarea> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" >撤销时间</td>
					<td class="FieldInput" colspan="7"><label field="logoffDate"/> </td>
				</tr>
			</table>
		 </fieldset>
	    </form>
	 </next:Html>
  </next:Panel>

	<next:Panel id="xgPanel" title="外管单位意见" width="100%" height="100%" autoScroll="true">
		<next:Html>
			<form id="form80" method="post" dataset="cemeLogoffOpinionDs" onsubmit="return false" class="L5form">
			<fieldset>
			<legend>国土资源单位意见</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" rowspan="2" width="100px;">国<br>	土<br>资<br>源</td>
						<td class="FieldLabel" width="8%">部门审核时间</td>
						<td class="FieldInput"><label name="检查时间" id="guotuTime" field="guotuTime" style="width: 80%" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="8%">部门审核意见</td>
						<td class="FieldInput" colspan="3"><textarea  rows="10"
							name="检查意见" id="guotuOpinion" field="guotuOpinion" maxlength="1500"
							style="width: 80%" readonly="readonly"> </textarea></td>
					</tr>
				</table>
			</fieldset>
		</form>
		<form id="form81" method="post" dataset="cemeLogoffOpinionDs" onsubmit="return false" class="L5form">
		<fieldset>
		<legend>城乡规划单位意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" rowspan="2" width="100px;">城<br>	乡<br>规<br>划</td>
					<td class="FieldLabel" width="8%">部门审核时间</td>
					<td class="FieldInput"><label name="城乡规划审核时间" id="townTime" field="townTime" style="width: 80%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="8%">部门审核意见</td>
					<td class="FieldInput" colspan="3"><textarea rows="10" name="城乡规划审核意见" id="townOpinion" field="townOpinion" maxlength="1500"
						style="width: 80%" readonly="readonly"> </textarea></td>
				</tr>
			</table>
		</fieldset>
		</form>

		<form id="form82" method="post" dataset="cemeLogoffOpinionDs" onsubmit="return false" class="L5form">
		<fieldset>
		<legend>环境保护单位意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" rowspan="2" width="100px;">环<br>	境<br>保<br>护</td>
					<td class="FieldLabel" width="8%">部门审核时间</td>
					<td class="FieldInput"><label name="环境保护审核时间" id="huanbaoTime" field="huanbaoTime" style="width: 80%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="8%">部门审核意见</td>
					<td class="FieldInput" colspan="3"><textarea rows="10" name="环境保护审核意见" id="huanbaoOpinion" field="huanbaoOpinion" maxlength="1500"
						style="width: 80%" readonly="readonly"> </textarea></td>	
				</tr>
			</table>
		</fieldset>
		</form>
		<form id="form81" method="post" dataset="cemeLogoffOpinionDs" onsubmit="return false" class="L5form">
		<fieldset>
		<legend>林业部门意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" rowspan="2" width="100px;">林<br>	业</td>
					<td class="FieldLabel" width="8%">部门审核时间</td>
					<td class="FieldInput"><label name="林业审核时间" id="linyeTime" field="linyeTime" style="width: 80%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="8%">部门审核意见</td>
					<td class="FieldInput" colspan="3"><textarea rows="10" name="林业审核意见" id="linyeOpinion" field="linyeOpinion" maxlength="1500"
						style="width: 80%" readonly="readonly"> </textarea></td>
				</tr>
			</table>
		</fieldset>
		</form>
		<form id="form86" method="post" dataset="cemeLogoffOpinionDs" onsubmit="return false" class="L5form">
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

<next:Panel title="审核审批" border="false" autoScroll="true" >
	<next:Html>
	<div id="xzdiv1">
	 <form id="shenheForm"   dataset="fisCemeApplyInfoDs" onsubmit="return false" style="padding: 5px;" class="L5form">
		  <fieldset>
		  <legend>乡镇、街办审核意见</legend>
		  <table width="98%">
		    <tr>
		        <td class="FieldLabel" style="width:5%" rowspan="3">乡<p>镇<p>发<p>起</td>
	   			<td  class="FieldLabel" style="width:10%">乡镇、街办审核结果</td>
				<td class="FieldInput" style="width:60%" colspan="5">
				<label style="width:90px;" name="zeroResult" 
					 id="zeroResult" field="zeroResult" dataset="fisBaseOpinionDs"/>
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width:10%">乡镇、街办审核意见</td>
				<td class="FieldInput" colspan="5" style="width:60%"><textarea name="zeroOpinion" field="zeroOpinion"  validateName="乡镇、街办审核意见" cols="50" rows="8" readonly="readonly"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" style="width:10%">乡镇、街办审核时间</td>
				<td class="FieldInput" colspan="5" style="width:60%"><label validateName="乡镇、街办审核时间"style="width: 100px" name="zeroTime" id="zeroTime" field="zeroTime" /></td>
			</tr>
		</table>
		</fieldset>
	    </form>
	</div>
	 <div id="xjdiv1"  >
	 <form id="shform2"    onsubmit="return false" dataset="fisCemeApplyInfoDs" style="padding: 5px;" class="L5form">
		 <fieldset>
	      <legend>县级审核意见</legend>
		<table width="98%">
		    <tr>
		        <td class="FieldLabel" style="width:5%" rowspan="3">批<p>复<p>内<p>容</td>
				<td  class="FieldLabel" >报告文件名</td>
				<td class="FieldInput" ><label field="firstReportName" /></td>
			</tr>
			<tr>
			    <td  class="FieldLabel" >报告文号</td>
				<td class="FieldInput" ><label field="firstReportNumber" maxlength="10"  /></td>
			</tr>
			<tr>
			    <td  class="FieldLabel" >报告时间</td>
				<td class="FieldInput" ><label field="firstReportTime" maxlength="10"  /></td>
			</tr>
	   		<tr>
	   		    <td class="FieldLabel" style="width:5%" rowspan="3">县<p>级<p>审<p>批</td>
	   			<td  class="FieldLabel" style="width:10%">县级审批结果</td>
				<td class="FieldInput" style="width:60%" colspan="5">
				<label style="width:90px;" name="firstResult" 
					 id="firstResult" field="firstResult" dataset="fisBaseOpinionDs"/>
				</td>
			</tr>
			<tr>
				<td  class="FieldLabel" >县级审批意见</td>
				<td class="FieldInput" colspan="5"><textarea name="firstOpinion" field="firstOpinion"  cols="50" rows="8" readonly="readonly"></textarea> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >县级审批时间</td>
				<td class="FieldInput" colspan="5"><label type="text" format="Y-m-d" style="width: 100px" name="firstTime" field="firstTime" maxlength="10"  /></td>
			</tr>
		</table>
		</fieldset>
	   </form>
	  </div>
	</next:Html>
	</next:Panel>
	<next:Panel title="附件">
		<next:EditGridPanel id="uploadGrid" width="99.9%"
			stripeRows="true" height="100%" dataset="accessoriesDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="view" text="附件下载"
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
					editable="false" >
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
<next:Window id="uploadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
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