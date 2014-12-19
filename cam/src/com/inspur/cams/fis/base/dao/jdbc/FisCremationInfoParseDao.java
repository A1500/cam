package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.workflow.taskinfo.util.QueryConditionUtil;
import com.inspur.cams.fis.base.dao.IFisCremationInfoParseDao;
import com.inspur.cams.fis.base.data.FisCremationInfoParse;

/**
 * �ϱ����������ѯdao
 * @author 
 * @date 2013-11-07
 */
public class FisCremationInfoParseDao extends EntityDao<FisCremationInfoParse> implements IFisCremationInfoParseDao {
	
	@Override
	public Class<FisCremationInfoParse> getEntityClass() {
		return FisCremationInfoParse.class;
	}
	
	public DataSet queryDs(ParameterSet pset){
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String unitName=(String)pset.getParameter("unitName");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT * ");
		 sql.append(" FROM  FIS_CREMATION_INFO_PARSE F");
		 sql.append(" WHERE 1=1 ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 if(unitName!=null&&!"".equals(unitName)){
			 sql.append("AND F.UNIT_NAME LIKE '%"+unitName+"%'");
		 }
		 sql.append(" ORDER BY F.UNIT_ID");
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
//		 System.out.println(sql.toString());
		 return this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
	}
	
	private int getDsStart(ParameterSet pset) {
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
	}

}