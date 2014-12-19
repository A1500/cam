<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>殡葬业务公墓关闭审核</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="publicCemeLogoffInsert.js"></script> 
<script type="text/javascript" src="../checkNull.js"></script> 
<script type="text/javascript" src="../../backspace.js"></script> 
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var cemeAppId='<%=request.getParameter("cemeApplyId")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var method='<%=request.getParameter("method")%>';
	var logoffId = '<%=IdHelp.getUUID32()%>';
	var opinionId = '<%=IdHelp.getUUID32()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organType = '<%=BspUtil.getOrganType()%>' ;
	var cemeApplyId = '<%=IdHelp.getUUID32()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var hisId = '<%= IdHelp.getUUID32()%>';
	var date ='<%=DateUtil.getDay()%>';
	var time ='<%=DateUtil.getTime()%>';
</script>
</head>
<body>

<model:datasets>
    <!-- 公墓业务信息 -->
	<model:dataset id="fisCemeApplyInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo">
		   <model:field name="zeroResult" type="string" rule="require"/>
		   <model:field name="zeroOpinion" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	<!-- 公墓业务信息查询，用于校验 -->
	<model:dataset id="fisCemeApplyInfoQueryDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"/>
	</model:dataset>
	<!-- 审核结果枚举 0：同意,1：不同意 -->
	<model:dataset id="fisBaseOpinionDs" enumName="FIS.OPINION" autoLoad="true" global="true"></model:dataset>
	<!-- 备案信息 -->
	<model:dataset id="fisCemeLogoffDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoff">
		    <model:field name="logoffReason" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 公墓信息 -->
	<model:dataset id="fisCemeDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="5">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo">
		     <model:field name="sinceHoleNum" type="string" rule="require|integer" />
		     <model:field name="singleHole" type="string" rule="require|integer" />
		     <model:field name="doubleHole" type="string" rule="require|integer" />
		     <model:field name="moreHole" type="string" rule="require|integer" />
		     <model:field name="cageHoleNum" type="string" rule="require|integer" />
		     <model:field name="ecologicalHoleNum" type="string" rule="require|integer" />
		</model:record>
	</model:dataset>
	<!-- 外管单位意见 -->
	<model:dataset id="cemeLogoffOpinionDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeLogoffOpinionQueryCmd" pageSize="5">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeLogoffOpinion">
		    <model:field name="guotuOpinion" type="string"rule="require"/>
		    <model:field name="guotuTime" type="string"rule="require"/>
		    <model:field name="townOpinion" type="string"rule="require"/>
		    <model:field name="townTime" type="string"rule="require"/>
		    <model:field name="huanbaoOpinion" type="string"rule="require"/>
		    <model:field name="huanbaoTime" type="string"rule="require"/>
		</model:record>
	</model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="propertiesDataSet" enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!-- 公墓性质 -->
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP" autoLoad="true" global="true"></model:dataset>
	<!-- 管辖级别 -->
	<model:dataset id="dominationDS" enumName="FIS.CEME.DOMINATION" autoLoad="true" global="true"></model:dataset>
	<!-- 驳回记录表 -->
	<model:dataset id="historyDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckHistoryQueryCmd" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeCheckHistory"/>
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

