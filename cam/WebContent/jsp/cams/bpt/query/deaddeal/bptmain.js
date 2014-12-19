function init() {
	var alldata= L5.DatasetMgr.lookup("alldata");
	alldata.setParameter("organCode",organCode);
	alldata.setParameter("type","A");
	alldata.load();
	alldata.on("load",showpie);
	var adddata= L5.DatasetMgr.lookup("adddata");
	adddata.setParameter("organCode",organCode);
	adddata.setParameter("type","I");
	adddata.load();
	var decreaseds= L5.DatasetMgr.lookup("decreaseds");
	decreaseds.setParameter("organCode",organCode);
	decreaseds.setParameter("type","D");
	decreaseds.load();
	
	var cityds= L5.DatasetMgr.lookup("cityds");
	cityds.setParameter("type","A");
	cityds.load();
	cityds.on("load",installData);
	L5.QuickTips.init();
	
	initBptGrid();
}

// 显示饼图
function showpie() {
	var ss=parseInt(alldata.get("DEPENDANT"));
    var sc= parseInt(alldata.get("DISABILITY"));
    var zx=parseInt(alldata.get("DEMOBILIED"));
    var cz=parseInt(alldata.get("WAR"));
    var cs=parseInt(alldata.get("TESTED"));
    var ls=parseInt(alldata.get("SOLDIER"));
    var db=parseInt(alldata.get("DEMOBILIZEDILLNESS"));
    var ll=parseInt(alldata.get("MARTYR"));
    
    var  chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'mapie',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: ''
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage, 2)  +' %';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Browser share',
                data: [
                       ['三属',   ss],
                       ['伤残',   sc],
                       ['在乡',   zx],
                       ['参战',  cz],
                       ['参试',   cs],
                       ['60岁',   ls],
                       {
                           name: '带病回乡',
                           y: db,
                           sliced: true,
                           selected: true
                       },
                       ['老烈子女',  ll]
                ]
            }]
        });
    });
}

function installData(){
	var pieData = value = "<pieSource>";
	
	for(var i=0 ;i<cityds.getCount();i++){
		var r = cityds.getAt(i);
		pieData+="<root key=\""+r.get("ORGAN_NAME")+"\">" +
				"<node field=\"三属\" value=\""+r.get("DEPENDANT")+"\" />" +
				"<node field=\"伤残\" value=\""+r.get("DISABILITY")+"\" />" +
				"<node field=\"在乡\" value=\""+r.get("DEMOBILIED")+"\" />" +
				"<node field=\"参试\" value=\""+r.get("TESTED")+"\" />" +
				"<node field=\"参战\" value=\""+r.get("WAR")+"\" />" +
				"<node field=\"60岁\" value=\""+r.get("SOLDIER")+"\" />" +
				"<node field=\"带病回乡\" value=\""+r.get("DEMOBILIZEDILLNESS")+"\" />" +
				"<node field=\"老烈子女\" value=\""+r.get("MARTYR")+"\" />" +
				"</root>";
	}
	pieData+="</pieSource>";
	_tId = 'main';
	_tData = pieData;
	tRenderPieChart();
	
}
//优抚
function initBptGrid(){
	var ops={
			height:360,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			loader : dcLoader,
			url: '/command/ajax/com.inspur.cams.bpt.query.cmd.CollectQueryCmd/queryAllProvince',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'ORGAN_NAME',title:'地区',width:60}
			]],
			columns:[[
				{
					field : 'YALL',
					title : '优抚人员合计',
					width : 80,
					align : 'right',
					formatter:function (value,rec){
						return value;
						//return renshu(value,record.ORGAN_CODE,"'all'");
					}
				},{
					field : 'DISABILITY',
					title : '伤残人员',
					width : 85,
					align : 'right',
					formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}
				},{
					field : 'DEPENDANT',
					title : '三属',
					width : 85,
					align : 'right',
					formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}
				},
				{field:'DEMOBILIED',title:'在乡复员',align:'right',width:85,formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}},
				{field:'DEMOBILIZEDILLNESS',title:'带病回乡',align:'right',width:85,formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}},
				{field:'WAR',title:'参战',align:'right',width:85,formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}},
				{field:'TESTED',title:'参核',align:'right',width:85,formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}},
				{field:'SOLDIER',title:'老兵',align:'right',width:85,formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}},
				{field:'MARTYR',title:'老烈子',align:'right',width:85,formatter:function(value,rec){
						/*if(value==0)
							return '';*/
						return value;
					}}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#bptDiv').datagrid(ops);
	//$('#bptDiv').datagrid('load');

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