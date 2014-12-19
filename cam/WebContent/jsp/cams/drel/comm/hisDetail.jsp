<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<model:datasets>
	<!-- 历史信息 -->
    <model:dataset id="applyInfoList" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method='queryHis'>
        <model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo" />
    </model:dataset>
	<!-- 分类施保类别 -->
	<model:dataset id="assistanceClassDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
			<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
			<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助对象类型 -->
			<model:dataset id="AssistanceDataset" autoLoad="true"
				cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
					<model:param name="value" value='CODE'></model:param>
					<model:param name="text" value='NAME'></model:param>
					<model:param name="includeCode" value='01,02,03'></model:param>
				</model:params>
			</model:dataset>
</model:datasets>

<!--查看历史信息-->
<next:Window id="hisDetail" closeAction="hide" title="历史救助信息详情" width="750" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeHisDetail"></next:ToolBarItem>		
	</next:TopBar>
	<next:GridPanel dataset="applyInfoList" height="350" >
		<next:Columns>
		    <next:RowNumberColumn></next:RowNumberColumn> 	
		    <next:Column field="DOMICILE_NAME" header="地区" width="150" align="center"/>
		    <next:Column field="FAMILY_NAME" header="户主姓名" width="80" align="center"/>
		     <next:Column field="ASSISTANCE_TYPE" header="救助类别" width="80" align="center"><next:ComboBox dataset="AssistanceDataset" /></next:Column>
			<next:Column field="ASSISTANCE_PEOPLE_NUM" header="保障人口数" width="80" align="center"/>
			<%
			if("01".equals(request.getParameter("assistanceType"))||"02".equals(request.getParameter("assistanceType"))){
			%>
			<next:Column field="ASSISTANCE_MONEY" header="户月保障金（元）" width="110" align="right" />
			<next:Column field="ASISSTANCE_CLASS" header="分类施保类别" width="100" align="right" ><next:ComboBox dataset="assistanceClassDataset" /></next:Column>
			<next:Column field="ASSISTANCE_CLASS_MONEY" header="分类施保金（元）" width="110" align="right" />
			<%
			}
			%>			
			<next:Column header="起始保障年月" field="BEGIN_DATE" width="100" align="center" />
			<next:Column header="截止保障年月" field="END_DATE" width="100" align="center" renderer="showEndDate"/>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="applyInfoList" />
		</next:BottomBar>
	</next:GridPanel>	
</next:Window>
	
<script type="text/javascript">
//查看历史信息
function hisDetail(){
	var win=L5.getCmp("hisDetail");
	win.show();
	var applyInfoList = L5.DatasetMgr.lookup("applyInfoList");
	applyInfoList.setParameter("familyId",familyId);
    applyInfoList.load();	
}
//关闭
function closeHisDetail(){
	var win = L5.getCmp("hisDetail");
	win.hide();
}
function showEndDate(value,cellmeta,record,rowindex,colindex,dataset){
	if("3000-12" == value || "3000-12-12" == value){
		return "";
	}
	return value;
}
</script>