<next:ViewPort>
<next:Panel>
   <next:TopBar>
      <next:ToolBarItem symbol="->"></next:ToolBarItem>
      <next:ToolBarItem iconCls="save" handler="save" text="保存"></next:ToolBarItem>
      <next:ToolBarItem iconCls="return" handler="returnBack" text="返回"></next:ToolBarItem>
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
				<td class="FieldInput"  style="width: 210"><label name="公墓名称" maxlength="50" field=name style="width: 200"></label>
					<img id="queryCeme" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
								style="cursor: hand" onclick="forCemeSelect()" title="列表选择"/></td>
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
				<td class="FieldInput" ><label name="主管单位" id="MANA_LEVEL" field="manaLevel" maxlength="50" ></label></td>
				<td class="FieldLabel" >主管单位代码</td>
				<td class="FieldInput" colspan="3"><label name="主管单位代码" id="MANA_LEVEL_ID" field="manaLevelId" maxlength="50" ></label></td>
				
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
				<td class="FieldInput"  colspan="3"><label name="法人代表联系电话" id="OFFICE_PHONE" field="officePhone" maxlength="50"></label></td>
			
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
					field="serviceScope" label="殡葬用品销售 "disabled="disabled" />殡葬用品销售 <br />
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
<next:Panel id="detailPanel" title="关闭事项" width="100%" height="99%">
		<next:Html>
		<form id="beianForm"    onsubmit="return false" dataset="fisCemeDataSet" style="padding: 5px;" class="L5form">
		   <fieldset>
		   <legend>公墓信息</legend>
		   <table width="98%">
		       <tr>
			       <td class="FieldLabel" rowspan="4" width="15%">安葬墓穴数量</td>
			       <td class="FieldLabel" width="15%">单穴</td>
			       <td class="FieldInput" colspan="2"><input type="text" name="单穴数" id="singleHole" field="singleHole"/><font color="red">*</font></td>
			    </tr>
			    <tr>
			       <td class="FieldLabel" width="15%">双穴</td>
			       <td class="FieldInput" colspan="2"><input type="text" name="双穴数" id="doubleHole" field="doubleHole"/><font color="red">*</font></td>
			    </tr>
			    <tr>
			        <td class="FieldLabel" width="15%">多穴</td>
			       <td class="FieldInput" colspan="2"><input type="text" name="多学数" id="moreHole" field="moreHole"/><font color="red">*</font></td>
			    </tr>
			    <tr>
			       <td class="FieldLabel" width="15%">合计</td>
			       <td class="FieldInput" colspan="2"><input type="text" name="合计数" id="sinceHoleNum" field="sinceHoleNum"/><font color="red">*</font></td>
			    </tr>
			    <tr>
			       <td class="FieldLabel">安放格位数量</td>
			       <td class="FieldInput"><input type="text" name="安放格位数量" id="cageHoleNum" field="cageHoleNum"/><font color="red">*</font></td>
			       <td class="FieldLabel" width="15%">生态安葬数量</td>
			       <td class="FieldInput"><input type="text" name="生态安葬数量" id="ecologicalHoleNum" field="ecologicalHoleNum"/><font color="red">*</font></td>
			    </tr>
		   </table>
		   </fieldset>
		</form>
		<form id="beianForm"    onsubmit="return false" dataset="fisCemeLogoffDs" style="padding: 5px;" class="L5form">
		   <fieldset>
		   <legend>公墓关闭备案信息</legend>
			  <table width="98%">
				<tr>
					<td  class="FieldLabel" >关闭原因</td>
					<td class="FieldInput" colspan="7"><textarea name="关闭原因" field="logoffReason"  cols="50" rows="8"></textarea><font color="red">*</font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" >关闭时间</td>
					<td class="FieldInput" colspan="7"><input type="text" format="Y-m-d" style="width: 100px" name="关闭时间" id="logoffDate" field="logoffDate" maxlength="10"  readonly="readonly"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
				</tr>
			</table>
		 </fieldset>
	    </form>
	 </next:Html>
  </next:Panel>

	<next:Panel title="外管单位意见" width="100%" autoScroll="true" height="98%">
		<next:Html>
			<form id="form80" method="post" dataset="cemeLogoffOpinionDs" onsubmit="return false" class="L5form">
			<fieldset>
			<legend>国土资源单位意见</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" rowspan="2" width="100px;">国<br>	土<br>资<br>源</td>
						<td class="FieldLabel" width="8%">部门审核时间</td>
						<td class="FieldInput"><input type="text" format="Y-m-d" style="width: 100px" name="国土资源部门审核时间" id="guotuTime" field="guotuTime" maxlength="10" readonly="readonly" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
					</tr>
					<tr>
						<td class="FieldLabel" width="8%">部门审核意见</td>
						<td class="FieldInput" colspan="3"><textarea  rows="10"
							name="国土资源部门审核意见" id="guotuOpinion" field="guotuOpinion" maxlength="1500"
							 style="width: 80%"> </textarea><font color="red">*</font></td>
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
					<td class="FieldInput"><input type="text" format="Y-m-d" style="width: 100px" name="城乡规划部门审核时间" id="townTime" field="townTime" maxlength="10" readonly="readonly" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
					
				</tr>
				<tr>
					<td class="FieldLabel" width="8%">部门审核意见</td>
					<td class="FieldInput" colspan="3"><textarea rows="10" name="城乡规划审核意见" id="townOpinion" field="townOpinion" maxlength="1500"
						style="width: 80%" > </textarea><font color="red">*</font></td>
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
					<td class="FieldInput"><input type="text" name="环境保护审核时间"format="Y-m-d" style="width: 100px" id="huanbaoTime" field="huanbaoTime" maxlength="10" readonly="readonly" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
				</tr>
				<tr>
					<td class="FieldLabel" width="8%">部门审核意见</td>
					<td class="FieldInput" colspan="3"><textarea rows="10" name="环境保护审核意见" id="huanbaoOpinion" field="huanbaoOpinion" maxlength="1500"
						style="width: 80%"> </textarea><font color="red">*</font></td>	
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
					<td class="FieldInput"><input type="text" name="林业部门审核时间"format="Y-m-d" style="width: 100px" id="linyeTime" field="linyeTime" maxlength="10" readonly="readonly" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  > </td>
				</tr>
				<tr>
					<td class="FieldLabel" width="8%">部门审核意见</td>
					<td class="FieldInput" colspan="3"><textarea rows="10" name="林业审核意见" id="linyeOpinion" field="linyeOpinion" maxlength="1500"
						style="width: 80%" > </textarea></td>
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

