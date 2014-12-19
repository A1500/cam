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
	if(cxsjq=='null'&&cxsjz=='null'){
		ds.setParameter("cxsjq", cu.toString());
		ds.setParameter("cxsjz", myDate.toString());
		ds.load();
	}else{
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
	var cxsj_q ;
	var cxsj_z ;
	if(cxsjq=='null'&&cxsjz=='null'){
		cxsj_q =cu.toString();
		cxsj_z = myDate.toString();
	}else{
		cxsj_q =cxsjq;
		cxsj_z =cxsjz;
	}
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

function test(obj) {
	var organCode =  obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	if(organCode.indexOf('000')==-1){
		return;
	}
	var cxsj_q ;
	var cxsj_z ;
	if(cxsjq=='null'&&cxsjz=='null'){
		cxsj_q =cu.toString();
		cxsj_z = myDate.toString();
	}else{
		cxsj_q =cxsjq;
		cxsj_z =cxsjz;
	}
	ds.setParameter("cxsjq", cxsj_q);
	ds.setParameter("cxsjz",cxsj_z);
	ds.setParameter("xzqu", organCode);
	ds.load(true);
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
	var cxsj_q ;
	var cxsj_z ;
	if(cxsjq=='null'&&cxsjz=='null'){
		cxsj_q =cu.toString();
		cxsj_z = myDate.toString();
	}else{
		cxsj_q =cxsjq;
		cxsj_z =cxsjz;
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
	L5.dataset2excel(ds, "/jsp/cams/prs/prsMain/page_placementExcel.jsp?fileName="+fileName+"&statisticsTime="+statisticsTime+"&title="+title);
}