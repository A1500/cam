package com.inspur.cams.drel.esurey.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.dao.ISamEsureyInsuranceDao;
import com.inspur.cams.drel.esurey.data.SamEsureyInsurance;

/**
 * @title:SamEsureyInsuranceDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyInsuranceDao extends EntityDao<SamEsureyInsurance> implements ISamEsureyInsuranceDao{

 	public SamEsureyInsuranceDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyInsurance.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyInsurance");
	}
   public void delete(String peopleId){
	   String sql="DELETE FROM SAM_ESUREY_INSURANCE WHERE TYPE='1' AND PEOPLE_ID='"+peopleId+"'";
	   executeUpdate(sql);
   }
   public DataSet queryExtInsurance(ParameterSet pset) {
		String name = (String)pset.getParameter("name");
		String startTime = (String)pset.getParameter("startTime");
		String endTime = (String)pset.getParameter("endTime");
		String idCard = (String)pset.getParameter("idCard");
		String checkOrganId = (String)pset.getParameter("checkOrganId");
		String familyAddress = (String)pset.getParameter("familyAddress");
		StringBuffer sql = new StringBuffer(
			"SELECT " +
				"p.ID_CARD , " +
				"p.NAME ," +
				"f.FAMILY_ADDRESS,"+
				"i.BENEFIT_PEOPLE," +
				"i.BENEFIT_DATE," +
				"i.BENEFIT_TYPE," +
				"i.BENEFIT_NUM ," +
				"P.CHECK_TIME,"+
				"P.CHECK_PEOPLE   "+
			"FROM " +
				"SAM_ESUREY_FAMILY f , SAM_ESUREY_FEEDBACK p ,SAM_ESUREY_INSURANCE i  " +
				" WHERE  f.FAMILY_ID=p.FAMILY_ID AND  p.FEEDBACK_ID=i.FEEDBACK_ID(+) " +
			" AND  p.CHECK_FLG='1' ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		if(StringUtils.isNotEmpty(checkOrganId)){
			sql.append("  AND P.CHECK_ORG_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(checkOrganId);
			
		}
		if(StringUtils.isNotEmpty(name)){
			sql.append(" AND p.NAME=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(name);	
		}
		if(StringUtils.isNotEmpty(startTime)){
			sql.append(" AND p.CHECK_TIME>=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(startTime);		
		}
		if(StringUtils.isNotEmpty(endTime)){
			sql.append(" AND p.CHECK_TIME<=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(endTime);	
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append(" AND p.ID_CARD=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(idCard);		
		}
		if(StringUtils.isNotEmpty(familyAddress)){ 
			
			sql.append(" AND substr(f.FAMILY_ADDRESS,1,6)=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(familyAddress.substring(0, 6));
			
		}
		DataSet ds=new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(),pset.getPageStart(), pset.getPageLimit(), true);
		}
		return ds;
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
