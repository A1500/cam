<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>等级评定复核表</title>
<%
String method=request.getParameter("method");
String applyId=request.getParameter("applyId");
String organCode=request.getParameter("organCode");
String organName=request.getParameter("organName");
String organType=request.getParameter("organType");
%>
<next:ScriptManager/>
<script>
var method='<%=request.getParameter("method")%>';
var applyId='<%=request.getParameter("applyId")%>';
var deptId='<%=request.getParameter("deptId")%>';
var applyType='<%=request.getParameter("applyType")%>';
var organCode='<%=request.getParameter("organCode")%>';
var organName=decodeURIComponent('<%=request.getParameter("organName")%>');
var organType='<%=request.getParameter("organType")%>';
var curDate ='<%=DateUtil.getDay()%>';
var curOrganName = '<%=BspUtil.getParentOrgan().getOrganName()%>';
var curOrganCode = '<%=BspUtil.getParentOrgan().getOrganCode()%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="mrmLevelReCheckDetail.js"></script>
<style type="text/css">
<!--
label {
	font-size: 17px;
}
-->
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="applyDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>	
	<model:dataset id="mrmElectronicDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmElectronicQueryCmd" method="queryCatalog" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmElectronic"></model:record>
	</model:dataset>
	<model:dataset id="basePersonDs" cmd="com.inspur.cams.marry.base.cmd.MrmBasePersonQueryCommand" global="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmBasePerson"/>
     </model:dataset>		
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="MRM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="compareDs" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardCompareQueryCommand" sortField="seq" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardCompare"></model:record>
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
		</model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<model:dataset id="opinionDataSet" enumName="MRM.WORKFLOW.OPINION" autoLoad="true" global="true" />
</model:datasets>

