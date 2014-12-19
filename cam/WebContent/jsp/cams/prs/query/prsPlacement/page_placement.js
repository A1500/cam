function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+organCode+"'");
	ds.setParameter("xzqu", organCode);
	ds.on('load', function(){
		OrgNameDataset.load();
	});
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
	 	showDiv();
	});
	if(cxsjq!='null'&&cxsjz!='null'){
		document.getElementById("cxsj_q").value  = cxsjq;
		document.getElementById("cxsj_z").value  = cxsjz;
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}//'null'涉及后台查询
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
	setStatisticsTime();
}
function setStatisticsTime(){
	var title = "";
	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	if(cxsj_q!=null&&cxsj_q!=""){
		cxsjq = cxsj_q;
	}
	if(cxsj_z!=null&&cxsj_z!=""){
		cxsjz = cxsj_z;
	}
	if(cxsj_q==cxsj_z){
		var times = cxsj_q.split("-");
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月"+times[2]+"日";
		title =times[0]+"年度"+orgName+"退役士兵安置统计表";
	}else{
		var timesq = cxsj_q.split("-");
		var timesz = cxsj_z.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日 至 "+ timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
		if(timesq[0]==timesz[0]){
				title =timesq[0]+"年度"+orgName+"退役士兵安置统计表";
		}else{
				title =timesq[0]+"-"+timesz[0]+"年度"+orgName+"退役士兵安置统计表";
		}
	}
	document.getElementById("reportTitle").innerHTML=title;
}
function query() {
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}

	if (cxsj_q != '') {
		ds.setParameter("cxsjq", cxsj_q);
	}
	if (cxsj_z != '') {
		ds.setParameter("cxsjz",cxsj_z);
	}

	ds.setParameter("xzqu", organCode);
	ds.load();
	noReclick(ds,"queryButton");
}

function test(value) {
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu== organCode){
		return ;
	}
	var data = new L5.Map();
	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
	if (cxsj_q != '') {
		data.put("cxsjq",cxsj_q);
	}
	if (cxsj_z != '') {
		data.put("cxsjz",cxsj_z);
	}
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "jsp/cams/prs/query/prsPlacement/query_placement.jsp";
	L5.forward(url, null, data);
}
function back() {
	history.go(-1);
}

function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}


function querydetail(value,type){
	if(value.innerHTML=='0'){
		return;
	}
	
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	var xzqu = value.nextSibling.innerHTML;//获得行政区号
	var url='retiredsodiersquery.jsp?cxsjq='+cxsj_q+'&cxsjz='+cxsj_z+'&xzqu='+xzqu;
	if(type=='1'){
		url+='&emplacementflag=0';//0:未安置
	}else if(type =='2'){
		url+='&emplacementflag=1&employment_type=1';//1：自主就业    2：政府指导
	}else if(type =='3'){
		url+='&emplacementflag=1&employment_type=0&resettlement_situation=10';//复学复工
	}else if(type =='4'){
		url+='&emplacementflag=1&employment_type=0&resettlement_situation=20';//服从分配
	}else if(type =='5'){
		url+='&emplacementflag=1&employment_type=0&resettlement_situation=30';//自谋职业
	}else if(type =='6'){
		url+='&emplacementflag=1&employment_type=0&resettlement_situation=40';//自找单位
	}else if(type =='7'){
		url+='&emplacementflag=1';
	}	
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function exportCSV(){
	var ds = L5.DatasetMgr.lookup("ds");
	if(ds.getTotalCount()==0) {
		return;
	}

	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var fileName = "";//+orgName;
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		fileName =times[0]+"年度"+orgName;
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		if(timesq[0]==timesz[0]){
			fileName =timesq[0]+"年度"+orgName;
		}else{
			fileName =timesq[0]+"-"+timesz[0]+"年度"+orgName;
		}
	}
	var title=document.getElementById("reportTitle").innerHTML;
	var statisticsTime= document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/prs/query/prsPlacement/page_placementExcel.jsp?fileName="+fileName+"&statisticsTime="+statisticsTime+"&title="+title);
}