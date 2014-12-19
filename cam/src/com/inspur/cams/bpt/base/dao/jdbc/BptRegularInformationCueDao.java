package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptRegularInformationCueDao;
import com.inspur.cams.bpt.base.data.BptRegularInformationCue;
import com.inspur.cams.bpt.util.FilterLimit;

/**
 * @title:BptRegularInformationCueDao
 * @description:定期信息提示
 * @author:
 * @since:2011-06-03
 * @version:1.0
*/
 public class BptRegularInformationCueDao extends EntityDao<BptRegularInformationCue> implements IBptRegularInformationCueDao{

 	public BptRegularInformationCueDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptRegularInformationCue> getEntityClass() {
		return BptRegularInformationCue.class;
	}
   
   /**
    * 查詢定期提示
    */
   public DataSet queryRegularInforCue(ParameterSet pset){
	   String domicileCode = (String)pset.getParameter("domicileCode");
	   String name = (String)pset.getParameter("name");
	   String idCard = (String)pset.getParameter("idCard");
	   String objectType = (String)pset.getParameter("objectType");
	   String cueDateBegin = (String)pset.getParameter("cueDateBegin");
	   String cueDateEnd = (String)pset.getParameter("cueDateEnd");
	   String cueInfoType = (String)pset.getParameter("cueInfoType");
	   String confirmFlag = (String)pset.getParameter("confirmFlag");
	   
	   String ageBegin = (String) pset.getParameter("ageBegin");
	   String ageEnd = (String) pset.getParameter("ageEnd");
	   
	   StringBuffer sql = new StringBuffer();
	   sql.append("SELECT INFORMATION_CUE_ID, PEOPLE_ID, NAME, SEX, NATION, ID_CARD,\n");
	   sql.append("       OBJECT_STATE, OBJECT_TYPE, CUE_DATE, CUE_INFO_TYPE, CUE_INFO_CONTENT,\n"); 
	   sql.append("       CONFIRM_FLAG, CONFIRM_TIME, CONFIRM_PEOSON_ID, DOMICILE_CODE,\n"); 
	   sql.append("       BIRTHDAY, AGE, DOMICILE_NAME\n"); 
	   sql.append("  FROM BPT_REGULAR_INFORMATION_CUE\n"); 
	   sql.append(" WHERE ");
	    List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if (domicileCode != null && !domicileCode.equals("")) {
			if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
				sql.append(" DOMICILE_CODE like ?");// 省局
				domicileCode = domicileCode.substring(0, 2)+"%";
			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4).equals("00000000")){
				sql.append(" DOMICILE_CODE like ?");//市局
				domicileCode = domicileCode.substring(0, 4)+"%";
			}else if (!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6, 9).equals("000")) {
				sql.append(" DOMICILE_CODE like ?");//区县
				domicileCode = domicileCode.substring(0, 6)+"%";
			}else if(!domicileCode.substring(6, 9).equals("000")&&domicileCode.substring(9, 12).equals("000")){
				sql.append(" DOMICILE_CODE like ?");//街道
				domicileCode = domicileCode.substring(0, 9)+"%";
			}else {
				sql.append(" DOMICILE_CODE=?");//社区
			}
		}else{
			domicileCode=FilterLimit.filterByOrganCode(sql,domicileCode);	
		}
		typeList.add(Types.VARCHAR);
		argsList.add(domicileCode);
		if(name!=null&&!"".equals(name)){
			sql.append(" AND NAME LIKE '%' || ? || '%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if(idCard!=null&&!"".equals(idCard)){
			sql.append(" AND ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(objectType != null && !objectType.equals("")){
			/* 取出节点ID，并组合sql*/
			String[] list =  new String[20];
			list = objectType.split(",");
			sql.append(" AND (");
			for (int i = 0; i < list.length; i++) {
				sql.append(" OBJECT_TYPE LIKE '%' || ? || '%'");
				typeList.add(Types.VARCHAR);
				argsList.add(list[i]+"%");
				if (i != list.length - 1) {
					sql.append(" OR ");
				}else {
					sql.append(" )");
				}
			}
		}
		if(cueDateBegin!=null&&!"".equals(cueDateBegin)){
			sql.append(" AND CUE_DATE >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cueDateBegin);
		}
		if(cueDateEnd!=null&&!"".equals(cueDateEnd)){
			sql.append(" AND CUE_DATE <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cueDateEnd);
		}
		if(cueInfoType!=null&&!"".equals(cueInfoType)){
			sql.append(" AND CUE_INFO_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(cueInfoType);
		}
		if(confirmFlag!=null&&!"".equals(confirmFlag)){
			sql.append(" AND CONFIRM_FLAG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(confirmFlag);
		}
		
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND age >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}

		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND age <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}
		
		sql.append(" ORDER BY DOMICILE_CODE,NAME,OBJECT_TYPE ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds= this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
		}
		return ds;
   } 
}
