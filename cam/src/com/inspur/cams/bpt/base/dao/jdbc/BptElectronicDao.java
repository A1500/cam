package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptElectronicDao;
import com.inspur.cams.bpt.base.data.BptElectronic;
import com.inspur.cams.bpt.util.FieldCaseChange;

/**
 * @title:BptElectronicDao
 * @description:
 * @author:
 * @since:2011-05-20
 * @version:1.0
*/
 public class BptElectronicDao extends EntityDao<BptElectronic> implements IBptElectronicDao{

 	public BptElectronicDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptElectronic> getEntityClass() {
		return BptElectronic.class;
	}
   
   /**
	 * 优抚对象信息管理修改人员信息，选择档案目录，加入公共目录部分
	 */
	public DataSet queryBaseInforSelectedContents(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> argsList = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.PEOPLE_ID AS PEOPLE_ID, T.APPLY_ID AS APPLY_ID,\n");
		sql.append("       T.OBJECT_TYPE AS OBJECT_TYPE, T.SERVICE_TYPE AS SERVICE_TYPE,\n"); 
		sql.append("       T.FILE_NAME AS FILE_NAME, T.FILE_TYPE AS FILE_TYPE,\n"); 
		sql.append("       T.FILE_MESS AS FILE_MESS, T.FILE_PATH AS FILE_PATH,\n"); 
		sql.append("       T.FILE_ID AS FILE_ID, T.ELECTRONIC_ID AS ELECTRONIC_ID,\n"); 
		sql.append("       T.FILE_SAVE AS FILE_SAVE, T.FILE_TIME AS FILE_TIME,\n"); 
		sql.append("       T.FILE_NUMBER AS FILE_NUMBER, T.FILE_OPER AS FILE_OPER,\n"); 
		sql.append("       B.CATALOG_CODE AS CATALOG_CODE, B.CATALOG_NAME AS CATALOG_NAME,\n"); 
		sql.append("       B.CATALOG_ORDER AS CATALOG_ORDER, B.ORGAN_ID AS ORGAN_ID\n"); 
		sql.append("  FROM BPT_ELECTRONIC T, BPT_CATALOGUE_ARCHIVES B\n"); 
		sql.append(" WHERE T.SERVICE_TYPE = B.SERVICE_TYPE AND T.FILE_TYPE = B.CATALOG_CODE AND\n"); 
		sql.append("       B.UP_CATALOG_CODE <> '0'");
		if(pset.getParameter("PEOPLE_ID")!= null){
			String peopleId = pset.getParameter("PEOPLE_ID").toString();
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
			sql.append(" AND PEOPLE_ID = ? ");
		}
		if(pset.getParameter("APPLY_ID")!= null){
			String applyId = pset.getParameter("APPLY_ID").toString();
			sql.append(" AND APPLY_ID =  ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}

		if(pset.getParameter("ORGAN_ID")!= null){
			String organCode = pset.getParameter("ORGAN_ID").toString();
			sql.append(" AND B.ORGAN_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if(pset.getParameter("SERVICE_TYPE")!=null){
			String serviceType = pset.getParameter("SERVICE_TYPE").toString();
			if("11".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('11','12','13','14','15','16','19')");
			}else if("21".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('21','22','23','25')");
			}else if("41".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('41','42','43','4A')");
			}else if("45".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('45','46','47','4B')");
			}else if("51".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('51','52','53','55')");
			}else if("61".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('61','62','63','65')");
			}else if("81".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('81','82','83','84')");
			}else if("B1".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('B1','B2','B3','B4')");
			}
		}
		if(pset.containsKey("serviceType") && pset.getParameter("serviceType")  != null) {
			String serviceType = (String)pset.getParameter("serviceType");
			sql.append(" and T.SERVICE_TYPE =  ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		if(pset.getParameter("ELECTRONIC_ID")!=null){
			String electronicId = pset.getParameter("ELECTRONIC_ID").toString();
			sql.append(" AND ELECTRONIC_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(electronicId);
		}
		sql.append(" ORDER BY T.SERVICE_TYPE, B.CATALOG_ORDER");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		}
		List<Record> newList = new ArrayList<Record>();
		for(Record temp:ds.getRecordSet()){
			Record record = new Record();
			FieldCaseChange.formatRecord(record, temp);
			newList.add(record);
		}
		DataSet resultDataSet = new DataSet();
		resultDataSet.getRecordSet().addAll(newList);
		resultDataSet.setTotalCount(ds.getTotalCount());
		return resultDataSet;
	}
   
   /**
	 * 查询已经选择的档案目录
	 */
	public DataSet querySelectedContents(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> argsList = new ArrayList<String>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.PEOPLE_ID AS PEOPLE_ID, T.APPLY_ID AS APPLY_ID,\n");
		sql.append("       T.OBJECT_TYPE AS OBJECT_TYPE, T.SERVICE_TYPE AS SERVICE_TYPE,\n"); 
		sql.append("       T.FILE_NAME AS FILE_NAME, T.FILE_TYPE AS FILE_TYPE,\n"); 
		sql.append("       T.FILE_MESS AS FILE_MESS, T.FILE_PATH AS FILE_PATH,\n"); 
		sql.append("       T.FILE_ID AS FILE_ID, T.ELECTRONIC_ID AS ELECTRONIC_ID,\n"); 
		sql.append("       T.FILE_SAVE AS FILE_SAVE, T.FILE_TIME AS FILE_TIME,\n"); 
		sql.append("       T.FILE_NUMBER AS FILE_NUMBER, T.FILE_OPER AS FILE_OPER,\n"); 
		sql.append("       B.CATALOG_CODE AS CATALOG_CODE, B.CATALOG_NAME AS CATALOG_NAME,\n"); 
		sql.append("       B.CATALOG_ORDER AS CATALOG_ORDER, B.ORGAN_ID AS ORGAN_ID\n"); 
		sql.append("  FROM BPT_ELECTRONIC T, BPT_CATALOGUE_ARCHIVES B\n"); 
		sql.append(" WHERE T.SERVICE_TYPE = B.SERVICE_TYPE AND T.FILE_TYPE = B.CATALOG_CODE AND\n"); 
		sql.append("       B.UP_CATALOG_CODE <> '0'");
		if(pset.getParameter("PEOPLE_ID")!= null){
			String peopleId = pset.getParameter("PEOPLE_ID").toString();
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
			sql.append(" AND PEOPLE_ID = ? ");
		}
		if(pset.getParameter("APPLY_ID")!= null){
			String applyId = pset.getParameter("APPLY_ID").toString();
			sql.append(" AND APPLY_ID =  ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		if(pset.getParameter("ORGAN_ID")!= null){
			String organCode = pset.getParameter("ORGAN_ID").toString();
			sql.append(" AND B.ORGAN_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		}
		if(pset.getParameter("SERVICE_TYPE")!=null){
			String serviceType = pset.getParameter("SERVICE_TYPE").toString();
			if("11".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('11','12','13','14','15','16','19')");
			}
			if("21".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('21','22','23','25')");
			}
			if("41".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('41','42','43','4A')");
			}
			if("45".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('45','46','47','4B')");
			}
			if("51".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('51','52','53','55')");
			}
			if("61".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('61','62','63','65')");
			}
			if("81".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('81','82','83','84')");
			}
			if("B1".equals(serviceType)){
				sql.append(" AND T.SERVICE_TYPE IN('B1','B2','B3','B4')");
			}
		}
		if(pset.containsKey("serviceType") && pset.getParameter("serviceType")  != null) {
			String serviceType = (String)pset.getParameter("serviceType");
			sql.append(" and T.service_type =  ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		if(pset.getParameter("ELECTRONIC_ID")!=null){
			String electronicId = pset.getParameter("ELECTRONIC_ID").toString();
			sql.append(" AND ELECTRONIC_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(electronicId);
		}
		sql.append(" ORDER BY T.SERVICE_TYPE, B.CATALOG_ORDER");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		}
		List<Record> newList = new ArrayList<Record>();
		for(Record temp:ds.getRecordSet()){
			Record record = new Record();
			FieldCaseChange.formatRecord(record, temp);
			newList.add(record);
		}
		DataSet resultDataSet = new DataSet();
		resultDataSet.getRecordSet().addAll(newList);
		resultDataSet.setTotalCount(ds.getTotalCount());
		return resultDataSet;
	}
   /**
    * 获取档案信息
    * @param pSet
    * @return
    */
	public DataSet queryProcessElectronic(ParameterSet pSet){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		DataSet ds = new DataSet();
		String serviceType = (String)pSet.getParameter("serviceType");
		String peopleId = pSet.getParameter("PEOPLE_ID").toString();
		StringBuffer sqlPBuffer = new StringBuffer();
		sqlPBuffer.append("SELECT DISTINCT T.PEOPLE_ID,\n");
		sqlPBuffer.append("                CASE\n"); 
		sqlPBuffer.append("                  WHEN T.APPLY_ID IS NULL THEN '数据采集'\n"); 
		sqlPBuffer.append("                  ELSE '业务办理'\n"); 
		sqlPBuffer.append("                END AS YW_NAME, T.SERVICE_TYPE, T.APPLY_ID\n"); 
		sqlPBuffer.append("  FROM BPT_ELECTRONIC T\n"); 
		sqlPBuffer.append(" WHERE 1 = 1");
		if (pSet.getParameter("PEOPLE_ID") != null) {
			sqlPBuffer.append(" AND T.PEOPLE_ID= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if("11".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('11','12','13','14','15','16','18','19')");
		}
		if("21".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('21','22','23','24','25')");
		}
		if("41".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('41','42','43','44','4A')");
		}
		if("42".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('45','46','47','48','4B')");
		}
		if("51".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('51','52','53','54','55')");
		}
		if("61".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('61','62','63','64','65')");
		}
		if("81".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('81','82','83','84')");
		}
		if("B1".equals(serviceType)){
			sqlPBuffer.append(" AND T.SERVICE_TYPE IN('B1','B2','B3','B4')");
		}
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		ds = this.executeDataset(sqlPBuffer.toString(),types,args, pSet.getPageStart(),pSet.getPageLimit(),true);
		Record record = new Record();
		if(ds.getCount() == 0) {
			StringBuffer sql = new StringBuffer();
			if("11".equals(serviceType)) {
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_DISABILITY V");
			} else if("21".equals(serviceType)) {
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_DENPENT V ");
			} else if("41".equals(serviceType)) {
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_DEMOBILIZED V");
			} else if("42".equals(serviceType)) {
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_DEM_ILLNESS V");
			} else if("51".equals(serviceType)) {
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_WAR V");
			} else if("61".equals(serviceType)) {
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_TEST V");
			} else if("81".equals(serviceType)){
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_RETIRED_SOLDIER V");
			} else if ("B1".equals(serviceType)){
				sql.append("SELECT APPLY_ID,PEOPLE_ID,SERVICE_TYPE FROM V_BPT_APPLY_MARTYR_OFFSPRING V");
			}
			sql.append(" WHERE V.PEOPLE_ID = ? ");
			ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);
			Record recordq1 = new Record();
			if(ds.getCount() == 0) {
				recordq1.set("YW_NAME", "数据采集");
				recordq1.set("SERVICE_TYPE", serviceType);
				recordq1.set("PEOPLE_ID", peopleId);
				ds.add(recordq1);
			} else {
				for(int i=0;i<ds.getCount();i++) {
					recordq1 = ds.getRecord(i);
					recordq1.set("YW_NAME", "业务办理");
				}
			}
		}
   		record.set("YW_NAME", "其他");
 		record.set("SERVICE_TYPE", "99");
 		record.set("PEOPLE_ID", peopleId);
		ds.add(record);
		return ds;
	}
	
		/**
	    * 获取详细档案信息
	    * @param pSet
	    * @return
	    */
		public DataSet queryProcessElectronicInfo(ParameterSet pSet){
			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> argsList = new ArrayList<Object>();
			StringBuffer sqlPBuffer = new StringBuffer();
			sqlPBuffer.append("SELECT DISTINCT B.CONTENT_NUM_ID, N.CONTENT_NUM_NAME, N.FILE_CABINET_NAME,\n");
			sqlPBuffer.append("       N.LAYER_NUM, N.BOX_NUM, N.CONTENT_YEAR, N.PLAIT_DATE,B.ARCHIVE_NO\n"); 
			sqlPBuffer.append("  FROM BPT_ELECTRONIC_LIST B, BPT_ELECTRONIC_CONTENT_NUM N, BPT_ELECTRONIC T\n"); 
			sqlPBuffer.append(" WHERE B.CONTENT_NUM_ID = N.CONTENT_NUM_ID AND B.PEOPLE_ID = T.PEOPLE_ID");
			if (pSet.getParameter("PEOPLE_ID") != null) {
				String peopleId = pSet.getParameter("PEOPLE_ID").toString();
				sqlPBuffer.append(" AND T.PEOPLE_ID= ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(peopleId);
			}
			if(pSet.containsKey("serviceType") && pSet.getParameter("serviceType") != null) {
				String serviceType = (String)pSet.getParameter("serviceType");
				sqlPBuffer.append(" AND T.SERVICE_TYPE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(serviceType);
			}
			DataSet ds = new DataSet();
			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = (Integer) (typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sqlPBuffer.toString(),types,args, pSet.getPageStart(),pSet.getPageLimit(),true);
			}
			return ds;
		}
		/**
		    * 获取详细档案信息打印封面
		    * @param pSet
		    * @return
		    */
		public DataSet queryProcessElectronicPrint(ParameterSet pSet){
			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> argsList = new ArrayList<Object>();
			StringBuffer sqlPBuffer = new StringBuffer();
			sqlPBuffer.append("SELECT DISTINCT M.ARCHIVAL_FONDS_NAME, N.CONTENT_NUM_NAME, N.CONTENT_YEAR,\n");
			sqlPBuffer.append("                N.PLAIT_DATE, N.COLLATOR, N.EXAMINER, N.PLAIT_DATE,\n"); 
			sqlPBuffer.append("                N.CONDITION_EXPLAIN, N.DOMICILE_NAME");
			
			if(pSet.containsKey("objectType") && pSet.getParameter("objectType") != null) {
				String objectType = (String)pSet.getParameter("objectType");
				String type ="优抚人员";
				if("11".equals(objectType)){
					type="伤残人员抚恤";
				}else if("41".equals(objectType)){
					type="在乡复员军人";
				}else if("42".equals(objectType)){
					type="带病回乡复员军人";
				}else if("21".equals(objectType)){
					type="三属人员";
				}else if("51".equals(objectType)){
					type="参战人员";
				}else if("61".equals(objectType)){
					type="参核人员";
				}else if("81".equals(objectType)){
					type="年满60周岁农村籍退役士兵";
				}else if("B1".equals(objectType)){
					type="老烈士子女";
				}
				sqlPBuffer.append(" ,? AS SERVICETYPE");
				typeList.add(Types.VARCHAR);
				argsList.add(type);
			}
			sqlPBuffer.append(" FROM BPT_ELECTRONIC_CONTENT_NUM N, BPT_ELECTRONIC_RDGROUP_NUM M,\n");
			sqlPBuffer.append("      BPT_ELECTRONIC T, BPT_ELECTRONIC_LIST B\n"); 
			sqlPBuffer.append("WHERE B.CONTENT_NUM_ID = N.CONTENT_NUM_ID AND B.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
			sqlPBuffer.append("      M.ARCHIVAL_FONDS_ID = N.ARCHIVAL_FONDS_ID");

			if (pSet.getParameter("PEOPLE_ID") != null) {
				String peopleId = pSet.getParameter("PEOPLE_ID").toString();
				sqlPBuffer.append(" AND T.PEOPLE_ID= ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(peopleId);
			}
			if(pSet.containsKey("serviceType") && pSet.getParameter("serviceType") != null) {
				String serviceType = (String)pSet.getParameter("serviceType");
				sqlPBuffer.append(" AND T.SERVICE_TYPE = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(serviceType);
			}
			DataSet ds = new DataSet();
			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = (Integer) (typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				ds = this.executeDataset(sqlPBuffer.toString(),types,args,true);
			}	
			return ds;
		}
		
		/**
		    * 档案管理中获取详细档案信息打印封面
		    * @param pSet
		    * @return
		    */
		public DataSet queryElectronicPrintCover(ParameterSet pSet){
			StringBuffer sqlPBuffer = new StringBuffer();
			sqlPBuffer.append("SELECT DISTINCT M.ARCHIVAL_FONDS_NAME, N.CONTENT_NUM_NAME, N.CONTENT_YEAR,\n");
			sqlPBuffer.append("                N.PLAIT_DATE, N.COLLATOR, N.EXAMINER, N.PLAIT_DATE,\n"); 
			sqlPBuffer.append("                N.CONDITION_EXPLAIN, N.DOMICILE_NAME, N.NOTE\n"); 
			sqlPBuffer.append("  FROM BPT_ELECTRONIC_CONTENT_NUM N, BPT_ELECTRONIC_RDGROUP_NUM M\n"); 
			sqlPBuffer.append(" WHERE M.ARCHIVAL_FONDS_ID = N.ARCHIVAL_FONDS_ID");
			
			String contentNnmId = (String)pSet.getParameter("contentNnmId");
			sqlPBuffer.append(" AND N.CONTENT_NUM_ID= ? ");
			
			return this.executeDataset(sqlPBuffer.toString(),new int[]{Types.VARCHAR},new Object[]{contentNnmId},true);
		}
		
		public DataSet queryContentPeople(ParameterSet pset){
			List<Integer> typeList = new ArrayList<Integer>();
			List<Object> argsList = new ArrayList<Object>();
			StringBuffer sqlPBuffer = new StringBuffer();
			sqlPBuffer.append("SELECT DISTINCT L.PEOPLE_ID,L.ARCHIVE_NO, B.NAME, B.ID_CARD, B.SEX, N.CONTENT_YEAR,\n");
			sqlPBuffer.append("                L.SERVICE_TYPE,N.FILE_CABINET_NAME,N.LAYER_NUM,N.BOX_NUM,\n"); 
			sqlPBuffer.append("                (CASE\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('11', '12', '13', '14', '15', '16', '19') THEN B.DISABILITY_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('21', '22', '23', '25') THEN B.DEPENDANT_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('41', '42', '43', '4A') THEN B.DEMOBILIZED_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('45', '46', '47', '4B') THEN B.DEMOBILIZED_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('51', '52', '53', '55') THEN B.WAR_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('61', '62', '63', '65') THEN B.WAR_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('81', '82', '83', '84') THEN B.RETIRED_NO\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('B1', 'B2', 'B3', 'B4') THEN B.MARTYR_OFFSPRING_NO\n"); 
			sqlPBuffer.append("                END) AS BPT_NO,\n"); 
			sqlPBuffer.append("                (CASE\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('11', '12', '13', '14', '15', '16', '19') THEN '伤残抚恤人员'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('21', '22', '23', '25') THEN '三属人员'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('41', '42', '43', '4A') THEN '在乡人员'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('45', '46', '47', '4B') THEN '带病回乡人员'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('51', '52', '53', '55') THEN '参战人员'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('81', '82', '83', '84') THEN '参试人员'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('61', '62', '63', '65') THEN '年满60周岁农村籍退役士兵'\n"); 
			sqlPBuffer.append("                  WHEN L.SERVICE_TYPE IN ('B1', 'B2', 'B3', 'B4') THEN '老烈士子女'\n"); 
			sqlPBuffer.append("                END) AS BPT_TYPE\n"); 
			sqlPBuffer.append("  FROM BPT_ELECTRONIC_LIST L, BASEINFO_PEOPLE B,\n"); 
			sqlPBuffer.append("       BPT_ELECTRONIC_CONTENT_NUM N\n"); 
			sqlPBuffer.append(" WHERE B.PEOPLE_ID = L.PEOPLE_ID AND N.CONTENT_NUM_ID = L.CONTENT_NUM_ID");
			
			if(pset.containsKey("contentNumId") && pset.getParameter("contentNumId") != null) {
				String contentNumId = (String)pset.getParameter("contentNumId");
				sqlPBuffer.append(" AND L.CONTENT_NUM_ID = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(contentNumId);
			}
			if(pset.containsKey("idCard") && pset.getParameter("idCard") != null) {
				String idCard = (String)pset.getParameter("idCard");
				sqlPBuffer.append(" AND B.ID_CARD = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(idCard);
			}
			if(pset.containsKey("name") && pset.getParameter("name") != null) {
				String name = (String)pset.getParameter("name");
				sqlPBuffer.append(" AND B.NAME LIKE ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(name+"%");
			}
			if(pset.containsKey("organCode") && pset.getParameter("organCode") != null) {
				String organCode = (String)pset.getParameter("organCode");
				
				if (!organCode.substring(0, 2).equals("00") && organCode.substring(2, 4).equals("00")) {
					sqlPBuffer.append(" AND  L.DOMICILE_CODE like ?");// 省局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 2)+"%");
				}else if(!organCode.substring(2, 4).equals("00")&&organCode.substring(4, 6).equals("00")){
					sqlPBuffer.append(" AND L.DOMICILE_CODE like ?");//市局
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 4)+"%");
				}else{
					sqlPBuffer.append(" AND L.DOMICILE_CODE like ?");//区县
					typeList.add(Types.VARCHAR);
					argsList.add(organCode.substring(0, 6)+"%");
				}
			}
			sqlPBuffer.append(" ORDER BY L.SERVICE_TYPE,L.ARCHIVE_NO");//区县
			DataSet ds = new DataSet();
			if (typeList.size() != 0 && argsList.size() != 0) {
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = (Integer) (typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				if(pset.containsKey("query")){//根据此参数判定是否要 分页
					return this.executeDataset(sqlPBuffer.toString(),types,args,pset.getPageStart(),pset.getPageLimit(),true);
				}else {
					return this.executeDataset(sqlPBuffer.toString(),types,args,true);
				}
			}		
			return ds;
		}
		/**
		 * 根据applyId删除信息
		 * @param pset
		 */
		public void delElectByApplyId(ParameterSet pset){
			String applyId =(String)pset.get("applyId");
			int[] type = new int[1];
			Object[] applyid = new Object[1];
			type[0]=Types.VARCHAR;
			applyid[0]=applyId;
			this.executeUpdate("DELETE FROM bpt_electronic A WHERE A.APPLY_ID=?",type,applyid);
		}
}
