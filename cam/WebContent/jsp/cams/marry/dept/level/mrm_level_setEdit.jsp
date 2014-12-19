<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>等级评定标准</title>
<next:ScriptManager/>
<%
String standardLevel=request.getParameter("standardLevel");
int level=Integer.parseInt(standardLevel.substring(1))+3;
%>
<script type="text/javascript" src="mrm_level_setEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
var standardLevel='<%=standardLevel%>';
var level='<%=level%>';
var evaluLevel=decodeURIComponent('<%=request.getParameter("evaluLevel")%>');
var reg3=new RegExp("^[0-9]{1,3}$");
var reg2=new RegExp("^[0-9]{1,2}$");
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
<style type="text/css">
<!--
label {
	font-size: 17px;
}
input {
	text-align: center;
}
-->
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardQueryCommand" global="true" sortField="standardLevel,seq" pageSize="100">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandard"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"/>
		<next:ToolBarItem text="返回" iconCls="undo" handler="goBack"/>
	</next:TopBar>
	<next:Html>
		<form onsubmit="return false" class="L5form" style="padding:20px;">
			<table border="0" width="700" align="center">
				<tr>
					<td align="center"><font size="5"><%=level %> <label id="standardLevel" style="font-size: 23px;"></label></font></td>
				</tr>
				<tr>
					<td align="left"><font size="4"><%=level %>.1 机构经费人员</font></td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.1.1 机构性质</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;婚姻登记机关机构性质应符合以下要求之一：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="jgxzChk1" onclick="chkClk(this)" value="jgxz"/>——<label id="jgxzLbl1">经编制部门批复成立的行政机关</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="jgxzChk2" onclick="chkClk(this)" value="jgxz"/>——<label id="jgxzLbl2">经编制部门批复成立的参照公务员法管理的事业单位</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="jgxzChk3" onclick="chkClk(this)" value="jgxz"/>——<label id="jgxzLbl3">经编制部门批复成立的全额拨款事业单位</label>。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.1.2 工作经费</font></td>
				</tr>
				<tr>
					<td>
					<%
					if(!"03".equals(standardLevel)){
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;婚姻登记工作者经费有制度性保障，满足工作需求和服务需求。
					<%
					}else{
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;婚姻登记工作经费列入财政预算，满足工作需求和服务需求。
					<%
					}
					%>
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.1.3 婚姻登记员</font></td>
				</tr>
				<tr>
					<td><%=level %>.1.3.1 姻登记员应为专职人员，其编制性质应符合以下要求之一：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hydjyChk1" onclick="chkClk(this)" value="hydjy"/>——<label id="hydjyLbl1">行政编制</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hydjyChk2" onclick="chkClk(this)" value="hydjy"/>——<label id="hydjyLbl2">参照公务员法管理的事业编制</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hydjyChk3" onclick="chkClk(this)" value="hydjy"/>——<label id="hydjyLbl3">全额拨款事业编制</label>。<br/>
					<%=level %>.1.3.2 办理内地居民婚姻登记的登记机关，人员配置应符合以下要求：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——辖区户籍人口<input name="hydjyPzRk" onchange="numCheck(this,3)" style="width:45px;" maxlength="3"/>万以下的，至少配备<input id="hydjyPzSta" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名婚姻登记员；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——辖区户籍人口<input name="hydjyPzRk" onchange="numCheck(this,3)" style="width:45px;" maxlength="3"/>万以上的市辖区，每增加<input id="hydjyPzAdd1" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>万户籍人口增配1名婚姻登记员；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——辖区户籍人口<input name="hydjyPzRk" onchange="numCheck(this,3)" style="width:45px;" maxlength="3"/>万以上的县、县级市，每增加<input id="hydjyPzAdd2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>万户籍人口增配1名婚姻登记员。<br/>
					<%=level %>.1.3.3 办理涉外、涉港澳台和华侨婚姻登记的登记机关，人员配置应符合以下要求：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hydjySwGzlSta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以下的，至少配<input id="hydjySw1" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名婚姻登记员；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hydjySwGzlSta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>—<input name="hydjySwGzlEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）的，至少配<input id="hydjySw2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名婚姻登记员；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hydjySwGzlEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，至少配<input id="hydjySw3" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名婚姻登记员。<br/>
					<%=level %>.1.3.4 
					<%
					if("01".equals(standardLevel)){
					%>
					婚姻登记员具有大学专科以上学历，取得地市级及以上民政部门颁发的婚姻登记员资格证书。
					<%
					}else{
					%>
					婚姻登记员具有大学专科以上学历（2011年后新录用婚姻登记员具有全日制大学专科以上学历），取得地市级及以上民政部门颁发的婚姻登记员资格证书。
					<%
					}
					%>
					<br/>
					<%=level %>.1.3.5 婚姻登记员每2年至少参加一次省级及以上民政部门举办的业务培训，取得业务培训合格证书。<br/>
					<%=level %>.1.3.6 婚姻登记员统一着装，挂牌上岗，举止得体，文明用语，微笑服务。<br/>
					<%=level %>.1.3.7 
					<%
					if("01".equals(standardLevel)){
					%>
					婚姻登记员统一使用普通话。
					<%
					}else{
					%>
					婚姻登记员统一使用普通话，涉外婚姻登记机关婚姻登记员至少熟练掌握一门外语。
					<%
					}
					%>
					<br/>
					<%=level %>.1.3.8 婚姻登记员熟知婚姻法律知识、业务政策文件，熟练使用婚姻登记信息系统。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.1.4 婚姻颁证员</font></td>
				</tr>
				<tr>
					<td><%=level %>.1.4.1 婚姻颁证员应为婚姻登记员。<br/>
					<%=level %>.1.4.2 婚姻颁证员配置应符合以下要求：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年结婚登记量<input name="hybzyDjl" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对以下的，至少配<input id="hybzy" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名婚姻颁证员；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年结婚登记量<input name="hybzyDjl" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对以上的，每增加<input name="hybzyDjlAdd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对增配1名婚姻颁证员。<br/>
					<%=level %>.1.4.3 婚姻颁证员符合精神面貌佳、表达能力强、文化修养高、道德品质好的要求。<br/>
					<%=level %>.1.4.4 婚姻颁证员需经省级及以上民政部门培训考核，取得婚姻颁证员资格证书。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.1.5 婚姻家庭辅导员</font></td>
				</tr>
				<tr>
					<td><%=level %>.1.5.1 婚姻登记机关配有<input name="hyjtfdy" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名或<input name="hyjtfdy" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>名以上通过政府购买服务等方式聘用或通过公开招募志愿者方式招募的婚姻家庭辅导员。<br/>
					<%=level %>.1.5.2 通过政府购买服务等方式聘用的婚姻家庭辅导员应具有以下资格之一：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——社工资格；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——心理咨询师资格；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——婚姻家庭咨询师资格；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——律师资格。<br/>
					<%=level %>.1.5.3 通过公开招募志愿者方式招募的婚姻家庭辅导员应具有心理学等方面的专业知识或具备良好的婚姻家庭辅导经验。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="4"><%=level %>.2 场所设备</font></td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.1 环境布局</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.1.1 婚姻登记机关选址应在交通便利处，有独立的场所。<br/>
					<%=level %>.2.1.2 婚姻登记机关不应设在婚纱摄影、婚庆服务、医疗保健等经营服务机构场所内，当事人办理登记无须穿越经营服务区域，
					婚姻登记与婚姻服务严格坚持人员、场地、收费、服装四分开。<br/>
					<%=level %>.2.1.3 登记环境宽敞明亮，庄严整洁，温馨舒适，标识醒目。<br/>
					<%=level %>.2.1.4 婚姻登记机关场所应分为以下区域：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk1" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl1">候登大厅</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk2" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl2">结婚登记区</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk3" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl3">离婚登记室</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk4" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl4">婚姻家庭辅导室</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk5" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl5">颁证大厅</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk6" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl6">档案室</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="hjbjQyChk7" onclick="chkClk(this)" value="hjbjQy"/>——<label id="hjbjQyLbl7">卫生间</label>。<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;设立既办结婚登记、也办离婚登记的婚姻登记室的，结婚登记区、离婚登记室可合并为<input name="hjbjQyHb" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个或<input name="hjbjQyHb" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个以上的婚姻登记室。<br/>
					<%=level %>.2.1.5 候登大厅、结婚登记区面积要求：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hjbjMjGzl" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以下的，使用面积不低于<input id="hjbjMj1" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>㎡；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hjbjMjGzl" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，使用面积不低于<input id="hjbjMj2" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>㎡。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.2 候登大厅</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.2.1 候登大厅应设立公示牌，公示以下内容。<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——婚姻登记机关职责及相关法律规定；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——婚姻登记收费项目、标准及依据；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——婚姻登记员照片、编号；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——婚姻登记员岗位及职责；<br/>
					<%
					if("01".equals(standardLevel)){
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;——婚姻登记机关所属民政局或乡镇人民政府监督、举报电话。
					<%
					}else{
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;——本行政区纪检监察部门或上级民政部门的监督、举报电话。
					<%
					}
					%>
					<br/>
					<%=level %>.2.2.2 候登大厅应明示当事人填写各类申请书的规范样本。<br/>
					<%=level %>.2.2.3 候登大厅应设立宣传资料展架、意见箱，配置饮水机、饮水杯、老花镜等服务设施。<br/>
					<%
					if("01".equals(standardLevel)){
					%>
					<%=level %>.2.2.4 候登大厅座椅配备要求：<br/>
					<%					
					}else if("02".equals(standardLevel)){
					%>
					<%=level %>.2.2.4 年工作量<input name="hddtZySta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，候等大厅应设立咨询台，安排专人答复咨询，维持登记秩序。<br/>
					<%=level %>.2.2.5 候登大厅座椅配备要求：<br/>
					<%
					}else{
					%>					
					<%=level %>.2.2.4 候等大厅设立咨询台，安排专人答复咨询，维持登记秩序。<br/>
					<%=level %>.2.2.5 候登大厅座椅配备要求：<br/>
					<%
					}
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hddtZySta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以下的，候等座椅不少于<input id="hddtZyHd1" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座，填表座椅不少于<input id="hddtZyTb1" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hddtZySta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>—<input name="hddtZyEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）的，候等座椅不少于<input id="hddtZyHd2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座，填表座椅不少于<input id="hddtZyTb2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年工作量<input name="hddtZyEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，候等座椅不少于<input id="hddtZyHd3" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座，填表座椅不少于<input id="hddtZyTb3" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.3 结婚登记区</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.3.1 登记台面宽敞整洁。<br/>
					<%=level %>.2.3.2 登记员与当事人正对平坐，中间无玻璃、栏杆或其它隔离屏障。<br/>
					<%=level %>.2.3.3 每个结婚登记窗口相对独立，办理登记的当事人不受左右人群影响。<br/>
					<%=level %>.2.3.4 结婚登记窗口数量要求：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年结婚登记、出具证明量<input name="jhdjCkSta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以下的，不少于<input id="jhdjCk1" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个结婚登记窗口；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年结婚登记、出具证明量<input name="jhdjCkSta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>—<input name="jhdjCkEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）的，不少于<input id="jhdjCk2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个结婚登记窗口；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年结婚登记、出具证明量<input name="jhdjCkEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，不少于<input id="jhdjCk3" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个结婚登记窗口。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.4 离婚登记室</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.4.1 离婚登记室有独立的房间。<br/>
					<%=level %>.2.4.2 离婚登记室面积及窗口数量要求：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年离婚登记量<input name="lhdjCkSta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对以下的，使用面积不低于<input id="lhdjMj1" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>㎡；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年离婚登记量<input name="lhdjCkSta" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>—<input name="lhdjCkEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对的，使用面积不低于<input id="lhdjMj2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>㎡，不少于<input id="lhdjCk2" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个相对独立的离婚登记窗口；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——年离婚登记量<input name="lhdjCkEnd" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对以上的，使用面积不低于<input id="lhdjMj3" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>㎡，不少于<input id="lhdjCk3" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>个相对独立的离婚登记窗口。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.5 婚姻家庭辅导室</font></td>
				</tr>
				<tr>
					<td>
					<%=level %>.2.5.1 有<input id="hyjtfds" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>间独立的婚姻家庭辅导室。<br/>
					<%=level %>.2.5.2 婚姻家庭辅导室使用面积不低于<input id="hyjtfdsMj" onchange="numCheck(this,3)" style="width:45px;" maxlength="3"/>㎡。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.6 颁证大厅</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.6.1 有独立的颁证大厅，使用面积不低于<input id="bzdtMj" onchange="numCheck(this,3)" style="width:45px;" maxlength="3"/>㎡，亲友观礼席位不少于<input id="bzdtZw" onchange="numCheck(this,2)" style="width:45px;" maxlength="2"/>座。<br/>
					<%=level %>.2.6.2 颁证大厅设立颁证台，配置国徽、红双喜、龙凤呈祥等能体现结婚登记庄重、温馨、神圣的装饰。<br/>
					<%=level %>.2.6.3 颁证大厅内没有开展婚姻服务产品销售等经营性项目。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.7 档案室</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.7.1 婚姻登记机关有独立的档案室。<br/>
					<%=level %>.2.7.2 档案室内配有满足婚姻登记档案保存需要的档案柜，备有防潮、防火、防虫、防盗等设备。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.8 卫生间</font></td>
				</tr>
				<tr>
					<td><%=level %>.2.8.1 
					<%
					if("01".equals(standardLevel)){
					%>
					婚姻登记机关所在楼内设有男女卫生间，有明显指示牌。
					<%
					}else if("02".equals(standardLevel)){
					%>
					婚姻登记机关所在楼层设有男女卫生间，有明显指示牌。
					<%
					}else{
					%>					
					婚姻登记机关内设有男女卫生间，干净整洁，有明显指示牌。
					<%
					}
					%>
					<br/>
					<%=level %>.2.8.2 卫生间对服务对象开放。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.2.9 设施配备</font></td>
				</tr>
				<tr>
					<td>
					<%
					if(!"01".equals(standardLevel)){
					%>
					<%=level %>.2.9.1 婚姻登记机关应配有以下设备：<br/>	
					<%
					}else{
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;婚姻登记机关应配有以下设备：<br/>	
					<%
					}
					%>									
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk1" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl1">复印机</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk2" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl2">传真机</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk3" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl3">扫描仪</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk4" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl4">当事人等候观看的电视</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk5" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl5">每个登记窗口一台电脑</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk6" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl6">每个登记窗口一套证件及纸张打印机</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk7" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl7">未与公安部门身份信息联网的，每个登记窗口一套身份证识别系统</label>；<br/>
					<%
					if("01".equals(standardLevel)){
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk8" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl8">年工作量<input name="sspbGzl" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，配有排队叫号系统</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk9" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl9">年工作量<input name="sspbGzl" onchange="numCheck(this,5)" style="width:45px;" maxlength="5"/>对（件）以上的，配有电子滚动显示屏</label>；<br/>
					<%
					}else{
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk8" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl8">排队叫号系统</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk9" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl9">电子滚动显示屏</label>；<br/>
					<%
					}
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk10" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl10">服务评价系统</label>；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="sspbChk11" onclick="chkClk(this)" value="sspb"/>——<label id="sspbLbl11">具有拍摄功能的监控系统</label>。
					
					<%
					if("02".equals(standardLevel)){
					%>
					<br/>
					<%=level %>.2.9.2 婚姻登记机关设有无障碍通道或提供无障碍登记服务。
					<%
					}else if("03".equals(standardLevel)){
					%>
					<br/>
					<%=level %>.2.9.2 婚姻登记机关设有无障碍通道。
					<%
					}
					%>
					
					</td>
				</tr>
				<tr>
					<td align="left"><font size="4"><%=level %>.3 服务管理</font></td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.3.1 便民服务</font></td>
				</tr>
				<tr>
					<td><%=level %>.3.1.1 
					<%
					if(!"03".equals(standardLevel)){
					%>
					开设直接咨询电话或24小时语音咨询电话，电话号码可在当地114查询。
					<%}else{ %>
					开设可有当事人自行选择人工咨询或24小时语音咨询电话，电话号码可在当地114查询。
					<%
					}
					%>
					<br/>
					<%
					if("01".equals(standardLevel)){
					%>
					<%=level %>.3.1.2 
					<%
					}else{
					%>
					<%=level %>.3.1.2 当事人可在外网查询婚姻登记机关办公地点、办公时间、登记所需提供的证件材料等信息。<br/>
					<%=level %>.3.1.3 
					<%
					}
					%>
					所在办公楼（院）外醒目悬挂符合民政部《婚姻登记工作暂行规范》第八条要求的婚姻登记机关标识牌，同时公告对外办公时间。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.3.2 登记要求</font></td>
				</tr>
				<tr>
					<td><%=level %>.3.2.1 依法履行以下工作职责：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——办理结婚登记；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——办理离婚登记；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——补发婚姻登记证；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——出具（无）婚姻登记记录证明；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——撤销受胁迫的婚姻；<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;——宣传婚姻法律法规，倡导文明婚俗等。<br/>
					<%=level %>.3.2.2 不要求当事人提供额外材料，不增加或变相增加工作程序。<br/>
					<%=level %>.3.2.3 只收取婚姻登记证工本费和经当地物价主管部门批准的婚姻登记档案查询利用费，不开展其它收费服务。<br/>
					<%=level %>.3.2.4 当事人因照证件照、摄录颁证仪式确需服务的，由当事人与服务机构在婚姻登记机关以外的场所签订自愿接受服务单。<br/>
					<%=level %>.3.2.5 近3年内无有效投诉和行政过错败诉案件发生，登记合格率100%。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.3.3 信息化建设</font></td>
				</tr>
				<tr>
					<td><%=level %>.3.3.1 
					<%
					if("01".equals(standardLevel)){
					%>
					通过省级婚姻登记工作平台实现实时在线登记。
					<%
					}else{
					%>
					通过省级婚姻登记工作平台实现实时在线登记，婚姻登记数据通过部省两级婚姻登记数据交换实现全国联网。
					<%
					}
					%>
					<br/>
					<%=level %>.3.3.2 备有可实现数据上传的应急单机版登记软件。<br/>
					<%=level %>.3.3.3 开通网络预约登记，实现预约系统与婚姻登记系统数据交换，确保优先为预约者办理登记，网络预约办理登记量不低于当年登记量的<input id="wlyy" onchange="numCheck(this,2,0)" style="width:45px;" maxlength="2"/>%。<br/>
					<%=level %>.3.3.4 将本辖区<input id="lssj" onchange="numCheck(this,4)" style="width:45px;" maxlength="4"/>年以来保存的所有婚姻登记档案录入婚姻登记信息系统。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.3.4 婚姻文化</font></td>
				</tr>
				<tr>
					<td><%=level %>.3.4.1 举行颁证仪式，免费为当事人颁发结婚证。<br/>
					<%=level %>.3.4.2 <label id="hywhTybz"></label>
					<label id="hywhJtfd"></label>免费为有需求的当事人提供婚姻家庭辅导。<br/>
					<label id="hywhGzbs"></label>悬挂全国婚姻登记工作标识。<br/>
					<label id="hywhXch"></label>营造婚姻文化氛围，在候登大厅、登记室（区）、辅导室和颁证大厅应分别张贴体现婚姻文化的宣传箴言、图画。<br/>
					<label id="hywhJbxb"></label>在候登大厅张贴引导当事人婚事简办新办、参加颁证仪式的宣传内容。
					</td>
				</tr>
				<tr>
					<td align="left"><font size="3"><%=level %>.3.5 管理制度</font></td>
				</tr>
				<tr>
					<td><%=level %>.3.5.1 制定有婚姻登记印章、证书、纸质档案、电子档案、业务学习、岗位责任、考评奖惩、应急预案等管理制度。<br/>
					<%=level %>.3.5.2 按规定保管婚姻登记档案，近3年内未出现纸质档案遗失、损毁、存档材料不当以及电子档案丢失、外泄等问题。<br/>
					<%=level %>.3.5.3 按规定保管婚姻登记证件，近3年内未出现空白婚姻登记证丢失、污损等问题，作废婚姻登记证书统一上交、集中销毁有记录。					
					<%
					if("02".equals(standardLevel)){
					%>
					<br/>
					<%=level %>.3.5.4 建立周末办公预约制度，周末至少对外办公半天，建立符合法律规定的人员轮休、补偿等配套制度。
					<%
					}else if("03".equals(standardLevel)){
					%>
					<br/>
					<%=level %>.3.5.4 建立周末办公预约制度，周末至少对外办公1天，建立符合法律规定的人员轮休、补偿等配套制度。
					<%
					}
					%>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