<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem> 
		<%
		if("UPDATE".equals(method)){
		%>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="select"  text="提交" handler="submit"/>
		<%
		}
		%>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="等级评定复核表" autoHeight="true">
				<next:Html>
					<form id="editForm"  dataset="applyDs" onsubmit="return false" style="padding:20px;" class="L5form">
						<table border="1"  width="700" align="center" class="noprint">
							<tr>
								<td colspan="4" align="center">
									<br><br>
									<font size="5" style="">婚姻登记机关等级评定复核申报表</font><br><br><br><br><br>
									 
									申 报 单 位： <label field="organName" style="font-size: 20px;text-decoration: underline">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br><br>
									
									复 核 等 级：
									<label field="applyLevel" dataset="evaluLevelDataSet" id="applyLevel" style="font-size: 17px;width: 280px"></label><br><br>
									申 报 时 间：
									<label field="applyTime"  title="成立日期" style="width: 280px;font-size: 17px;"></label><br><br>
								</td>
							</tr>
							 
							<tr>
								<td align="center" width="15%">婚姻登记机关名称</td>
								<td width="30%"> <label field="organName" style="font-size: 17px"></label></td>
								<td width="30%">对外人工或语音咨询电话</td>
								<td width="25%"> <label field="phone" style="font-size: 17px"></label></td>
							</tr>
							<tr>
								<td colspan="2">可查询婚姻登记机关办公情况的外网网址</td>
								<td colspan="2"> <label field="web" style="font-size: 17px"></label></td>
							</tr>
							<tr>
								<td rowspan="2" align="center">机构性质及工作经费</td>
								<td  colspan="3">
									 机构性质:<span id="xz1" style="font-size: 17px;display:none;">行政机关</span>
									 <span id="xz2"  style="font-size: 17px;display:none;">
									 参照照公务员法管理事业单位</span>
									<span id="xz3"  style="font-size: 17px;display:none;" >全额拨款事业单位</span><br>
								</td>
							</tr>
							<tr>
								<td colspan="3">工作经费：上年度拨付[  <span field="found" ></span> ]万元：
								本年度拨付[   <span field="yearFound" ></span>  ]万元
								</td>
							</tr>
							<tr>
								<td rowspan="4"  align="center">婚姻登记员配置及工作量</td>
								<td colspan="3">辖区户籍人口：[  <span field="populateNum" style="font-size: 14px;"></span> ]万人</td>
							</tr>
							<tr>
								<td colspan="3">婚姻登记员共[  <span field="marriageRegNum" style="font-size: 14px;"></span>  ]人，
								其中取得婚姻颁证员资格[   <span field="hasQualifyNum" style="font-size: 14px;"></span>   ]人
								</td>
							</tr>
							<tr>
								<td colspan="3">婚姻登记员中行政编制[   <span field="regOneNum" style="font-size: 14px;"></span>  ]人，
								参照公务员法管理的事业编制[   <span field="regTwoNum" style="font-size: 14px;"></span>  ]人，
								全额拨款事业编制[  <span field="regThreeNum" style="font-size: 14px;"></span>   ]人
								</td>
							</tr>
							<tr>
								<td colspan="3">上年度工作量共[      <span field="workNum" style="font-size: 14px;"></span>    ]对(件)，
								其中结婚登记[        <span field="marriageNum" ></span>     ]对；
								离婚登记[       <span field="divorceNum"></span>      ]对；
								补发婚姻登记证[       <span field="supplyNum"  ></span>       ]对；
								出具(无)婚姻登记记录证明[     <span field="certNum" ></span>        ]件
								</td>
							</tr>
							<tr>
								<td  rowspan="2"  align="center">婚姻家庭辅导员配置</td>
								<td colspan="3">辅导员共[    <span field="tutorNum" style="font-size: 14px;"></span>   ]人
								</td>
							</tr>
							<tr>
								<td colspan="3">人员来源：<span id="zfgmSpan" style="font-size: 17px;display:none;"> 政府购买服务；</span>
								<span id="zyzSpan" style="font-size: 17px;display:none;">
								公开招募、志愿者</span> <span id="qtqksc" style="width: 600px;font-size: 17px;" readonly="readonly"></span>
								</td>
							</tr>
							<tr>
								<td rowspan="7" align="center">场所建设</td>
								<td colspan="3">
								候登大厅、结婚登记区共[  <span field="waitArea"  ></span>  ]㎡，
								结婚登记窗口[ <span field="marriageWinNum"  ></span>    ]个<br>
								</td>
							</tr>
							<tr>
								<td colspan="3">候登座椅[   <span field="waitSeatNum"  ></span>  ]座，
								填表座椅[ <span field="writeSeatNum"  ></span> ]座<br>
								</td>
							</tr>
							<tr>
								<td colspan="3">离婚登记室[   <span field="divorceArea"  ></span> ]㎡，
								离婚登记窗口[    <span field="divorceWinNum"  ></span>]个
								</td>
							</tr>
							<tr>
								<td colspan="3">婚姻家庭辅导室[  <span field="tutorRoomNum" style="font-size: 14px;"></span>   ]间，
								共[   <span field="tutorRoomArea"  ></span> ]㎡
								</td>
							</tr>
							<tr>
								<td colspan="3">颁证大厅[  <span field="presentArea"  ></span>   ]㎡,
								亲友观礼席位[ <span field="friendSeatNum"  ></span> ]座
								</td>
							</tr>
							<tr>
								<td colspan="3">卫生间设在:<span id="station1" style="font-size: 17px;display:none;">本机关内 </span>
								<span id="station2" style="font-size: 17px;display:none;">本楼层内 </span>
								<span id="station3" style="font-size: 17px;display:none;">本楼其他楼层 </span>
								</td>
							</tr>
							<tr>
								<td colspan="3"><span id="wzatd1" style="font-size: 17px;display:none;">设有无障碍通道</span>
								<span id="wzatd2" style="font-size: 17px;display:none;">
								没有设无障碍通道</span>
								</td>
							</tr>
							<tr>
								<td rowspan="2" align="center">设施配置</td>
								<td colspan="3">电脑[  <span field="computeNum"  ></span>  ]台：
								打印机[  <span field="printerNum"  ></span>  ]台，身份证识别系统[ <span field="identifyNum"  ></span>   ]套
								</td>
							</tr>
							<tr>
								<td colspan="3">已配有:
								<span id="fyj" style="font-size: 17px;display:none;">复印机；</span>
								<span id="czj" style="font-size: 17px;display:none;">传真机；</span>
								<span id="smy" style="font-size: 17px;display:none;">扫描仪；</span>
								<span id="dsj" style="font-size: 17px;display:none;">电视机；</span>
								<span id="jhj" style="font-size: 17px;display:none;">排队叫号系统；</span>
								<span id="dzxsp" style="font-size: 17px;display:none;">电子滚动显示屏；</span>
								<span id="fwpjxt" style="font-size: 17px;display:none;">服务评价系统；</span>
								<span id="jksb" style="font-size: 17px;display:none;">监控系统</span>
								</td>
							</tr>
							
							<tr>
								<td rowspan="5" align="center">信息化建设</td>
								<td colspan="3">通过省级婚姻登记平台实现在线登记时间：<span field="onlineDate" style="font-size: 14px;"></span>
								</td>
							</tr>
							<tr>
								<td colspan="3">实现部省两级婚姻登记数据交换共享时间：<span field="dataChargeDate" style="font-size: 14px;"></span>
								</td>
							</tr>
							<tr>
								<td colspan="3">婚姻登记历史数据已补录至：<span field="hisDataDate" style="font-size: 14px;"></span> ，
								数据量共[  <span field="dataNum" style="font-size: 14px;"></span>   ]万条
								</td>
							</tr>
							<tr>
								<td colspan="3">网络预约系统启用时间：<span field="bookingDate" style="font-size: 14px;"></span>
								</td>
							</tr>
							<tr>
								<td colspan="3">网络预约量共计[   <span field="allBookingNum" style="font-size: 14px;"></span>     ]对，
								上年度预约量[    <span field="bookingNum" style="font-size: 14px;"></span>    ]对
								</td>
							</tr>
							<tr>
								<td rowspan="4" align="center">县级人民政府<br>民政部门<br>意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "13".equals(organType)){
									%>
									<select id="townOpinionId" field="townOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>
									<%
									}else{
									%>
									<label field="townOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<%
									if("UPDATE".equals(method) && "13".equals(organType)){
									%>
									<textarea field="townOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>
									<%
									}else{
									%>
									<textarea field="townOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"> 
									<label field="townOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="townAuditTime"/>
								</td>
							</tr>
							
							<tr>
								<td rowspan="4"  align="center">地市级人民政<br>府民政部门<br>意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "12".equals(organType)){
									%>
									<select id="cityOpinionId" field="cityOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>						
									<%
									}else{
									%>
									<label field="cityOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "12".equals(organType)){
									%>
									<textarea field="cityOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>						
									<%
									}else{
									%>
									<textarea field="cityOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
									<label field="cityOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="cityAuditTime"/>
								</td>
							</tr>	
							
							<tr>
								<td rowspan="4" align="center">省级人民政府<br>民政部门<br>意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "11".equals(organType)){
									%>
									<select id="provinceOpinionId" field="provinceOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>					
									<%
									}else{
									%>	
									<label field="provinceOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "11".equals(organType)){
									%>
									<textarea field="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>				
									<%
									}else{
									%>	
									<textarea field="provinceOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right">
									<label field="provinceOrganName"/>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"><label id="provinceAuditTime"/>
								</td>
							</tr>
							
							<tr>
								<td rowspan="4" align="center">民政部<br>审批意见</td>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "0".equals(organType)){
									%>
									<select id="departmentOpinionId" field="departmentOpinionId" style="font-size:17px;width:200px">
										<option dataset="opinionDataSet"></option>
									</select>			
									<%
									}else{
									%>	
									<label field="departmentOpinionId" dataset="opinionDataSet"/>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" >
									<%
									if("UPDATE".equals(method) && "0".equals(organType)){
									%>
									<textarea field="departmentOpinion" style="font-size:17px;width:100%;overflow:hidden" rows="3"></textarea>			
									<%
									}else{
									%>	
									<textarea field="departmentOpinion" style="font-size:17px;width:100%;overflow:hidden;border:0" rows="3" 
									readonly></textarea>
									<%
									}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="3" align="right"> 
									<label field="departmentOrganName"/>
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
</html>

