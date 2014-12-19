package com.inspur.cams.drel.esurey.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.dao.ISamEsureyHouseDao;
import com.inspur.cams.drel.esurey.data.SamEsureyHouse;

/**
 * @title:SamEsureyHouseDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyHouseDao extends EntityDao<SamEsureyHouse> implements ISamEsureyHouseDao{

 	public SamEsureyHouseDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyHouse.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyHouse");
	}
   public void delete(String peopleId){
	   String sql="DELETE  FROM  SAM_ESUREY_HOUSE WHERE TYPE='1' AND PEOPLE_ID='"+peopleId+"'";
	   executeUpdate(sql);
   }
   public DataSet queryExtHouse(ParameterSet pset) {
		String name = (String)pset.getParameter("name");
		String checkOrganId = (String)pset.getParameter("checkOrganId");
		String startTime = (String)pset.getParameter("startTime");
		String endTime = (String)pset.getParameter("endTime");
		String idCard = (String)pset.getParameter("idCard");
		String familyAddress = (String)pset.getParameter("familyAddress");
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT p.ID_CARD,");
		sql.append(" p.NAME,");
		sql.append(" f.FAMILY_ADDRESS,");
		sql.append(" c.name FAMILY_ADDRESS_NAME,");
		sql.append("h.HOUSE_CARD_NO,u.name HOUSE_USEAGE_NAME,");
		sql.append(" h.HOUSE_PROP,P.CHECK_PEOPLE,");
		sql.append(" s.name HOUSE_PROP_NAME,");
		sql.append("h.HOUSE_TYPE,P.CHECK_TIME,");
		sql.append("q.name HOUSE_TYPE_NAME,");
		sql.append("h.HOUSE_OWER,h.HOUSE_AREA,");
		sql.append(" h.OWER_ID_CARD, h.LOCATION,");
		sql.append("h.HOUSE_USEAGE, h.RECORD_DATE,");
		sql.append("h.REG_VALUE,h.REG_DATE,h.BUSINESS_TYPE, ");
		sql.append("t.name BUSINESS_TYPE_NAME  ");
		sql.append(" FROM SAM_ESUREY_FEEDBACK p ");
		sql.append(" left join SAM_ESUREY_FAMILY f on f.FAMILY_ID = p.FAMILY_ID ");
		sql.append(" left join SAM_ESUREY_HOUSE h on p.FEEDBACK_ID = h.FEEDBACK_ID ");
		sql.append(" left join DIC_HOUSE_QUALITY q ON h.house_type = q.code ");
		sql.append(" left join DIC_HOUSE_STATUS s on h.house_prop = s.code ");
		sql.append(" left join DIC_CITY c on f.Family_Address = c.id ");
		sql.append(" left join dic_details u on h.house_useage = u.code ");
		sql.append(" left join dic_details t on h.BUSINESS_TYPE = t.code  ");
		sql.append(" where p.CHECK_FLG = '1' ");
		sql.append(" and u.dic_type = 'ESUREY_HOUSE_USEAGE' ");
		sql.append(" and t.dic_type = 'ESUREY_BUSINESS_TYPE' ");

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
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(),getDsStart(pset), getDsLimit(pset), true);
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
