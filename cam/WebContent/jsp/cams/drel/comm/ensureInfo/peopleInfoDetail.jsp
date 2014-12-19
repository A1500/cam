<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员明细列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var commissionId = '<%=request.getParameter("commissionId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='peopleInfoDetail.js'> </script>
</head>
<body>
<model:datasets>
	<!-- 房管 -->
	<model:dataset id="fangguanDs"
		cmd="com.inspur.cams.drel.info.cmd.D204c22QueryCmd" method="queryFangguan"
		global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.drel.info.data.D204c22" />
	</model:dataset>
	<!-- 社保 -->
	<model:dataset id="shebaoDs"
		cmd="com.inspur.cams.drel.info.cmd.D204d32QueryCmd" method="queryShebao"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204d32" />
	</model:dataset>
	<!-- 工商-->
	<model:dataset id="gongshangDs"
		cmd="com.inspur.cams.drel.info.cmd.D204b12QueryCmd" method="queryGongshang"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204b12" />
	</model:dataset>
	<!-- 国税-->
	<model:dataset id="guoshuiDs"
		cmd="com.inspur.cams.drel.info.cmd.D204d33QueryCmd" method="queryGuoshui"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204d33" />
	</model:dataset>
	<!-- 公安（车辆）-->
	<model:dataset id="cheliangDs"
		cmd="com.inspur.cams.drel.info.cmd.D204c21QueryCmd" method="queryCheliang"
		global="true" pageSize="100">
		
	</model:dataset>
	<!-- 公安（死亡）-->
	<model:dataset id="siwangDs"
		cmd="com.inspur.cams.drel.info.cmd.D204c21QueryCmd" 
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204c21" />
	</model:dataset>
	<!-- 民政（民非）-->
	<model:dataset id="minfeiDs"
		cmd="com.inspur.cams.drel.info.cmd.D204z54QueryCmd"  method="queryMinfei"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204z54" />
	</model:dataset>
	<!-- 民政（殡葬）-->
	<model:dataset id="fisDetailDs"
		cmd="com.inspur.cams.drel.info.cmd.D204z62QueryCmd" method="queryBinzang"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204z62" />
	</model:dataset>
	<!-- 民政（婚姻）-->
	<model:dataset id="marryDetailDs"
		cmd="com.inspur.cams.drel.info.cmd.D204z63QueryCmd" method="queryMarry"
		global="true" pageSize="100">
		<model:record
			fromBean="com.inspur.cams.drel.info.data.D204z63" />
	</model:dataset>
   </model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true">
			<next:EditGridPanel id="siwangGrid" dataset="siwangDs" title="户籍注销"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="peopleName" header="姓名" width="100" align="center"/>
					<next:Column field="idCard" header="身份证号" width="150" align="center"/>
					<next:Column field="sex" header="性别" width="100" align="center"/>
					<next:Column field="birthdayAd" header="出生地详址" width="300" align="center"/>
					<next:Column field="birthday" header="出生时间" width="100" align="center"/>
					<next:Column field="dieTime" header="死亡时间" width="100" align="center"/>
					<next:Column field="organAd" header="所属派出所" width="300" align="center"/>
					<next:Column field="adress" header="住址" width="300" align="center"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="siwangDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="cheliangGrid" dataset="cheliangDs" title="车辆"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="INPUT_TIME" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="carType" header="号牌种类" width="100" align="center" hidden="true" />
					<next:Column field="D204C210004" header="车辆型号" width="100" align="center"/>
					<next:Column field="D204C210001" header="车辆品牌（中文）" width="150" align="center"/>
					<next:Column field="D204C210001YW" header="车辆品牌（英文）" width="150" align="center" hidden="true"/>
					<next:Column field="D204C210002" header="车牌号码" width="100" align="center" hidden="true" />
					<next:Column field="D204C210005" header="车辆初次登记时间" width="150" align="center"/>
					<next:Column field="D204A010014" header="住址信息地址" width="300" align="center"/>
					<next:Column field="PHONE" header="联系电话" width="100" align="center" hidden="true"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="cheliangDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="minfeiGrid" dataset="minfeiDs" title="民非"
				width="100%" stripeRows="true" autoHeight="true" >
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="d204z540001" header="组织名称" width="100" align="center"/>
					<next:Column field="d204z540002" header="组织类型" width="100" align="center"/>
					<next:Column field="d204z540003" header="登记证号" width="100" align="center"/>
					<next:Column field="d204z540007" header="开办资金" width="100" align="center"/>
					<next:Column field="d204z540005" header="业务主管单位" width="100" align="center"/>
					<next:Column field="d204z540006" header="登记管理机关" width="100" align="center"/>
					<next:Column field="d204z540004" header="组织机构代码" width="100" align="center"/>
					<next:Column field="d204z540008" header="行业分类" width="100" align="center"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="minfeiDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="fisGrid" dataset="fisDetailDs" title="殡葬"
				width="100%" stripeRows="true" autoHeight="true" >
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="d204z620005" header="出生日期" width="100" align="center"/>
					<next:Column field="d204z620006" header="户口所在地" width="150" align="center"/>
					<next:Column field="d204z620007" header="死亡日期" width="100" align="center"/>
					<next:Column field="d204z620008" header="死亡地点" width="100" align="center"/>
					<next:Column field="d204z620009" header="死亡原因" width="100" align="center" dataset="deadReasonDs"/>
					<next:Column field="createOrganName" header="殡仪馆名称" width="100" align="center"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="fisDetailDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="marryGrid" dataset="marryDetailDs" title="婚姻"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="d204z630004" header="配偶名称" width="100" align="center"/>
					<next:Column field="d204z630005" header="配偶身份证号" width="100" align="center"/>
					<next:Column field="d204z630006" header="登记单位" width="100" align="center"/>
					<next:Column field="d204z630007" header="登记日期" width="100" align="center"/>
					<next:Column field="d204z630008" header="登记状态" width="100" align="center" dataset="marryOptypeDs"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="marryDetailDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="shebaoGrid" dataset="shebaoDs" title="社保"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="d204d320010" header="缴费基数" width="100" align="center"/>
					<next:Column field="d204d320006" header="缴费月份" width="100" align="center"/>
					<next:Column field="d204d320026" header="养老单位缴费" width="100" align="center"/>
					<next:Column field="d204d320002" header="养老个人缴费" width="100" align="center"/>
					<next:Column field="d204d320027" header="失业单位缴费" width="100" align="center"/>
					<next:Column field="d204d320003" header="失业个人缴费" width="100" align="center"/>
					<next:Column field="d204d320028" header="医疗单位缴费" width="100" align="center"/>
					<next:Column field="d204d320004" header="医疗个人缴费" width="100" align="center"/>
					<next:Column field="d204d320005" header="单位名称" width="100" align="center"/>
					<next:Column field="d204d320029" header="单位属性" width="100" align="center"/>
					<next:Column field="d204d320030" header="失业金" width="100" align="center"/>
					<next:Column field="d204d320031" header="养老金" width="100" align="center"/>
					<next:Column field="compareType" header="比对情况" width="100" align="center" dataset="compareTypeDS"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="shebaoDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="fangguanGrid" dataset="fangguanDs" title="房管"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号码" />
					<next:Column field="D204C220001" header="房产证编码" />
					<next:Column field="D204C220005" header="房屋建筑面积(㎡)" />
					<next:Column field="D204C220008" header="房屋购值(元)" />
					<next:Column field="D204C220002" header="房屋坐落位置" />
					<next:Column field="D204C220003" header="房屋类型"  />
					<next:Column field="D204C220007" header="产权人" width="135" />
					<next:Column field="D204C220004" header="产权状态" width="135" />
					<next:Column field="D204C220009" header="登记时间"  />
					
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="fangguanDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="guoshuiGrid" dataset="guoshuiDs" title="国税"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="d204d330002" header="企业名称" width="250" align="center"/>
					<next:Column field="d204d330013" header="注册号" width="120" align="center"/>
					<next:Column field="d204d330011" header="税号（税号中带“A”的为个体户）" width="200" align="center"/>
					<next:Column field="d204d330017" header="注册资本" width="120" align="center"/>
					<next:Column field="d204d330009" header="销售收入（2013年1-9月）" width="200" align="center"/>
					<next:Column field="d204d330010" header="应纳税额（2013年1-9月）" width="200" align="center"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="guoshuiDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="gongshangGrid" dataset="gongshangDs" title="工商"
				width="100%" stripeRows="true" autoHeight="true">
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column field="inputTime" header="反馈日期" width="100" align="center"/>
					<next:Column field="D204A010001" header="姓名" width="100" align="center"/>
					<next:Column field="D204A010005" header="身份证号" width="150" align="center"/>
					<next:Column field="dataSource" header="数据来源" width="150" align="center" dataset="GSDS"/>
					<next:Column field="d204b120004" header="企业（个体户）名称" width="300" align="center"/>
					<next:Column field="adressTrue" header="经营场所" width="300" align="center"/>
					<next:Column field="d204b120005" header="法定代表人（经营者）" width="150" align="center"/>
					<next:Column field="d204b120007" header="职务" width="100" align="center"/>
					<next:Column field="d204b120003" header="注册号" width="120" align="center"/>
					<next:Column field="adress" header="住所" width="300" align="center"/>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="gongshangDs" />
				</next:BottomBar>
			</next:EditGridPanel>
			
</next:Panel>
</body>

</html>