<next:Panel id="shenhePanel" title="审核审批" width="100%" height="100%">
<next:Html>
    <form id="shenheForm"   dataset="fisCemeApplyInfoDs" onsubmit="return false" style="padding: 5px;" class="L5form">
		  <fieldset>
		  <legend>乡镇、街办审核意见</legend>
		  <table width="98%">
		    <tr>
		        <td  class="FieldLabel" rowspan="3" style="width:5%">乡<p>镇<p>、<p>街<p>办<p>发<p>起</td>
		        <td  class="FieldLabel" style="width:10%">乡镇、街办审核结果</td>
		        <td>
		           <select field="zeroResult" name="审核结果">
		              <option dataset="fisBaseOpinionDs"></option>
		           </select><font color="red">*</font>
		        </td>     
		    </tr>
			<tr>
				<td  class="FieldLabel" >乡镇、街办审核意见</td>
				<td class="FieldInput" colspan="5"><textarea name="zeroOpinion" field="zeroOpinion"  validateName="乡镇、街办审核意见" cols="50" rows="8"></textarea><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >乡镇、街办审核时间</td>
				<td class="FieldInput" colspan="5"><input type="text" validateName="乡镇、街办审核时间"format="Y-m-d" style="width: 100px" name="zeroTime" id="zeroTime" field="zeroTime" maxlength="10" readonly="readonly" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
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
				<next:ToolBarItem iconCls="upload" text="附件上传"
					handler="clickUploadFile"></next:ToolBarItem>
				<next:ToolBarItem iconCls="view" text="附件下载"
					handler="clickDownloadFile"></next:ToolBarItem>
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
<!-- 下载窗口 -->
<next:Window id="downloadList" closeAction="hide" title="附件下载"
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
<!-- 附件管理窗口 -->
<next:Window id="uploadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="附件上传"
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
</body>
</html>