package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptPetitionDao;
import com.inspur.cams.bpt.base.data.BptPetition;

/**
 * @title:BptPetitionDao
 * @description:信访
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
 public class BptPetitionDao extends EntityDao<BptPetition> implements IBptPetitionDao{

 	public BptPetitionDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
  	@Override
	public Class<BptPetition> getEntityClass() {
		return BptPetition.class;
	}
   /**
    * 查询未扫描电子档案的人员
    * @param pset
    * @return
    */
   public DataSet queryNoERecord(ParameterSet pset){
	   String domicileCode = (String)pset.getParameter("domicileCode");
	   String name = (String)pset.getParameter("name");
	   String idCard = (String)pset.getParameter("idCard");
	   String objectType = (String)pset.getParameter("objectType");
	   String objectState = (String)pset.getParameter("objectState");
	   String ageBegin = (String) pset.getParameter("ageBegin");
	   String ageEnd = (String) pset.getParameter("ageEnd");
	   StringBuffer sql = new StringBuffer();
	   sql.append("SELECT V.PEOPLE_ID, V.FULL_NAME DOMICILE_NAME, V.NAME, V.SEX, V.NATION,\n");
	   sql.append("       V.ID_CARD, V.PEOPLE_AGE AS AGE, V.OBJECT_STATE, V.OBJECT_TYPE\n"); 
	   sql.append("  FROM V_BPT_OBJECT_UNION V\n"); 
	   sql.append(" WHERE V.PEOPLE_ID IN\n"); 
	   sql.append("       (SELECT T.PEOPLE_ID\n"); 
	   sql.append("          FROM BASEINFO_PEOPLE T\n"); 
	   sql.append("         WHERE T.DISABILITY_FLAG = '1' OR DEPENDANT_FLAG ='1' OR\n"); 
	   sql.append("               DEMOBILIZED_FLAG ='1' OR WAR_FLAG = '1'  OR MARTYR_OFFSPRING_FLAG='1' OR RETIRED_FLAG='1'\n"); 
	   sql.append("        MINUS\n"); 
	   sql.append("        SELECT F.PEOPLE_ID FROM BPT_ELECTRONIC F) AND ");
	    List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if (domicileCode != null && !domicileCode.equals("")) {
			if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
				sql.append(" V.DOMICILE_CODE like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4).equals("00000000")){
				sql.append(" V.DOMICILE_CODE like ?");//市局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 4)+"%");
			}else if (!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6, 9).equals("000")) {
				sql.append(" V.DOMICILE_CODE like ?");//区县
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			}else if(!domicileCode.substring(6, 9).equals("000")&&domicileCode.substring(9, 12).equals("000")){
				sql.append(" V.DOMICILE_CODE like ?");//街道
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 9)+"%");
			}else {
				sql.append(" V.DOMICILE_CODE=?");//社区
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}
		}else{
			if(!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
				sql.append(" V.DOMICILE_CODE like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 6).equals("00")){
				sql.append(" V.DOMICILE_CODE like ?");//市局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 4)+"%");
			}else{
				sql.append(" V.DOMICILE_CODE like ?");//区县
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			}
		}
		if(name!=null&&!"".equals(name)){
			sql.append(" AND V.NAME LIKE ? || '%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if(idCard!=null&&!"".equals(idCard)){
			sql.append(" AND V.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(objectType != null && !objectType.equals("")){
			/* 取出节点ID，并组合sql*/
			String[] list =  new String[20];
			list = objectType.split(",");
			if(list!=null){
				sql.append(" AND (");
				for (int i = 0; i < list.length; i++) {
					if(list[i]!=null&&!"".equals(list[i])){
						sql.append(" OBJECT_TYPE like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(list[i] + "%");
						if (i != list.length - 1) {
							sql.append(" OR ");
						}else {
							sql.append(" )");
						}
					}
				}
			}
		}
		if(objectState!=null&&!"".equals(objectState)){
			sql.append(" AND OBJECT_STATE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND  V.PEOPLE_AGE  >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}
		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND  V.PEOPLE_AGE  <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}
		//sql.append(" ORDER BY V.DOMICILE_CODE,OBJECT_TYPE ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (!pset.containsKey("limit")) {// 导出Excel用的方法
				ds= this.executeDataset(sql.toString(),types,args, true);
			} else {
				ds= this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
			}
		}
		return ds;
   }
   
   /**
    * 查询已扫描电子档案的人员
    * @param pset
    * @return
    */
   public DataSet queryHaveERecord(ParameterSet pset){
	   String domicileCode = (String)pset.getParameter("domicileCode");
	   String name = (String)pset.getParameter("name");
	   String idCard = (String)pset.getParameter("idCard");
	   String objectType = (String)pset.getParameter("objectType");
	   String objectState = (String)pset.getParameter("objectState");
	   String ageBegin = (String) pset.getParameter("ageBegin");
	   String ageEnd = (String) pset.getParameter("ageEnd");
	   StringBuffer sql = new StringBuffer();
	   sql.append("SELECT V.PEOPLE_ID, V.FULL_NAME DOMICILE_NAME, V.NAME, V.SEX, V.NATION,\n");
	   sql.append("       V.ID_CARD, V.PEOPLE_AGE AS AGE, V.OBJECT_STATE, V.OBJECT_TYPE\n"); 
	   sql.append("  FROM V_BPT_OBJECT_UNION V\n"); 
	   sql.append(" WHERE exists\n"); 
	   sql.append("       (SELECT T.PEOPLE_ID\n"); 
	   sql.append("          FROM BASEINFO_PEOPLE T ,BPT_ELECTRONIC F\n"); 
	   sql.append("         WHERE (T.DISABILITY_FLAG = '1' OR DEPENDANT_FLAG ='1' OR\n"); 
	   sql.append("               DEMOBILIZED_FLAG ='1' OR WAR_FLAG = '1'  OR MARTYR_OFFSPRING_FLAG='1' OR RETIRED_FLAG='1')\n"); 
	   sql.append("         and f.people_id=t.people_id and v.PEOPLE_ID = t.people_id) and \n"); 
	    List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		if (domicileCode != null && !domicileCode.equals("")) {
			if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
				sql.append(" V.DOMICILE_CODE like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4).equals("00000000")){
				sql.append(" V.DOMICILE_CODE like ?");//市局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 4)+"%");
			}else if (!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6, 9).equals("000")) {
				sql.append(" V.DOMICILE_CODE like ?");//区县
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			}else if(!domicileCode.substring(6, 9).equals("000")&&domicileCode.substring(9, 12).equals("000")){
				sql.append(" V.DOMICILE_CODE like ?");//街道
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 9)+"%");
			}else {
				sql.append(" V.DOMICILE_CODE=?");//社区
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}
		}else{
			if(!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
				sql.append(" V.DOMICILE_CODE like ?");// 省局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 2)+"%");
			}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 6).equals("00")){
				sql.append(" V.DOMICILE_CODE like ?");//市局
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 4)+"%");
			}else{
				sql.append(" V.DOMICILE_CODE like ?");//区县
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode.substring(0, 6)+"%");
			}
		}
		if(name!=null&&!"".equals(name)){
			sql.append(" AND V.NAME LIKE ? || '%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if(idCard!=null&&!"".equals(idCard)){
			sql.append(" AND V.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(objectType != null && !objectType.equals("")){
			/* 取出节点ID，并组合sql*/
			String[] list =  new String[20];
			list = objectType.split(",");
			if(list!=null){
				sql.append(" AND (");
				for (int i = 0; i < list.length; i++) {
					if(list[i]!=null&&!"".equals(list[i])){
						sql.append(" OBJECT_TYPE like ? ");
						typeList.add(Types.VARCHAR);
						argsList.add(list[i] + "%");
						if (i != list.length - 1) {
							sql.append(" OR ");
						}else {
							sql.append(" )");
						}
					}
				}
			}
		}
		if(objectState!=null&&!"".equals(objectState)){
			sql.append(" AND OBJECT_STATE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(objectState);
		}
		if (ageBegin != null && !"".equals(ageBegin)) {
			sql.append(" AND  V.PEOPLE_AGE  >= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageBegin));
		}
		if (ageEnd != null && !"".equals(ageEnd)) {
			sql.append(" AND  V.PEOPLE_AGE  <= ?");
			typeList.add(Types.INTEGER);
			argsList.add(Integer.parseInt(ageEnd));
		}
		//sql.append(" ORDER BY V.DOMICILE_CODE,OBJECT_TYPE ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			if (!pset.containsKey("limit")) {// 导出Excel用的方法
				ds= this.executeDataset(sql.toString(),types,args, true);
			} else {
				ds= this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
			}
		}
		return ds;
   }
   /**
	 * 查询未上传二代身份证扫描件人员
	 * @return
	 */
	public DataSet queryNoPhoto(ParameterSet pset) {
		String domicileCode = (String)pset.getParameter("domicileCode");
		   String name = (String)pset.getParameter("name");
		   String idCard = (String)pset.getParameter("idCard");
		   String objectType = (String)pset.getParameter("objectType");
		   String objectState = (String)pset.getParameter("objectState");
		   String ageBegin = (String) pset.getParameter("ageBegin");
		   String ageEnd = (String) pset.getParameter("ageEnd");
		   StringBuffer sql = new StringBuffer();
		   sql.append("SELECT V.PEOPLE_ID, V.FULL_NAME DOMICILE_NAME, V.NAME, V.SEX, V.NATION,\n");
		   sql.append("       V.ID_CARD, V.PEOPLE_AGE AS AGE, V.OBJECT_STATE, V.OBJECT_TYPE\n"); 
		   sql.append("  FROM V_BPT_OBJECT_UNION V\n"); 
		   sql.append(" WHERE V.PEOPLE_ID IN\n"); 
		   sql.append("       (select t.people_id from baseinfo_people t where t.HAVE_NEW_CARD is null ) AND \n");
		    List<Object> typeList = new ArrayList<Object>();
			List<Object> argsList = new ArrayList<Object>();
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
					sql.append(" V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4).equals("00000000")){
					sql.append(" V.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}else if (!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6,9).equals("000")) {
					sql.append(" V.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				}else if(!domicileCode.substring(6, 9).equals("000")&&domicileCode.substring(9, 12).equals("000")){
					sql.append(" V.DOMICILE_CODE like ?");//街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				}else {
					sql.append(" V.DOMICILE_CODE =?");//社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			}else{
				if(!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
					sql.append(" V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 6).equals("00")){
					sql.append(" V.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}else{
					sql.append(" V.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				}
			}
			if(name!=null&&!"".equals(name)){
				sql.append(" AND V.NAME LIKE ? || '%' ");
				typeList.add(Types.VARCHAR);
				argsList.add(name);
			}
			if(idCard!=null&&!"".equals(idCard)){
				sql.append(" AND V.ID_CARD = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(idCard);
			}
			if(objectType != null && !objectType.equals("")){
				/* 取出节点ID，并组合sql*/
				String[] list =  new String[20];
				list = objectType.split(",");
				if(list!=null){
					sql.append(" AND (");
					for (int i = 0; i < list.length; i++) {
						if(list[i]!=null&&!"".equals(list[i])){
							sql.append(" OBJECT_TYPE like ? ");
							typeList.add(Types.VARCHAR);
							argsList.add(list[i] + "%");
							if (i != list.length - 1) {
								sql.append(" OR ");
							}else {
								sql.append(" )");
							}
						}
					}
				}
			}
			if(objectState!=null&&!"".equals(objectState)){
				sql.append(" AND OBJECT_STATE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(objectState);
			}
			if (ageBegin != null && !"".equals(ageBegin)) {
				sql.append(" AND  V.PEOPLE_AGE  >= ?");
				typeList.add(Types.INTEGER);
				argsList.add(Integer.parseInt(ageBegin));
			}
			if (ageEnd != null && !"".equals(ageEnd)) {
				sql.append(" AND  V.PEOPLE_AGE  <= ?");
				typeList.add(Types.INTEGER);
				argsList.add(Integer.parseInt(ageEnd));
			}
			//sql.append(" ORDER BY V.DOMICILE_CODE,OBJECT_TYPE ");
			DataSet ds = new DataSet();
			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				if (!pset.containsKey("limit")) {// 导出Excel用的方法
					ds= this.executeDataset(sql.toString(),types,args, true);
				} else {
					ds= this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
				}
			}
			return ds;
	}
	/**
	 * 查询已上传二代身份证扫描件人员
	 * @return
	 */
	public DataSet queryHavePhoto(ParameterSet pset) {
		String domicileCode = (String)pset.getParameter("domicileCode");
		   String name = (String)pset.getParameter("name");
		   String idCard = (String)pset.getParameter("idCard");
		   String objectType = (String)pset.getParameter("objectType");
		   String objectState = (String)pset.getParameter("objectState");
		   String ageBegin = (String) pset.getParameter("ageBegin");
		   String ageEnd = (String) pset.getParameter("ageEnd");
		   StringBuffer sql = new StringBuffer();
		   sql.append("SELECT V.PEOPLE_ID, V.FULL_NAME DOMICILE_NAME, V.NAME, V.SEX, V.NATION,\n");
		   sql.append("       V.ID_CARD, V.PEOPLE_AGE AS AGE, V.OBJECT_STATE, V.OBJECT_TYPE\n"); 
		   sql.append("  FROM V_BPT_OBJECT_UNION V\n"); 
		   sql.append(" WHERE V.PEOPLE_ID IN\n"); 
		   sql.append("       (select t.people_id from baseinfo_people t where t.HAVE_NEW_CARD ='1' ) AND \n");
		    List<Object> typeList = new ArrayList<Object>();
			List<Object> argsList = new ArrayList<Object>();
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
					sql.append(" V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4).equals("00000000")){
					sql.append(" V.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}else if (!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6, 9).equals("000")) {
					sql.append(" V.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				}else if(!domicileCode.substring(6, 9).equals("000")&&domicileCode.substring(9, 12).equals("000")){
					sql.append(" V.DOMICILE_CODE like ?");//街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				}else {
					sql.append(" V.DOMICILE_CODE=?");//社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			}else{
				if(!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
					sql.append(" V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 6).equals("00")){
					sql.append(" V.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}else{
					sql.append(" V.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				}
			}
			if(name!=null&&!"".equals(name)){
				sql.append(" AND V.NAME LIKE ? || '%' ");
				typeList.add(Types.VARCHAR);
				argsList.add(name);
			}
			if(idCard!=null&&!"".equals(idCard)){
				sql.append(" AND V.ID_CARD = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(idCard);
			}
			if(objectType != null && !objectType.equals("")){
				/* 取出节点ID，并组合sql*/
				String[] list =  new String[20];
				list = objectType.split(",");
				if(list!=null){
					sql.append(" AND (");
					for (int i = 0; i < list.length; i++) {
						if(list[i]!=null&&!"".equals(list[i])){
							sql.append(" OBJECT_TYPE like ? ");
							typeList.add(Types.VARCHAR);
							argsList.add(list[i] + "%");
							if (i != list.length - 1) {
								sql.append(" OR ");
							}else {
								sql.append(" )");
							}
						}
					}
				}
			}
			if(objectState!=null&&!"".equals(objectState)){
				sql.append(" AND OBJECT_STATE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(objectState);
			}
			if (ageBegin != null && !"".equals(ageBegin)) {
				sql.append(" AND  V.PEOPLE_AGE  >= ?");
				typeList.add(Types.INTEGER);
				argsList.add(Integer.parseInt(ageBegin));
			}
			if (ageEnd != null && !"".equals(ageEnd)) {
				sql.append(" AND  V.PEOPLE_AGE  <= ?");
				typeList.add(Types.INTEGER);
				argsList.add(Integer.parseInt(ageEnd));
			}
			//sql.append(" ORDER BY V.DOMICILE_CODE,OBJECT_TYPE ");
			DataSet ds = new DataSet();
			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				if (!pset.containsKey("limit")) {// 导出Excel用的方法
					ds= this.executeDataset(sql.toString(),types,args, true);
				} else {
					ds= this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
				}
			}
			return ds;
	}
	
	/**
	 * 查询已上传二代身份证扫描件人员
	 * @return
	 */
	public DataSet queryHaveERecordPhoto(ParameterSet pset) {
		String domicileCode = (String)pset.getParameter("domicileCode");
		   String name = (String)pset.getParameter("name");
		   String idCard = (String)pset.getParameter("idCard");
		   String objectType = (String)pset.getParameter("objectType");
		   String objectState = (String)pset.getParameter("objectState");
		   String ageBegin = (String) pset.getParameter("ageBegin");
		   String ageEnd = (String) pset.getParameter("ageEnd");
		   StringBuffer sql = new StringBuffer();
		   sql.append("SELECT V.PEOPLE_ID, V.FULL_NAME DOMICILE_NAME, V.NAME, V.SEX, V.NATION,\n");
		   sql.append("       V.ID_CARD, V.PEOPLE_AGE AS AGE, V.OBJECT_STATE, V.OBJECT_TYPE\n"); 
		   sql.append("  FROM V_BPT_OBJECT_UNION V\n"); 
		   sql.append(" WHERE exists \n"); 
		   sql.append("       (SELECT T.PEOPLE_ID\n"); 
		   sql.append("          FROM BASEINFO_PEOPLE T ,BPT_ELECTRONIC F\n"); 
		   sql.append("         WHERE (T.DISABILITY_FLAG = '1' OR DEPENDANT_FLAG ='1' OR\n"); 
		   sql.append("               DEMOBILIZED_FLAG ='1' OR WAR_FLAG = '1'  OR MARTYR_OFFSPRING_FLAG='1' OR RETIRED_FLAG='1')\n"); 
		   sql.append("         and f.people_id=t.people_id  and t.HAVE_NEW_CARD = '1' and v.PEOPLE_ID = t.people_id ) and \n"); 
		    List<Object> typeList = new ArrayList<Object>();
			List<Object> argsList = new ArrayList<Object>();
			if (domicileCode != null && !domicileCode.equals("")) {
				if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
					sql.append(" V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4).equals("00000000")){
					sql.append(" V.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}else if (!domicileCode.substring(4, 6).equals("00")&&domicileCode.substring(6, 9).equals("000")) {
					sql.append(" V.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				}else if(!domicileCode.substring(6, 9).equals("000")&&domicileCode.substring(9, 12).equals("000")){
					sql.append(" V.DOMICILE_CODE like ?");//街道
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 9)+"%");
				}else {
					sql.append(" V.DOMICILE_CODE=?");//社区
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode);
				}
			}else{
				if(!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(2, 4).equals("00")) {
					sql.append(" V.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 2)+"%");
				}else if(!domicileCode.substring(2, 4).equals("00")&&domicileCode.substring(4, 6).equals("00")){
					sql.append(" V.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 4)+"%");
				}else{
					sql.append("V.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(domicileCode.substring(0, 6)+"%");
				}
			}
			if(name!=null&&!"".equals(name)){
				sql.append(" AND V.NAME LIKE ? || '%' ");
				typeList.add(Types.VARCHAR);
				argsList.add(name);
			}
			if(idCard!=null&&!"".equals(idCard)){
				sql.append(" AND V.ID_CARD = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(idCard);
			}
			if(objectType != null && !objectType.equals("")){
				/* 取出节点ID，并组合sql*/
				String[] list =  new String[20];
				list = objectType.split(",");
				if(list!=null){
					sql.append(" AND (");
					for (int i = 0; i < list.length; i++) {
						if(list[i]!=null&&!"".equals(list[i])){
							sql.append(" OBJECT_TYPE like ? ");
							typeList.add(Types.VARCHAR);
							argsList.add(list[i] + "%");
							if (i != list.length - 1) {
								sql.append(" OR ");
							}else {
								sql.append(" )");
							}
						}
					}
				}
			}
			if(objectState!=null&&!"".equals(objectState)){
				sql.append(" AND OBJECT_STATE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(objectState);
			}
			if (ageBegin != null && !"".equals(ageBegin)) {
				sql.append(" AND  V.PEOPLE_AGE  >= ?");
				typeList.add(Types.INTEGER);
				argsList.add(Integer.parseInt(ageBegin));
			}
			if (ageEnd != null && !"".equals(ageEnd)) {
				sql.append(" AND  V.PEOPLE_AGE  <= ?");
				typeList.add(Types.INTEGER);
				argsList.add(Integer.parseInt(ageEnd));
			}
			//sql.append(" ORDER BY V.DOMICILE_CODE,OBJECT_TYPE ");
			DataSet ds = new DataSet();
			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++) {
					types[i]=(Integer)(typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				if (!pset.containsKey("limit")) {// 导出Excel用的方法
					ds= this.executeDataset(sql.toString(),types,args, true);
				} else {
					ds= this.executeDataset(sql.toString(),types,args,pset.getPageStart(),pset.getPageLimit(), true);
				}
			}
			return ds;
	}
}
