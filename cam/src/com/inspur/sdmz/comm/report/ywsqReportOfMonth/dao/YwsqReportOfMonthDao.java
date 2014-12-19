package com.inspur.sdmz.comm.report.ywsqReportOfMonth.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;

@SuppressWarnings("unchecked")
public class YwsqReportOfMonthDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		//1、获取受理单位
		StringBuffer querySql = new StringBuffer("SELECT ACCEPT_ORG,ACCEPT_ORG_NAME FROM SAM_APPLY WHERE 1=1 ");
		String startDate = (String) pset.getParameter("startDate");
		if(startDate!=null && !"".equals(startDate)) {
			querySql.append(" AND APPLY_DATE>='"+startDate+"'");
		}
		String endDate = (String) pset.getParameter("endDate");
		if(endDate!=null && !"".equals(endDate)) {
			querySql.append(" AND APPLY_DATE<='"+endDate+"'");
		}
		querySql.append(" GROUP BY ACCEPT_ORG,ACCEPT_ORG_NAME ");
		
		List list = this.executeQuery(querySql.toString());
		//2、单条处理受理单位业务信息
		if(list == null || list.size()<1) return new DataSet();
		DataSet reDs = new DataSet();
		Iterator it = list.listIterator();
		while(it.hasNext()) {
			Map map = (Map)it.next();
			String dwId = (String)map.get("ACCEPT_ORG");
			String dwName = (String)map.get("ACCEPT_ORG_NAME");
			if(null!=dwId && !"".equals(dwId)) {
				List listO = this.executeQuery("SELECT TO_CHAR(COUNT(*)) VALUE,SAM_APPLY.APPLY_TYPE APPLY_TYPE,SAM_APPLY.HANDLE_SIGN HANDLE_SIGN " +
									"FROM SAM_APPLY WHERE SAM_APPLY.ACCEPT_ORG = '"+dwId+"' " +
									"GROUP BY SAM_APPLY.APPLY_TYPE,SAM_APPLY.HANDLE_SIGN");
				//getRowecort(listO, jb);
				reDs.addRecord(getBean(listO,dwName));
			}
		}
		return reDs;
	}
	private Record getBean(List list, String dwName) {
		if(list==null || list.size() <1) {
			return new Record();
		}
		Record record = new Record();
		record.set("name", dwName);
		int row1 = 0;  //救助业务总计
		int row5 = 0;  //投诉业务总计
		int row9 = 0;  //咨询业务总计
		int row2 = 0;  //救助业务已办结
		int row3 = 0;  //救助业务未办结
		int row4 = 0;  //救助业务超期办结
		int row6 = 0;  //投诉业务已办结
		int row7 = 0;  //投诉业务未办结
		int row8 = 0;  //投诉业务超期办结
		int row10 = 0;  //咨询业务已办结
		int row11 = 0;  //咨询业务未办结
		int row12 = 0;  //咨询业务超期办结
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map)list.get(i);
			String ywlx = (String) map.get("APPLY_TYPE");
			String blbz = (String) map.get("HANDLE_SIGN");
			String value = ((String) map.get("VALUE"));
			if("1".equals(ywlx)) {
				if("0".equals(blbz)||"1".equals(blbz)) {  //未办结
					row3 += Integer.parseInt(value);
					row1 += Integer.parseInt(value);
				} else if("2".equals(blbz)||"3".equals(blbz)) {  //已办结
					row2 += Integer.parseInt(value);
					row1 += Integer.parseInt(value);
				} else if("4".equals(blbz)) {  //超期办结
					row4 += Integer.parseInt(value);
					row1 += Integer.parseInt(value);
				}
			} else if("2".equals(ywlx)) {
				if("0".equals(blbz)||"1".equals(blbz)) {  //未办结
					row6 += Integer.parseInt(value);
					row5 += Integer.parseInt(value);
				} else if("2".equals(blbz)||"3".equals(blbz)) {  //已办结
					row7 += Integer.parseInt(value);
					row5 += Integer.parseInt(value);
				} else if("4".equals(blbz)) {  //超期办结
					row8 += Integer.parseInt(value);
					row5 += Integer.parseInt(value);
				}
			} else if("3".equals(ywlx)) {
				if("0".equals(blbz)||"1".equals(blbz)) {  //未办结
					row10 += Integer.parseInt(value);
					row9 += Integer.parseInt(value);
				} else if("2".equals(blbz)||"3".equals(blbz)) {  //已办结
					row11 += Integer.parseInt(value);
					row9 += Integer.parseInt(value);
				} else if("4".equals(blbz)) {  //超期办结
					row12 += Integer.parseInt(value);
					row9 += Integer.parseInt(value);
				}
			}
		}
		record.set("Row1", row1);
		record.set("Row2", row2);
		record.set("Row3", row3);
		record.set("Row4", row4);
		record.set("Row5", row5);
		record.set("Row6", row6);
		record.set("Row7", row7);
		record.set("Row8", row8);
		record.set("Row9", row9);
		record.set("Row10", row10);
		record.set("Row11", row11);
		record.set("Row12", row12);
		return record;
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
