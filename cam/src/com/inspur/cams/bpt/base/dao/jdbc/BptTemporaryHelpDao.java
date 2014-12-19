package com.inspur.cams.bpt.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptTemporaryHelpDao;
import com.inspur.cams.bpt.base.data.BptTemporaryHelp;
import com.inspur.cams.bpt.util.BptGetAge;

/**
 * @title:BptTemporaryHelpDao
 * @description:
 * @author:
 * @since:2011-06-09
 * @version:1.0
*/
 public class BptTemporaryHelpDao extends EntityDao<BptTemporaryHelp> implements IBptTemporaryHelpDao{

 	public BptTemporaryHelpDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptTemporaryHelp> getEntityClass() {
		return BptTemporaryHelp.class;
	}
   
   /**
    * 对要进行审批的人进行查询
    */
   public DataSet queryTemporary(ParameterSet pset){
	   List<Integer> typeList = new ArrayList<Integer>();
	   List<Object> argsList = new ArrayList<Object>();
	   int start = pset.getPageStart();
	   int limit = pset.getPageLimit();
	   StringBuffer sql =new StringBuffer();
	   sql.append("SELECT A.PEOPLE_ID, C.FAMILY_ID, B.NAME, B.SEX, B.ID_CARD,\n");
	   sql.append("       B.BIRTHDAY,'' AS AGE, B.NATION,\n"); 
	   sql.append("       B.DOMICILE_CODE,\n"); 
	   sql.append("       CASE\n"); 
	   sql.append("         WHEN A.DISABILITY_TYPE_CODE != '00' THEN DISABILITY_TYPE_CODE\n"); 
	   sql.append("         WHEN A.DEPENDANT_TYPE_CODE != '00' THEN DEPENDANT_TYPE_CODE\n"); 
	   sql.append("         WHEN A.WAR_TYPE_CODE != '00' THEN WAR_TYPE_CODE\n");
	   sql.append("         WHEN A.RETIRED_TYPE_CODE != '00' THEN RETIRED_TYPE_CODE\n"); 
	   sql.append("         WHEN A.MARTYR_OFFSPRING_CODE != '00' THEN MARTYR_OFFSPRING_CODE\n"); 
	   sql.append("         WHEN A.DEMOBILIZED_TYEP_CODE != '00' THEN DEMOBILIZED_TYEP_CODE\n"); 
	   sql.append("       END OBJECT_TYPE, B.ADDRESS, C.PEOPLE_NUM\n"); 
	   sql.append("  FROM BPT_PEOPLE A, BASEINFO_PEOPLE B, BASEINFO_FAMILY C\n"); 
	   sql.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND B.FAMILY_ID = C.FAMILY_ID");
	   String domicileCode = (String)pset.getParameter("domicileCode");
	   String peopleId = (String)pset.getParameter("peopleId");
	   String objectType = (String)pset.getParameter("objectType");
		
		if (peopleId != null && !peopleId.equals("")) {
			sql.append(" AND A.PEOPLE_ID= ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if (domicileCode != null && !domicileCode.equals("")) {
			sql.append(" AND B.DOMICILE_CODE = ? ") ;
			typeList.add(Types.VARCHAR);
			argsList.add(domicileCode);
		}
		
		if (objectType != null && !objectType.equals("")) {
			sql.append("AND (CASE WHEN A.DISABILITY_TYPE_CODE != '00' THEN DISABILITY_TYPE_CODE\n");
			sql.append("          WHEN A.DEPENDANT_TYPE_CODE != '00' THEN DEPENDANT_TYPE_CODE\n"); 
			sql.append("          WHEN A.REDA_TYPE_CODE != '00' THEN REDA_TYPE_CODE\n"); 
			sql.append("          WHEN A.DEMOBILIZED_TYEP_CODE != '00' THEN DEMOBILIZED_TYEP_CODE\n"); 
			sql.append("     END) = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(objectType);
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,start,limit, true);
		}
	   List list = ds.getRecordSet();
	   //List newList =new ArrayList();
	   for(int i = 0;i<list.size();i++){
		   BptTemporaryHelp ob = new BptTemporaryHelp();
		   Record temp = (Record) list.get(i);
		   /*ob.setPeopleId((String)temp.get("PEOPLE_ID"));
		   ob.setName((String)temp.get("NAME"));
		   ob.setSex((String)temp.get("SEX"));
		   ob.setIdCord((String)temp.get("ID_CARD"));
		   ob.setAge(String.valueOf(temp.get("AGE")));
		   ob.setNation((String)temp.get("NATION"));
		   ob.setObjectType((String)temp.get("OBJECT_TYPE"));
		   ob.setAddress((String)temp.get("ADDRESS"));
		   ob.setFamilyNum((BigDecimal)temp.get("PEOPLE_NUM"));
		   ob.setDomicileCode((String)temp.get("DOMICILE_CODE"));
		   newList.add(ob);*/
		   
		   temp.set("peopleId",(String)temp.get("PEOPLE_ID"));
		   temp.set("name",(String)temp.get("NAME"));
		   temp.set("sex",(String)temp.get("SEX"));
		   temp.set("idCord",(String)temp.get("ID_CARD"));
		   //temp.set("age",String.valueOf(temp.get("AGE")));
		   temp.set("age",String.valueOf(BptGetAge.getAgeByBirthday((String)ds.getRecord(i).get("BIRTHDAY"))));
		   temp.set("nation",(String)temp.get("NATION"));
		   temp.set("objectType",(String)temp.get("OBJECT_TYPE"));
		   temp.set("address",(String)temp.get("ADDRESS"));
		   temp.set("familyNum",(BigDecimal)temp.get("PEOPLE_NUM"));
		   temp.set("domicileCode",(String)temp.get("DOMICILE_CODE"));
	   }
	   DataSet result = new DataSet();
	   result.getRecordSet().addAll(list);
	   result.setTotalCount(ds.getTotalCount());
	   /*for (int i = 0; i < result.getCount(); i++) {
			
			String birth=(String)ds.getRecord(i).get("BIRTHDAY");
			result.getRecord(i).set("AGE",BptGetAge.getAgeByBirthday(birth));
		}*/
		return result;
   }
   /***
	 * 对已审批的数据进行查询
	 * 
	 */
	public DataSet queryTemporaryHelp(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> argsList = new ArrayList<String>();
		   StringBuffer sql =new StringBuffer();
		   sql.append("SELECT A.APPLY_ID, A.PEOPLE_ID, B.FAMILY_ID, A.NAME, A.SEX, A.AGE, A.ID_CORD,\n");
		   sql.append("       A.NATION, A.OBJECT_TYPE, A.ADDRESS, A.FAMILY_NUM, A.HELP_TYPE,\n"); 
		   sql.append("       A.DOMICILE_CODE, A.APPLY_MON, C.FULL_NAME, A.APPLY_MON,\n"); 
		   sql.append("       A.APPLY_SUBJECT, A.CHECK_INCHARGE, A.CHECK_DATE, A.CHECK_ADVICE,\n"); 
		   sql.append("       A.AUDIT_INCHARGE, A.AUDIT_DATE, A.AUDIT_ADVICE, A.VERIFY_INCHARGE,\n"); 
		   sql.append("       A.VERIFY_DATE, A.VERIFY_ADVICE\n"); 
		   sql.append("  FROM BPT_TEMPORARY_HELP A, BASEINFO_PEOPLE B, DIC_CITY C\n"); 
		   sql.append(" WHERE B.PEOPLE_ID = A.PEOPLE_ID AND A.DOMICILE_CODE = C.ID");
		    String domicileCode = (String)pset.getParameter("domicileCode");
			String objectType = (String)pset.getParameter("objectType");
			String helpType = (String)pset.getParameter("helpType");
			String peopleId = (String)pset.getParameter("peopleId");
			String submitFlag = (String)pset.getParameter("submitFlag");
			String organCode = (String) pset.getParameter("organCode");
			if (peopleId != null && !peopleId.equals("")) {
				sql.append(" AND A.PEOPLE_ID = ? ") ;
				typeList.add(Types.VARCHAR);
				argsList.add(peopleId);
			}
			
			if (domicileCode != null && !domicileCode.equals("")) {
  				if(!"00".equals(domicileCode.substring(2, 4))) { //非省级
  					if ("00".equals(domicileCode.substring(4, 6))&& "00000000".equals(domicileCode.substring(4))) { // 市级
  						sql.append(" AND A.DOMICILE_CODE like ? ");
  						typeList.add(Types.VARCHAR);
  						argsList.add(domicileCode.substring(0, 4)+"%");
  					} else if("000000".equals(domicileCode.substring(6))) { //县级
  						sql.append(" AND A.DOMICILE_CODE like ? ");
  						typeList.add(Types.VARCHAR);
  						argsList.add(domicileCode.substring(0, 6)+"%");
  					} else if("000".equals(domicileCode.substring(9))) { //街道
  						sql.append(" AND A.DOMICILE_CODE like ? ");
  						typeList.add(Types.VARCHAR);
  						argsList.add(domicileCode.substring(0, 9)+"%");
  					} else { //村
  						sql.append(" AND A.DOMICILE_CODE = ? ");
  						typeList.add(Types.VARCHAR);
  						argsList.add(domicileCode.trim());
  					}
  				} else { //省级
  					sql.append(" AND A.DOMICILE_CODE like ? ");
  					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
  				}
  			} else {
  				if (!organCode.substring(0, 2).equals("00")
  						&& organCode.substring(2, 4).equals("00")) {
  					sql.append(" AND  A.DOMICILE_CODE like ? ");// 省局
  					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
  				} else if (!organCode.substring(2, 4).equals("00") && organCode.substring(4, 6).equals("00") && "000000".equals(organCode.substring(6))) {
  					sql.append(" AND A.DOMICILE_CODE like  ? ");// 市局
  					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
  				} else if(!organCode.substring(4, 6).equals("00")){
  					sql.append(" AND A.DOMICILE_CODE like  ? ");// 区县
  					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
  				}
  			}
			if (objectType != null && !objectType.equals("")) {
				sql.append(" AND A.OBJECT_TYPE = ? ") ;
				typeList.add(Types.VARCHAR);
				argsList.add(objectType);
			}
			
			if (helpType != null && !helpType.equals("")) {
				sql.append(" AND A.HELP_TYPE = ? ") ;
				typeList.add(Types.VARCHAR);
				argsList.add(helpType);
			}
			
			if (submitFlag != null && !"".equals(submitFlag)) {
				sql.append(" AND A.SUBMIT_FLAG = ? ") ;
				typeList.add(Types.VARCHAR);
				argsList.add(submitFlag);
			}
			sql.append(" ORDER BY A.NAME");
			DataSet ds = new DataSet();
			if(typeList.size()>0&&argsList.size()>0){
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++){
					types[i] = (Integer)typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				
				ds = this.executeDataset(sql.toString(),types,args,true);
			}else{
				ds = this.executeDataset(sql.toString(),true);
			}
		   return ds;
	}
   
	/***
	 * 对已审批的数据进行修改
	 * 
	 */
	public DataSet queryUpdateTemporaryHelp(ParameterSet pset) {
		   int start = pset.getPageStart();
		   int limit = pset.getPageLimit();
		   String applyId = (String)pset.getParameter("applyId");
		   StringBuffer sql =new StringBuffer();
		   sql.append("SELECT APPLY_ID, PEOPLE_ID, NATION, OBJECT_TYPE, HELP_TYPE, ADDRESS,\n");
		   sql.append("       FAMILY_NUM, APPLY_MON, APPLY_SUBJECT, NOTE, REG_ID, REG_TIME, MOD_ID,\n"); 
		   sql.append("       MOD_TIME, NAME, SEX, ID_CORD, AGE, DOMICILE_CODE, SUBMIT_FLAG,\n"); 
		   sql.append("       CHECK_INCHARGE, CHECK_DATE, CHECK_ADVICE, AUDIT_INCHARGE, AUDIT_DATE,\n"); 
		   sql.append("       AUDIT_ADVICE, VERIFY_INCHARGE, VERIFY_DATE, VERIFY_ADVICE\n"); 
		   sql.append("  FROM BPT_TEMPORARY_HELP\n"); 
		   sql.append(" WHERE APPLY_ID = ?");
		   DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{applyId}, start, limit, true);
		   List list = ds.getRecordSet();
		   List newList =new ArrayList();
		   for(int i = 0;i<list.size();i++){
			   BptTemporaryHelp ob = new BptTemporaryHelp();
			   Record temp = (Record) list.get(i);
			   ob.setApplyId((String)temp.get("APPLY_ID"));
			   ob.setPeopleId((String)temp.get("PEOPLE_ID"));
			   ob.setNation((String)temp.get("NATION"));
			   ob.setObjectType((String)temp.get("OBJECT_TYPE"));
			   ob.setHelpType((String)temp.get("HELP_TYPE"));
			   ob.setAddress((String)temp.get("ADDRESS"));
			   ob.setFamilyNum((BigDecimal)temp.get("FAMILY_NUM"));
			   ob.setApplyMon((BigDecimal)temp.get("APPLY_MON"));
			   ob.setApplySubject((String)temp.get("APPLY_SUBJECT"));
			   ob.setNote((String)temp.get("NOTE"));
			   ob.setRegId((String)temp.get("REG_ID"));
			   ob.setRegTime((String)temp.get("REG_TIME"));
			   ob.setModId((String)temp.get("MOD_ID"));
			   ob.setModTime((String)temp.get("MOD_TIME"));
			   ob.setName((String)temp.get("NAME"));
			   ob.setSex((String)temp.get("SEX"));
			   ob.setIdCord((String)temp.get("ID_CORD"));
			   ob.setAge((String)temp.get("AGE"));
			   ob.setDomicileCode((String)temp.get("DOMICILE_CODE"));
			   ob.setSubmitFlag((String)temp.get("SUBMIT_FLAG"));
			   ob.setCheckIncharge((String)temp.get("CHECK_INCHARGE"));
			   ob.setCheckDate((String)temp.get("CHECK_DATE"));
			   ob.setCheckAdvice((String)temp.get("CHECK_ADVICE"));
			   ob.setAuditIncharge((String)temp.get("AUDIT_INCHARGE"));
			   ob.setAuditDate((String)temp.get("AUDIT_DATE"));
			   ob.setAuditAdvice((String)temp.get("AUDIT_ADVICE"));
			   ob.setVerifyIncharge((String)temp.get("VERIFY_INCHARGE"));
			   ob.setVerifyDate((String)temp.get("VERIFY_DATE"));
			   ob.setVerifyAdvice((String)temp.get("VERIFY_ADVICE"));
			   newList.add(ob);
		   }
		   DataSet result = new DataSet();
		   result.getRecordSet().addAll(newList);
		   result.setTotalCount(ds.getTotalCount());
		   return result;
	}
}
