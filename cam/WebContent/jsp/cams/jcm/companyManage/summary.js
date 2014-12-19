var svColor = "1|174";
var pieData = value = "<pieSource> </pieSource>";
function init(){ 
	/*
	var analysisDs = L5.DatasetMgr.lookup("analysisDs");
	analysisDs.load();
	analysisDs.on("load",function(){
		pieData = value = "<pieSource> ";
		analysisDs.each(function(record,index){
		pieData+="<root key=\""+record.get("YEAR")+"\">"
		+ "<node field=\"工作经费\" value=\""+record.get("MONEY_COST")+"\" />"
		+"</root>"
		});
		pieData+="</pieSource>";
		_tId = 'main';
		_tData = pieData;
		tRenderPieChart();
	});
	*/
	var analysisDs = L5.DatasetMgr.lookup("analysisDs");
	analysisDs.setParameter("companyId",companyId);
	analysisDs.load();
	analysisDs.on('load',function(){
		showLineChart(analysisDs,'MarryChart','YEAR',[{name:"工作经费(元)",key:'MONEY_COST'}]);//图表展现
	});
}
//获取项目根路径
function getProjectName(){
	var curWwwPath=window.document.location.href;
	var pathName=window.document.location.pathname;
	var pos=curWwwPath.indexOf(pathName);
	var localhostPaht=curWwwPath.substring(0,pos);
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	return projectName;
}