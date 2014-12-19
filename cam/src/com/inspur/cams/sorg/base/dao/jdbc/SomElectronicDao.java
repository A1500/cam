package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.dao.ISomElectronicDao;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.util.ApplyType;

/**
 * 社会组织电子档案dao实现类
 * 
 * @author shgtch
 * @date 2011-8-18
 */
public class SomElectronicDao extends EntityDao<SomElectronic> implements
		ISomElectronicDao {
	public static String UPDATE_SORG_ID = "UPDATE som_electronic SET SORG_ID=? WHERE TASK_CODE=? ";
	
	@Override
	public Class<SomElectronic> getEntityClass() {
		return SomElectronic.class;
	}

	/**
	 * 通过sql查询下载列表
	 */
	public DataSet queryElectronic(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String dutyId = (String) pset.getParameter("dutyId");
		String ids = (String) pset.getParameter("ids");
		StringBuffer sql = new StringBuffer("");
		if(dutyId != null && !("".equals(dutyId.trim()))){
			sql.append("select e.* from som_duty_electronic de left join som_electronic e on e.electronic_id=de.electronic_id where 1=1");
			sql.append(" and de.duty_id=?");
			typeList.add(Types.VARCHAR);
			objsList.add(dutyId);
		}
		else if (ids != null && !("".equals(ids.trim()))) {
			sql.append("SELECT * FROM SOM_ELECTRONIC T WHERE 1=1 ");
			sql.append(" AND ( ");
			String[] ary = ids.split(";");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" ELECTRONIC_ID=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		DataSet ds = new DataSet();
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
		List<Record> list = ds.getRecordSet();
		DataSet returnDs = new DataSet();
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				Record rd = list.get(i);
				SomElectronic bean = new SomElectronic();
				bean.setElectronicId((String) rd.get("ELECTRONIC_ID"));
				bean.setTaskCode((String) rd.get("TASK_CODE"));
				bean.setSorgId((String) rd.get("SORG_ID"));
				bean.setFileCode((String) rd.get("FILE_CODE"));
				bean.setSorgKind((String) rd.get("SORG_KIND"));
				bean.setSorgType((String) rd.get("SORG_TYPE"));
				bean.setCnName((String) rd.get("CN_NAME"));
				bean.setApplyType((String) rd.get("APPLY_TYPE"));
				bean.setIfValid((String) rd.get("IF_VALID"));
				bean.setCatalogCode((String) rd.get("CATALOG_CODE"));
				bean.setFileName((String) rd.get("FILE_NAME"));
				bean.setFileType((String) rd.get("FILE_TYPE"));
				bean.setFileMess((String) rd.get("FILE_MESS"));
				bean.setFilePath((String) rd.get("FILE_PATH"));
				bean.setCreatePeople((String) rd.get("CREATE_PEOPLE"));
				bean.setCreateTime((String) rd.get("CREATE_TIME"));
				bean.setModPeople((String) rd.get("MOD_PEOPLE"));
				bean.setModTime((String) rd.get("MOD_TIME"));
				
				returnDs.addRecord(bean);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}
	
	/**
	 * 通过sql查询登记阶段法律要件信息
	 */
	public DataSet queryCatalogBySql(ParameterSet pset) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		String applyType = (String) pset.getParameter("applyType");
		String sorgId = (String) pset.getParameter("sorgId");
		String taskCode = (String) pset.getParameter("taskCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT CATALOG_CODE,UP_CATALOG_CODE,APPLY_TYPE,FILE_CODE,RELATING_FILE_CODE FROM SOM_CATALOG WHERE IF_VALID='1' AND CATALOG_LEVEL>4 AND ARCHIVE_STAGE='0'");
		if (applyType != null && !("".equals(applyType.trim()))) {
			sql.append(" AND ( ");
			String[] ary = applyType.split(",");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" APPLY_TYPE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		sql.append(" ORDER BY CATALOG_ORDER ASC ");
		DataSet catalogDS = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			catalogDS = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			catalogDS = this.executeDataset(sql.toString(),pset.getPageStart(), pset.getPageLimit(), true);
		}
		List<Record> list = catalogDS.getRecordSet();
		ArrayList<Record> records = new ArrayList<Record>();
		for (int i = 0; i < list.size(); i++) {
			Record map = (Record) list.get(i);
			SomElectronic electronicBean = new SomElectronic();
			electronicBean.setCatalogCode((String) map.get("CATALOG_CODE"));
			electronicBean.setTaskCode(taskCode);
			electronicBean.setApplyType((String) map.get("APPLY_TYPE"));
			electronicBean.setSorgId(sorgId);
			electronicBean.setUpCatalogCode((String) map.get("UP_CATALOG_CODE"));
			electronicBean.setFileCode((String) map.get("FILE_CODE"));
			getInfo(electronicBean,null);
			getRelatingFile((String)map.get("RELATING_FILE_CODE"),electronicBean);
			Record record = new Record(electronicBean);
			records.add(record);
		}
		DataSet electronicDS = new DataSet();
		electronicDS.getRecordSet().addAll(records);
		electronicDS.setTotalCount(catalogDS.getTotalCount());
		return electronicDS;
	}

	/**
	 * 通过sql查询归档阶段法律要件信息
	 */
	public DataSet queryArchiveCatalogBySql(ParameterSet pset) {
		//先查询出该社会组织所有的业务
		String sorgId = (String) pset.getParameter("sorgId");
//		StringBuffer applySql  = new StringBuffer();
//		//applySql.append("SELECT  APPLY_TYPE,MAX（CREATE_TIME） FROM SOM_APPLY A WHERE A.SORG_ID=? GROUP BY APPLY_TYPE ORDER BY APPLY_TYPE");
//		applySql.append("SELECT APPLY_TYPE,TASK_CODE FROM SOM_APPLY A WHERE  A.SORG_ID=? ORDER BY A.CREATE_TIME");
//		int[] applyTypes = new int[] { Types.VARCHAR };
//		Object[] applyTArgs = new Object[] { sorgId };
//		DataSet applyDs = this.executeDataset(applySql.toString(), applyTypes, applyTArgs,true);
		//查询目录表
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		//sql.append("SELECT CATALOG_CODE,UP_CATALOG_CODE,APPLY_TYPE,FILE_CODE FROM SOM_CATALOG WHERE IF_VALID='1' AND CATALOG_LEVEL>4");
		sql.append("SELECT A.CATALOG_CODE,A.UP_CATALOG_CODE,A.APPLY_TYPE,A.FILE_CODE,B.TASK_CODE,B.CREATE_TIME FROM SOM_CATALOG_ARCHIVE A,SOM_APPLY B WHERE A.IF_VALID='1' AND A.CATALOG_LEVEL>4  AND  B.SORG_ID=?  AND A.APPLY_TYPE_ARCHIVE=B.APPLY_TYPE");
//		if (applyDs.getCount()>0) {
//			//for(int i=0 ; i<applyDs.getCount();i++){
//				//if(i==0){
//					sql.append(" AND ( ");
//				//}else{
//				//	sql.append(" OR ( ");
//				//}
//				applyType = applyDs.getRecord(i).get("APPLY_TYPE").toString();
//				if (ApplyType.SOM_FUND_BUILD.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_NAME_CHECK);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_SETUP);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_FUND_SEND_LETTER);
//				} else if (ApplyType.SOM_FUND_BRANCH_BUILD.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_BRANCH_NAME_CHECK);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_BRANCH_SETUP);
//				} else if (ApplyType.SOM_FUND_CHANGE.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_CHANGE_BASIC);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_CHANGE_RESIDE);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_FUND_CHANGE_LEGAL);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_FUND_CHANGE_FUNDING);
//				} else if (ApplyType.SOM_FUND_BRANCH_CHANGE.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_BRANCH_CHANGE_BASIC);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_FUND_BRANCH_CHANGE_RESIDE);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_FUND_BRANCH_CHANGE_PRINCIPAL);
//				}
//				else if (ApplyType.SOM_GROUP_CHANGE.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_GROUP_CHANGE_BASIC);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_GROUP_CHANGE_RESIDE);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_GROUP_CHANGE_LEGAL);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_GROUP_CHANGE_FUNDING);
//				}
//				else if (ApplyType.SOM_GROUP_BRANCH_CHANGE.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_GROUP_BRANCH_CHANGE_BASIC);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_GROUP_BRANCH_CHANGE_RESIDE);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_GROUP_BRANCH_CHANGE_PRINCIPAL);
//				}
//				else if (ApplyType.SOM_UNGOV_CHANGE.equals(applyType)) {
//					sql.append(" APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? OR APPLY_TYPE =? ");
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_UNGOV_CHANGE_BASIC);
//					typeList.add(Types.VARCHAR);
//					objsList.add(ApplyType.SOM_UNGOV_CHANGE_RESIDE);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_UNGOV_CHANGE_LEGAL);
//					typeList.add(Types.VARCHAR);
//					objsList.add( ApplyType.SOM_UNGOV_CHANGE_FUNDING);
//				}
//				else{
//					sql.append(" APPLY_TYPE = ?");
//					typeList.add(Types.VARCHAR);
//					objsList.add(applyType);
//				}
//				sql.append(" ) ");
//			}
			
		//}else{
		//	sql.append(" AND APPLY_TYPE ='不存在' ");
		//}
		typeList.add(Types.VARCHAR);
		objsList.add(sorgId);
		sql.append(" ORDER BY CREATE_TIME,APPLY_TYPE,CATALOG_ORDER ASC ");
		DataSet catalogDS = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			catalogDS = this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			catalogDS = this.executeDataset(sql.toString(),pset.getPageStart(), pset.getPageLimit(), true);
		}
		List<Record> list = catalogDS.getRecordSet();
		ArrayList<Record> records = new ArrayList<Record>();
		for (int i = 0; i < list.size(); i++) {
			Record map = (Record) list.get(i);
			SomElectronic electronicBean = new SomElectronic();
			electronicBean.setCatalogCode((String) map.get("CATALOG_CODE"));
			electronicBean.setTaskCode((String) map.get("TASK_CODE"));
			electronicBean.setApplyType((String) map.get("APPLY_TYPE"));
			electronicBean.setSorgId(sorgId);
			electronicBean.setUpCatalogCode((String) map.get("UP_CATALOG_CODE"));
			electronicBean.setFileCode((String) map.get("FILE_CODE"));
			electronicBean.setCreateTime((String) map.get("CREATE_TIME"));
			getInfo(electronicBean,null);
			Record record = new Record(electronicBean);
			records.add(record);
		}
		DataSet electronicDS = new DataSet();
		electronicDS.getRecordSet().addAll(records);
		electronicDS.setTotalCount(catalogDS.getTotalCount());
		return electronicDS;
	}
	
	/**
	 * 通过sql查询人员法律要件信息
	 */
	public DataSet queryPeopleCatalogBySql(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("SELECT CATALOG_CODE,UP_CATALOG_CODE,APPLY_TYPE,FILE_CODE,RELATING_FILE_CODE FROM SOM_CATALOG WHERE IF_VALID='1' AND CATALOG_LEVEL>4 ");
		String fileCodes = (String) pset.getParameter("fileCodes");
		String sorgId = (String) pset.getParameter("sorgId");
		String taskCode = (String) pset.getParameter("taskCode");
		String dutyId = (String) pset.getParameter("dutyId");
//		String applyType = (String) pset.getParameter("applyType");
		if(fileCodes!=null && !("".equals(fileCodes))){
			String[] fileCodeAry = fileCodes.split(",");
			sql.append(" AND ( ");
			for (int i = 0; i < fileCodeAry.length; i++) {
				sql.append(" FILE_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(fileCodeAry[i]);
				if(i!=fileCodeAry.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
//		if (applyType != null && !("".equals(applyType.trim()))) {
//			sql.append(" AND ( ");
//			String[] applyTypeAry = applyType.split(",");
//			for (int i = 0; i < applyTypeAry.length; i++) {
//				sql.append(" APPLY_TYPE=? ");
//				typeList.add(Types.VARCHAR);
//				objsList.add(applyTypeAry[i]);
//				if(i!=applyTypeAry.length-1){
//					sql.append(" OR ");
//				}
//			}
//			sql.append(" ) ");
//		}
		sql.append(" ORDER BY CATALOG_ORDER ASC ");
		DataSet catalogDS = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			catalogDS = this.executeDataset(sql.toString(), types, args, true);
		} else {
			catalogDS = this.executeDataset(sql.toString(), true);
		}
		List<Record> list = catalogDS.getRecordSet();
		List<Record> records = new ArrayList<Record>();
		for (int i = 0; i < list.size(); i++) {
			Record map = (Record) list.get(i);
			SomElectronic electronicBean = new SomElectronic();
			electronicBean.setCatalogCode((String) map.get("CATALOG_CODE"));
			electronicBean.setTaskCode(taskCode);
			electronicBean.setApplyType((String) map.get("APPLY_TYPE"));
			electronicBean.setSorgId(sorgId);
			electronicBean.setUpCatalogCode((String) map.get("UP_CATALOG_CODE"));
			electronicBean.setFileCode((String) map.get("FILE_CODE"));
			electronicBean.setDutyId(dutyId);
			getInfo(electronicBean,null);
			getRelatingFile((String)map.get("RELATING_FILE_CODE"),electronicBean);
			Record record = new Record(electronicBean);
			records.add(record);
		}
		DataSet electronicDS = new DataSet();
		electronicDS.getRecordSet().addAll(records);
		electronicDS.setTotalCount(catalogDS.getTotalCount());
		return electronicDS;
	}
	/**
	 * 获取FILE_CODE关联的文件
	 * @return
	 */
	private void getRelatingFile(String relatingFileCodes,SomElectronic electronicBean){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("SELECT CATALOG_CODE FROM SOM_CATALOG WHERE IF_VALID='1' AND CATALOG_LEVEL>4 ");
		if(relatingFileCodes!=null && !("".equals(relatingFileCodes))){
			String[] fileCodeAry = relatingFileCodes.split(",");
			sql.append(" AND ( ");
			for (int i = 0; i < fileCodeAry.length; i++) {
				sql.append(" FILE_CODE=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(fileCodeAry[i]);
				if(i!=fileCodeAry.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		sql.append(" ORDER BY CATALOG_ORDER ASC ");
		DataSet catalogDS = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			catalogDS = this.executeDataset(sql.toString(), types, args, true);
			List<Record> list = catalogDS.getRecordSet();
			ArrayList<Record> records = new ArrayList<Record>();
			for (int i = 0; i < list.size(); i++) {
				Record map = (Record) list.get(i);
				getInfo(electronicBean,(String) map.get("CATALOG_CODE"));
				Record record = new Record(electronicBean);
				records.add(record);
			}
		}
	}
	/**
	 * 获取分号连接的上传文件名称、分号连接的上传文件ID、分号连接的上传文件描述
	 * 
	 * @param catalogCode
	 * @param sorgId
	 * @param electronicBean
	 */
	public void getInfo(SomElectronic electronicBean,String relatingCatalogCode) {
		String sorgId = electronicBean.getSorgId();
		String taskCode = electronicBean.getTaskCode();
		String dutyId = electronicBean.getDutyId();
		StringBuffer fileNameBuf = new StringBuffer();
		StringBuffer electronicIdBuf = new StringBuffer();
		StringBuffer fileMessBuf = new StringBuffer();
		String catalogCode = null;
		if(relatingCatalogCode!=null){
			catalogCode = relatingCatalogCode;
		}else{
			catalogCode = electronicBean.getCatalogCode();
		}
		String str = new String();
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("SELECT * FROM SOM_ELECTRONIC WHERE 1=1 ");
		if(sorgId!=null && !("".equals(sorgId))){
			sql.append(" AND SORG_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgId);
		}
		if(taskCode!=null && !("".equals(taskCode))){
			sql.append(" AND TASK_CODE=? ");
			typeList.add(Types.VARCHAR);
			if(taskCode.split(";").length>0){
				objsList.add(taskCode.split(";")[0]);
			}else{
				objsList.add(taskCode);
			}
			
		}
		if(catalogCode!=null && !("".equals(catalogCode))){
			sql.append(" AND CATALOG_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(catalogCode);
		}
		if(dutyId!=null && !("".equals(dutyId))){
			sql.append(" AND ELECTRONIC_ID in (SELECT ELECTRONIC_ID FROM SOM_DUTY_ELECTRONIC T WHERE T.DUTY_ID=?) ");
			typeList.add(Types.VARCHAR);
			objsList.add(dutyId);
		}
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			list = this.executeQuery(sql.toString(), types, args);
		}
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				fileNameBuf.append((String) list.get(i).get("FILE_NAME"));
				fileNameBuf.append(";");
				electronicIdBuf.append((String) list.get(i).get("ELECTRONIC_ID"));
				electronicIdBuf.append(";");
				if (list.get(i).get("FILE_MESS") == null) {
					fileMessBuf.append("无描述");
					fileMessBuf.append(";");
				} else {
					fileMessBuf.append((String) list.get(i).get("FILE_MESS"));
					fileMessBuf.append(";");
				}
			}
			str = fileNameBuf.toString();
			if(electronicBean.getFileName()==null){
				electronicBean.setFileName(str.substring(0, str.length() - 1));
			}else{
				electronicBean.setFileName(str+electronicBean.getFileName());
			}
			str = electronicIdBuf.toString();
			if(electronicBean.getElectronicId()==null){
				electronicBean.setElectronicId(str.substring(0, str.length() - 1));
			}else{
				electronicBean.setElectronicId(str+electronicBean.getElectronicId());
			}
			str = fileMessBuf.toString();
			if(electronicBean.getFileMess()==null){
				electronicBean.setFileMess(str.substring(0, str.length() - 1));
			}else{
				electronicBean.setFileMess(str+electronicBean.getFileMess());
			}
			//将件号付给前台，对于同一目录的件号应该是一样的，所以取第一个文件的件号即可
			electronicBean.setPieceNumber((String) list.get(0).get("PIECE_NUMBER"));
		}
	}

	/**
	 * 通过sql查询人员Electronic信息
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleElectronicBySql(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("SELECT E.ELECTRONIC_ID,E.TASK_CODE,E.FILE_CODE,E.SORG_ID,E.SORG_KIND,E.SORG_TYPE,E.CN_NAME,E.APPLY_TYPE,E.IF_VALID,E.CATALOG_CODE,E.FILE_NAME,E.FILE_TYPE,E.FILE_MESS,E.FILE_PATH,E.CREATE_PEOPLE,E.CREATE_TIME,E.MOD_PEOPLE,E.MOD_TIME,DE.DUTY_ID FROM SOM_ElECTRONIC E,SOM_DUTY_ELECTRONIC DE WHERE E.ELECTRONIC_ID=DE.ELECTRONIC_ID AND IF_VALID='1' ");
//		String sorgId = (String) pset.getParameter("sorgId");
//		String applyType = (String) pset.getParameter("applyType");
		String catalogCode = (String) pset.getParameter("catalogCode");
		String taskCode = (String) pset.getParameter("taskCode");
		String electronicIds = (String) pset.getParameter("electronicIds");
		String dutyId = (String) pset.getParameter("dutyId");
		if(dutyId!=null && !("".equals(dutyId))){
			sql.append(" AND DE.DUTY_ID=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(dutyId);
		}
		if(taskCode!=null && !("".equals(taskCode))){
			sql.append(" AND E.TASK_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(taskCode);
		}
		if(catalogCode!=null && !("".equals(catalogCode))){
			sql.append(" AND E.CATALOG_CODE=? ");
			typeList.add(Types.VARCHAR);
			objsList.add(catalogCode);
		}
		if(electronicIds!=null && !("".equals(electronicIds))){
			sql.append(" UNION SELECT E.ELECTRONIC_ID,E.TASK_CODE,E.FILE_CODE,E.SORG_ID,E.SORG_KIND,E.SORG_TYPE,E.CN_NAME,E.APPLY_TYPE,E.IF_VALID,E.CATALOG_CODE,E.FILE_NAME,E.FILE_TYPE,E.FILE_MESS,E.FILE_PATH,E.CREATE_PEOPLE,E.CREATE_TIME,E.MOD_PEOPLE,E.MOD_TIME,DE.DUTY_ID FROM SOM_ElECTRONIC E,SOM_DUTY_ELECTRONIC DE WHERE E.ELECTRONIC_ID=DE.ELECTRONIC_ID AND IF_VALID='1' ");
			if(dutyId!=null && !("".equals(dutyId))){
				sql.append(" AND DE.DUTY_ID=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(dutyId);
			}
			String[] ary = electronicIds.split(";");
			sql.append(" AND ( ");
			for (int i = 0; i < ary.length; i++) {
				sql.append(" E.ELECTRONIC_ID=? ");
				typeList.add(Types.VARCHAR);
				objsList.add(ary[i]);
				if(i!=ary.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
//		if(sorgId!=null && !("".equals(sorgId))){
//			sql.append(" AND E.SORG_ID=? ");
//			typeList.add(Types.VARCHAR);
//			objsList.add(sorgId);
//		}
//		
//		if(applyType!=null && !("".equals(applyType))){
//			sql.append(" AND E.APPLY_TYPE=? ");
//			typeList.add(Types.VARCHAR);
//			objsList.add(applyType);
//		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(),true);
		}
		List<Record> list = ds.getRecordSet();
		DataSet returnDs = new DataSet();
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				SomElectronic bean = new SomElectronic();
				
				bean.setElectronicId((String) list.get(i).get("ELECTRONIC_ID"));
				bean.setTaskCode((String) list.get(i).get("TASK_CODE"));
				bean.setFileCode((String) list.get(i).get("FILE_CODE"));
				bean.setSorgId((String) list.get(i).get("SORG_ID"));
				bean.setSorgKind((String) list.get(i).get("SORG_KIND"));
				bean.setSorgType((String) list.get(i).get("SORG_TYPE"));
				bean.setCnName((String) list.get(i).get("CN_NAME"));
				bean.setApplyType((String) list.get(i).get("APPLY_TYPE"));
				bean.setIfValid((String) list.get(i).get("IF_VALID"));
				bean.setCatalogCode((String) list.get(i).get("CATALOG_CODE"));
				bean.setFileName((String) list.get(i).get("FILE_NAME"));
				bean.setFileType((String) list.get(i).get("FILE_TYPE"));
				bean.setFileMess((String) list.get(i).get("FILE_MESS"));
				bean.setFilePath((String) list.get(i).get("FILE_PATH"));
				bean.setCreatePeople((String) list.get(i).get("CREATE_PEOPLE"));
				bean.setCreateTime((String) list.get(i).get("CREATE_TIME"));
				bean.setModPeople((String) list.get(i).get("MOD_PEOPLE"));
				bean.setModTime((String) list.get(i).get("MOD_TIME"));
				bean.setDutyId((String) list.get(i).get("DUTY_ID"));
				
				returnDs.addRecord(bean);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}
	/**
	 * 通过sql查询人员Electronic信息
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySql(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("");
		String sorgId = (String) pset.getParameter("sorgId");
		String taskCode = (String) pset.getParameter("taskCode");
		String applyType = (String) pset.getParameter("applyType");
		String catalogCode = (String) pset.getParameter("catalogCode");
		String electronicIds = (String) pset.getParameter("electronicIds");
		String dutyId = (String) pset.getParameter("dutyId");
		if(dutyId!=null && !("".equals(dutyId))){
			sql.append("SELECT E.* FROM SOM_DUTY_ELECTRONIC DE LEFT JOIN SOM_ELECTRONIC E ON DE.ELECTRONIC_ID=E.ELECTRONIC_ID WHERE DE.DUTY_ID = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(dutyId);
		}else{
			sql.append("SELECT E.ELECTRONIC_ID,E.TASK_CODE,E.FILE_CODE,E.SORG_ID,E.SORG_KIND,E.SORG_TYPE,E.CN_NAME,E.APPLY_TYPE,E.IF_VALID,E.CATALOG_CODE,E.FILE_NAME,E.FILE_TYPE,E.FILE_MESS,E.FILE_PATH,E.CREATE_PEOPLE,E.CREATE_TIME,E.MOD_PEOPLE,E.MOD_TIME FROM SOM_ElECTRONIC E WHERE E.IF_VALID='1' ");
			if(sorgId!=null && !("".equals(sorgId))){
				sql.append(" AND E.SORG_ID = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(sorgId);
			}
			if(taskCode!=null && !("".equals(taskCode))){
				sql.append(" AND E.TASK_CODE = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(taskCode);
			}
			if(applyType!=null && !("".equals(applyType))){
				sql.append(" AND E.APPLY_TYPE = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(applyType);
			}
			if(catalogCode!=null && !("".equals(catalogCode))){
				sql.append(" AND E.CATALOG_CODE = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(catalogCode);
			}
			if(electronicIds!=null && !("".equals(electronicIds))){
				String[] ary = electronicIds.split(";");
				sql.append(" UNION SELECT E.ELECTRONIC_ID,E.TASK_CODE,E.FILE_CODE,E.SORG_ID,E.SORG_KIND,E.SORG_TYPE,E.CN_NAME,E.APPLY_TYPE,E.IF_VALID,E.CATALOG_CODE,E.FILE_NAME,E.FILE_TYPE,E.FILE_MESS,E.FILE_PATH,E.CREATE_PEOPLE,E.CREATE_TIME,E.MOD_PEOPLE,E.MOD_TIME FROM SOM_ElECTRONIC E WHERE E.IF_VALID='1' AND ( ");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" E.ELECTRONIC_ID=? ");
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
					if(i!=ary.length-1){
						sql.append(" OR ");
					}
				}
				sql.append(" ) ");
			}
		}
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(),true);
		}
		List<Record> list = ds.getRecordSet();
		DataSet returnDs = new DataSet();
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				SomElectronic bean = new SomElectronic();
				
				bean.setElectronicId((String) list.get(i).get("ELECTRONIC_ID"));
				bean.setTaskCode((String) list.get(i).get("TASK_CODE"));
				bean.setFileCode((String) list.get(i).get("FILE_CODE"));
				bean.setSorgId((String) list.get(i).get("SORG_ID"));
				bean.setSorgKind((String) list.get(i).get("SORG_KIND"));
				bean.setSorgType((String) list.get(i).get("SORG_TYPE"));
				bean.setCnName((String) list.get(i).get("CN_NAME"));
				bean.setApplyType((String) list.get(i).get("APPLY_TYPE"));
				bean.setIfValid((String) list.get(i).get("IF_VALID"));
				bean.setCatalogCode((String) list.get(i).get("CATALOG_CODE"));
				bean.setFileName((String) list.get(i).get("FILE_NAME"));
				bean.setFileType((String) list.get(i).get("FILE_TYPE"));
				bean.setFileMess((String) list.get(i).get("FILE_MESS"));
				bean.setFilePath((String) list.get(i).get("FILE_PATH"));
				bean.setCreatePeople((String) list.get(i).get("CREATE_PEOPLE"));
				bean.setCreateTime((String) list.get(i).get("CREATE_TIME"));
				bean.setModPeople((String) list.get(i).get("MOD_PEOPLE"));
				bean.setModTime((String) list.get(i).get("MOD_TIME"));
				bean.setDutyId((String) list.get(i).get("DUTY_ID"));
				
				returnDs.addRecord(bean);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}
	/**
	 * 通过ID删除档案信息
	 */
	public void deleteById(String electronicId) {
		if (electronicId != null && !("".equals(electronicId.trim()))) {
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM SOM_ELECTRONIC WHERE ELECTRONIC_ID = ? ");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { electronicId };
			executeUpdate(sql.toString(), types, args);
			StringBuffer sql2 = new StringBuffer("DELETE FROM SOM_DUTY_ELECTRONIC WHERE ELECTRONIC_ID = ? ");
			int[] types2 = new int[] { Types.VARCHAR };
			Object[] args2 = new Object[] { electronicId };
			executeUpdate(sql2.toString(), types2, args2);
		}
	}

	/**
	 * 创建一条SOM_DUTY_ELECTRONIC信息
	 */
	public void insertSomDutyElectronicBySql(String dutyId, String electronicId) {
		if (electronicId != null && !("".equals(electronicId.trim())) && dutyId!=null && !("".equals(dutyId))) {
			StringBuffer sql = new StringBuffer("INSERT INTO SOM_DUTY_ELECTRONIC (ID,DUTY_ID,ELECTRONIC_ID) VALUES (?,?,?)");
			int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
			Object[] objs = new Object[] {IdHelp.getUUID32(),dutyId,electronicId};
			executeUpdate(sql.toString(), types, objs);
		}
		
	}

	/**
	 * 删除一条SOM_DUTY_ELECTRONIC信息
	 */
	public void deleteSomDutyElectronicBySql(String dutyId, String electronicId) {
		if(electronicId!=null && !("".equals(electronicId)) && dutyId!=null && !("".equals(dutyId))){
			StringBuffer sql = new StringBuffer("DELETE FROM SOM_DUTY_ELECTRONIC WHERE DUTY_ID=? AND ELECTRONIC_ID=? ");
			int[] types = new int[] { Types.VARCHAR,Types.VARCHAR };
			Object[] args = new Object[] { dutyId,electronicId };
			executeUpdate(sql.toString(), types, args);
		}
		
	}
	
	/**
	 * 根据sorgId查询社会组织的所有档案
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySorgId(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer("SELECT * FROM SOM_ELECTRONIC WHERE SORG_ID=?  ORDER BY CREATE_TIME");
		String sorgId = (String) pset.getParameter("sorgId");
		typeList.add(Types.VARCHAR);
		objsList.add(sorgId);
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(),true);
		}
		List<Record> list = ds.getRecordSet();
		DataSet returnDs = new DataSet();
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				SomElectronic bean = new SomElectronic();
				bean.setElectronicId((String) list.get(i).get("ELECTRONIC_ID"));
				bean.setTaskCode((String) list.get(i).get("TASK_CODE"));
				bean.setFileCode((String) list.get(i).get("FILE_CODE"));
				bean.setSorgId((String) list.get(i).get("SORG_ID"));
				bean.setSorgKind((String) list.get(i).get("SORG_KIND"));
				bean.setSorgType((String) list.get(i).get("SORG_TYPE"));
				bean.setCnName((String) list.get(i).get("CN_NAME"));
				bean.setApplyType((String) list.get(i).get("APPLY_TYPE"));
				bean.setIfValid((String) list.get(i).get("IF_VALID"));
				bean.setCatalogCode((String) list.get(i).get("CATALOG_CODE"));
				bean.setFileName((String) list.get(i).get("FILE_NAME"));
				bean.setFileType((String) list.get(i).get("FILE_TYPE"));
				bean.setFileMess((String) list.get(i).get("FILE_MESS"));
				bean.setFilePath((String) list.get(i).get("FILE_PATH"));
				bean.setCreatePeople((String) list.get(i).get("CREATE_PEOPLE"));
				bean.setCreateTime((String) list.get(i).get("CREATE_TIME"));
				bean.setModPeople((String) list.get(i).get("MOD_PEOPLE"));
				bean.setModTime((String) list.get(i).get("MOD_TIME"));
				bean.setDutyId((String) list.get(i).get("DUTY_ID"));
				returnDs.addRecord(bean);
			}
			returnDs.setTotalCount(ds.getTotalCount());
		}
		return returnDs;
	}
	/**
	 * 通过taskCode更新sorgId
	 */
	public void updateSorgId(String sorgId, String taskCode) {
		int[] types = new int[] {Types.VARCHAR, Types.VARCHAR};
		Object[] objs = new Object[] {sorgId, taskCode};
		executeUpdate(UPDATE_SORG_ID, types, objs);
	}
}
