<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>公墓信息编辑</title>
<next:ScriptManager />
<script type="text/javascript">
</script>
<script type="text/javascript" src="cemeOrganUserDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
<script type="text/javascript">
	var unitId = "<%=request.getParameter("unitId")%>";
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true" method="queryImportCemeInfo">
	</model:dataset>
	<!-- 性质 -->
	<model:dataset id="propertiesDataSet" enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="cemePropDataSet" enumName="FIS.CEME.PROP" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dominationDS" enumName="FIS.CEME.DOMINATION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="公墓信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="取消" handler="reset" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			class="L5form">
		<table border="1" width="100%" height="100%">
			<tr>
				<td class="FieldLabel" width="100">公墓名称</td>
				<td class="FieldInput"  style="width: 210"><label name="公墓名称" maxlength="50" field="NAME" style="width: 200"></label></td>
				<td class="FieldLabel" width="100">单位编号</td>
				<td class="FieldInput" style="width: 210"><label name="单位编号" field="ORGAN_ID" style="font-weight: bold;"></label></td>
				<td class="FieldLabel" width="150">公墓性质</td>
				<td class="FieldInput">
					<label name="公墓性质" field="prop" dataset="cemePropDataSet"></label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" >主管单位代码</td>
				<td class="FieldInput" ><label name="主管单位代码" id="MANA_LEVEL_ID" field="manaLevelId" maxlength="50" style="width: 200"></label></td>
			
				<td class="FieldLabel">单位性质</td>
				<td class="FieldInput">
					<label name="单位性质" field="PROPERTIES" dataset="propertiesDataSet"></label>
				</td>
				<td class="FieldLabel">组织机构代码</td>
				<td class="FieldInput"><label name="组织机构代码" field="ORGAN_CODE" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" >管辖级别</td>
				<td class="FieldInput" >
					<label name="管辖级别" id="domination" field="DOMINATION" maxlength="50" style="width: 200" dataset="dominationDS"></label>
					</td>
				<td class="FieldLabel" >主管单位</td>
				<td class="FieldInput"  colspan="3"><label name="主管单位" id="MANA_LEVEL" field="manaLevel" maxlength="50" style="width:200"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">主办单位</td>
				<td class="FieldInput"  ><label name="主办单位" field="ORGANIZER"  style="width:200" maxlength="25"></label></td>
				<td class="FieldLabel" >主办单位性质</td>
				<td class="FieldInput" colspan="3">
					<label  name="主办单位性质" field="ORGANIZER_PROPERTIES"></label>
				</td>
			
			</tr>
			<tr>
				<td class="FieldLabel" >联办单位</td>
				<td class="FieldInput"  ><label name="联办单位" id="coOrganizer" field="CO_ORGANIZER" maxlength="50" style="width:200"></label></td>
				<td class="FieldLabel" >联办单位性质</td>
				<td class="FieldInput" colspan="3">
					<label name="联办单位性质" field="coOrganizerProperties" ></label>
				</td>
			</tr>
			<tr>
			<td class="FieldLabel">所属行政区划</td>
				<td class="FieldInput"><label id="deptName" name="所属行政区划" field="DEPT_NAME" readonly="readonly" ></label></td>
				<td class="FieldLabel">所在地址</td>
				<td class="FieldInput"><label name="所在地址" maxlength="100" style="width: 200"
					field="ADDRESS" ></label></td>
				<td class="FieldLabel">邮政编码</td>
				<td class="FieldInput"><label name="邮政编码" maxlength="6"
					field="PORT_CODE" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">法人代表</td>
				<td class="FieldInput"><label name="法人代表" maxlength="36" field="LEGAL_PEOPLE" ></label></td>
				<td class="FieldLabel" >联系电话</td>
				<td class="FieldInput"  colspan="3"><label name="法人代表联系电话" id="OFFICE_PHONE" field="officePhone" maxlength="50" style="width:200"></label></td>
			
			</tr>
			<!-- <tr>
				<td class="FieldLabel">负责人</td>
				<td class="FieldLabel">联系电话</td>
				<td class="FieldInput"  colspan="3"><label name="负责人手机" field="directorMobile" maxlength="15"/>
			</tr> -->
			<tr>
			
				<td class="FieldLabel">编制人数</td>
				<td class="FieldInput"><label id="numberOf" name="编制人数" maxlength="9" style="text-align:right" 
					field="NUMBER_OF" ></label>人</td>
				<td class="FieldLabel">实有人数</td>
				<td class="FieldInput"><label id="numberReal" name="实有人数" maxlength="9" style="text-align:right" 
					field="NUMBER_REAL" ></label>人</td>
					<td class="FieldLabel" >参加民政部门业务培训人数</td>
				<td class="FieldInput" ><label name="参加民政部门业务培训人数"  style="text-align:right" id="trainNum" field="TRAIN_NUM" maxlength="50" ></label>人</td>
				
			</tr>
			<tr>
				<td class="FieldLabel" >计算机管理员</td>
				<td class="FieldInput" ><label name="计算机管理员"  style="text-align:right" id="computerManager" field="COMPUTER_MANAGER" maxlength="50" ></label></td>
				<td class="FieldLabel" >联系电话</td>
				<td class="FieldInput"  colspan="3"><label name="计算机管理员联系电话" id="computerManagerPhone" field="COMPUTER_MANAGER_PHONE" maxlength="50" ></label></td>
			
			
			</tr>
			<tr>
				<td class="FieldLabel" >计算机数量</td>
				<td class="FieldInput" ><label name="计算机数量（台）"  style="text-align:right" id="computerNum" field="COMPUTER_NUM" maxlength="50" ></label>台</td>
			<td class="FieldLabel" >信息系统安装时间</td>
				<td class="FieldInput"  colspan="3"><label name="信息系统安装时间" id="fixTime" field="FIX_TIME" maxlength="50" ></label></td>
			
			</tr>
			<tr>
			<td class="FieldLabel">网站网址</td>
				<td class="FieldInput">
					<label name="网站网址" maxlength="50" field="WEB" ></label>
				</td>
				<td class="FieldLabel">电子邮件地址</td>
				<td class="FieldInput" ><label name="电子邮件地址" maxlength="50"
					field="EMAIL" ></label></td>
				<td class="FieldLabel">服务电话</td>
				<td class="FieldInput"><label name="服务电话" maxlength="16"
					field="SERVICE_PHONE" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" >批准建设时间</td>
				<td class="FieldInput" ><label name="批准建设时间" id="approveTime" field="APPROVE_TIME" ></label></td>
				<td class="FieldLabel">正式营业时间</td>
				<td class="FieldInput"><label id="qStartTime" name="正式营业时间" field="GESTION_TIME" ></label></td>
			
				<td class="FieldLabel" >计划使用年限至</td>
				<td class="FieldInput" ><label name="计划使用年限至" id="yearPlanto" field="YEAR_PLANTO" maxlength="4" ></label></td>
			</tr>
			<tr>
			<td class="FieldLabel" >占用土地性质</td>
				<td class="FieldInput" ><label name="占用土地性质" id="LAND_PROPERTIES" field="LAND_PROPERTIES" maxlength="50" ></label></td>
				
				<td class="FieldLabel">占地面积</td>
				<td class="FieldInput"><label name="占地面积" id="totalArea" maxlength="13" style="text-align:right" 
					field="TOTAL_AREA" ></label>亩</td>
				<td class="FieldLabel">墓区建成面积</td>
				<td class="FieldInput"><label name="墓区建成面积" id="builtArea" maxlength="13" style="text-align:right" 
					field="BUILT_AREA" ></label>亩</td>
			</tr>
			<tr>
				<td class="FieldLabel">建筑面积</td>
				<td class="FieldInput"><label name="建筑面积" id="builtTotalArea" maxlength="13" style="text-align:right" 
					field="BUILTTOTAL_AREA" />㎡</td>
				<td class="FieldLabel" >营业室面积</td>
				<td class="FieldInput" ><label name="营业室面积" id="businessArea" field="BUSINESS_AREA"  style="text-align:right"   maxlength="10" ></label>㎡</td>
				<td class="FieldLabel" >档案室面积</td>
				<td class="FieldInput" ><label name="档案室面积" id="filesroomArea" field="FILESROOM_AREA"   style="text-align:right"  maxlength="10" ></label>㎡</td>
			</tr>
			<tr>
				<td class="FieldLabel" >办公室面积</td>
				<td class="FieldInput" ><label name="办公室面积（㎡）" id="officeromArea" style="text-align:right"   field="OFFICEROM_AREA" maxlength="10" ></label>㎡</td>
				<td class="FieldLabel" >绿地面积</td>
				<td class="FieldInput" ><label name="绿地面积（㎡）" id="greenArea" style="text-align:right"   field="GREEN_AREA" maxlength="10" ></label>㎡</td>
				<td class="FieldLabel" >绿化覆盖率</td>
				<td class="FieldInput" ><label name="绿化覆盖率(%)" id="greenRatio" style="text-align:right"   field="GREEN_RATIO" maxlength="10" ></label>%</td>
			</tr>
			
			<tr>
				<td class="FieldLabel">总投资额</td>
				<td class="FieldInput"><label name="总投资额" id="totalInvestment" maxlength="13" style="text-align:right" 
					field="TOTAL_INVESTMENT" ></label>万元</td>
			
				<td class="FieldLabel">固定资产</td>
				<td class="FieldInput"  colspan="3"><label name="固定资产" id="fixedAssets" maxlength="10" style="text-align:right" 
					field="FIXED_ASSETS"></label>万元</td>
			</tr>
			<tr>
				<td class="FieldLabel" >建设资金合计</td>
				<td class="FieldInput" ><label name="建设资金合计" id="fundTotal" field="FUND_TOTAL"  style="text-align:right" maxlength="10" ></label>万元</td>
				<td class="FieldLabel" >财政拨款</td>
				<td class="FieldInput" ><label name="财政拨款" id="fundFinance"  field="FUND_FINANCE" style="text-align:right" maxlength="10" ></label>万元</td>
				<td class="FieldLabel" >上级部门拨款</td>
				<td class="FieldInput" ><label name="上级部门拨款" id="fundHigher"   field="FUND_HIGHER" style="text-align:right" maxlength="10" ></label>万元</td>
			</tr>
			<tr>
				<td class="FieldLabel" >自筹</td>
				<td class="FieldInput" ><label name="自筹" id="fundSelf"   field="FUND_SELF" style="text-align:right"maxlength="10" ></label>万元</td>
				<td class="FieldLabel" >福彩资助</td>
				<td class="FieldInput" ><label name="福彩资助" id="fundLottery"   field="FUND_LOTTERY" style="text-align:right"maxlength="10" ></label>万元</td>
				<td class="FieldLabel" >其他</td>
				<td class="FieldInput" ><label name="其他" id="fundOther"   field="FUND_OTHER" style="text-align:right" maxlength="10" ></label>万元</td>
			</tr>
			<TR>
				<td class="FieldLabel" >经营管理方式<br>(维护管理办法)</td>
				<td class="FieldInput"  colspan="5">
				<label name="经营管理方式（维护管理办法）" field="MANAGE_STYLE" 
					style="width: 60%;height: 80"></label></td>
			</TR>
			
			
			<tr>
				<td class="FieldLabel">服务内容</td>
				<td class="FieldInput" colspan="5"><input type="checkbox" name="服务内容" value="1" 
					field="SERVICE_SCOPE" label="殡仪服务" />殡仪服务 <br />
				<input type="checkbox" name="serviceScope" value="2"
					field="SERVICE_SCOPE" label="骨灰寄存" />骨灰寄存 <br />
				<input type="checkbox" name="serviceScope" value="3"
					field="SERVICE_SCOPE" label="殡葬用品销售 " />殡葬用品销售 <br />
				<input type="checkbox" name="serviceScope" value="4"
					field="SERVICE_SCOPE" label="骨灰安葬" />骨灰安葬 <br/>
					
				<!-- <td class="FieldLabel">资金来源</td>
				<td class="FieldInput">
				<input type="checkbox" name="fundSources" value="1" 
					field="fundSources" label="财政拨款" />财政拨款
				<br />
				<input type="checkbox" name="fundSources" value="2"
					field="fundSources" label="上级部门拨款" />上级部门拨款 <br />
				<input type="checkbox" name="fundSources" value="3"
					field="fundSources" label="自筹" />自筹 <br />
				<input type="checkbox" name="fundSources" value="4"
					field="fundSources" label="福彩资助" />福彩资助 <br/>
					<input type="checkbox" name="fundSources" value="5"
					field="fundSources" label="其他" />其他
					</td>	 -->
			</tr>
			<tr>
				<td class="FieldLabel">备注</td>
				<td class="FieldInput" colspan="5"><label name="备注" field="NOTE" 
					style="width: 60%;height: 80"></label> </td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>