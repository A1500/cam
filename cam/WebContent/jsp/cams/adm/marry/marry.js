function init(){
	var analysisDs = L5.DatasetMgr.lookup("analysisDs");
	analysisDs.on('load',function(){
		showLineChart(analysisDs,'MarryChart','SUM_DATE',[{name:"结婚总数",key:'MARRY_NUM'},{name:"离婚总数",key:'DIVORCE_NUM'}]);//图表展现
	});
	analysisDs.load();
}