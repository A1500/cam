<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp" %>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>等级评定复核申报表</title>
<next:ScriptManager/>
<script>
<%
	String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String cityCode=organArea.substring(0,4)+"00000000";
	String cityName=DicUtil.getTextValueFromDic("dic_city","ID",cityCode,"FULL_NAME");
	
	String organName=BspUtil.getOrganName();
%>
var method='<%=request.getParameter("method")%>';
var applyId='<%=request.getParameter("applyId")%>';
var appId='<%=IdHelp.getUUID32()%>';
var applyType='1';
var deptId="";
var deptName="";
var organCode ="";
var organName ='<%=organName%>';
var msg="noCheck";
var myDate = new Date();
var fOrganName="";
var curDate ='<%=DateUtil.getDay()%>';
var cityName ='<%=cityName.substring(0,3)%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="mrmLevelReCheckInsert.js"></script>
<style type="text/css">
<!--
@media print {
	.noprint {display:none}
}
label {
	font-size: 17px;
}
-->
</style>
<script language="javascript">
//查询条件打开合并函数
 
var str;
function getPrintDataByDataSet(reportName,printDataset,CreateOrgan,ReportNo,ReportType){
	var pp="sfsdf";
	var applyLevel=$("skinValue").innerHTML;
	//var deptName=document.getElementById("deptName").innerHTML;
	var creatDate=document.getElementById("creatDate").value;
	//	alert("<Report ReportName='' Creater='"+applyLevel+"' CreateOrgan='"+pp+"' ReportNo='"+creatDate+"' ReportType='"+creatDate+"'>");
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='' Creater='"+applyLevel+"' CreateOrgan='"+pp+"' ReportNo='"+applyLevel+"' ReportType='"+creatDate+"'>";
	//	alert(printDataset.getCount());
	var records=printDataset.getAllRecords();
	xmlStr +="<Info>";
	var item =records[0].fields.items;
	var showStr="";
	for(var i=0;i<records[0].fields.getCount();i++){
		if(item[i].name=='types'){
			if(records[0].get(item[i].name)=='01'){
				showStr='行政机构';
			}else if(records[0].get(item[i].name)=='02'){
				showStr='参公管理事业单位';
			}else if(records[0].get(item[i].name)=='03'){
				showStr='全额拨款事业单位';
			}
		}
		else if(item[i].name=='zfgmNum'){
			if(records[0].get(item[i].name)>0){
				showStr='政府购买,';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='gkzmNum' || item[i].name=='zyzNum'){
			if(records[0].get(item[i].name)>0){
				showStr='公开招募、志愿者;';
			}else{
				showStr='';
			}
		}
		/*
		else if(item[i].name=='zyzNum'){
			if(records[0].get(item[i].name)>0){
				showStr=' 志愿者,';
			}else{
				showStr='';
			}
		}
		**/
		else if(item[i].name=='wc'){
			if(records[0].get(item[i].name)=='01'){
				showStr='本机关';
			}else if(records[0].get(item[i].name)=='02'){
				showStr='本楼层';
			}else if(records[0].get(item[i].name)=='03'){
				showStr='本楼其他楼层';
			}else{
				showStr='没有卫生间';
			}
		}
		
		else if(item[i].name=='wzatd'){
			if(records[0].get(item[i].name)>0){
				showStr='设有无障碍通道';
			}else{
				showStr='没有设无障碍通道';
			}
		}
		
		else if(item[i].name=='fyj'){
			if(records[0].get(item[i].name)>0){
				showStr='复印机；';
			}else{
				showStr='';
			}
		}
		
		else if(item[i].name=='czj'){
			if(records[0].get(item[i].name)>0){
				showStr='传真机；';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='smy'){
			if(records[0].get(item[i].name)>0){
				showStr='扫描仪；';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='dsj'){
			if(records[0].get(item[i].name)>0){
				showStr='电视机；';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='dkq'){
			if(records[0].get(item[i].name)>0){
				showStr='读卡器；';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='jhj'){
			if(records[0].get(item[i].name)>0){
				showStr='叫号机；';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='dzxsp'){
			if(records[0].get(item[i].name)>0){
				showStr='电子显示屏；';
			}else{
				showStr='';
			}
		}
		else if(item[i].name=='jksb'){
			if(records[0].get(item[i].name)>0){
				showStr='监控设备 ';
			}else{
				showStr='';
			}
		}
		
		else{
			showStr=records[0].get(item[i].name);
		}
		
		xmlStr+="<"+item[i].name+">"+showStr+"</"+item[i].name+">";
	}
	//L5.each(records[0].fields.items,function(item,index){xmlStr+="<"+item.name+">"+records[0].get(item.name)+"</"+item.name+">";});
	xmlStr +="</Info>";
	xmlStr +="</Report>";
	return xmlStr;
	
}
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true" method="getOrganInfo">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisAll">
			<model:field name="foreign" type="string"/>	
			<model:field name="townOpinionId" type="string"/>	
			<model:field name="cityOpinionId" type="string"/>	
			<model:field name="provinceOpinionId" type="string"/>	
			<model:field name="departmentOpinionId" type="string"/>	
		</model:record>
	</model:dataset>
	 <model:dataset id="basePersonDs" cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand" global="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmBasePerson"/>
     </model:dataset>
	<model:dataset id="standardDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardQueryCommand" sortField="standardLevel,seq" pageSize="100">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandard"></model:record>
	</model:dataset>
	<model:dataset id="conditionDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardQueryCommand" sortField="standardLevel,seq" pageSize="100">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandard">
			<model:field name="actural" type="string"/>	
		</model:record>
	</model:dataset>
	<model:dataset id="compareDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardCompareQueryCommand" sortField="seq" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardCompare">
			<model:field name="actural" type="string"/>	
		</model:record>
	</model:dataset>
	<model:dataset id="applyDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<model:dataset id="applyQueryDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="mrmElectronicDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" method="queryCatalog" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>		
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="MRM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<model:dataset id="opinionDataSet" enumName="MRM.WORKFLOW.OPINION" autoLoad="true" global="true" />
</model:datasets>

<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem> 
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="select"  text="提交" handler="submit"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="undo"/>
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="等级评定复核表" autoHeight="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem> 
					<next:ToolBarItem iconCls="edit"  text="校验" handler="showDiv"/>
					<next:ToolBarItem iconCls="print"  text="打印" handler="printBill"/>
				</next:TopBar>
				<next:Html>
					<form id="editForm"  dataset="ds" onsubmit="return false" style="padding:20px;" class="L5form">
						<table border="1"  width="700" align="center" class="noprint">
							<tr>
								<td colspan="4" align="center">
									<br><br>
									<font size="5" style="">婚姻登记机关等级评定复核申报表</font><br><br><br><br><br>
									 
									申 报 单 位： <label field="deptName" style="font-size: 20px;width: 300px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									
									复 核 等 级：
									<label id="skinValue" style="font-size: 20px;width: 300px;text-decoration: underline" >
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									申 报 时 间：
									<input type="text" id="creatDate"  title="成立日期" format="Y-m-d"  
									style="width: 280px;font-size: 17px;"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" 
									onclick="getTimes(this)" />
									<br><br>
								</td>
							</tr>
							 
							<tr>
								<td align="center" width="15%">婚姻登记机关名称</td>
								<td width="30%"> <label field="deptName" style="font-size: 17px"></label></td>
								<td width="30%">对外人工或语音咨询电话</td>
								<td width="25%"> <label field="deptTel" style="font-size: 17px"></label></td>
							</tr>
							<tr>
								<td colspan="2">可查询婚姻登记机关办公情况的外网网址</td>
								<td colspan="2"> <label field="homeUrl" style="font-size: 17px"></label></td>
							</tr>
							<tr>
								<td rowspan="2" align="center">机构性质及工作经费</td>
								<td  colspan="3">
									 机构性质:<span id="xz1" style="font-size: 17px;">行政机关</span><span id="xz2"  style="font-size: 17px;">
									 参照照公务员法管理事业单位</span>
									<span id="xz3"  style="font-size: 17px;" >全额拨款事业单位</span><br>
									<div id="jgDiv" style="color: red;" ></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">工作经费：上年度拨付[  <span id="lastYearBudget" field="lastYearBudget" ></span> ]万元：
								本年度拨付[   <span id="thisYearBudget" field="thisYearBudget" ></span>  ]万元
								</td>
							</tr>
							<tr>
								<td rowspan="4"  align="center">婚姻登记员配置及工作量</td>
								<td colspan="3">辖区户籍人口：[  <span field="deptNumRy" id="deptNumRy" style="font-size: 14px;"></span> ]万人</td>
							</tr>
							<tr>
								<td colspan="3">婚姻登记员共[  <span id="djyNum" field="djyNum" style="font-size: 14px;"></span>  ]人，
								其中取得婚姻颁证员资格[   <span id="bzyNum" field="bzyNum" style="font-size: 14px;"></span>   ]人
								<div id="djyDiva" style="color: red;"></div>
								<div id="djyDivb" style="color: red;"></div>
								<div id="bzyDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">婚姻登记员中行政编制[   <span id="xzbzNum" field="xzbzNum" style="font-size: 14px;"></span>  ]人，
								参照公务员法管理的事业编制[   <span id="cgglNum" field="cgglNum" style="font-size: 14px;"></span>  ]人，
								全额拨款事业编制[  <span id="qebkNum" field="qebkNum" style="font-size: 14px;"></span>   ]人
								<div id="djyBzDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">上年度工作量共[      <span id="AllNum" field="AllNum" style="font-size: 14px;"></span>    ]对(件)，
								其中结婚登记[        <span id="marryNum" field="marryNum" ></span>     ]对；
								离婚登记[       <span id="divorceNum" field="divorceNum"></span>      ]对；
								补发婚姻登记证[       <span id="reissueNum" field="reissueNum"  ></span>       ]对；
								出具(无)婚姻登记记录证明[     <span id="attestNum" field="attestNum" ></span>        ]件
								</td>
							</tr>
							<tr>
								<td  rowspan="2"  align="center">婚姻家庭辅导员配置</td>
								<td colspan="3">辅导员共[    <span id="fdyNum" field="fdyNum" style="font-size: 14px;"></span>   ]人
								<div id="fdyDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">人员来源：<span id="zfgmSpan" style="font-size: 17px;"> 政府购买服务；</span>
								<span id="zyzSpan" style="font-size: 17px;">
								公开招募、志愿者</span> <span id="qtqksc" field="qtqksc" style="width: 600px;font-size: 17px;" readonly="readonly"></span>
								</td>
							</tr>
							<tr>
								<td rowspan="7" align="center">场所建设</td>
								<td colspan="3">
								候登大厅、结婚登记区共[  <span id="marryArea" field="marryArea"  ></span>  ]㎡，
								结婚登记窗口[ <span id="marryWindow" field="marryWindow"  ></span>    ]个<br>
								<div id="maAreaDiv" style="color: red;"></div>
								<div id="maWinDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">候登座椅[   <span id="hdChair" field="hdChair"  ></span>  ]座，
								填表座椅[ <span id="tbChair" field="tbChair"  ></span> ]座<br>
								<div id="hdtbchiarDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">离婚登记室[   <span id="lhArea" field="lhArea"  ></span> ]㎡，
								离婚登记窗口[    <span id="lhWindow" field="lhWindow"  ></span>]个
								<div id="lhAreaWinDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">婚姻家庭辅导室[  <span id="jianShu" field="jianShu" style="font-size: 14px;"></span>   ]间，
								共[   <span id="fdsArea" field="fdsArea"  ></span> ]㎡
								<div id="fdsDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">颁证大厅[  <span id="bzdtArea" field="bzdtArea"  ></span>   ]㎡,
								亲友观礼席位[ <span id="qyglx" field="qyglx"  ></span> ]座
								<div id="bzdtDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">卫生间设在:<span id="station1" style="font-size: 17px;">本机关内</span>
								<span id="station2" style="font-size: 17px;">本楼层内</span><span id="station3" style="font-size: 17px;">本楼其他楼层</span>
								<div id="wsjDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3"><span id="wzatd1" style="font-size: 17px;">设有无障碍通道</span><span id="wzatd2" style="font-size: 17px;">
								没有设无障碍通道</span>
								<div id="wzatdDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td rowspan="2" align="center">设施配置</td>
								<td colspan="3">电脑[  <span id="computer" field="computer"  ></span>  ]台：
								打印机[  <span id="printer" field="printer"  ></span>  ]台，身份证识别系统[ <span id="cardReader" field="cardReader"  ></span>   ]套
								<div id="threeResDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">已配有:
								<span id="fyj" style="font-size: 17px;">复印机；</span><span id="czj" style="font-size: 17px;">传真机；</span>
								<span id="smy" style="font-size: 17px;">扫描仪；</span><span id="dsj" style="font-size: 17px;">电视机；</span>
								<span id="jhj" style="font-size: 17px;">排队叫号系统；</span><span id="dzxsp" style="font-size: 17px;">电子滚动显示屏；</span>
								<span id="fwpjxt" style="font-size: 17px;">服务评价系统；</span><span id="jksb" style="font-size: 17px;">监控系统</span>
								<div id="fourResDiv" style="color: red;"></div>
								</td>
							</tr>
							
							<tr>
								<td rowspan="5" align="center">信息化建设</td>
								<td colspan="3">通过省级婚姻登记平台实现在线登记时间：<span id="zxsj" field="zxsj" style="font-size: 14px;"></span>
								<div id="zxsjDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">实现部省两级婚姻登记数据交换共享时间：<span id="lwsj" field="lwsj" style="font-size: 14px;"></span>
								<div id="lwsjDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">婚姻登记历史数据已补录至：<span id="blsj" field="blsj" style="font-size: 14px;"></span> ，
								数据量共[  <span id="blNum" field="blNum" style="font-size: 14px;"></span>   ]万条
								<div id="blsjDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">网络预约系统启用时间：<span id="wlyyqysj" field="wlyyqysj" style="font-size: 14px;"></span>
								<div id="wlyyDiv" style="color: red;"></div>
								</td>
							</tr>
							<tr>
								<td colspan="3">网络预约量共计[   <span id="wlyyl" field="wlyyl" style="font-size: 14px;"></span>     ]对，
								上年度预约量[    <span id="sndyyl" field="sndyyl" style="font-size: 14px;"></span>    ]对
								</td>
							</tr>
							
							<tr>
								<td rowspan="4" align="center">县级人民政府<br>民政部门<br>意见</td>
								<td colspan="3" >
									<label field="townOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<textarea id="townOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
								<%=cityName %><%=organName %>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="townAuditTime"/>
								</td>
							</tr>
							
							<tr>
								<td rowspan="4"  align="center">地市级人民政<br>府民政部门<br>意见</td>
								<td colspan="3" >
									<label field="cityOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="cityOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><%=cityName %>民政局
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="cityAuditTime"/>
								</td>
							</tr>	
							
							<tr>
								<td rowspan="4" align="center">省级人民政府<br>民政部门<br>意见</td>
								<td colspan="3" >
									<label field="provinceOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">山东省民政厅
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="provinceAuditTime"/>
								</td>
							</tr>	
							
                            <tr>
								<td rowspan="4" align="center">民政部<br>审批意见</td>
								<td colspan="3" >
									<label field="departmentOpinionId" dataset="opinionDataSet"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<textarea id="departmentOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">中华人民共和国民政部
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="departmentAuditTime"/>
								</td>
							</tr>	
						
						</table>
					</form>
			   </next:Html>
			</next:Panel>
			<next:Panel title="基本情况与等级标准对照表" autoHeight="true" id="approveTabPanel">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem> 
					<next:ToolBarItem iconCls="print"  text="打印" handler="wordcontorl"/>
				</next:TopBar>
				<next:Html>
					<form id="editForm"  onsubmit="return false" style="padding:20px;" class="L5form">
						<table border="1"  width="900" align="center" class="noprint" id="dzb"></table>
					</form>
			   </next:Html>
			</next:Panel>
		<next:Panel title="上传证明材料" width="100%" height="100%" autoScroll="true">
			<next:GridPanel id="uploadGrid" title="上传证明材料" height="70%" width="99%" stripeRows="true" dataset="mrmElectronicDataSet" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
				</next:TopBar>		
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="证明材料目录" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"/>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false"/>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false"/>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="mrmElectronicDataSet" />
				</next:BottomBar>
			</next:GridPanel>
			<next:GridPanel id="uploadGrid1" height="30%" stripeRows="true"  width="99%" dataset="queryDs" notSelectFirstRow="true">	
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="" field="" width="38%" editable="false" renderer="catalogName"/>
					<next:Column header="" field="" width="58%" editable="false" renderer="clickShowHref"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="queryDs" />
				</next:BottomBar>
			</next:GridPanel>
          </next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>	
<jsp:include page="../../../common/mrmUpload.jsp" flush="true"/>
</body>

<input type="hidden" id="docpath" value=""/>
<input type="hidden" id="deptId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="mrmLevelApply/mrmLevelApplyDao"/>
</html>

<next:Window id="cueWin" closeAction="hide" title="检验" width="700" height="450"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="print" handler="save_win"></next:ToolBarItem>
		<next:ToolBarItem text="关闭"  iconCls="delete" handler="close_win"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table align="center" >
		 	 	<tr align="center">
			 	 	<td align="center">
			 			<div id="cue_title"></div>
			 	 	</td>
		 	 	</tr>
		 	 	<tr align="left"> 
			 	 	<td align="left">
			 	 		<div id="cue_content"></div>
			 	 	</td>
		 	 	</tr>
		 	 	<tr align="right"> 
			 	 	<td align="right">
			 	 		<div id="cue_date"></div>
			 	 	</td>
		 	 	</tr>
	 	 	</table>
		</form>
	</next:Html>
</next:Window>
