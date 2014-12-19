var sStr = "";
var mStr = "";
var jStr = "";
var numJosn = "";
var titleStr = "";
var numJosnObj ="";
function init(){
	var command = new L5.Command("com.inspur.cams.sorg.adm.summary.cmd.SomSummaryQuery");
	command.execute("querySorgNumGrid");
	numJosn = command.getReturn("numJosn");
	//sStr = command.getReturn("sStr");
	//mStr = command.getReturn("mStr");
	//jStr = command.getReturn("jStr");
	//titleStr = command.getReturn("titleStr");
	//sStrObj = sStr.split(",");
	//mStrObj = mStr.split(",");
	//jStrObj = jStr.split(",");
	//titleStrObj = titleStr.split(",");
	if (!command.error) {
		initSorgGird();
		//initSorgNumChart();

	}else{
		L5.Msg.alert('提示',"加载数据时出现错误！"+command.error);
	}
	//showpie();
	//initCountry();
//	initCountryFive();
//	initFisGrid();
	 //initBptGrid();
	 //initSorgGrid();
//	 initOrganGrid();
//	 initAnZhiGrid();
	 initSorgYearChangeChart();
//	 initJZChart();
//	 initSHFLChart();
	 //initMarryGrid();
	 //initMarryYearChart();
	//showMarry();
}
function showMarryDetail(){
	var data=null;
	var url='jsp/cams/adm/marry/marry.jsp';
	var text = '婚姻数据分析';
	L5.forward(url,text,data);

}
//城市低保
function initSorgGird(){
		var ops={
			height:520,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			remoteSort: false,
			url:'sorgNumLoader',
			idField:'DIM',
				frozenColumns:[[
				{field:'地区',title:'地区',width:50}
			]],
			columns:[
			[
				{field:'合计',title:'合计',width:93,align:'right'},
				{field:'社会团体',title:'社会团体',width:80,align:'right'},
				{field:'民办非企业单位',title:'民办非企业单位',width:80,align:'right'},
				{field:'基金会',title:'基金会',width:80,align:'right'}
			]],
			pagination:false,
			rownumbers:true
		};
		$('#chengshi').datagrid(ops);
		numJosnObj = strToJson(numJosn);
		$('#chengshi').datagrid('loadData',numJosnObj );
}
function strToJson(str){
var json = eval('(' + str + ')');
return json;
}

//全省社会组织数量图
function initSorgNumChart(){
	var sArr = new Array();
	var mArr = new Array();
	var jArr = new Array();
	for(var i=0;i<sStrObj.length;i++){
		sArr.push(parseFloat(sStrObj[i]));
	}
	var mArr = new Array();
	for(var i=0;i<mStrObj.length;i++){
		mArr.push(parseFloat(mStrObj[i]));
	}
	var jArr = new Array();
	for(var i=0;i<jStrObj.length;i++){
		jArr.push(parseFloat(jStrObj[i]));
	}
options = {
            chart: {
                renderTo: 'sorgNumDiv',
                type: 'column'
            },
            title: {
                text: '全省社会组织数量'
            },
            xAxis: {
                categories: titleStrObj
            },
            yAxis: {
                min: 0,
                title: {
                    text: '全省社会组织数量'
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -100,
                verticalAlign: 'top',
                y: 20,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y +'<br/>'+
                        '总共: '+ this.point.stackTotal;
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal'
                }
            },
            series: [{
                name: '社会团体',
                data: sArr
            }, {
                name: '民办非企业单位',
                data: mArr
            }, {
                name: '基金会',
                data: jArr
            }]
        };
        var chart = new Highcharts.Chart(options);
}


//全省社会组织全年增减情况图
function initSorgYearChangeChart(){
	var command2 = new L5.Command("com.inspur.cams.sorg.adm.summary.cmd.SomSummaryQuery");
	command2.execute("querySorgAddCancelNumGrid");
	var addStr = command2.getReturn("addStr");
	var cancelStr = command2.getReturn("cancelStr");
	addStrObj = addStr.split(",");
	cancelStrObj = cancelStr.split(",");
	var addArr = new Array();
	var cancelArr = new Array();
	for(var i=0;i<addStrObj.length;i++){
		addArr.push(parseFloat(addStrObj[i]));
	}
	for(var i=0;i<cancelStrObj.length;i++){
		cancelArr.push(parseFloat(cancelStrObj[i]));
	}
 chart = new Highcharts.Chart({
            chart: {
                renderTo: 'sorgYearCheckDiv',
                type: 'column'
            },
            title: {
                text: '社会组织全年增减情况图'
            },
            xAxis: {
                categories: [
                    '一月',
                    '二月',
                    '三月',
                    '四月',
                    '五月',
                    '六月',
                    '七月',
                    '八月',
                    '九月',
                    '十月',
                    '十一月',
                    '十二月'
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: '数量(个)'
                }
            },
            legend: {
                layout: 'vertical',
                backgroundColor: '#FFFFFF',
                align: 'left',
                verticalAlign: 'top',
                x: 100,
                y: 70,
                floating: true,
                shadow: true
            },
            tooltip: {
                formatter: function() {
                    return ''+
                        this.x +': '+ this.y +' 个';
                }
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
                series: [{
                name: '新增',
                data: addArr

            },  {
                name: '注销',
                data: cancelArr

            }]
        });
}

// 显示饼图
function showpie() {
	var command3 = new L5.Command("com.inspur.cams.sorg.adm.summary.cmd.SomSummaryQuery");
	command3.execute("querySorgKindPie");
	//需要转换成int格式才能展现
	var xs = parseInt(command3.getReturn("xs"));
	var hy = parseInt(command3.getReturn("hy"));
	var zy = parseInt(command3.getReturn("zy"));
	var lh = parseInt(command3.getReturn("lh"));
		 var  chart;
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
                       ['学术性',   xs],
                       ['行业性',   hy],
                       ['专业性',   zy],
                       ['联合性',  lh]
                ]
            }]
        });
}
