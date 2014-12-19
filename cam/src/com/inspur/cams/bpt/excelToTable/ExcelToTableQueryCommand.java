package com.inspur.cams.bpt.excelToTable;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.excelToTable.dao.MessageDao;

public class ExcelToTableQueryCommand extends BaseQueryCommand{
	MessageDao dao = new MessageDao();
	/**
	 * 查询错误信息
	 * @param makeTable
	 * @param organCode
	 * @return
	 */
	public DataSet queryErrData(){
		ParameterSet pset = getParameterSet();
		return dao.queryErrData(pset);
	}
	/*private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}*/
	/**
	 * 查询错误更新后信息
	 * @param makeTable
	 * @param organCode
	 * @return
	 */
	/*public  DataSet  queryErrUpdateData(){
		String organCode=(String)this.getParameter("organCode");
		String makeTable=(String)this.getParameter("makeTable");
		return dao.queryErrUpdateData(makeTable, organCode);
		
	}*/
	/**
	 * 查询重复信息
	 * @param makeTable
	 * @param organCode
	 * @return
	 */
	public  DataSet  queryRepeatData(){
		String organCode=(String)this.getParameter("organCode");
		String makeTable=(String)this.getParameter("makeTable");
		return dao.queryRepeatData(makeTable, organCode);
		
	}
	/**
	 * 根据id查询校验错误的数据
	 * @param makeTable
	 * @param organCode
	 * @param id
	 * @return
	 */
	public DataSet queryErrUpdate(){
		String organCode=(String)this.getParameter("organCode");
		String makeTable=(String)this.getParameter("makeTable");
		String id=(String)this.getParameter("id");
		DataSet ds = dao.queryErrUpdate(makeTable, organCode,id);
		
		return ds;
	}
	public static void main(String[] args) { 
		/*ExcelToTableQueryCommand  c= new ExcelToTableQueryCommand();
		DataSet dse=c.queryErrData("bpt_imp_people_disability_make","370100000000");*/
		//DataSet ds=c.queryRepeatData("bpt_imp_people_disability_make","370100000000");
	}
}
